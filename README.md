# ofxVips

A thin wrapper around [libvips](https://github.com/libvips/libvips). It is made
public in case it is of use to anyone. It is currently missing support for
MacOS, and it only wraps a small subset of the API.
Feedback and additions are welcome.

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

WARNING: when changing the version, check if any DLL files have been added (or
removed) and update addon_config.mk accordingly.

An alternative to this might be to build a DLL containing the wrapper code, but
this might be problematic, just like using an online prebuilt DLL, as the same
compiler (and version?) must be used as for the rest of the program to ensure
ABI compatibility. See https://github.com/libvips/libvips/issues/508.


## TODO

- (?) include library dependencies for linux and use thos, like in windows, or
  build a completely static libvips if possible; currently, glib headers are
  included for windows but not used on linux which is less than ideal
- (FIXME) both the linux and windows setup scripts copy the include files, this
  should not matter as long as the versions match
- (windows) see if really all dll files are required
- create an example (also to test if everything works correctly)
- add macos support
