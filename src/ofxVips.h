/**
 * A thin wrapper addon for [libvips](https://www.libvips.org).
 *
 * GtkHandlerProxy idea from https://stackoverflow.com/a/1396431
 */
#ifndef OFX_VIPS_H_SEEN
#define OFX_VIPS_H_SEEN

#include <string>
#include "ofxVips/libs/include/vips/vips8"
#include "ofPixels.h"
#include "ofImage.h"

#define GTK_SIGNAL_METHOD(Class, Handler, Arg1, Arg2) \
  G_CALLBACK((GtkHandlerProxy<Class, Arg1, Arg2, &Class::Handler>::HandlerProxy))


class ofxVips {
public:
  template <class HandlerClass, class Arg1, class Arg2, void(HandlerClass::*HandlerFunc)(Arg1, Arg2)>
  struct GtkHandlerProxy {
    static void HandlerProxy(Arg1 arg1, Arg2 arg2, void* pdata) {
      (static_cast<HandlerClass*>(pdata)->*HandlerFunc)(arg1, arg2);
    }
  };

  static bool init();
  static void deinit();

  static std::string getError();  // Returns the last error (if any) and clears the error buffer.

  static vips::VImage createVImageRef(ofImage& img);

  template<class C, void(C::*HandlerFunc)(VipsImage*, VipsProgress*)>
  static void connectVImageProgressCb(vips::VImage* img, const C* instance) {
    SignalData<C> sd = { img, instance };

    vips_image_set_progress(img->get_image(), true);

    // Warning: dropping const from C*
    g_signal_connect(
      img->get_image(), "eval",
      G_CALLBACK((GtkHandlerProxy<C, VipsImage*, VipsProgress*, HandlerFunc>::HandlerProxy)),
      const_cast<C*>(instance)
    );

    g_signal_connect(
      img->get_image(), "preeval",
      G_CALLBACK((GtkHandlerProxy<C, VipsImage*, VipsProgress*, HandlerFunc>::HandlerProxy)),
      const_cast<C*>(instance)
    );

    g_signal_connect(
      img->get_image(), "posteval",
      G_CALLBACK((GtkHandlerProxy<C, VipsImage*, VipsProgress*, HandlerFunc>::HandlerProxy)),
      const_cast<C*>(instance)
    );

    g_signal_connect(
      img->get_image(), "written",
      G_CALLBACK((GtkHandlerProxy<C, VipsImage*, VipsProgress*, HandlerFunc>::HandlerProxy)),
      const_cast<C*>(instance)
    );
  }

private:
  template <class C>
  struct SignalData {
    vips::VImage* image;
    const C* instance;
  };

  ofxVips() = delete;
  ofxVips(ofxVips& other) = delete;
  ofxVips(ofxVips&& other) = delete;
};

#endif /* OFX_VIPS_H_SEEN */
