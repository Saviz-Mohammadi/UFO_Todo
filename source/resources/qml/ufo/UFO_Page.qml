import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

Item {
    id: root

    implicitWidth: 300
    implicitHeight: 300

    default property alias content: columnLayout_1.children
    property int contentSpacing: 7
    property real contentWidth: 0.80
    property int contentTopMargin: 20
    property int contentBottomMargin: 20
    property int contentLeftMargin: 20
    property alias title: text_1.text
    property real titleFontSize: 1.8

    Rectangle {
        id: rectangle_1

        anchors.fill: parent

        color: Qt.color(AppTheme.colors["UFO_Page_Background"])

        ScrollView {
            id: scrollView_1

            anchors.fill: parent

            anchors.topMargin: contentTopMargin
            anchors.bottomMargin: contentBottomMargin
            anchors.leftMargin: contentLeftMargin

            // Disable horizontal scrolling
            contentWidth: -1

            // If you want to enable horizontal scrolling, then it is best to place the target elemnt inside of another ScrollView.
            // This is because even if you want to achieve horizontal scrolling, ScrollView will only affect the element that it
            // immediately contains. So, even if you don't use "contentWidth: -1", then it will still not work.
            ColumnLayout {
                id: columnLayout_1

                // Instead of using the width of contentItem, you should use the width of the ScrollView itself.
                width: Math.round(scrollView_1.width * contentWidth)

                clip: true
                spacing: contentSpacing

                Text {
                    id: text_1

                    text: qsTr("")
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    color: Qt.color(AppTheme.colors["UFO_Page_Title"])
                    font.pixelSize: Qt.application.font.pixelSize * titleFontSize // Read-only property. Holds the default application font returned by QGuiApplication::font()
                    elide: Text.ElideRight
                }
            }
        }
    }
}
