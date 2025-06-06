#!/bin/sh

# This script downloads the required libvips files and extracts those required
# for the addon to compile on Windows.

VIPS_VERSION=8.17.0

VIPS_UNPACK_DIR="vips-$VIPS_VERSION.tmp"
TGT_BASE_DIR=../libs

VIPS_PREBUILT_URL="https://github.com/libvips/build-win64-mxe/releases/download/v$VIPS_VERSION/vips-dev-w64-all-$VIPS_VERSION.zip"
VIPS_PREBUILT_DIRNAME="vips-$VIPS_VERSION-prebuilt"
VIPS_GIT_URL="https://github.com/libvips/libvips.git"
VIPS_REPO_DIRNAME="vips-$VIPS_VERSION.git"

if [ ! -f addon_config.mk ]; then
  echo "$0: please run this script from the addon root directory"
  exit 2
fi

if [ -d "$VIPS_UNPACK_DIR" ]; then
  echo "$0: working directory '$VIPS_UNPACK_DIR' already exists, please (carefully) remove it first"
  # exit 2
fi

echo "***** Changing to $VIPS_UNPACK_DIR directory *****"

mkdir -p "$VIPS_UNPACK_DIR" || exit 2
cd "$VIPS_UNPACK_DIR" || exit 2

echo "***** Downloading libvips version $VIPS_VERSION prebuilt for Windows from '$VIPS_PREBUILT_URL' *****"
curl -L -o "$VIPS_PREBUILT_DIRNAME.zip" "$VIPS_PREBUILT_URL" || exit 2
# Ensure a predictable base directory, based on https://superuser.com/a/573624.
temp=$(mktemp -d -p .) && unzip -d "$temp" "$VIPS_PREBUILT_DIRNAME.zip" && mkdir -p "$VIPS_PREBUILT_DIRNAME" && mv "$temp"/*/* "$VIPS_PREBUILT_DIRNAME" && rmdir "$temp"/* "$temp"

echo "***** Cloning libvips repository version $VIPS_VERSION from '$VIPS_GIT_URL' *****"
git clone --depth 1 --branch "v$VIPS_VERSION" "$VIPS_GIT_URL" "$VIPS_REPO_DIRNAME"

TGT_LIB_DIR="$TGT_BASE_DIR/lib/win64"
TGT_DLL_DIR="$TGT_LIB_DIR/dll"
TGT_INCLUDE_DIR="$TGT_BASE_DIR/include"
TGT_CPLUSPLUS_DIR="$TGT_BASE_DIR/vips-cplusplus"

mkdir -p "$TGT_LIB_DIR"
mkdir -p "$TGT_DLL_DIR"
mkdir -p "$TGT_INCLUDE_DIR"
mkdir -p "$TGT_CPLUSPLUS_DIR"

echo "***** Copying $VIPS_PREBUILT_DIRNAME/bin/*.dll to '$TGT_DLL_DIR/' *****"
cp "$VIPS_PREBUILT_DIRNAME/bin"/*.dll "$TGT_DLL_DIR/"
echo "***** Copying $VIPS_PREBUILT_DIRNAME/lib/glib-2.0/ to '$TGT_LIB_DIR/' *****"
cp -r "$VIPS_PREBUILT_DIRNAME/lib/glib-2.0/" "$TGT_LIB_DIR/"
echo "***** Copying $VIPS_PREBUILT_DIRNAME/lib/libvips.lib to '$TGT_LIB_DIR/' *****"
cp "$VIPS_PREBUILT_DIRNAME/lib/libvips.lib" "$TGT_LIB_DIR/"
echo "***** Copying $VIPS_PREBUILT_DIRNAME/lib/libglib-2.0.lib to '$TGT_LIB_DIR/' *****"
cp "$VIPS_PREBUILT_DIRNAME/lib/libglib-2.0.lib" "$TGT_LIB_DIR/"
echo "***** Copying $VIPS_PREBUILT_DIRNAME/lib/libgobject-2.0.lib to '$TGT_LIB_DIR/' *****"
cp "$VIPS_PREBUILT_DIRNAME/lib/libgobject-2.0.lib" "$TGT_LIB_DIR/"

echo "***** Copying $VIPS_PREBUILT_DIRNAME/include/glib-2.0/ to '$TGT_INCLUDE_DIR/' *****"
cp -r "$VIPS_PREBUILT_DIRNAME/include/glib-2.0/" "$TGT_INCLUDE_DIR/"
echo "***** Copying $VIPS_PREBUILT_DIRNAME/include/vips/ to '$TGT_INCLUDE_DIR/' *****"
cp -r "$VIPS_PREBUILT_DIRNAME/include/vips/" "$TGT_INCLUDE_DIR/"

echo "***** Copying $VIPS_REPO_DIRNAME/cplusplus/*.cpp to '$TGT_CPLUSPLUS_DIR/' *****"
cp "$VIPS_REPO_DIRNAME/cplusplus"/*.cpp "$TGT_CPLUSPLUS_DIR/"

echo
echo "***** Done, you can remove the working directory '$VIPS_UNPACK_DIR' now *****"
