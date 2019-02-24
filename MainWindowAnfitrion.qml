import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.0
import ModeloMesero 1.0


ApplicationWindow {
    id:ventanaPrincipalAnfitrion
    visible: true
    title: "Mapa mesas"
    width: 1366
    height: 720
    background: BorderImage {source: "img/mapa.jpg" }
    property int i:0


    MainWindowAsignar{
        id: mainWindiwAsignar
        visible: false
    }

     Mesa{
        id: mesa1
        x: 218
        y: 107
        ancho:90
        numMesa: "1"
    }
    Mesa{
        id: mesa2
        x: 470
        y: 108
        ancho:90
        numMesa: "2"
    }
    Mesa{
        id: mesa3
        x: 732
        y: 108
        ancho:90
        numMesa: "3"
    }
    Mesa{
        id: mesa4
        x: 974
        y: 109
        ancho:90
        numMesa: "4"
    }
    Mesa{
        id: mesa5
        x: 305
        y: 318
        ancho:130
        numMesa: "5"
    }
    Mesa{
        id: mesa6
        x: 583
        y: 312
        ancho:130
        numMesa: "6"
    }
    Mesa{
        id: mesa7
        x: 844
        y: 311
        ancho:130
        numMesa: "7"
    }
    Mesa{
        id: mesa8
        x: 218
        y: 518
        ancho:90
        numMesa: "8"
    }
    Mesa{
        id: mesa9
        x: 470
        y: 518
        ancho:90
        numMesa: "9"
    }
    Mesa{
        id: mesa10
        x: 732
        y: 518
        ancho:90
        numMesa: "10"
    }
    Mesa{
        id: mesa11
        x: 974
        y: 518
        ancho:90
        numMesa: "11"
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
                        ventanaPrincipalAnfitrion.i++
                        if(ventanaPrincipalAnfitrion.i%2!=0)
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
                    onClicked: close();
                    onEntered: salir.color = "#cbae82"
                    onExited:  salir.color = "white"
                }
            }
        }
    }
    Popup
    {
        id: popupMesero1
        x: 174
        y: 182
        width: 200
        height: 50
        Text {
            id:textPopup1
            anchors.centerIn: parent
            font.pixelSize: 18
            text : meseroLista.getMeseroAsignado(1)
        }
    }
    Popup
    {
        id: popupMesero2
        x: 415
        y: 182
        width: 200
        height: 50
        Text {
            id:textPopup2
            anchors.centerIn: parent
            font.pixelSize: 18
            text : meseroLista.getMeseroAsignado(2)
        }
    }
    Popup
    {
        id: popupMesero3
        x: 677
        y: 182
        width: 200
        height: 50
        Text {
            id:textPopup3
            anchors.centerIn: parent
            font.pixelSize: 18
            text : meseroLista.getMeseroAsignado(3)
        }
    }
    Popup
    {
        id: popupMesero4
        x: 919
        y: 182
        width: 200
        height: 50
        Text {
            id:textPopup4
            anchors.centerIn: parent
            font.pixelSize: 18
            text : meseroLista.getMeseroAsignado(4)
        }
    }
    Popup
    {
        id: popupMesero5
        x: 270
        y: 372
        width: 200
        height: 50
        Text {
            id:textPopup5
            anchors.centerIn: parent
            font.pixelSize: 18
            text : meseroLista.getMeseroAsignado(5)
        }
    }
    Popup
    {
        id: popupMesero6
        x: 548
        y: 372
        width: 200
        height: 50
        Text {
            id:textPopup6
            anchors.centerIn: parent
            font.pixelSize: 18
            text : meseroLista.getMeseroAsignado(6)
        }
    }
    Popup
    {
        id: popupMesero7
        x: 809
        y: 372
        width: 200
        height: 50
        Text {
            id:textPopup7
            anchors.centerIn: parent
            font.pixelSize: 18
            text : meseroLista.getMeseroAsignado(7)
        }
    }
    Popup
    {
        id: popupMesero8
        x: 163
        y: 582
        width: 200
        height: 50
        Text {
            id:textPopup8
            anchors.centerIn: parent
            font.pixelSize: 18
            text : meseroLista.getMeseroAsignado(8)
        }
    }
    Popup
    {
        id: popupMesero9
        x: 415
        y: 582
        width: 200
        height: 50
        Text {
            id:textPopup9
            anchors.centerIn: parent
            font.pixelSize: 18
            text : meseroLista.getMeseroAsignado(9)
        }
    }
    Popup
    {
        id: popupMesero10
        x: 677
        y: 582
        width: 200
        height: 50
        Text {
            id:textPopup10
            anchors.centerIn: parent
            font.pixelSize: 18
            text : meseroLista.getMeseroAsignado(10)
        }
    }
    Popup
    {
        id: popupMesero11
        x: 919
        y: 582
        width: 200
        height: 50
        Text {
            id:textPopup11
            anchors.centerIn: parent
            font.pixelSize: 18
            text : meseroLista.getMeseroAsignado(11)
        }
    }
    Component.onCompleted: {

            if(meseroLista.verificaEstadoMesa(1)===1)
            {
                mesa1.estadoMesa = 1
                mesa1.imagen = "img/MesaChica_Disponible.png"
            }
            else
            {
                mesa1.estadoMesa = 2
                mesa1.imagen = "img/MesaChica_Ocupada.png"
            }

            if(meseroLista.verificaEstadoMesa(2)===1)
            {
                mesa2.estadoMesa = 1
                mesa2.imagen = "img/MesaChica_Disponible.png"
            }
            else
            {
                mesa2.estadoMesa = 2
                mesa2.imagen = "img/MesaChica_Ocupada.png"
            }

            if(meseroLista.verificaEstadoMesa(3)===1)
            {
                mesa3.estadoMesa = 1
                mesa3.imagen = "img/MesaChica_Disponible.png"
            }
            else
            {
                mesa3.estadoMesa = 2
                mesa3.imagen = "img/MesaChica_Ocupada.png"
            }

            if(meseroLista.verificaEstadoMesa(4)===1)
            {
                mesa4.estadoMesa = 1
                mesa4.imagen = "img/MesaChica_Disponible.png"
            }
            else
            {
                mesa4.estadoMesa = 2
                mesa4.imagen = "img/MesaChica_Ocupada.png"
            }
            if(meseroLista.verificaEstadoMesa(5)===1)
            {
                mesa5.estadoMesa = 1
                mesa5.imagen = "img/MesaGrandeDisponible.png"
            }
            else
            {
                mesa5.estadoMesa = 2
                mesa5.imagen = "img/MesaGrande_Ocupada.png"
            }
            if(meseroLista.verificaEstadoMesa(6)===1)
            {
                mesa6.estadoMesa = 1
                mesa6.imagen = "img/MesaGrandeDisponible.png"
            }
            else
            {
                mesa6.estadoMesa = 2
                mesa6.imagen = "img/MesaGrande_Ocupada.png"
            }
            if(meseroLista.verificaEstadoMesa(7)===1)
            {
                mesa7.estadoMesa = 1
                mesa7.imagen = "img/MesaGrandeDisponible.png"
            }
            else
            {
                mesa7.estadoMesa = 2
                mesa7.imagen = "img/MesaGrande_Ocupada.png"
            }
            if(meseroLista.verificaEstadoMesa(8)===1)
            {
                mesa8.estadoMesa = 1
                mesa8.imagen = "img/MesaChica_Disponible.png"
            }
            else
            {
                mesa8.estadoMesa = 2
                mesa8.imagen = "img/MesaChica_Ocupada.png"
            }
            if(meseroLista.verificaEstadoMesa(9)===1)
            {
                mesa9.estadoMesa = 1
                mesa9.imagen = "img/MesaChica_Disponible.png"
            }
            else
            {
                mesa9.estadoMesa = 2
                mesa9.imagen = "img/MesaChica_Ocupada.png"
            }
            if(meseroLista.verificaEstadoMesa(10)===1)
            {
                mesa10.estadoMesa = 1
                mesa10.imagen = "img/MesaChica_Disponible.png"
            }
            else
            {
                mesa10.estadoMesa = 2
                mesa10.imagen = "img/MesaChica_Ocupada.png"
            }
            if(meseroLista.verificaEstadoMesa(11)===1)
            {
                mesa11.estadoMesa = 1
                mesa11.imagen = "img/MesaChica_Disponible.png"
            }
            else
            {
                mesa11.estadoMesa = 2
                mesa11.imagen = "img/MesaChica_Ocupada.png"
            }
    }
}
