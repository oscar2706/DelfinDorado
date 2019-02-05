import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.0

//import QtQuick.Dialogs 1.2

ApplicationWindow{
    visible: true
    width: 1366
    height: 720
    title: qsTr("Prueba inicial")
    //color: color("#008d9e")

    Image {
        id: name
        fillMode: Image.Tile
        opacity: 1
        anchors.fill: parent
        source: "img/loginBackground.png"
    }

    Image {
        id: image
        x: 30
        y: 30
        width: 70
        height: 70
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.top: parent.top
        anchors.topMargin: 30
        fillMode: Image.PreserveAspectFit
        source: "img/logo.png"
    }

    Pane {
        id: pane
        x: 483
        y: 160
        width: 350
        height: 400
        antialiasing: true
        anchors.centerIn: parent
        Material.elevation: 8
        Material.background: "#FFFFFF"
        //Material.background: Material.Amber

        ColumnLayout{
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            spacing: 0
            clip: true

            Image {
                antialiasing: true
                Layout.minimumHeight: 100
                Layout.minimumWidth: 100
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.columnSpan: 1
                Layout.rowSpan: 1
                Layout.maximumHeight: 100
                Layout.maximumWidth: 100
                fillMode: Image.PreserveAspectFit
                visible: true
                source: "img/loginUser.png"
            }

            RowLayout{
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillWidth: false
                spacing: 10
                Label {
                    text: qsTr("Empleado:")
                }
                TextField {
                    //placeholderText: qsTr("User name")
                    onTextChanged: persona.getUserName = text
                }
            }

            RowLayout{
                spacing: 10
                Layout.alignment: Qt.AlignHCenter
                Label {
                    text: qsTr("Contraseña:")
                }
                TextField {
                    //placeholderText: qsTr("User name")
                    onTextChanged: persona.getUserName = text
                }
            }
            RoundButton{
                radius: 20
                width: 120
                text: qsTr("Iniciar sesión")
                antialiasing: true
                autoRepeat: false
                spacing: 0
                Layout.maximumHeight: 65535
                Layout.minimumHeight: 50
                Layout.minimumWidth: 120
                Layout.preferredHeight: 50
                Layout.preferredWidth: 120
                hoverEnabled: true
                focusPolicy: Qt.NoFocus
                padding: 0
                font.capitalization: Font.MixedCase
                font.family: "Verdana"
                flat: false
                font.pointSize: 10
                highlighted: true
                Material.background: "#006677"
                display: AbstractButton.TextBesideIcon
                Layout.fillWidth: false
                wheelEnabled: false
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                MainWindowGerente{
                    id: mainWindiwGerente
                    title: qsTr("Gerente")
                    visible: false
                }
                onClicked: mainWindiwGerente.show()
            }
            /*
            RowLayout{
                width: 150
                height: 50
                Layout.fillHeight: false
                Layout.fillWidth: false
                Layout.alignment: Qt.AlignHCenter
            }
            */

        }
    }

}



























/*##^## Designer {
    D{i:2;anchors_x:43;anchors_y:42}
}
 ##^##*/
