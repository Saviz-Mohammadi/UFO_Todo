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

    QtObject {
        id: qtObject_Properties

        property int hours: 0
        property int minutes: 0
        property int seconds: 0
        property int milliseconds: 0

        Component.onCompleted: {
            hours = root.defaultHours
            minutes = root.defaultMinutes
            seconds = root.defaultSeconds
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10

        UFO_ProgressBar {
            id: ufo_ProgressBar

            Layout.fillWidth: true
            Layout.fillHeight: true

            // NOTE (SAVIZ): The "- 25" is for creating some additional space.
            circleWidth: root.implicitWidth - 25
            circleHeight: root.implicitHeight - 25

            message: defaultMessage

            from: 0
            to: qtObject_Properties.milliseconds
            value: stopTimer_1.remaningTime
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 40

            Item {
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

                onTextChanged: {
                    var input = parseInt(ufo_TextField_1.text)

                    if (input !== 0) {
                        qtObject_Properties.hours = input

                        return
                    }

                    if (root.defaultHours !== 0) {
                        qtObject_Properties.hours = root.defaultHours

                        return
                    }

                    // NOTE (SAVIZ): Otherwise, don't perform any actions.
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

                onTextChanged: {
                    var input = parseInt(ufo_TextField_2.text)

                    if (input !== 0) {
                        qtObject_Properties.minutes = input

                        return
                    }

                    if (root.defaultMinutes !== 0) {
                        qtObject_Properties.minutes = root.defaultMinutes

                        return
                    }

                    // NOTE (SAVIZ): Otherwise, don't perform any actions.
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

                onTextChanged: {
                    var input = parseInt(ufo_TextField_3.text)

                    if (input !== 0) {
                        qtObject_Properties.seconds = input

                        return
                    }

                    if (root.defaultSeconds !== 0) {
                        qtObject_Properties.seconds = root.defaultSeconds

                        return
                    }

                    // NOTE (SAVIZ): Otherwise, don't perform any actions.
                }
            }

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 40

            Item {
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
                    qtObject_Properties.milliseconds = (qtObject_Properties.hours * 3600 * 1000) + (qtObject_Properties.minutes * 60 * 1000) + (qtObject_Properties.seconds * 1000)

                    if (qtObject_Properties.milliseconds === 0) {
                        return
                    }

                    ufo_TextField_1.enabled = false
                    ufo_TextField_2.enabled = false
                    ufo_TextField_3.enabled = false

                    stopTimer_1.startTimer(qtObject_Properties.milliseconds, 1000)
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
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }



        StopTimer {
            id: stopTimer_1

            onTimeChanged: {
                ufo_ProgressBar.message = stopTimer_1.time
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

                    systemTrayIcon.showMessage(
                        qsTr("Timer Finished!"),
                        qsTr("The application timer has ended.")
                    )

                    soundEffect.play()

                    ufo_StatusBar.displayMessage("Timer Finished!")

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
            id: soundEffect

            loops: 3
            source: "./../../music/sound effects/notification.wav"
        }

        SystemTrayIcon {
            id: systemTrayIcon

            visible: true
            icon.source: "./../../icons/Application icons/ufo.ico"
            icon.mask: false

            menu: Menu {

                MenuItem {
                    text: qsTr("Quit")
                    onTriggered: Qt.quit()
                }
            }

            onActivated: {
                soundEffect.stop()
            }
        }
    }
}
