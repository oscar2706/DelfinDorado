import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 800
    height: 1280
    title: qsTr("Stack")

    header: ToolBar {
        contentHeight: toolButton.implicitHeight
        Material.background: "#ffb03a"


        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }

    Drawer {
        id: drawer
        width: 200
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {

                text: qsTr("Mis comandas")
                width: parent.width
                onClicked: {
                    //stackView.push("Page1Form.ui.qml")
                    //drawer.close()
                }
            }
            ItemDelegate {
                Image {
                    id: imgTodas
                    source: "img/editar.png"
                    width: 30
                    height: 30
                    anchors.verticalCenter: parent.verticalCenter

                }
                text: qsTr("    Todas")
                width: parent.width
                onClicked: {
                    //stackView.push("Page1Form.ui.qml")
                    //drawer.close()
                }
            }
            ItemDelegate {
                Image {
                    id: imgPendiente
                    source: "img/pendiente.png"
                    width: 30
                    height: 30
                    anchors.verticalCenter: parent.verticalCenter

                }
                text: qsTr("    Pendientes")
                width: parent.width
                onClicked: {
                    //stackView.push("Page1Form.ui.qml")
                    //drawer.close()
                }
            }
            ItemDelegate {
                Image {
                    id: imgAtendio
                    source: "img/atendido.png"
                    width: 30
                    height: 30
                    anchors.verticalCenter: parent.verticalCenter
                }
                text: qsTr("    Atendidos")
                width: parent.width
                onClicked: {
                    //stackView.push("Page1Form.ui.qml")
                    //drawer.close()
                }
            }
            ItemDelegate {
                Image {
                    id: imgCobrada
                    source: "img/cobrada.png"
                    width: 30
                    height: 30
                    anchors.verticalCenter: parent.verticalCenter

                }
                text: qsTr("    Cobradas")
                width: parent.width
                onClicked: {
                    //stackView.push("Page1Form.ui.qml")
                    //drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Platillos")
                width: parent.width
                onClicked: {
                    //stackView.push("Page1Form.ui.qml")
                    //drawer.close()
                }
            }
        }
    }

    StackView {
        id: stackView
        initialItem: "HomeForm.ui.qml"
        anchors.fill: parent

    }
    GridLayout{
        id: panelCentral
        columns: 2
        anchors.fill:parent

        Rectangle{
            id:rect1
            width: 400
            height: 400
            Pane{
                anchors.fill: parent
                Material.background: "white"
                Material.elevation: 8

                Image {
                    id: comando1
                    source: "img/editar.png"
                    width: 200
                    height: 200
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text {
                    id: textImg1
                    text: qsTr("\t\tComanda 1")
                    font.pointSize: 14
                    font.family: "Verdana"
                    anchors.centerIn: parent
                }

            }
        }
        Rectangle{
            id:rect2
            width: 400
            height: 400
            Pane{
                anchors.fill: parent
                Material.background: "white"
                Material.elevation: 8

                Image {
                    id: comando2
                    source: "img/editar.png"
                    width: 200
                    height: 200
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text {
                    id: textImg2
                    text: qsTr("\t\tComanda 2")
                    font.pointSize: 14
                    font.family: "Verdana"
                    anchors.centerIn: parent
                }
            }
        }
        Rectangle{
            id:rect3
            width: 400
            height: 400
            Pane{
                anchors.fill: parent
                Material.background: "white"
                Material.elevation: 8
                Image {
                    id: comando3
                    source: "img/editar.png"
                    width: 200
                    height: 200
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text {
                    id: textImg3
                    text: qsTr("\t\tComanda 3")
                    font.pointSize: 14
                    font.family: "Verdana"
                    anchors.centerIn: parent
                }
            }
        }
        Rectangle{
            id:rect4
            width: 400
            height: 400
            Pane{
                anchors.fill: parent
                Material.background: "white"
                Material.elevation: 8
                Image {
                    id: comando4
                    source: "img/editar.png"
                    width: 200
                    height: 200
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text {
                    id: textImg4
                    text: qsTr("\t\tComanda 4")
                    font.pointSize: 14
                    font.family: "Verdana"
                    anchors.centerIn: parent
                }
            }
        }
    }
}
