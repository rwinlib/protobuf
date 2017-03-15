Source: https://github.com/google/protobuf/archive/v3.2.0.zip
First ran ./autogen.sh in msys2.

Then compiled all 4 versions with msys and native R tool chains:

export CFLAGS="-m64 -O3 -DNDEBUG"
export CXXFLAGS="-m64 -O3 -DNDEBUG"
../protobuf-3.0.0/configure --enable-static --disable-shared

