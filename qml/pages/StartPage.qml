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
    objectName: "startPage"
    allowedOrientations: Orientation.All

    PageHeader {
      id : mainheader
      objectName: "pageHeader"
      title: qsTr("Enter")
    }


//=====================*******==========================================*******=====================
    Label {
      id  : loginlabel
      anchors.top: mainheader.bottom
      text:  qsTr("Login")
    }

    TextField {
      id  : logintext
      anchors.top: loginlabel.bottom
      validator: RegExpValidator {
      regExp: /^[a-z][a-z0-9_-]{2,15}$/ }
      inputMethodHints: Qt.ImhNoAutoUppercase

      focus: true
      text: ""
    }

    Label {
      id  : passlabel
      anchors.top: logintext.bottom
      text:  qsTr("Password")
    }

    TextField {
      id  : passtext
      anchors.top: passlabel.bottom

      inputMethodHints: Qt.ImhDialableCharactersOnly
      validator: IntValidator {
        bottom: 0;
        top: 9
      }

      focus: true
      text: ""
    }

 //=====================*******=====================
    Label {
       id  :   errorlabel
       anchors.top: passtext.bottom
       anchors.horizontalCenter: parent.horizontalCenter
       color: "red"
       text:  qsTr("ERROR")
       visible: false
    }

    Button {
      id  : entButton
      anchors.top: errorlabel.bottom
      anchors.horizontalCenter: parent.horizontalCenter

       border.color : "black"
       text: "ENTER"
       onClicked: {

          var res = JS.dbReadUser(logintext.text)

          console.log("click->" + logintext.text + "=" + res[0] + "=" + res[1])

          if(res[0] === logintext.text  && res[1] === passtext.text && logintext.text !== "")
             {
               errorlabel.visible = false
               console.log("entbutton clicked!")
               pageStack.push(Qt.resolvedUrl("TaskPage.qml"))
             }
            else
             {
                errorlabel.visible = true
             }

       }
    }


    Button {
      id  : regButton
      anchors.top: entButton.bottom
      anchors.horizontalCenter: parent.horizontalCenter

       border.color : "black"
       text: "REGISTRATION"
       onClicked: {
         console.log("regbutton clicked!")
         pageStack.push(Qt.resolvedUrl("RegistrationPage.qml"))
       }
    }

//=====================*******==========================================*******=====================
        Component.onCompleted: {
         // dbDrop()

         JS.dbInit();
         JS.dbReadAllUser();

         JS.dbReadUser("JohnSmith@gmail.com");



          console.log("StartPagecomplite")
        }

//=====================*******==========================================*******=====================
}
