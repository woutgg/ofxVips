# ofxVips

A thin wrapper around [libvips](https://github.com/libvips/libvips). It is made
public in case it is of use to anyone. Most notably it is currently missing
support for MacOS. Feedback and additions are welcome.

The libvips version used is 8.17.0.


## Updating the shipped library files

### Linux

On Linux, libvips is built from source as a static library. External libraries
e.g. for file format support should be installed on system-wide. A minimal set
of them is included in the built. For details, see `script/build-libs-linux.sh`.
To build and copy the files, just run that script.

### Windows

On Windows, a combination of built files and source files is used. See
`script/setup-libs-win.sh` for details. The C++-wrapper files are included as
source files in the generated project. To put the required files in place or
update them to a new version, just run the script mentioned, perhaps removing
the existing files first (everything under 'libs/').

An alternative to this might be to build a DLL containing the wrapper code, but
this might be problematic, just like using an online prebuilt DLL, as the same
compiler (and version?) must be used as for the rest of the program to ensure
ABI compatibility. See https://github.com/libvips/libvips/issues/508.
