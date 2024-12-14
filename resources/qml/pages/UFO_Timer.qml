import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom QML Files
import "./../components_ufo"
import "./../components_custom"

// Custom CPP Registered Types
import AppTheme 1.0

UFO_Page {
    id: root

    title: qsTr("Timers")
    contentSpacing: 20

    Flow {
        Layout.fillWidth: true

        spacing: 10

        UFO_StopTimer {
            width: 400
            height: 300

            defaultMessage: "00:00:30"
            defaultSeconds: 30
        }

        UFO_StopTimer {
            width: 400
            height: 300

            defaultMessage: "00:30:00"
            defaultMinutes: 30
        }

        UFO_StopTimer {
            width: 400
            height: 300

            defaultMessage: "01:00:00"
            defaultHours: 30
        }

        UFO_StopTimer {
            width: 400
            height: 300

            defaultMessage: "05:00:00"
            defaultHours: 30
        }

        UFO_StopTimer {
            width: 400
            height: 300

            defaultMessage: "10:00:00"
            defaultHours: 30
        }

        UFO_StopTimer {
            width: 400
            height: 300

            defaultMessage: "30:00:00"
            defaultHours: 30
        }
    }
}
