#/bin/sh
set -e
PACKAGE=protobuf

# Update
pacman -Syy --noconfirm
OUTPUT=$(mktemp -d)
ROOT=$(pwd)

# Download files (-dd skips dependencies)
pkgs=$(echo mingw-w64-{i686,x86_64,ucrt-x86_64}-${PACKAGE})
URLS=$(pacman -Sp $pkgs --cache=$OUTPUT)
VERSION=$(pacman -Si mingw-w64-x86_64-${PACKAGE} | awk '/^Version/{print $3}')

# Set version for next step
echo "::set-output name=VERSION::${VERSION}"
echo "::set-output name=PACKAGE::${PACKAGE}"
echo "Bundling $PACKAGE-$VERSION"
echo "# $PACKAGE $VERSION" > README.md
echo "" >> README.md

for URL in $URLS; do
  curl -OLs $URL
  FILE=$(basename $URL)
  echo "Extracting: $URL"
  echo " - $FILE" >> README.md
  tar xf $FILE -C ${OUTPUT}
  rm -f $FILE
done

# Copy libs
rm -Rf bin* lib* include
mkdir -p include bin{32,} lib lib-8.3.0/{x64,i386}
(cd ${OUTPUT}/ucrt64/lib; cp -fv *.a $ROOT/lib/)
(cd ${OUTPUT}/mingw64/lib; cp -fv *.a $ROOT/lib-8.3.0/x64/)
(cd ${OUTPUT}/mingw32/lib; cp -fv *.a $ROOT/lib-8.3.0/i386/)
(cd ${OUTPUT}/mingw32/bin/; cp -fv *.exe $ROOT/bin32/)
(cd ${OUTPUT}/mingw64/bin/; cp -fv *.exe $ROOT/bin/)
cp -Rf ${OUTPUT}/ucrt64/include $ROOT/

# Cleanup temporary dir
rm -Rf ${OUTPUT}/*
