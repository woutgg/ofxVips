# All variables and this file are optional, if they are not present the PG and the
# makefiles will try to parse the correct values from the file system.
#
# Variables that specify exclusions can use % as a wildcard to specify that anything in
# that position will match. A partial path can also be specified to, for example, exclude
# a whole folder from the parsed paths from the file system
#
# Variables can be specified using = or +=
# = will clear the contents of that variable both specified from the file or the ones parsed
# from the file system
# += will add the values to the previous ones in the file or the ones parsed from the file
# system
#
# The PG can be used to detect errors in this file, just create a new project with this addon
# and the PG will write to the console the kind of error and in which line it is

meta:
	ADDON_NAME = ofxVips
	ADDON_DESCRIPTION = Thin wrapper addon for libvips
	ADDON_AUTHOR = woutgg
	ADDON_TAGS = "image processing"
	ADDON_URL = -

common:
	# dependencies with other addons, a list of them separated by spaces
	# or use += in several lines
	# ADDON_DEPENDENCIES =

	# include search paths, this will be usually parsed from the file system
	# but if the addon or addon libraries need special search paths they can be
	# specified here separated by spaces or one per line using +=
	# ADDON_INCLUDES =

	# any special flag that should be passed to the compiler when using this
	# addon
	# ADDON_CFLAGS =

	# any special flag that should be passed to the linker when using this
	# addon, also used for system libraries with -lname
	# ADDON_LDFLAGS =

	# linux only, any library that should be included in the project using
	# pkg-config
	# ADDON_PKG_CONFIG_LIBRARIES =

	# osx/iOS only, any framework that should be included in the project
	# ADDON_FRAMEWORKS =

	# source files, these will be usually parsed from the file system looking
	# in the src folders in libs and the root of the addon. if your addon needs
	# to include files in different places or a different set of files per platform
	# they can be specified here
	# ADDON_SOURCES =

	# some addons need resources to be copied to the bin/data folder of the project
	# specify here any files that need to be copied, you can use wildcards like * and ?
	# ADDON_DATA =

	# when parsing the file system looking for libraries exclude this for all or
	# a specific platform
	# ADDON_LIBS_EXCLUDE =





linux64:
	ADDON_PKG_CONFIG_LIBRARIES = expat libexif libjpeg spng
	ADDON_LDFLAGS = -ltiff
	ADDON_LIBS =
	ADDON_LIBS += libs/lib/linux64/libvips-cpp.a
	ADDON_LIBS += libs/lib/linux64/libvips.a

linux:
	ADDON_PKG_CONFIG_LIBRARIES = expat libexif libjpeg spng
	ADDON_LDFLAGS = -ltiff
	ADDON_LIBS =
	ADDON_LIBS += libs/lib/linux64/libvips-cpp.a
	ADDON_LIBS += libs/lib/linux64/libvips.a

# Reference how/what to compile more or less as here: https://github.com/lovell/libvips-cpp-dll/blob/master/binding.gyp,
# and here: https://github.com/libvips/libvips/issues/508.
vs:
	# Note: exclude source files which should not be compiled or are compiled indirectly.
	ADDON_SOURCES_EXCLUDE =
	ADDON_SOURCES_EXCLUDE += libs/vips-cplusplus/vips-operators.cpp
	ADDON_SOURCES_EXCLUDE += libs/include/glib-2.0/gio/
	ADDON_SOURCES_EXCLUDE += libs/include/glib-2.0/girepository/
	ADDON_SOURCES_EXCLUDE += libs/include/glib-2.0/glib/
	ADDON_SOURCES_EXCLUDE += libs/include/glib-2.0/gmodule/
	ADDON_SOURCES_EXCLUDE += libs/include/glib-2.0/gobject/
	ADDON_SOURCES_EXCLUDE += libs/vips-cplusplus/examples/
	ADDON_SOURCES_EXCLUDE += libs/vips-cplusplus/include/
	# Note: these paths end up in C/C++ -> General -> 'Additional Include Directories'.
	ADDON_INCLUDES =
	ADDON_INCLUDES += src
	ADDON_INCLUDES += libs/include
	ADDON_INCLUDES += libs/include/glib-2.0
	ADDON_INCLUDES += libs/lib/win64/glib-2.0/include
	ADDON_LIBS =
	# Note: these paths end up in Linker -> General -> 'Additional Library Directories', the files in Linker -> Input -> 'Additional Dependencies'.
	ADDON_LIBS += libs/lib/win64/libglib-2.0.lib
	ADDON_LIBS += libs/lib/win64/libgobject-2.0.lib
	ADDON_LIBS += libs/lib/win64/libvips.lib
	ADDON_DLLS_TO_COPY =
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libaom.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libarchive-13.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libbrotlicommon.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libbrotlidec.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libbrotlienc.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libc++.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libcairo-2.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libcfitsio.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libcgif-0.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libdicom-1.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libexif-12.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libexpat-1.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libffi-8.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libfftw3-3.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libfontconfig-1.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libfreetype-6.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libfribidi-0.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libgdk_pixbuf-2.0-0.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libgio-2.0-0.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libglib-2.0-0.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libgmodule-2.0-0.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libgobject-2.0-0.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libharfbuzz-0.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libheif.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libhwy.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libIex-3_1.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libIlmThread-3_1.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libimagequant.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libjpeg-62.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libjxl.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libjxl_cms.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libjxl_threads.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/liblcms2-2.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libMagickCore-6.Q16-7.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libmatio-13.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libniftiio.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libOpenEXR-3_1.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libopenjp2.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libopenslide-1.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libpango-1.0-0.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libpangocairo-1.0-0.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libpangoft2-1.0-0.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libpixman-1-0.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libpng16-16.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libpoppler-150.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libpoppler-glib-8.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/librsvg-2-2.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libsharpyuv-0.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libspng-0.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libsqlite3-0.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libtiff-6.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libunwind.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libvips-42.dll
	# ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libvips-cpp-42.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libwebp-7.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libwebpdemux-2.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libwebpmux-3.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libxml2-16.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libz1.dll
	ADDON_DLLS_TO_COPY += libs/lib/win64/dll/libznz.dll
