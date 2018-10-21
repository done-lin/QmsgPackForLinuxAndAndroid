##
## qt 5.6.1 is tested, for unbuntu 16.04 x64, and compile and tested app on android 7.0---- done lin
## just comple the src directory, and generate a qmsgpackd.a static lib, we must use static lib on Android!
## 2018.08.07
##
QT       += core gui

TARGET = qmsgpack
CONFIG   -= app_bundle

TEMPLATE = lib
DEFINES += MSGPACK_MAKE_LIB
DESTDIR = $$PWD/../bin
QMAKE_CXXFLAGS += -fPIC

## 在ubuntu 16.04 64bit linux上测试通过,生成了a文件在bin目录
##2018.10.21. 在windows migw, qt5.9.4上测试通过,生成了a文件在bin目录.! ok
CONFIG   += debug_and_release  staticlib
CONFIG(debug, debug|release) {
     TARGET = $$join(TARGET,,,d)
}


SOURCES += msgpack.cpp \
    msgpackcommon.cpp \
    private/pack_p.cpp \
    private/unpack_p.cpp \
    private/qt_types_p.cpp \
    msgpackstream.cpp \
    stream/time.cpp \
    stream/geometry.cpp

HEADERS += \
    msgpack.h \
    private/pack_p.h \
    private/unpack_p.h \
    endianhelper.h \
    msgpackcommon.h \
    msgpack_export.h \
    private/qt_types_p.h \
    msgpackstream.h \
    stream/time.h \
    stream/geometry.h

HEADERS_INSTALL = \
    msgpack.h \
    endianhelper.h \
    msgpackcommon.h \
    msgpack_export.h \
    msgpackstream.h \

STREAM_HEADERS_INSTALL = \
    stream/time.h

qtHaveModule(location) {
    QT += location

    SOURCES += stream/location.cpp
    HEADERS += stream/location.h
    STREAM_HEADERS_INSTALL += stream/location.h
}

unix {
    header_files.files = $$HEADERS_INSTALL
    header_files.path = /usr/include/qmsgpack
    stream_header_files.files = $$STREAM_HEADERS_INSTALL
    stream_header_files.path = /usr/include/qmsgpack/stream
    target.path = /usr/lib
    INSTALLS += header_files stream_header_files target
}
