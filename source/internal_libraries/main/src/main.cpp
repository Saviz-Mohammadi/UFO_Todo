#include "main.hpp"

int main(int argc, char *argv[])
{
    QGuiApplication application(argc, argv);
    QQmlApplicationEngine engine;


    registerTypes();
    setupThemeSystem();
    chooseFirstTheme();
    readCustomFonts(application);
    setGlobalFont(application);
    setupDatabase();


    // Load main.qml to start the engine. (Relative path from executable)
    engine.load("./resources/qml/main.qml");


    // Launch Event loop.
    return application.exec();
}


// You can register your C++ types to be visible to QML here.
void registerTypes()
{
    qmlRegisterSingletonType<AppTheme>("AppTheme", 1, 0, "AppTheme", &AppTheme::qmlInstance);
    qmlRegisterSingletonType<Database>("Database", 1, 0, "Database", &Database::qmlInstance);
    qmlRegisterType<StopTimer>("StopTimer", 1, 0, "StopTimer");
}

void setupThemeSystem()
{
    AppTheme *appTheme = AppTheme::cppInstance();


    appTheme->addTheme(

        "light",
        "./resources/json/theme_ufo/light.json"
    );

    appTheme->addTheme(

        "dark",
        "./resources/json/theme_ufo/dark.json"
    );
}

void chooseFirstTheme()
{
    AppTheme *appTheme = AppTheme::cppInstance();

    QString lastUsedThemeKey = appTheme->cachedTheme();


    if(!lastUsedThemeKey.isEmpty())
    {
        appTheme->loadColorsFromTheme(lastUsedThemeKey);

        return;
    }

    appTheme->loadColorsFromTheme("light");
}

void readCustomFonts(const QGuiApplication &application)
{
    // Path to font files.
    QStringList fontPaths;

    fontPaths << application.applicationDirPath() + "/resources/fonts/Titillium_Web/TitilliumWeb-Black.ttf"
              << application.applicationDirPath() + "/resources/fonts/Titillium_Web/TitilliumWeb-Bold.ttf"
              << application.applicationDirPath() + "/resources/fonts/Titillium_Web/TitilliumWeb-BoldItalic.ttf"
              << application.applicationDirPath() + "/resources/fonts/Titillium_Web/TitilliumWeb-ExtraLight.ttf"
              << application.applicationDirPath() + "/resources/fonts/Titillium_Web/TitilliumWeb-ExtraLightItalic.ttf"
              << application.applicationDirPath() + "/resources/fonts/Titillium_Web/TitilliumWeb-Italic.ttf"
              << application.applicationDirPath() + "/resources/fonts/Titillium_Web/TitilliumWeb-Light.ttf"
              << application.applicationDirPath() + "/resources/fonts/Titillium_Web/TitilliumWeb-LightItalic.ttf"
              << application.applicationDirPath() + "/resources/fonts/Titillium_Web/TitilliumWeb-Regular.ttf"
              << application.applicationDirPath() + "/resources/fonts/Titillium_Web/TitilliumWeb-SemiBold.ttf"
              << application.applicationDirPath() + "/resources/fonts/Titillium_Web/TitilliumWeb-SemiBoldItalic.ttf";

    // Looping through each font file.
    foreach (const QString &fontPath, fontPaths)
    {
        int fontId = QFontDatabase::addApplicationFont(fontPath);

        if (fontId == -1)
        {
            #ifdef QT_DEBUG
            qDebug() << "Failed to load font file:" << fontPath;
            #endif
        }
    }
}

void setGlobalFont(const QGuiApplication &application)
{
    // The name is automatically set by Qt and depends on the metadata of the file.
    // Refer to Google Fonts to find out the correct name to use.
    QString fontFamilyName = "Titillium Web";


    // Check if the font family is available.
    if (QFontDatabase::families().contains(fontFamilyName))
    {
        // Font family is available, use it
        QFont customFont(

            fontFamilyName,
            11
            );

        QGuiApplication::setFont(customFont);
    }

    else
    {
        // Font family is not available, handle the error.

        #ifdef QT_DEBUG
        qDebug() << "Font family" << fontFamilyName << "is not available.";
        #endif
    }
}

void setupDatabase()
{
    Database *Database = Database::cppInstance();

    Database->establishConnection("tasks.db");
}
