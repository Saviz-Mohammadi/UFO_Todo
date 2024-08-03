#ifndef APPTHEME_H
#define APPTHEME_H

#include <QObject>
#include <QVariantMap>
#include <QQmlEngine>
#include <QGuiApplication>
#include <QSettings>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QRegularExpression>

class AppTheme : public QObject
{
    Q_OBJECT

    // This is neccessary for Singleton pattern.
    // Disables following:
    //
    // -- Copy constructor
    // -- Copy assignment operator
    // -- Move constructor
    // -- Move assignment operator
    Q_DISABLE_COPY_MOVE(AppTheme)

public:
    explicit AppTheme(QObject *parent = nullptr);
    ~AppTheme();

    // Q_PROPERTY;
private:
    Q_PROPERTY(QVariantMap Colors READ colors NOTIFY colorsChanged FINAL)
    Q_PROPERTY(QVariantMap Themes READ themes NOTIFY themesChanged FINAL)

    // Fields;
private:
    static AppTheme *m_Instance;

    // Properties;
private:
    QVariantMap m_Themes; // Contains pairs of file paths and their names.
    QVariantMap m_Colors; // Contains pairs of color values and their names.

    // Methods;
public:
    static AppTheme *qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine);
    static AppTheme *cppInstance(QObject *parent = nullptr);

    QVariantMap colors() const;
    QVariantMap themes() const;

    void addTheme(const QString &themeName, const QString &filePath);
    Q_INVOKABLE void loadColorsFromTheme(const QString &themeKey);

    Q_INVOKABLE QString cachedTheme() const;
    void clearCache();

    // Methods;
private:
    QString resolvePlaceholders(const QString &themeJson, const QString &placeholderJson);
    void cacheTheme(const QString &themeKey);

    // Signals;
signals:
    void colorsChanged();
    void themesChanged();
};

#endif // APPTHEME_H
