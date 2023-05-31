#ifndef OFX_VIPS_H_SEEN
#define OFX_VIPS_H_SEEN

#include <string>
#include "ofxVips/libs/include/vips/vips8"
#include "ofImage.h"

class ofxVips {
public:
  static bool init();
  static void deinit();

  static std::string getError();  // Returns the last error (if any) and clears the error buffer.

  static vips::VImage createVImageRef(ofImage& img);

private:
  ofxVips() = delete;
  ofxVips(ofxVips& other) = delete;
  ofxVips(ofxVips&& other) = delete;
};

#endif /* OFX_VIPS_H_SEEN */
