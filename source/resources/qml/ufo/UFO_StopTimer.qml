import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom CPP Registered Types
import AppTheme 1.0
import StopTimer 1.0


Rectangle {
    id: root

    implicitWidth: 200
    implicitHeight: 200

    color: "grey"

    // This way properties are not visible to the outside world.
    QtObject {
        id: qtObject_1

        property int hours: 0
        property int minutes: 0
        property int seconds: 0
        property int milliseconds: 0
    }

    ColumnLayout {
        id: columnLayout_1

        anchors.fill: parent

        UFO_ProgressBar {
            id: ufo_ProgressBar_1

            Layout.fillWidth: true
            Layout.fillHeight: true

            message: stopTimer_1.Time

            from: 0
            to: qtObject_1.milliseconds
            value: stopTimer_1.RemaningTime
        }

        RowLayout {
            id: rowLayout_1

            Layout.fillWidth: true
            Layout.fillHeight: true

            UFO_TextField {
                id: ufo_TextField_1

                Layout.fillWidth: true
                Layout.fillHeight: true

                validator: RegularExpressionValidator { regularExpression: /^[0-9]{1,2}$/ }
                placeholderText: qsTr("Enter hours")

                ToolTip {
                    text: "Please enter a whole number between 0 and 99"
                }

                onTextChanged: {
                    qtObject_1.hours = parseInt(ufo_TextField_1.text) || 0
                }
            }

            UFO_TextField {
                id: ufo_TextField_2

                Layout.fillWidth: true
                Layout.fillHeight: true

                validator: RegularExpressionValidator { regularExpression: /^[0-9]{1,2}$/ }
                placeholderText: qsTr("Enter minutes")

                ToolTip {
                    text: "Please enter a whole number between 0 and 99"
                }

                onTextChanged: {
                    qtObject_1.minutes = parseInt(ufo_TextField_2.text) || 0
                }
            }

            UFO_TextField {
                id: ufo_TextField_3

                Layout.fillWidth: true
                Layout.fillHeight: true

                validator: RegularExpressionValidator { regularExpression: /^[0-9]{1,2}$/ }
                placeholderText: qsTr("Enter seconds")

                ToolTip {
                    text: "Please enter a whole number between 0 and 99"
                }

                onTextChanged: {
                    qtObject_1.seconds = parseInt(ufo_TextField_3.text) || 0
                }
            }
        }

        RowLayout {
            id: rowLayout_2

            Layout.fillWidth: true
            Layout.fillHeight: true

            Button {
                id: button_1

                Layout.fillWidth: true
                Layout.fillHeight: true

                text: qsTr("Start")

                onClicked: {
                    // Convert hours + minutes + seconds into milliseconds
                    qtObject_1.milliseconds = (qtObject_1.hours * 3600 * 1000) + (qtObject_1.minutes * 60 * 1000) + (qtObject_1.seconds * 1000)

                    if(qtObject_1.milliseconds === 0)
                    {
                        return;
                    }

                    ufo_TextField_1.enabled = false
                    ufo_TextField_2.enabled = false
                    ufo_TextField_3.enabled = false

                    // Add some code here to make the message appear as the full number at first.

                    stopTimer_1.startTimer(qtObject_1.milliseconds, 1000)
                }
            }

            Button {
                id: button_2

                Layout.fillWidth: true
                Layout.fillHeight: true

                text: qsTr("Resume")
                enabled: false

                onClicked: {
                    ufo_TextField_1.enabled = false
                    ufo_TextField_2.enabled = false
                    ufo_TextField_3.enabled = false

                    stopTimer_1.resumeTimer()
                }
            }

            Button {
                id: button_3

                Layout.fillWidth: true
                Layout.fillHeight: true

                text: qsTr("Stop")
                enabled: false

                onClicked: {
                    ufo_TextField_1.enabled = true
                    ufo_TextField_2.enabled = true
                    ufo_TextField_3.enabled = true

                    stopTimer_1.stopTimer()
                }
            }
        }

        // The logic.
        StopTimer {
            id: stopTimer_1

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

                if(RemaningTime <= 0)
                {
                    // Here is where the timer really stops! We must send a notification.
                    return;
                }

                button_2.enabled = true
            }

            onTimerResumed: {
                button_1.enabled = false
                button_2.enabled = false
                button_3.enabled = true
            }
        }
    }
}
