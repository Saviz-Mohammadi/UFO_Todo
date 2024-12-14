import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

Item {
    id: root

    property alias description: label.text
    property alias backgroundColor: rectangle_Task.color

    signal deleteClicked

    implicitWidth: 200
    implicitHeight: content.implicitHeight

    Rectangle {
        id: rectangle_Task

        width: parent.width
        height: content.implicitHeight

        radius: 0

        RowLayout {
            id: content

            anchors.fill: parent

            Label {
                id: label

                Layout.fillWidth: true
                Layout.fillHeight: true

                Layout.topMargin: 15
                Layout.bottomMargin: 15
                Layout.leftMargin: 15

                text: qsTr("")
                color: Qt.color(AppTheme.colors["UFO_ListDelegate_Text"])
                verticalAlignment: Text.AlignVCenter
            }

            Button {
                id: button

                width: 120
                height: 30

                Layout.topMargin: 15
                Layout.bottomMargin: 15
                Layout.rightMargin: 15

                text: "Done"
                hoverEnabled: true

                contentItem: RowLayout {

                    Item {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }

                    IconImage {
                        Layout.preferredWidth: 18
                        Layout.preferredHeight: 18

                        source: "./../../icons/Google icons/check_circle.svg"
                        smooth: true
                        mipmap: true
                        verticalAlignment: Image.AlignVCenter
                        antialiasing: true

                        color: {
                            color: {
                                if (button.pressed) {
                                    Qt.color(AppTheme.colors["UFO_ListDelegate_Icon_Pressed"])
                                }

                                else if (button.hovered) {
                                    Qt.color(AppTheme.colors["UFO_ListDelegate_Icon_Hovered"])
                                }

                                else {
                                    Qt.color(AppTheme.colors["UFO_ListDelegate_Icon_Normal"])
                                }
                            }
                        }
                    }

                    Text {
                        Layout.fillHeight: true

                        text: button.text
                        font: button.font
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter

                        color: {
                            if (button.pressed) {
                                Qt.color(AppTheme.colors["UFO_ListDelegate_Text_Pressed"])
                            }

                            else if (button.hovered) {
                                Qt.color(AppTheme.colors["UFO_ListDelegate_Text_Hovered"])
                            }

                            else {
                                Qt.color(AppTheme.colors["UFO_ListDelegate_Text_Normal"])
                            }
                        }
                    }

                    Item {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }
                }

                background: Rectangle {

                    radius: 0

                    color: {
                        if (button.pressed) {
                            Qt.color(AppTheme.colors["UFO_ListDelegate_Background_Pressed"])
                        }

                        else if (button.hovered) {
                            Qt.color(AppTheme.colors["UFO_ListDelegate_Background_Hovered"])
                        }

                        else {
                            Qt.color(AppTheme.colors["UFO_ListDelegate_Background_Normal"])
                        }
                    }
                }

                onClicked: {
                    root.deleteClicked()
                }
            }
        }
    }
}
