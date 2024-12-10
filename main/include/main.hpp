#ifndef MAIN_H
#define MAIN_H

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFontDatabase>
#include <QIcon>
#include "app_theme.hpp"
#include "database.hpp"
#include "stop_timer.hpp"

void registerTypes();
void setupThemeSystem();
void chooseFirstTheme();
void readCustomFonts(const QGuiApplication &application);
void setGlobalFont(const QGuiApplication &application);
void setupDatabase();

#endif  //MAIN_H
