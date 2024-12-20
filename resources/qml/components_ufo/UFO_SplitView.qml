import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0

SplitView {
    anchors.fill: parent

    handle: Rectangle {
        implicitWidth: 4
        implicitHeight: 4

        color: SplitHandle.pressed ? Qt.color(AppTheme.colors["UFO_SplitView_Handle_Pressed"]) : (SplitHandle.hovered ? Qt.color(AppTheme.colors["UFO_SplitView_Handle_Hovered"]) : Qt.color(AppTheme.colors["UFO_SplitView_Handle_Normal"]))
    }
}
