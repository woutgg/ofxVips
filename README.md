# ofxVips

A thin wrapper around [libvips](https://github.com/libvips/libvips). It is made
public in case it is of use to anyone. It is currently missing support for
MacOS, and it only wraps a small subset of the API.
Feedback and additions are welcome.

The libvips version used is 8.17.0.

WARNING: linux and windows include files currently overlap and they are not
entirely identical (mainly glib headers). The current files are for windows, so
until this has been resolved, the linux build script might have to be run to
obtain usable headers for linux.


## Updating the shipped library files

https://www.libvips.org/install.html

### Linux

On Linux, libvips is built from source as a static library. External libraries
e.g. for file format support should be installed on system-wide. A minimal set
of them is included in the built. For details, see `script/build-libs-linux.sh`.

To build and copy the files, perform the following steps (more or less):

- Make sure build dependencies are installed: meson, 'build-essential'
  (arch: ??? gcc, ld, etc?), pkg-config (arch: pkgconf), libglib2.0-dev
  (arch: glib2), libexpat1-dev (arch: expat)
- Install optional dependencies (currently only exif, jpeg, png and tiff are
  enabled in the build script, but see https://github.com/libvips/libvips#optional-dependencies):
  * packages: libexif (previously also: fftw, orc, lcms, zlib, pangocairo, fontconfig (all installed already))
  * format libs: mozjpeg (broken on arch, but libjpeg-turbo also works), libspng, libtiff
- run the build script (perhaps remove previous build files first)

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

- (FIXME) both the linux and windows setup scripts copy the include files, this
  might not matter as long as the versions match but there are differences,
  mainly in glib (just observe git changes after building / setting up the
  libraries on a new platform)
- currently, glib headers are included for windows but not used on linux which
  is less than ideal -> split into platform-specific dir like libs?
- (?) include library dependencies for linux and use those like in windows, or
  build a completely static libvips if possible
- also document the required external libraries here accurately
- create an example (also to test if everything works correctly)
- add macos support
