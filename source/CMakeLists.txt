# I find Modules and other new concepts in Qt/QML very challenging to grasp
# and somewhat unreliable. As a result, I mostly depend on my own
# straightforward methods for creating a Qt/QML project. Moreover, I've
# found the documentation to be quite inadequate.

# However, if you're keen on exploring these new concepts, there's an
# interesting blog post that provides better explanations:

# https://www.basyskom.de/en/2024/how-to-use-modern-qml-tooling-in-practice/

cmake_minimum_required(VERSION 3.16 FATAL_ERROR)


# [[ Project ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

project("UFO_Todo"

    VERSION 0.0.1

    DESCRIPTION "A simple Todo application made with the Qt framework"

    LANGUAGES CXX)


set(CMAKE_CXX_STANDARD 17)
set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


set(EXECUTABLE_NAME "${PROJECT_NAME}")

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Project ]]





# [[ Finding Qt Components ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

find_package(Qt6 6.7.2 COMPONENTS

    REQUIRED

    Core
    Widgets
    Gui
    Quick
    QuickControls2
    Network
    Sql
    Multimedia)

# Add more Qt Components as needed...

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Finding Qt Components ]]





# [[ Output Locations ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

set(OUTPUT_DIRECTORY "")




if(CMAKE_SIZEOF_VOID_P EQUAL 8)

    set(OUTPUT_DIRECTORY

        "${CMAKE_BINARY_DIR}/bin/${CMAKE_SYSTEM_NAME}/64-bit/")
endif()


if(CMAKE_SIZEOF_VOID_P EQUAL 4)

    set(OUTPUT_DIRECTORY

        "${CMAKE_BINARY_DIR}/bin/${CMAKE_SYSTEM_NAME}/32-bit/")
endif()




set(CMAKE_RUNTIME_OUTPUT_DIRECTORY	# Defines executable path

    "${OUTPUT_DIRECTORY}/$<CONFIG>/executable")


set(CMAKE_LIBRARY_OUTPUT_DIRECTORY	# Defines shared lib path

    "${OUTPUT_DIRECTORY}/$<CONFIG>/executable")


set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY	# Defines static lib path

    "${OUTPUT_DIRECTORY}/$<CONFIG>/lib_static")

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Output Locations ]]





# [[ Resource Files ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

set(BASE_RESOURCE_LOCATION

    "${CMAKE_SOURCE_DIR}/resources")


set(BASE_TXT_LOCATION

    "${BASE_RESOURCE_LOCATION}/txt")


set(BASE_JSON_LOCATION

    "${BASE_RESOURCE_LOCATION}/json")


set(BASE_ICON_LOCATION

    "${BASE_RESOURCE_LOCATION}/icons")


set(BASE_FONT_LOCATION

    "${BASE_RESOURCE_LOCATION}/fonts")


set(BASE_QML_LOCATION

    "${BASE_RESOURCE_LOCATION}/qml")


set(BASE_MUSIC_LOCATION

    "${BASE_RESOURCE_LOCATION}/music")


set(BASE_WINDOWS_LOCATION

    "${BASE_RESOURCE_LOCATION}/windows")




# Make sure to prefix the path with ${BASE_TXT_LOCATION}.
set(RESOURCE_TXT_FILES

    "")


# Make sure to prefix the path with ${BASE_JSON_LOCATION}.
set(RESOURCE_JSON_FILES

    "${BASE_JSON_LOCATION}/placeholder.json"
    "${BASE_JSON_LOCATION}/themes/theme_ufo/ufo_light.json"
    "${BASE_JSON_LOCATION}/themes/theme_ufo/ufo_dark.json")


# Make sure to prefix the path with ${BASE_ICON_LOCATION}.
set(RESOURCE_ICON_FILES

    "${BASE_ICON_LOCATION}/Google icons/help.svg"
    "${BASE_ICON_LOCATION}/Google icons/delete.svg"
    "${BASE_ICON_LOCATION}/Google icons/list.svg"
    "${BASE_ICON_LOCATION}/Google icons/settings.svg"
    "${BASE_ICON_LOCATION}/Google icons/alarm.svg"
    "${BASE_ICON_LOCATION}/Google icons/play.svg"
    "${BASE_ICON_LOCATION}/Google icons/resume.svg"
    "${BASE_ICON_LOCATION}/Google icons/stop.svg"
    "${BASE_ICON_LOCATION}/Application icons/ufo.png"
    "${BASE_ICON_LOCATION}/Application icons/ufo.ico")


# Make sure to prefix the path with ${BASE_ICON_LOCATION}.
set(RESOURCE_FONT_FILES

    "${BASE_FONT_LOCATION}/Titillium_Web/TitilliumWeb-Black.ttf"
    "${BASE_FONT_LOCATION}/Titillium_Web/TitilliumWeb-Bold.ttf"
    "${BASE_FONT_LOCATION}/Titillium_Web/TitilliumWeb-BoldItalic.ttf"
    "${BASE_FONT_LOCATION}/Titillium_Web/TitilliumWeb-ExtraLight.ttf"
    "${BASE_FONT_LOCATION}/Titillium_Web/TitilliumWeb-ExtraLightItalic.ttf"
    "${BASE_FONT_LOCATION}/Titillium_Web/TitilliumWeb-Italic.ttf"
    "${BASE_FONT_LOCATION}/Titillium_Web/TitilliumWeb-Light.ttf"
    "${BASE_FONT_LOCATION}/Titillium_Web/TitilliumWeb-LightItalic.ttf"
    "${BASE_FONT_LOCATION}/Titillium_Web/TitilliumWeb-Regular.ttf"
    "${BASE_FONT_LOCATION}/Titillium_Web/TitilliumWeb-SemiBold.ttf"
    "${BASE_FONT_LOCATION}/Titillium_Web/TitilliumWeb-SemiBoldItalic.ttf")


