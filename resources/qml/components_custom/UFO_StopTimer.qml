import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtMultimedia
import Qt.labs.platform

// Custom QML Files
import "./../components_ufo"

// Custom CPP Registered Types
import AppTheme 1.0
import StopTimer 1.0

Rectangle {
    id: root

    property string defaultMessage: "00:00:00"
    property int defaultHours: 0
    property int defaultMinutes: 0
    property int defaultSeconds: 0

    implicitWidth: 200
    implicitHeight: 200

    color: Qt.color(AppTheme.colors["UFO_StopTimer_Background"])

    radius: 0

    // This way properties are not visible to the outside world.
    QtObject {
        id: qtObject_1

        property int hours: 0
        property int minutes: 0
        property int seconds: 0
        property int milliseconds: 0

        // For the very first time make sure to read defaults.
        Component.onCompleted: {
            hours = root.defaultHours
            minutes = root.defaultMinutes
            seconds = root.defaultSeconds
        }
    }

    ColumnLayout {
        id: columnLayout_1

        anchors.fill: parent
        anchors.margins: 10

        UFO_ProgressBar {
            id: ufo_ProgressBar_1

            Layout.fillWidth: true
            Layout.fillHeight: true

            // The -25 is for creating some space.
            circleWidth: root.implicitWidth - 25
            circleHeight: root.implicitHeight - 25

            message: defaultMessage

            from: 0
            to: qtObject_1.milliseconds
            value: stopTimer_1.remaningTime
        }

        RowLayout {
            id: rowLayout_1

            Layout.fillWidth: true
            Layout.preferredHeight: 40

            Item {
                id: item_1

                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            UFO_TextField {
                id: ufo_TextField_1

                Layout.fillWidth: true
                Layout.preferredHeight: 35

                validator: RegularExpressionValidator {
                    regularExpression: /^[0-9]{1,2}$/
                }

                placeholderText: qsTr("Hours")

                ToolTip.visible: hovered
                ToolTip.text: "Number can only be between 0 and 99"

                onTextChanged: {
                    var input = parseInt(ufo_TextField_1.text)

                    if (input !== 0) {
                        qtObject_1.hours = input
                        return
                    }

                    if (root.defaultHours !== 0) {
                        qtObject_1.hours = root.defaultHours
                        return
                    }

                    // Otherwise, don't do anything.
                }
            }

            UFO_TextField {
                id: ufo_TextField_2

                Layout.fillWidth: true
                Layout.preferredHeight: 35

                validator: RegularExpressionValidator {
                    regularExpression: /^[0-9]{1,2}$/
                }

                placeholderText: qsTr("Minutes")

                ToolTip.visible: hovered
                ToolTip.text: "Number can only be between 0 and 99"

                onTextChanged: {
                    var input = parseInt(ufo_TextField_2.text)

                    if (input !== 0) {
                        qtObject_1.minutes = input
                        return
                    }

                    if (root.defaultMinutes !== 0) {
                        qtObject_1.minutes = root.defaultMinutes
                        return
                    }

                    // Otherwise, don't do anything.
                }
            }

            UFO_TextField {
                id: ufo_TextField_3

                Layout.fillWidth: true
                Layout.preferredHeight: 35

                validator: RegularExpressionValidator {
                    regularExpression: /^[0-9]{1,2}$/
                }

                placeholderText: qsTr("Seconds")

                ToolTip.visible: hovered
                ToolTip.text: "Number can only be between 0 and 99"

                onTextChanged: {
                    var input = parseInt(ufo_TextField_3.text)

                    if (input !== 0) {
                        qtObject_1.seconds = input
                        return
                    }

                    if (root.defaultSeconds !== 0) {
                        qtObject_1.seconds = root.defaultSeconds
                        return
                    }

                    // Otherwise, don't do anything.
                }
            }

            Item {
                id: item_2

                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }

        RowLayout {
            id: rowLayout_2

            Layout.fillWidth: true
            Layout.preferredHeight: 40

            Item {
                id: item_3

                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            UFO_Button {
                id: button_1

                Layout.fillWidth: true
                Layout.preferredHeight: 35

                text: qsTr("Start")
                svg: "./../../icons/Google icons/play.svg"

                onClicked: {
                    // Convert hours + minutes + seconds into milliseconds
                    qtObject_1.milliseconds = (qtObject_1.hours * 3600 * 1000)
                            + (qtObject_1.minutes * 60 * 1000) + (qtObject_1.seconds * 1000)

                    if (qtObject_1.milliseconds === 0) {
                        return
                    }

                    ufo_TextField_1.enabled = false
                    ufo_TextField_2.enabled = false
                    ufo_TextField_3.enabled = false

                    // Add some code here to make the message appear as the full number at first.
                    stopTimer_1.startTimer(qtObject_1.milliseconds, 1000)
                }
            }

            UFO_Button {
                id: button_2

                Layout.fillWidth: true
                Layout.preferredHeight: 35

                text: qsTr("Resume")
                enabled: false
                svg: "./../../icons/Google icons/resume.svg"

                onClicked: {
                    ufo_TextField_1.enabled = false
                    ufo_TextField_2.enabled = false
                    ufo_TextField_3.enabled = false

                    stopTimer_1.resumeTimer()
                }
            }

            UFO_Button {
                id: button_3

                Layout.fillWidth: true
                Layout.preferredHeight: 35

                text: qsTr("Stop")
                enabled: false
                svg: "./../../icons/Google icons/stop.svg"

                onClicked: {
                    ufo_TextField_1.enabled = true
                    ufo_TextField_2.enabled = true
                    ufo_TextField_3.enabled = true

                    stopTimer_1.stopTimer()
                }
            }

            Item {
                id: item_4

                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }

        // The logic.
        StopTimer {
            id: stopTimer_1

            onTimeChanged: {
                ufo_ProgressBar_1.message = stopTimer_1.time
            }

            onTimerStarted: {
                button_1.enabled = false
                button_2.enabled = false
                button_3.enabled = true
            }

            onTimerStopped: {
                ufo_TextField_1.enabled = true
                ufo_TextField_2.enabled = true
                ufo_TextField_3.enabled = true
                button_1.enabled = true
                button_3.enabled = false

                if (remaningTime <= 0) {

                    systemTrayIcon_1.showMessage(
                        qsTr("Timer Finished!"),
                        qsTr("The application timer has ended.")
                    )

                    soundEffect_1.play()

                    return
                }

                button_2.enabled = true
            }

            onTimerResumed: {
                button_1.enabled = false
                button_2.enabled = false
                button_3.enabled = true
            }
        }

        SoundEffect {
            id: soundEffect_1

            loops: 3
            source: "./../../music/sound effects/notification.wav"
        }

        SystemTrayIcon {
            id: systemTrayIcon_1

            visible: true
            icon.source: "./../../icons/Application icons/ufo.ico"
            icon.mask: false

            menu: Menu {
                id: menu_1

                MenuItem {
                    id: menuItem_1

                    text: qsTr("Quit")
                    onTriggered: Qt.quit()
                }
            }

            onActivated: {
                soundEffect_1.stop()
            }
        }
    }
}
