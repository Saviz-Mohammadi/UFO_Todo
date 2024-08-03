import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom QML Files
import "ufo"

// Custom CPP Registered Types
import AppTheme 1.0
import Database 1.0
import StopTimer 1.0


ApplicationWindow {
    id: root

    width: 800
    height: 700

    visible: true
    title: qsTr("UFO_Todo")




    // MenuBar
    // [[ ---------------------------------------------------------------------- ]]
    // [[ ---------------------------------------------------------------------- ]]
    menuBar: UFO_MenuBar {
        id: ufo_MenuBar_1

        spacing: 0




        // File
        // [[ ---------------------------------------------------------------------- ]]
        // [[ ---------------------------------------------------------------------- ]]
        UFO_Menu {
            id: ufo_Menu_1

            title: qsTr("File")
            topMargin: 40
            leftMargin: 4

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
            topMargin: 40
            leftMargin: 4

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
            topMargin: 40
            leftMargin: 4

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
    // [[ ---------------------------------------------------------------------- ]]
    // [[ ---------------------------------------------------------------------- ]]
    // MenuBar




    // Footer
    // [[ ---------------------------------------------------------------------- ]]
    // [[ ---------------------------------------------------------------------- ]]
    footer: UFO_StatusBar {
        id: ufo_StatusBar_1

        text: qsTr("Status Bar")
    }
    // [[ ---------------------------------------------------------------------- ]]
    // [[ ---------------------------------------------------------------------- ]]
    // Footer




    // SplitView
    // [[ ---------------------------------------------------------------------- ]]
    // [[ ---------------------------------------------------------------------- ]]
    SplitView {
        id: splitView_1

        anchors.fill: parent




        // SideBar
        // [[ ---------------------------------------------------------------------- ]]
        // [[ ---------------------------------------------------------------------- ]]
        UFO_SideBar {
            id: ufo_SideBar_1

            Layout.preferredWidth: 200 // This will give an initial startup width to the SideBar.
            Layout.fillHeight: true
        }
        // [[ ---------------------------------------------------------------------- ]]
        // [[ ---------------------------------------------------------------------- ]]
        // SideBar




        // StackLayout
        // [[ ---------------------------------------------------------------------- ]]
        // [[ ---------------------------------------------------------------------- ]]
        StackLayout {
            id: stackLayout_1

            Layout.fillWidth: true
            Layout.fillHeight: true

            currentIndex: 0




            // Task List
            // [[ ---------------------------------------------------------------------- ]]
            // [[ ---------------------------------------------------------------------- ]]
            UFO_Page {
                id: ufo_Page_0

                Layout.fillWidth: true
                Layout.fillHeight: true

                contentSpacing: 25
                title: qsTr("Task List")




                // TextField
                // [[ ---------------------------------------------------------------------- ]]
                // [[ ---------------------------------------------------------------------- ]]
                UFO_TextField {
                    id: ufo_TextField_1

                    placeholderText: qsTr("[Press Enter to add task]")

                    Layout.fillWidth: true
                    Layout.preferredHeight: 45

                    Layout.bottomMargin: 5

                    // When "Enter" key is pressed.
                    onAccepted: {
                        var id = Database.addTask(ufo_TextField_1.text);

                        listModel_1.append(
                            {task_id: id, task_description: ufo_TextField_1.text}
                        )

                        ufo_TextField_1.clear()
                    }
                }
                // [[ ---------------------------------------------------------------------- ]]
                // [[ ---------------------------------------------------------------------- ]]
                // TextField




                // List
                // [[ ---------------------------------------------------------------------- ]]
                // [[ ---------------------------------------------------------------------- ]]
                ListView {
                    id: listView_1

                    Layout.fillWidth: true
                    Layout.preferredHeight: ufo_Page_0.height - ufo_TextField_1.height

                    spacing: 10
                    clip: true

                    model: ListModel {
                        id: listModel_1

                        // For the very first time, load all tasks from database.
                        Component.onCompleted: {
                            Database.obtainAllTasks().forEach(function(task) {

                                listModel_1.append(
                                    {task_id: task.id, task_description: task.task}
                                );
                            });
                        }
                    }

                    delegate: UFO_ListDelegate {
                        id: ufo_ListDelegate_1

                        width: listView_1.width

                        // Change background color of ListDelegate per each row.
                        backgroundColor: index % 2 === 0 ? Qt.color(AppTheme.Colors["UFO_ListDelegate_Background_1"]) : Qt.color(AppTheme.Colors["UFO_ListDelegate_Background_2"])

                        description: model.task_description

                        onDeleteClicked: {
                            Database.removeTask(model.task_id);
                            listModel_1.remove(index);
                        }
                    }
                }
                // [[ ---------------------------------------------------------------------- ]]
                // [[ ---------------------------------------------------------------------- ]]
                // List




            }
            // [[ ---------------------------------------------------------------------- ]]
            // [[ ---------------------------------------------------------------------- ]]
            // Task List




            // Timer
            // [[ ---------------------------------------------------------------------- ]]
            // [[ ---------------------------------------------------------------------- ]]
            UFO_Page {
                id: ufo_Page_1

                Layout.fillWidth: true
                Layout.fillHeight: true

                contentSpacing: 25
                title: qsTr("Timer")




                // Timer
                // [[ ---------------------------------------------------------------------- ]]
                // [[ ---------------------------------------------------------------------- ]]
                UFO_StopTimer {
                    id: ufo_StopTimer_1

                    Layout.fillWidth: true
                    Layout.preferredHeight: 350
                }
                // [[ ---------------------------------------------------------------------- ]]
                // [[ ---------------------------------------------------------------------- ]]
                // Timer




            }
            // [[ ---------------------------------------------------------------------- ]]
            // [[ ---------------------------------------------------------------------- ]]
            // Timer




            // Settings
            // [[ ---------------------------------------------------------------------- ]]
            // [[ ---------------------------------------------------------------------- ]]
            UFO_Page {
                id: ufo_Page_2

                Layout.fillWidth: true
                Layout.fillHeight: true

                title: qsTr("Application Settings")
                contentSpacing: 20

                // Settings Page
                UFO_GroupBox {
                    id: ufo_GroupBox_1

                    Layout.fillWidth: true
                    // No point setting the "Layout.fillHeight" as "UFO_Page" ignores height to enable vertical scrolling.

                    title: qsTr("Style")
                    contentSpacing: 10

                    Text {
                        id: text_2

                        Layout.preferredWidth: ufo_GroupBox_1.width - 50

                        Layout.topMargin: 20
                        Layout.bottomMargin: ufo_GroupBox_1.titleTopMargin
                        Layout.leftMargin: ufo_GroupBox_1.titleLeftMargin
                        text: qsTr("The theme will be cached and loaded on application launch.")
                        color: Qt.color(AppTheme.Colors["UFO_GroupBox_Text"])
                        wrapMode: Text.WordWrap
                    }

                    UFO_ComboBox {
                        id: ufo_ComboBox_1

                        Layout.preferredHeight: 30
                        Layout.preferredWidth: 100

                        model: Object.keys(AppTheme.Themes)
                        Layout.bottomMargin: ufo_GroupBox_4.titleTopMargin
                        Layout.leftMargin: ufo_GroupBox_4.titleLeftMargin

                        onActivated: {
                            // Grab the text when a new element is selected.
                            AppTheme.loadColorsFromTheme(currentText)
                        }

                        Component.onCompleted: {
                            // Obtain the name of last used Theme.
                            var cachedTheme = AppTheme.cachedTheme()

                            // This function looks at every entry, and finds the one that corresponds
                            // to our cachedTheme name. Then it will set the index to that.
                            for (var index = 0; index < ufo_ComboBox_1.model.length; ++index) {
                                if (ufo_ComboBox_1.model[index] === cachedTheme) {
                                    ufo_ComboBox_1.currentIndex = index;
                                    return;
                                }
                            }
                        }
                    }
                }
            }
            // [[ ---------------------------------------------------------------------- ]]
            // [[ ---------------------------------------------------------------------- ]]
            // Settings




            // About
            // [[ ---------------------------------------------------------------------- ]]
            // [[ ---------------------------------------------------------------------- ]]
            UFO_Page {
                id: ufo_Page_3

                Layout.fillWidth: true
                Layout.fillHeight: true

                title: qsTr("About Application")
                contentSpacing: 20




                // Application Name and Version
                // [[ ---------------------------------------------------------------------- ]]
                // [[ ---------------------------------------------------------------------- ]]
                UFO_GroupBox {
                    id: ufo_GroupBox_2

                    Layout.fillWidth: true
                    // No point setting the "Layout.fillHeight" as "UFO_Page" ignores height to enable vertical scrolling.

                    title: qsTr("Application Name and Version")
                    contentSpacing: 10

                    Text {
                        id: text_3

                        Layout.preferredWidth: ufo_GroupBox_2.width - 50

                        Layout.topMargin: 20
                        Layout.bottomMargin: ufo_GroupBox_2.titleTopMargin
                        Layout.leftMargin: ufo_GroupBox_2.titleLeftMargin
                        text: qsTr("Name: UFO_Todo")+ "\n" +
                              qsTr("Version: 0.0.1 Beta")
                        color: Qt.color(AppTheme.Colors["UFO_GroupBox_Text"])
                        wrapMode: Text.WordWrap
                    }
                }
                // [[ ---------------------------------------------------------------------- ]]
                // [[ ---------------------------------------------------------------------- ]]
                // Application Name and Version




                // Software License
                // [[ ---------------------------------------------------------------------- ]]
                // [[ ---------------------------------------------------------------------- ]]
                UFO_GroupBox {
                    id: ufo_GroupBox_3

                    Layout.fillWidth: true
                    // No point setting the "Layout.fillHeight" as "UFO_Page" ignores height to enable vertical scrolling.

                    title: qsTr("Software License")
                    contentSpacing: 10

                    Text {
                        id: text_4

                        Layout.preferredWidth: ufo_GroupBox_3.width - 50

                        Layout.topMargin: 20
                        Layout.bottomMargin: ufo_GroupBox_3.titleTopMargin
                        Layout.leftMargin: ufo_GroupBox_3.titleLeftMargin
                        text: qsTr("Copyright © 2024 Saviz Mohammadi") + "\n" +
                              qsTr("Licensed under the MIT License. See LICENSE for details.") + "\n\n" +
                              qsTr("MIT License") + "\n\n" +
                              qsTr("Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"[Your Application Name]\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:") + "\n\n" +
                              qsTr("The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.") + "\n\n" +
                              qsTr("THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.")
                        color: Qt.color(AppTheme.Colors["UFO_GroupBox_Text"])
                        wrapMode: Text.WordWrap
                    }
                }
                // [[ ---------------------------------------------------------------------- ]]
                // [[ ---------------------------------------------------------------------- ]]
                // Software License




                // Contribution
                // [[ ---------------------------------------------------------------------- ]]
                // [[ ---------------------------------------------------------------------- ]]
                UFO_GroupBox {
                    id: ufo_GroupBox_4

                    Layout.fillWidth: true
                    // No point setting the "Layout.fillHeight" as "UFO_Page" ignores height to enable vertical scrolling.

                    title: qsTr("Contributing")
                    contentSpacing: 10

                    Text {
                        id: text_5

                        Layout.preferredWidth: ufo_GroupBox_4.width - 50

                        Layout.topMargin: 20
                        Layout.bottomMargin: ufo_GroupBox_4.titleTopMargin
                        Layout.leftMargin: ufo_GroupBox_4.titleLeftMargin
                        text: qsTr("We welcome contributions to the UFO_Todo application! Please visit our <a href=\"https://www.google.com/\">GitHub page</a> for more information.")
                        color: Qt.color(AppTheme.Colors["UFO_GroupBox_Text"])
                        wrapMode: Text.WordWrap

                        HoverHandler {
                            id: hoverHandler_1

                            enabled: parent.hoveredLink
                            cursorShape: Qt.PointingHandCursor
                        }

                        onLinkActivated: {
                            Qt.openUrlExternally(text_4.hoveredLink);
                        }
                    }
                }
                // [[ ---------------------------------------------------------------------- ]]
                // [[ ---------------------------------------------------------------------- ]]
                // Contribution




            }
            // [[ ---------------------------------------------------------------------- ]]
            // [[ ---------------------------------------------------------------------- ]]
            // About




            // Connections
            // [[ ---------------------------------------------------------------------- ]]
            // [[ ---------------------------------------------------------------------- ]]
            Connections {
                target: ufo_SideBar_1

                function onTabChanged(index) {
                    switch (index) {
                        case 0:
                            stackLayout_1.currentIndex = 0;
                            break;
                        case 1:
                            stackLayout_1.currentIndex = 1;
                            break;
                        case 2:
                            stackLayout_1.currentIndex = 2;
                            break;
                        default:
                            stackLayout_1.currentIndex = 3;
                    }
                }
            }
            // [[ ---------------------------------------------------------------------- ]]
            // [[ ---------------------------------------------------------------------- ]]
            // Connections




        }
        // [[ ---------------------------------------------------------------------- ]]
        // [[ ---------------------------------------------------------------------- ]]
        // StackLayout




    }
    // [[ ---------------------------------------------------------------------- ]]
    // [[ ---------------------------------------------------------------------- ]]
    // SplitView
}
