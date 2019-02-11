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
    property int i: 0

    Pane
    {
        id: fondo
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        Material.background: "#ffe0b2"

        Pane{
            id: menuOpciones
            width: 180
            height: 700
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            Material.background: "#cbae82"
            antialiasing: true
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
                    border.width: 1
                    radius: 8
                    Image {
                        id: imgVisualizar
                        height: 40
                        width: 40
                        anchors.verticalCenter: parent.verticalCenter
                        source: "img/pedido_anfitrion.png"
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
                            //visualizar.border.width = 2.5
                            salir.border.width = 1
                            ventaPrincipal.i++
                            if(ventaPrincipal.i%2!=0)
                                itemVisualizar.state ="visible"
                            else
                                itemVisualizar.state ="inVisible"

                        }
                        onEntered: visualizar.color = "#cbae82"
                        onExited:  visualizar.color = "#ffffe4"
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
                        onClicked:
                        {
                            ventaPrincipal.close()
                        }
                        onEntered: salir.color = "#cbae82"
                        onExited:  salir.color = "#ffffe4"
                    }
                }
            }
        }

        Image {
            id: sanitario
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 182
            width: 89
            height: 218
            source: "img/sanitario.png"
        }

        Image
        {
            id: estufa1
            width: 90
            height: 90
            anchors.top: parent.top
            anchors.right: parent.right
            source: "img/estufa.jpg"
        }
        Image
        {
            id: estufa2
            width: 90
            height: 90
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 90
            source: "img/estufa.jpg"
        }
        Image
        {
            id: lavabo
            width: 90
            height: 60
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 180
            source: "img/lavabo.jpg"
        }
        Image
        {
            id: estufa3
            width: 90
            height: 90
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 240
            source: "img/estufa.jpg"
        }

        Image {
            id: entrada1
            source: "img/puerta.png"
            width: 100
            height: 25
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 633
        }

        Image {
            id: maceta1
            source: "img/maceta.png"
            width: 50
            height: 50
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 182
        }
        Image {
            id: maceta2
            source: "img/maceta.png"
            width: 50
            height: 50
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 232
        }
        Image {
            id: maceta3
            source: "img/maceta.png"
            width: 50
            height: 50
            x: 80
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 282
        }
        Image {
            id: maceta4
            source: "img/maceta.png"
            width: 50
            height: 50
            x: 80
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 332
        }
        Image {
            id: maceta5
            source: "img/maceta.png"
            width: 50
            height: 50
            x: 80
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 382
        }
        Image {
            id: maceta6
            source: "img/maceta.png"
            width: 50
            height: 50
            x: 80
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 432
        }
        Image {
            id: maceta7
            source: "img/maceta.png"
            width: 50
            height: 50
            x: 80
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 482
        }
        Image {
            id: maceta8
            source: "img/maceta.png"
            width: 50
            height: 50
            x: 80
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 532
        }
        Image {
            id: maceta9
            source: "img/maceta.png"
            width: 50
            height: 50
            x: 80
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 582
        }
        Image {
            id: maceta10
            source: "img/maceta.png"
            width: 50
            height: 50
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 734
        }
        Image {
            id: maceta11
            source: "img/maceta.png"
            width: 50
            height: 50
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 784
        }
        Image {
            id: maceta12
            source: "img/maceta.png"
            width: 50
            height: 50
            x: 80
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 834
        }
        Image {
            id: maceta13
            source: "img/maceta.png"
            width: 50
            height: 50
            x: 80
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 884
        }
        Image {
            id: maceta14
            source: "img/maceta.png"
            width: 50
            height: 50
            x: 80
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 934
        }
        Image {
            id: maceta15
            source: "img/maceta.png"
            width: 50
            height: 50
            x: 80
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 984
        }
        Image {
            id: maceta16
            source: "img/maceta.png"
            width: 50
            height: 50
            x: 80
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 1034
        }
        Image {
            id: maceta17
            source: "img/maceta.png"
            width: 50
            height: 50
            x: 80
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 1084
        }
        Image {
            id: maceta18
            source: "img/maceta.png"
            width: 50
            height: 50
            x: 80
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 1134
        }
        Image {
            id: maceta19
            source: "img/maceta.png"
            width: 50
            height: 50
            x: 80
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 1184
        }
        Image {
            id: maceta20
            source: "img/maceta.png"
            width: 50
            height: 50
            x: 80
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 1234
        }
        Image {
            id: maceta21
            source: "img/maceta.png"
            width: 50
            height: 50
            x: 80
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 1284
        }

        Formulario_Asignar{
            id: mainWindowAsignar
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
    }
}
