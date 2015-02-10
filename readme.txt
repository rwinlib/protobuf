Builds from Jeroen Ooms, Dec 2014.

i386 was built using msys + rtools 3.1 (which has mingw 4.6.3)
x64 was built using msys + mingw-x64-4.7.3-posix-sjlj-rev1 (from mingw-builds installer)

Building libprotobuf with more recent versions of mingw results in errors when linking
to the R package with the current Rtools (gcc 4.6.3-pre).