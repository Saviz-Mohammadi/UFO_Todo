#include "app_theme.hpp"

AppTheme* AppTheme::m_Instance = nullptr;

AppTheme::AppTheme(QObject *parent)
    : QObject{parent}
    , m_Colors()
    , m_Themes()
{}

AppTheme *AppTheme::qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    if (!m_Instance)
    {
        m_Instance = new AppTheme();
    }

    return(m_Instance);
}

AppTheme *AppTheme::cppInstance(QObject *parent)
{
    if(m_Instance)
    {
        return(qobject_cast<AppTheme *>(AppTheme::m_Instance));
    }

    auto instance = new AppTheme(parent);
    m_Instance = instance;
    return(instance);
}

AppTheme::~AppTheme()
{}

QVariantMap AppTheme::themes() const
{
    return (m_Themes);
}

QVariantMap AppTheme::colors() const
{
    return (m_Colors);
}

// This method allows us to store the last used theme in an INI file for future use.
// Caching is enabled by default; however, the choice to use the cache is yours.
void AppTheme::cacheTheme(const QString &themeKey)
{
    QSettings settings(

        QGuiApplication::applicationDirPath() + "/cache/theme.ini",
        QSettings::Format::IniFormat
        );

    settings.setValue(

        "lastUsedThemeKey",
        themeKey
        );

    settings.sync();
}

// This method will load the last Theme used;
QString AppTheme::cachedTheme() const
{
    QSettings settings(

        QGuiApplication::applicationDirPath() + "/cache/theme.ini",
        QSettings::Format::IniFormat
        );

    QVariant returnValue = settings.value("lastUsedThemeKey");


    if(returnValue.isNull())
    {
        return "";
    }


    return returnValue.toString();
}

void AppTheme::clearCache()
{
    QSettings settings(

        QGuiApplication::applicationDirPath() + "/cache/theme.ini",
        QSettings::Format::IniFormat
        );

    settings.clear();
}

void AppTheme::addTheme(const QString &themeName, const QString &filePath)
{
    QFile file(filePath);

    if (!file.exists())
    {
        qDebug() << "File does not exist: " << filePath;

        return;
    }

    if (themeName.isEmpty())
    {
        qDebug() << "Provided Theme name is empty! Please provide a non-empty name.";

        return;
    }

    // You can add more rules for how the QString should look
    // here by using Regex if you wish to;

    m_Themes.insert(themeName, filePath);
}

void AppTheme::loadColorsFromTheme(const QString &themeKey)
{
    QVariantMap map;
    QString filePath = themes().value(themeKey).toString();


    // Saving to cache;
    cacheTheme(themeKey);


    QFile themeFile(filePath);
    QFile placeholderFile("./resources/json/placeholder.json");

    if (!themeFile.open(QIODevice::ReadOnly))
    {
        qWarning() << "Could not open JSON file:" << filePath;

        return;
    }

    if (!placeholderFile.open(QIODevice::ReadOnly))
    {
        qWarning() << "Could not open JSON file:" << "placeholder.json";

        return;
    }


    QByteArray themeJsonData = themeFile.readAll();
    themeFile.close();

    QByteArray placeholderJsonData = placeholderFile.readAll();
    placeholderFile.close();


    QString resolvedJson = resolvePlaceholders(themeJsonData, placeholderJsonData);


    QJsonDocument jsonDoc = QJsonDocument::fromJson(

        resolvedJson.toUtf8()
        );

    QJsonObject rootObject = jsonDoc.object();

    for (auto it = rootObject.begin(); it != rootObject.end(); ++it)
    {
        map[it.key()] = it.value().toString();
    }

    // Making a safety check, then emitting change;
    if (m_Colors == map) { return; }

    // Setting new set of colors;
    m_Colors = map;

    // Syncronizing changes across application;
    emit colorsChanged();
}


// This method is luxury and can be discarded if wanted. This a nice method that
// enables creating temporary placeholders in json files and relpace them with
// their actual vaule using Regex string manipulation;
QString AppTheme::resolvePlaceholders(const QString &themeJson, const QString &placeholderJson)
{
    QJsonObject themeJsonObject = QJsonDocument::fromJson(

        themeJson.toUtf8()
        ).object();

    QJsonObject placeholderJsonObject = QJsonDocument::fromJson(

        placeholderJson.toUtf8()
        ).object();

    // Final version of the theme after replacing placeholders;
    QString resolvedThemeString = themeJson;


    // This Regex pattern is used to match placeholders that have the following pattern:
    // "Color_char*_numbers[0-9]";
    static const QRegularExpression placeholderRegex("\"(Color_[a-zA-Z]*_[0-9]+)\"");

    QRegularExpressionMatchIterator iter = placeholderRegex.globalMatch(themeJson);


    while (iter.hasNext())
    {
        QRegularExpressionMatch match = iter.next();

        QString placeholder = match.captured(1);

        if (placeholderJsonObject.contains(placeholder))
        {
            QJsonValue replacementValue = placeholderJsonObject.value(placeholder);

            resolvedThemeString.replace(

                placeholder,
                replacementValue.toString()
                );
        }

        else
        {
            qDebug() << "Placeholder" << placeholder << "not found in placeholder.json file.";
        }
    }

    return (resolvedThemeString);
}
