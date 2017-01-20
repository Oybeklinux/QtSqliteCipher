QT      += core sql sql-private core-private

QMAKE_CFLAGS += -fvisibility=hidden
QMAKE_CXXFLAGS += -fvisibility=hidden

CONFIG(debug, debug|release): TARGET = qsqlcipherd
CONFIG(release, debug|release): TARGET = qsqlcipher

TEMPLATE = lib

CONFIG(release, debug|release):DEFINES *= NDEBUG
DEFINES     += QT_PLUGIN

HEADERS  += $$PWD/qsql_sqlite_p.h

SOURCES  += $$PWD/qsql_sqlite.cpp \
            $$PWD/smain.cpp

OTHER_FILES += sqlitecipher.json

INCLUDEPATH += $$[QT_INSTALL_PREFIX]/../Src/qtbase/src/sql/kernel

include($$PWD/sqlcipher/sqlcipher.pri)

wince*: DEFINES += HAVE_LOCALTIME_S=0
PLUGIN_CLASS_NAME = SqliteCipherDriverPlugin
