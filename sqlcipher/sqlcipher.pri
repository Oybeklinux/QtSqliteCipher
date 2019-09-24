# see http://sourceforge.net/projects/wxcode
CONFIG(release, debug|release):DEFINES *= NDEBUG

DEFINES += SQLITE_OMIT_LOAD_EXTENSION SQLITE_OMIT_COMPLETE SQLITE_ENABLE_FTS3 SQLITE_ENABLE_FTS3_PARENTHESIS \
    SQLITE_ENABLE_FTS4 SQLITE_ENABLE_FTS4_PARENTHESIS \
    SQLITE_ENABLE_FTS5 SQLITE_ENABLE_FTS5_PARENTHESIS \
    SQLITE_ENABLE_RTREE SQLITE_HAS_CODEC \
    DISABLE_COLUMN_METADATA

!contains(CONFIG, largefile):DEFINES += SQLITE_DISABLE_LFS
contains(QT_CONFIG, posix_fallocate):DEFINES += HAVE_POSIX_FALLOCATE=1
winrt: DEFINES += SQLITE_OS_WINRT
winphone: DEFINES += SQLITE_WIN32_FILEMAPPING_API=1
qnx: DEFINES += _QNX_SOURCE

android {

    # Android >= 6.0 requires apps to install their own libcrypto.so and libssl.so
    # https://subsite.visualstudio.com/DefaultCollection/android-openssl
    equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
        ANDROID_EXTRA_LIBS += $${PWD}/lib/armeabi-v7a/libcrypto.so
    LIBS += -L$$PWD/lib/armeabi-v7a -lsqlcipher -lcrypto
    }
    equals(ANDROID_TARGET_ARCH, arm64-v8a) {
        ANDROID_EXTRA_LIBS += $${PWD}/lib/arm64-v8a/libcrypto.so
    LIBS += -L$$PWD/lib/arm64-v8a -lsqlcipher -lcrypto
    }
    equals(ANDROID_TARGET_ARCH, x86)  {
#        ANDROID_EXTRA_LIBS += $$files($${PWD}/platform/android/lib/openssl/arch-x86/*.so)
    }
} else {
    LIBS += -L$$PWD/lib -lsqlcipher -lcrypto #-lsqlite3
}

INCLUDEPATH +=  $$PWD
DEPENDPATH  += $$PWD

HEADERS += \
    $$PWD/sqlite3.h \
    $$PWD/sqlite3ext.h

SOURCES += \
    $$PWD/sqlite3.c

TR_EXCLUDE += $$PWD/*
