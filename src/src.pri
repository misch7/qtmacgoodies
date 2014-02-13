#-------------------------------------------------
#
# Project created by QtCreator 2014-02-12T23:22:25
#
#-------------------------------------------------

QT += core gui
QT += widgets
QT += macextras

HEADERS += \
    $$PWD/macstandardicon.h \
    $$PWD/macpreferenceswindow.h

OBJECTIVE_SOURCES += \
    $$PWD/macstandardicon.mm \
    $$PWD/macpreferenceswindow.mm

INCLUDEPATH += $$PWD

LIBS_PRIVATE += -framework AppKit
