import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.0


Window {
    id:ventaPrincipal
    visible: true
    title: "Mapa mesas"
    width: 1366
    height: 720
    //background: BorderImage {source: "img/fondoPiso.jpg" }
    property int i: 0

    Image {
        id: sanitario
        x: 182
        y: 0
        width: 89
        height: 218
        source: "img/sanitario.png"
    }
    Image {
        id: jardin1
        x: 173
        y: 632
        width: 507
        height: 87
        source: "img/jardin.jpg"
    }
    Image {
        id: jardin2
        x: 859
        y: 632
        width: 507
        height: 87
        source: "img/jardin.jpg"
    }

    Image {
        id: cocina
        x: 1198
        y: 0
        width: 168
        height: 631
        source: "img/cocina.jpg"
    }
    Formulario_Asignar{
        id: mainWindiwAsignar
        title: qsTr("Asignar")
        visible: false
    }
    Mesa{
        id:mesa1
        x: 366
        y: 66
        ancho:90
        imagen: "img/MesaChica_Disponible.png"
    }
    Mesa{
        id:mesa2
        x: 590
        y: 66
        ancho:90
        imagen: "img/MesaChica_Disponible.png"
    }
    Mesa{
        id:mesa3
        x: 817
        y: 66
        ancho:90
        imagen: "img/MesaChica_Disponible.png"
    }
    Mesa{
        id:mesa4
        x: 1038
        y: 66
        ancho:90
        imagen: "img/MesaChica_Disponible.png"
    }
    Mesa{
        id:mesa5
        x: 474
        y: 258
        ancho:130
        imagen: "img/MesaGrandeDisponible.png"
    }
    Mesa{
        id:mesa6
        x: 712
        y: 258
        ancho:130
        imagen: "img/MesaGrandeDisponible.png"
    }
    Mesa{
        id:mesa7
        x: 954
        y: 258
        ancho:130
        imagen: "img/MesaGrandeDisponible.png"
    }
    Mesa{
        id:mesa8
        x: 366
        y: 438
        ancho:90
        imagen: "img/MesaChica_Disponible.png"
    }
    Mesa{
        id:mesa9
        x: 590
        y: 438
        ancho:90
        imagen: "img/MesaChica_Disponible.png"
    }
    Mesa{
        id:mesa10
        x: 817
        y: 438
        ancho:90
        imagen: "img/MesaChica_Disponible.png"
    }
    Mesa{
        id:mesa11
        x: 1038
        y: 438
        ancho:90
        imagen: "img/MesaChica_Disponible.png"
    }


    Pane{
        id: menuOpciones
        width: 180
        height: 720
        Material.background:"white"
        antialiasing: true
        Material.elevation: 16
        Column
        {
            id:panelIzq
            width: 160
            height: 680
            spacing: 1

            Rectangle{
                id: visualizar
                height: 40
                width: panelIzq.width
                border.color: "black"
                border.width: 1
                radius: 8
                Image {
                    id: imgVisualizar
                    height: 50
                    width: 50
                    anchors.verticalCenter: parent.verticalCenter
                    source: "img/visualizar.png"
                }
                Text {
                    id: textVisualizar
                    text: qsTr("      Pedidos")
                    anchors.centerIn: parent
                    font.pointSize: 12
                    font.family: "Verdana"
                    Material.background: "#FFFFFF"

                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked:{
                        visualizar.border.width = 2.5
                        salir.border.width = 1
                        ventaPrincipal.i++
                        if(ventaPrincipal.i%2!=0)
                            itemVisualizar.state ="visible"
                        else
                            itemVisualizar.state ="inVisible"

                    }
                    onEntered: visualizar.color = "#cbae82"
                    onExited:  visualizar.color = "white"
                }
            }
            Item {
                id: itemVisualizar
                width: parent.width
                Rectangle{
                    id: infoVisualizar
                    anchors.fill:parent
                    color: "black"
                }
                state: "inVisible"
                states: [
                    State {
                        name: "visible"
                        PropertyChanges {
                            target: itemVisualizar
                            height:550
                        }
                    },
                    State {
                        name: "inVisible"
                        PropertyChanges {
                            target: itemVisualizar
                            height:0
                        }
                    }
                ]
                transitions: [
                    Transition {
                        from: "visible"
                        to: "inVisible"
                        NumberAnimation {
                            target: itemVisualizar
                            property: "height"
                            duration: 1000
                            easing.type: Easing.InOutSine
                        }
                    },
                    Transition {
                        from: "inVisible"
                        to: "visible"
                        NumberAnimation {
                            target: itemVisualizar
                            property: "height"
                            duration: 1000
                            easing.type: Easing.InOutSine
                        }
                    }
                ]
            }
            Rectangle{
                id: salir
                height: 40
                width: panelIzq.width
                radius: 10
                border.color: "black"
                border.width: 1

                Image {
                    id: imgSalir
                    height: 40
                    width: 40
                    source: "img/salir.png"
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text {
                    id: textSalir
                    text: qsTr(" Salir")
                    anchors.centerIn: parent
                    font.pointSize: 12
                    font.family: "Verdana"
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: Qt.quit()
                    onEntered: salir.color = "#cbae82"
                    onExited:  salir.color = "white"
                }
            }
        }
    }


}

