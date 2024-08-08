import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom QML Files
import "ufo"
import "pages"

// Custom CPP Registered Types
import AppTheme 1.0

ApplicationWindow {
    id: root

    width: 800
    height: 600

    visible: true
    title: qsTr("UFO_Todo")

    menuBar: UFO_MenuBar {
        id: ufo_MenuBar_1

        spacing: 0

        // File
        // [[ ---------------------------------------------------------------------- ]]
        // [[ ---------------------------------------------------------------------- ]]
        UFO_Menu {
            id: ufo_Menu_1

            title: qsTr("File")
            topMargin: 0
            leftMargin: 0

            UFO_MenuItem {
                id: ufo_MenuItem_1

                leftPadding: 10
                rightPadding: 10
                text: qsTr("Quit")

                onTriggered: {
                    Qt.quit()
                }
            }
        }
        // [[ ---------------------------------------------------------------------- ]]
        // [[ ---------------------------------------------------------------------- ]]
        // File

        // View
        // [[ ---------------------------------------------------------------------- ]]
        // [[ ---------------------------------------------------------------------- ]]
        UFO_Menu {
            id: ufo_Menu_2

            title: qsTr("View")
            topMargin: 0
            leftMargin: 0

            UFO_MenuItem {
                id: ufo_MenuItem_2

                leftPadding: 10
                rightPadding: 10
                text: qsTr("Task List")

                onTriggered: {
                    stackLayout_1.currentIndex = 0
                }
            }

            UFO_MenuSeparator {
                id: ufo_MenuSeparator_1

                leftPadding: 10
                rightPadding: 10
            }

            UFO_MenuItem {
                id: ufo_MenuItem_3

                leftPadding: 10
                rightPadding: 10
                text: qsTr("Timer")

                onTriggered: {
                    stackLayout_1.currentIndex = 1
                }
            }

            UFO_MenuSeparator {
                id: ufo_MenuSeparator_2

                leftPadding: 10
                rightPadding: 10
            }

            UFO_MenuItem {
                id: ufo_MenuItem_4

                leftPadding: 10
                rightPadding: 10
                text: qsTr("Settings")

                onTriggered: {
                    stackLayout_1.currentIndex = 2
                }
            }

            UFO_MenuSeparator {
                id: ufo_MenuSeparator_3

                leftPadding: 10
                rightPadding: 10
            }

            UFO_MenuItem {
                id: ufo_MenuItem_5

                leftPadding: 10
                rightPadding: 10
                text: qsTr("About")

                onTriggered: {
                    stackLayout_1.currentIndex = 3
                }
            }
        }
        // [[ ---------------------------------------------------------------------- ]]
        // [[ ---------------------------------------------------------------------- ]]
        // View

        // Help
        // [[ ---------------------------------------------------------------------- ]]
        // [[ ---------------------------------------------------------------------- ]]
        UFO_Menu {
            id: ufo_Menu_3

            title: qsTr("Help")
            topMargin: 0
            leftMargin: 0

            UFO_MenuItem {
                id: ufo_MenuItem_6

                leftPadding: 10
                rightPadding: 10
                text: qsTr("About UFO_Todo")

                onTriggered: {
                    stackLayout_1.currentIndex = 3
                }
            }
        }
        // [[ ---------------------------------------------------------------------- ]]
        // [[ ---------------------------------------------------------------------- ]]
        // Help
    }

    footer: UFO_StatusBar {
        id: ufo_StatusBar_1

        text: qsTr("Status Bar")
    }

    SplitView {
        id: splitView_1

        anchors.fill: parent

        UFO_SideBar {
            id: ufo_SideBar_1

            Layout.preferredWidth: 200 // This will give an initial startup width to the SideBar.
            Layout.fillHeight: true
        }

        StackLayout {
            id: stackLayout_1

            Layout.fillWidth: true
            Layout.fillHeight: true

            currentIndex: 0

            UFO_TaskList {
                id: ufo_TaskList

                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            UFO_Timer {
                id: ufo_Timer

                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            UFO_Settings {
                id: ufo_Settings

                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            UFO_About {
                id: ufo_About

                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Connections {
                target: ufo_SideBar_1

                function onTabChanged(index) {
                    switch (index) {
                    case 0:
                        stackLayout_1.currentIndex = 0
                        break
                    case 1:
                        stackLayout_1.currentIndex = 1
                        break
                    case 2:
                        stackLayout_1.currentIndex = 2
                        break
                    default:
                        stackLayout_1.currentIndex = 3
                    }
                }
            }
        }
    }
}
