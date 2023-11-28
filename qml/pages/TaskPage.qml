//=====================*******==========================================*******=====================

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../assets/Database.js" as JS

Page {
    allowedOrientations: Orientation.All

    property int noteEditFlag

//=====================*******=====================
    ListModel {
      id: listModel
    }
//=====================*******==========================================*******=====================
    PageHeader {
      id :  reqheader
      objectName: "pageHeader"
      title: qsTr("Task")
    }

    Label {
        id  : datelabel
        anchors.top: reqheader.bottom
        text: qsTr("DATE")
    }

    TextField {
      id: dateInput
      anchors.top: datelabel.bottom
      validator: RegExpValidator { regExp: /[0-9/,:.]+/ }
        }

    Label {
        id  : disclabel
        anchors.top: dateInput.bottom
        text: qsTr("TASK")
    }

    TextField {
        id: descInput
        anchors.top: disclabel.bottom
    }

    Button {
        id: saveButton
        anchors.top: descInput.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        preferredWidth : Theme.buttonWidthMedium
        text: qsTr("SAVE")

        onClicked: {

           if (noteEditFlag == 0)
             {
              JS.dbInsert(dateInput.text, descInput.text);
              listModel.clear();
              JS.dbReadAll();
             }
           else
            {
              JS.dbUpdate(noteEditFlag, dateInput.text, descInput.text);
              listModel.clear();
              JS.dbReadAll();
              noteEditFlag = 0;
            }


        }
     }
//=====================*******==========================================*******=====================
    SilicaListView {
        id: taskList
        anchors.top:  saveButton.bottom
        anchors.left:  parent.left
        anchors.right:  parent.right
        anchors.bottom:  parent.bottom

        header: Component {
          Label {
            text: qsTr("TASKS")
          }
        }

        model: listModel

        delegate: ListItem {
            width: taskList.width
            Label {
                id: firstName
                text: model.id + " " + model.date + " " + model.request
                anchors.verticalCenter: parent.verticalCenter
                x: Theme.horizontalPageMargin
            }


            menu: ContextMenu {
                id: contmenu
                MenuItem {
                    text: qsTr("TRACK")
                    onClicked: {
                       console.log("track clicked!")
                       pageStack.push(Qt.resolvedUrl("MapPage.qml"))

                    }
                }
                MenuItem {
                    id : cm1
                    text: qsTr("EDIT")
                    onClicked: {
                      dateInput.text = model.date
                      descInput.text = model.request

                      noteEditFlag = model.id

                    }

                }
                MenuItem {
                    text: qsTr("DELETE")
                    onClicked: {
                      JS.dbDelete(model.id)
                      listModel.clear();
                      JS.dbReadAll();

                    }
                }
             }



        }
        VerticalScrollDecorator {}
    }
//=====================*******==========================================*******=====================
    Component.onCompleted: {
     // dbDrop()

     JS.dbInit();
     JS.dbReadAll();

     noteEditFlag = 0

      console.log("TaskPagecomplite")
    }

//=====================*******==========================================*******=====================
}
