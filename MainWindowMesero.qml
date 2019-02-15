import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.0

ApplicationWindow {
    property int selectedComanda: -1
    property int selectedMesa: -1
    property string selectedFecha: ""
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
                    stackView.clear()
                    stackView.push(listaComandas)
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
                    stackView.push(listaComandasTerminadas)
                    //stackView.initialItem = listaComandasTerminadas
                    //stackView.push(listaComandasTerminadas)
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
        initialItem: listaComandas
        anchors.fill: parent
    }

    ListModel{
        id:modelComandas
        ListElement{
            idComanda: 1
            idMesa:1
        }
        ListElement{
            idComanda: 8
            idMesa:3
        }
        ListElement{
            idComanda: 6
            idMesa:2
        }
        ListElement{
            idComanda: 4
            idMesa:4
        }
        ListElement{
            idComanda: 5
            idMesa:5
        }
        ListElement{
            idComanda: 14
            idMesa:7
        }
    }

    ListView {
        id: listaComandas
        boundsBehavior: Flickable.VerticalFlick
        //anchors.fill: parent
        spacing: 4
        clip: true
        focus: true
        model: modeloComandas
        highlight: Button {
            id: btn2
            Material.background: "#cfd8dc"
            Material.elevation: 4
            Layout.fillWidth: true
            Layout.fillHeight: true
            hoverEnabled: true
        }
        highlightFollowsCurrentItem: true
        removeDisplaced: Transition {
            NumberAnimation { properties: "x,y"; duration: 300 }
        }
        delegate: Component {
            Item{
                width: parent.width
                height: 50
                property string select: "#ffffff"
                property int elevacion: 2
                //property bool selectedItem: false
                Pane{
                    anchors.fill: parent
                    Material.background: select
                    Material.elevation: elevacion
                }
                Text{
                    Layout.minimumWidth: 250
                    Layout.maximumWidth: 250
                    topPadding: 20
                    leftPadding: 50
                    text: "N° Comanda:"+idComanda
                    font.family: "Verdana"
                    font.pointSize: 10
                }
                Text{
                    Layout.minimumWidth: 200
                    Layout.maximumWidth: 200
                    topPadding: 20
                    leftPadding: 150
                    text: "Mesa:"+idMesa
                    font.family: "Verdana"
                    font.pointSize: 10
                }

                MouseArea{
                    anchors.fill: parent
                    onPressed: {
                        console.log("Se presiono la comanda: "+ idComanda)
                        console.log("su mesa es la:"+idMesa)
                        select = "#cfd8dc"
                        selectedComanda  = idComanda
                        selectedMesa = idMesa
                        selectedFecha = fecha
                        comandaCompleta.fechaSeleccionada
                    }
                    onReleased: {
                        select = "#ffffff"
                        stackView.push(comandaCompleta)
                    }
                    onClicked: {
                        //Abrir la pestaña de la comanda
                    }
                }
            }
        }
    }


    ListModel{
        id:modelComandasTerminadas
        ListElement{
            idComanda: 6
            idMesa:6
        }
        ListElement{
            idComanda: 6
            idMesa:6
        }
        ListElement{
            idComanda: 6
            idMesa:6
        }
        ListElement{
            idComanda: 1
            idMesa:1
        }
        ListElement{
            idComanda: 1
            idMesa:1
        }
    }

    ListView {
        id: listaComandasTerminadas
        boundsBehavior: Flickable.VerticalFlick
        //anchors.fill: parent
        spacing: 4
        clip: true
        focus: true
        model: modelComandasTerminadas
        removeDisplaced: Transition {
            NumberAnimation { properties: "x,y"; duration: 300 }
        }
        delegate: Component {
            Item{
                width: parent.width
                height: 50
                property string select: "#ffffff"
                property int elevacion: 2
                //property bool selectedItem: false
                Pane{
                    anchors.fill: parent
                    Material.background: select
                    Material.elevation: elevacion
                }
                Text{
                    Layout.minimumWidth: 250
                    Layout.maximumWidth: 250
                    topPadding: 20
                    leftPadding: 50
                    text: "N° Comanda:"+idComanda
                    font.family: "Verdana"
                    font.pointSize: 10
                }
                Text{
                    Layout.minimumWidth: 200
                    Layout.maximumWidth: 200
                    topPadding: 20
                    leftPadding: 150
                    text: "Mesa:"+idMesa
                    font.family: "Verdana"
                    font.pointSize: 10
                }

                MouseArea{
                    anchors.fill: parent
                    onPressed: {
                        console.log("Se presiono la comanda: "+ idComanda)
                        console.log("su mesa es la:"+idMesa)
                        select = "#cfd8dc"
                        selectedComanda  = idComanda
                        selectedMesa = idMesa

                    }
                    onReleased: {
                        select = "#ffffff"
                        stackView.push(comandaCompleta)
                    }
                    onClicked: {
                        //Abrir la pestaña de la comanda
                    }
                }
            }
        }
    }


    Component{
        id: comandaCompleta
        ComandaSeleccionada_Page{
            id: comanda
            idComanda: selectedComanda
            mesaAsignada: selectedMesa
            fechaComanda: selectedFecha
        }
    }
}
