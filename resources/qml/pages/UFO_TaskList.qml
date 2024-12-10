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

    Layout.fillWidth: true
    Layout.fillHeight: true

    contentSpacing: 25
    title: qsTr("Task List")

    UFO_TextField {
        id: ufo_TextField_1

        placeholderText: qsTr("[Press Enter to add task]")

        Layout.fillWidth: true
        Layout.preferredHeight: 45

        Layout.bottomMargin: 5

        // When "Enter" key is pressed.
        onAccepted: {
            var id = Database.addTask(ufo_TextField_1.text)

            listModel_1.append({
                                   "task_id": id,
                                   "task_description": ufo_TextField_1.text
                               })

            ufo_TextField_1.clear()
        }
    }

    ListView {
        id: listView_1

        Layout.fillWidth: true
        Layout.preferredHeight: root.height - ufo_TextField_1.height

        spacing: 10
        clip: true

        model: ListModel {
            id: listModel_1

            // For the very first time, load all tasks from database.
            Component.onCompleted: {
                Database.obtainAllTasks().forEach(function (task) {

                    listModel_1.append({
                                           "task_id": task.id,
                                           "task_description": task.task
                                       })
                })
            }
        }

        delegate: UFO_ListDelegate {
            id: ufo_ListDelegate_1

            width: listView_1.width

            // Change background color of ListDelegate per each row.
            backgroundColor: index % 2 === 0 ? Qt.color(
                                                   AppTheme.colors["UFO_ListDelegate_Background_1"]) : Qt.color(AppTheme.colors["UFO_ListDelegate_Background_2"])

            description: model.task_description

            onDeleteClicked: {
                Database.removeTask(model.task_id)
                listModel_1.remove(index)
            }
        }
    }
}
