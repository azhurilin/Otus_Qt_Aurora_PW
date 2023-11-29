/*******************************************************************************
**
** Copyright (C) 2022 ru.auroraos
**
** This file is part of the My Aurora OS Application project.
**
** Redistribution and use in source and binary forms,
** with or without modification, are permitted provided
** that the following conditions are met:
**
** * Redistributions of source code must retain the above copyright notice,
**   this list of conditions and the following disclaimer.
** * Redistributions in binary form must reproduce the above copyright notice,
**   this list of conditions and the following disclaimer
**   in the documentation and/or other materials provided with the distribution.
** * Neither the name of the copyright holder nor the names of its contributors
**   may be used to endorse or promote products derived from this software
**   without specific prior written permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
** AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
** THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
** FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
** IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
** FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
** OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
** PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
** LOSS OF USE, DATA, OR PROFITS;
** OR BUSINESS INTERRUPTION)
** HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
** WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE)
** ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
** EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**
*******************************************************************************/
import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../assets/Database.js" as JS

Page {
    objectName: "RegistrationPage"
    allowedOrientations: Orientation.All

    SilicaFlickable {
      objectName: "flickable"
      anchors.fill: parent

      VerticalScrollDecorator { }

        PageHeader {
          id :  regheader
          objectName: "pageHeader"
          title: qsTr("Registration")
        }
//=====================*******=====================
        Label {
          id  : namelabel
          anchors.top: regheader.bottom
          text: qsTr("NAME")
        }
        TextField {
          id  : nametext
          anchors.top: namelabel.bottom
          focus: true
          text: qsTr("John")
        }

        Label {
          id  : surnamelabel
          anchors.top: nametext.bottom
          text:  qsTr("SURNAME")
        }
        TextField {
          id  : surnametext
          anchors.top: surnamelabel.bottom
          focus: true
          text: qsTr("Smith")
        }
//=====================*******=====================
        Label {
          id  :   maillabel
          anchors.top: surnametext.bottom
          text:  qsTr("Mail")
        }
        TextField {
          id  : mailtext
          anchors.top: maillabel.bottom
          inputMethodHints: Qt.ImhEmailCharactersOnly
          focus: true
          text: "JohnSmith@gmail.com"
        }
//=====================*******=====================
        Label {
          id  :   passlabel
          anchors.top: mailtext.bottom
          text:  qsTr("PASSWORD")
        }
        TextArea {
          id :  passtext
          anchors.top: passlabel.bottom
          focus: true
          text: qsTr("qwerty")
        }
//=====================*******=====================
        TextSwitch {
          id: spamswitch
          anchors.top: passtext.bottom
          text: qsTr("I agree to the newsletter")
        }
//=====================*******=====================
        Label {
          id  :   errorlabel
          anchors.top: spamswitch.bottom
          anchors.horizontalCenter: parent.horizontalCenter
          color: "red"
          text:  qsTr("ERROR")
          visible: false
        }


//=====================*******=====================
        Button{
          id: startbutton
          anchors.top: errorlabel.bottom
          anchors.horizontalCenter: parent.horizontalCenter

          preferredWidth : Theme.buttonWidthMedium
          text: qsTr("START")
          onClicked: {

            var res = JS.dbReadUser(mailtext.text)

            console.log("click->" + mailtext.text + "=" + res[0] + "=" + res[1])

            if(res[0] === mailtext.text)
              {
                 errorlabel.visible = true
              }
             else
              {
                 errorlabel.visible = false
                 JS.dbInsertUser(nametext.text, surnametext.text, mailtext.text, passtext.text, spamswitch.state);
                 pageStack.push(Qt.resolvedUrl("TaskPage.qml"))
                 console.log("startbutton clicked")
              }

           }
        }
//=====================*******==========================================*******=====================
   }
}
