import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0


Item {
    id: root

    implicitWidth: 300
    implicitHeight: columnLayout_1.height

    default property alias content: columnLayout_1.children
    property int contentSpacing: 7
    property alias title: text_1.text
    property real titleFontSize: 1.3
    property real titleTopMargin: 10
    property real titleLeftMargin: 20

    Rectangle {
        id: rectangle_1

        anchors.fill: parent

        color: Qt.color(AppTheme.Colors["UFO_GroupBox_Background"])

        radius: 4

        ColumnLayout {
            id: columnLayout_1

            clip: true
            spacing: contentSpacing

            Text {
                id: text_1

                Layout.topMargin: titleTopMargin
                Layout.leftMargin: titleLeftMargin
                text: qsTr("")
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                color: Qt.color(AppTheme.Colors["UFO_GroupBox_Title"])
                font.pixelSize: Qt.application.font.pixelSize * titleFontSize // Read-only property. Holds the default application font returned by QGuiApplication::font()
                elide: Text.ElideRight
            }

            Rectangle {
                id: rectangle_2

                Layout.preferredWidth: root.width
                Layout.preferredHeight: 1

                color: Qt.color(AppTheme.Colors["UFO_GroupBox_Separator"])
            }
        }
    }
}
