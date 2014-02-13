#-------------------------------------------------
#
# Project created by QtCreator 2014-02-12T23:22:25
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = qt-macpreferenceswindow
TEMPLATE = app


SOURCES += main.cpp
OBJECTIVE_SOURCES += macpreferenceswindow.mm

HEADERS  += macpreferenceswindow.h

LIBS_PRIVATE += -framework AppKit
