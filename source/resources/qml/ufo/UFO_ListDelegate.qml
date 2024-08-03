import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0


Item {
    id: root
    property alias description: label_1.text
    property alias backgroundColor: rectangle_Task.color

    signal deleteClicked()

    implicitWidth: 200
    implicitHeight: content.implicitHeight

    Rectangle {
        id: rectangle_Task
        width: parent.width
        height: content.implicitHeight

        radius: 4

        RowLayout {
            id: content
            anchors.fill: parent

            Label {
                id: label_1

                Layout.fillWidth: true
                Layout.fillHeight: true

                Layout.topMargin: 15
                Layout.bottomMargin: 15
                Layout.leftMargin: 15

                text: qsTr("")
                color: Qt.color(AppTheme.Colors["UFO_ListDelegate_Text"])
                verticalAlignment: Text.AlignVCenter
            }

            Button {
                id: button_1

                width: 120
                height: 30

                Layout.topMargin: 15
                Layout.bottomMargin: 15
                Layout.rightMargin: 15

                text: "Delete"
                hoverEnabled: true

                contentItem: RowLayout {

                    Item {
                        id: item_1

                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }

                    IconImage {
                        source: "./../../icons/Google icons/delete.svg"
                        smooth: true
                        mipmap: true
                        Layout.preferredWidth: 18
                        Layout.preferredHeight: 18
                        verticalAlignment: Image.AlignVCenter
                        antialiasing: true

                        color: {
                            color: {
                                if(button_1.pressed) {
                                    Qt.color(AppTheme.Colors["UFO_ListDelegate_Icon_Pressed"])
                                }

                                else if(button_1.hovered) {
                                    Qt.color(AppTheme.Colors["UFO_ListDelegate_Icon_Hovered"])
                                }

                                else {
                                    Qt.color(AppTheme.Colors["UFO_ListDelegate_Icon_Normal"])
                                }
                            }
                        }
                    }

                    Text {
                        Layout.fillHeight: true
                        text: button_1.text
                        font: button_1.font
                        horizontalAlignment : Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter

                        color: {
                            if(button_1.pressed) {
                                Qt.color(AppTheme.Colors["UFO_ListDelegate_Text_Pressed"])
                            }

                            else if(button_1.hovered) {
                                Qt.color(AppTheme.Colors["UFO_ListDelegate_Text_Hovered"])
                            }

                            else {
                                Qt.color(AppTheme.Colors["UFO_ListDelegate_Text_Normal"])
                            }
                        }
                    }

                    Item {
                        id: item_2

                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }
                }

                background: Rectangle {

                    radius: 4

                    color: {
                        if(button_1.pressed) {
                            Qt.color(AppTheme.Colors["UFO_ListDelegate_Background_Pressed"])
                        }

                        else if(button_1.hovered) {
                            Qt.color(AppTheme.Colors["UFO_ListDelegate_Background_Hovered"])
                        }

                        else {
                            Qt.color(AppTheme.Colors["UFO_ListDelegate_Background_Normal"])
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
