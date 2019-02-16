import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.0

ApplicationWindow {
    property int selectedComanda: -1
    property int selectedMesa: -1
    property string selectedFecha: ""
    property int idMesero: 0
    id: window
    visible: true
    width: 480
    height: 800
    title: qsTr("Stack")
    Component.onCompleted: {
        setX(screen.width / 2 - width / 2);
        setY(screen.height / 2 - height / 2);
    }
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
                    stackView.clear()
                    modeloComandas.getComandasMesero(idMesero, 0);
                    stackView.push(comandasTodas)
                    drawer.close()
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
                    stackView.clear()
                    modeloComandas.getComandasMesero(idMesero, 1);
                    stackView.push(comandasTodas)
                    drawer.close()
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
                text: qsTr("    Atendidas")
                width: parent.width
                onClicked: {
                    stackView.clear()
                    modeloComandas.getComandasMesero(idMesero, 2);
                    stackView.push(comandasTodas)
                    drawer.close()
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
                    stackView.clear()
                    modeloComandas.getComandasMesero(idMesero, 3);
                    stackView.push(comandasTodas)
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Platillos")
                width: parent.width
            }
        }
    }

    StackView {
        id: stackView
        initialItem: comandasTodas
        anchors.fill: parent
    }

    Component
    {
        id: comandasTodas

        Comandas_Page
        {
            id: comandas
        }
    }
}
