#!/bin/sh

VIPS_VERSION="v8.17.0"
VIPS_GIT_URL="https://github.com/libvips/libvips.git"
VIPS_DIR="vips-$VIPS_VERSION"
BUILD_DIR=build-dir
OUTPUT_DIR=build-output
TGT_BASE_DIR=../libs
BUILD_TYPE=release  # release or debug (or others, see meson docs)

# Uncomment this for verbose debugging.
# export CFLAGS="-DVIPS_DEBUG"


# -Dexif=enabled \
# -Djpeg=enabled \
# -Dspng=enabled \
# -Dtiff=enabled \
BUILD_OPTIONS=" \
  --buildtype=$BUILD_TYPE \
  --default-library=static -Dexamples=false -Ddeprecated=false \
  -Dcfitsio=disabled \
  -Dcgif=disabled \
  -Dfftw=disabled \
  -Dfontconfig=disabled \
  -Dheif=disabled \
  -Dimagequant=disabled \
  -Djpeg-xl=disabled \
  -Dlcms=disabled \
  -Dmagick=disabled \
  -Dmatio=disabled \
  -Dnifti=disabled \
  -Dopenexr=disabled \
  -Dopenjpeg=disabled \
  -Dopenslide=disabled \
  -Dorc=disabled \
  -Dpangocairo=disabled \
  -Dpdfium=disabled \
  -Dpng=disabled \
  -Dpoppler=disabled \
  -Dquantizr=disabled \
  -Drsvg=disabled \
  -Dwebp=disabled \
  -Dzlib=disabled \
  "

if [ ! -f addon_config.mk ]; then
  echo "$0: please run the build script from the addon root directory"
  exit 1
fi

# First ensure we have the repo at the correct tag

if [ ! -d "$VIPS_DIR" ]; then
  echo "***** Cloning libvips repository for version $VIPS_VERSION *****"
  git clone --depth 1 --branch "$VIPS_VERSION" "$VIPS_GIT_URL" "$VIPS_DIR"
else
  echo "***** Using existing libvips repository for version $VIPS_VERSION *****"
fi

cd "$VIPS_DIR" || exit 2

if [ ! -z "$(git status --porcelain)" ]; then
  echo "$0: a libvips repository for version $VIPS_VERSION has already been cloned, but has changes"
  exit 2
fi

echo "***** Cleaning up *****"
rm -r "$BUILD_DIR"
rm -r "$OUTPUT_DIR"

echo "***** Running meson *****"
meson setup "$BUILD_DIR" --prefix="$(pwd)/$OUTPUT_DIR" $BUILD_OPTIONS

if [ $? -ne 0 ]; then
  echo "$0: meson failed to run successfully"
  exit 1
fi

cd "$BUILD_DIR" || exit 2

echo "***** Building *****"
ninja

echo "***** Installing *****"
ninja install

cd - || exit 2

echo "***** Copying built files into place *****"

# TODO: (?) remove target files/dirs first?
cp -r "$OUTPUT_DIR"/include/vips "$TGT_BASE_DIR"/include/
cp "$OUTPUT_DIR"/lib/libvips-cpp.a "$TGT_BASE_DIR"/lib/linux64/
cp "$OUTPUT_DIR"/lib/libvips.a "$TGT_BASE_DIR"/lib/linux64/

# TODO: or should we leave these out? is code included statically? then no, otherwise yes
cp -r /usr/include/glib-2.0 "$TGT_BASE_DIR"/include/  # Assuming prefix is /usr/include
