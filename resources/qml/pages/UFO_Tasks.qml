import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// Custom QML Files
import "./../components_ufo"

// Custom CPP Registered Types
import AppTheme 1.0
import Database 1.0

UFO_Page {
    id: root

    title: qsTr("Task List")
    contentSpacing: 20

    UFO_TextField {
        id: ufo_TaskField

        Layout.fillWidth: true
        Layout.preferredHeight: 45

        Layout.bottomMargin: 5

        placeholderText: qsTr("[Press Enter to add task]")

        onAccepted: {
            var id = Database.addTask(ufo_TaskField.text)

            listModel.append({"task_id": id, "task_description": ufo_TaskField.text})

            ufo_TaskField.clear()
        }
    }



    ListView {
        id: listView

        Layout.fillWidth: true
        Layout.preferredHeight: root.height - ufo_TaskField.height

        spacing: 10
        clip: true

        model: ListModel {
            id: listModel

            // NOTE (SAVIZ): Load all tasks from database on startup.
            Component.onCompleted: {

                Database.obtainAllTasks().forEach(function (task) {
                    listModel.append({"task_id": task.id, "task_description": task.task})
                })
            }
        }

        delegate: UFO_ListDelegate {
            width: listView.width

            // NOTE (SAVIZ): This is not really needed. I just think this is a nice touch as it allows to have delegates with different colors.
            backgroundColor: index % 2 === 0 ? Qt.color(
                                                   AppTheme.colors["UFO_ListDelegate_Background_1"]) : Qt.color(AppTheme.colors["UFO_ListDelegate_Background_2"])

            description: model.task_description

            onDeleteClicked: {
                Database.removeTask(model.task_id)

                listModel.remove(index)
            }
        }
    }
}
