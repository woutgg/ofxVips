#include "ofxVips.h"

using namespace std;
using namespace vips;

bool ofxVips::init() {
  if (VIPS_INIT("") != 0) return false;

  return true;
}

void ofxVips::deinit() {
  vips_shutdown();
}

string ofxVips::getError() {
  string err(vips_error_buffer());

  vips_error_clear();

  return err;
}

/**
 * Returns a VImage that references the pixels of the given ofImage.
 *
 * Be careful to keep the pixel data valid as long as the returned VImage exists.
 *
 * @see: https://www.libvips.org/API/current/VipsImage.html#vips-image-new-from-memory
 */
VImage ofxVips::createVImageRef(ofImage& img) {
  ofPixels& pix = img.getPixels();
  auto fmt = VIPS_FORMAT_UCHAR;  // ofImage is unsigned char, ofFloatImage is float, ofShortImage is unsigned short

  return VImage::new_from_memory(
    pix.getData(), pix.getTotalBytes(), pix.getWidth(), pix.getHeight(), pix.getNumChannels(), fmt
  );
}
