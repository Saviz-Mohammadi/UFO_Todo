import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom QML Files
import "./../ufo"

// Custom CPP Registered Types
import AppTheme 1.0

UFO_Page {
    id: root

    Layout.fillWidth: true
    Layout.fillHeight: true

    contentSpacing: 25
    contentWidth: 1.0
    title: qsTr("Timer")



    Flow {
        Layout.fillWidth: true

        spacing: 10

        UFO_StopTimer {
            id: ufo_StopTimer_1

            width: 400
            height: 300

            defaultMessage: "00:00:30"
            defaultSeconds: 30
        }

        UFO_StopTimer {
            id: ufo_StopTimer_2

            width: 400
            height: 300

            defaultMessage: "00:30:00"
            defaultMinutes: 30
        }

        UFO_StopTimer {
            id: ufo_StopTimer_3

            width: 400
            height: 300

            defaultMessage: "30:00:00"
            defaultHours: 30
        }
    }
}