# Make sure to prefix the path with ${BASE_QML_LOCATION}.
set(RESOURCE_QML_FILES

    "${BASE_QML_LOCATION}/main.qml"
    "${BASE_QML_LOCATION}/ufo/UFO_MenuBar.qml"
    "${BASE_QML_LOCATION}/ufo/UFO_MenuBarItem.qml"
    "${BASE_QML_LOCATION}/ufo/UFO_Menu.qml"
    "${BASE_QML_LOCATION}/ufo/UFO_MenuItem.qml"
    "${BASE_QML_LOCATION}/ufo/UFO_MenuSeparator.qml"
    "${BASE_QML_LOCATION}/ufo/UFO_MenuItemIndicator.qml"
    "${BASE_QML_LOCATION}/ufo/UFO_MenuItemArrow.qml"
    "${BASE_QML_LOCATION}/ufo/UFO_StatusBar.qml"
    "${BASE_QML_LOCATION}/ufo/UFO_SideBarButton.qml"
    "${BASE_QML_LOCATION}/ufo/UFO_SideBar.qml"
    "${BASE_QML_LOCATION}/ufo/UFO_Page.qml"
    "${BASE_QML_LOCATION}/ufo/UFO_SideBarSeparator.qml"
    "${BASE_QML_LOCATION}/ufo/UFO_GroupBox.qml"
    "${BASE_QML_LOCATION}/ufo/UFO_ComboBox.qml"
    "${BASE_QML_LOCATION}/ufo/UFO_TextField.qml"
    "${BASE_QML_LOCATION}/ufo/UFO_ListDelegate.qml"
    "${BASE_QML_LOCATION}/ufo/UFO_ProgressBar.qml"
    "${BASE_QML_LOCATION}/ufo/UFO_StopTimer.qml"
    "${BASE_QML_LOCATION}/ufo/UFO_Button.qml"
    "${BASE_QML_LOCATION}/pages/UFO_About.qml"
    "${BASE_QML_LOCATION}/pages/UFO_Settings.qml"
    "${BASE_QML_LOCATION}/pages/UFO_Timer.qml"
    "${BASE_QML_LOCATION}/pages/UFO_TaskList.qml")


set(RESOURCE_MUSIC_FILES

    "${BASE_MUSIC_LOCATION}/sound effects/simple-notification.mp3"
    "${BASE_MUSIC_LOCATION}/sound effects/simple-notification.wav")


# Only add these files if the target platform is Windows
if(WIN32)
set(RESOURCE_WINDOWS_FILES

    "${BASE_WINDOWS_LOCATION}/icons.rc")
endif()

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Resource Files ]]





# [[ Executable Target ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

qt_add_executable(${EXECUTABLE_NAME})





set(HEADER_FILES

    # HPP
    "${CMAKE_SOURCE_DIR}/internal_libraries/main/include/main.hpp")

set(SOURCE_FILES

    # CPP
    "${CMAKE_SOURCE_DIR}/internal_libraries/main/src/main.cpp")




target_sources(${EXECUTABLE_NAME}

    PUBLIC
    ${HEADER_FILES}

    PRIVATE
    ${SOURCE_FILES}

    # Resource Files
    ${RESOURCE_TXT_FILES}
    ${RESOURCE_JSON_FILES}
    ${RESOURCE_ICON_FILES}
    ${RESOURCE_FONT_FILES}
    ${RESOURCE_QML_FILES}
    ${RESOURCE_MUSIC_FILES})




# Only add these files if the target platform is Windows
if(WIN32)
    target_sources(${EXECUTABLE_NAME}

        PRIVATE
        ${RESOURCE_WINDOWS_FILES})
endif()




target_include_directories(${EXECUTABLE_NAME}

    PUBLIC
    "${CMAKE_SOURCE_DIR}/internal_libraries/main/include")

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Executable Target ]]





# [[ Custom tools ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

include("${CMAKE_SOURCE_DIR}/cmake_scripts/other/copy_resources.cmake")

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Custom tools ]]





# [[ Adding Qt libraries ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

target_link_libraries(${EXECUTABLE_NAME}

    PRIVATE

    Qt6::Core
    Qt6::Widgets
    Qt6::Gui
    Qt6::Quick
    Qt6::QuickControls2
    Qt6::Network
    Qt6::Sql
    Qt6::Multimedia)




set_target_properties(${EXECUTABLE_NAME} PROPERTIES

    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.${EXECUTABLE_NAME}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE)




include(GNUInstallDirs)

install(TARGETS ${EXECUTABLE_NAME}

    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Adding Qt libraries ]]





# [[ Internal Libraries ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

add_subdirectory("${CMAKE_SOURCE_DIR}/internal_libraries")




target_link_libraries(${EXECUTABLE_NAME}

    PRIVATE
    "Lib_AppTheme"
    "Lib_Database"
    "Lib_StopTimer")

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Internal Libraries ]]
