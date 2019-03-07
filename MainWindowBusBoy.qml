import QtQuick 2.0
import QtQuick 2.9
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.0


ApplicationWindow {
    id: maindWindowBusboy
    visible: true
    property string mesa
    title: "Mapa mesas"
    width: 1366
    height: 720
    background: BorderImage {source: "img/mapaBusboy.jpg"

    Rectangle {
        id: rectangle
        x: 1993
        y: 8
        z: 1
        width: 50
        height: 50
        color: "#ffffff"
        visible: true
        anchors.right: parent.right
        anchors.top: parent.top

        Image {
            id: imgSalir
            height: 40
            width: 40
            source: "img/salir.png"
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea
       {
        anchors.fill: parent
        onClicked:
        {
            maindWindowBusboy.close()
        }
       }
    }
    }

    GridView{
        id:listaMeseros

        x: 133
        y: 44
        width: 1008
        height: 777
        model: mesaObjModel
        cellHeight: height /3
        cellWidth: width /4
        delegate:Rectangle{
            property string numMesa: "mesa"+model.idMesa
            id: numMesa
            height: model.alto
            width: model.ancho
            color:"transparent"
            Image {
                anchors.fill: parent
                source: model.imgMesa
            }
            MouseArea{
                anchors.fill: parent
                onClicked:{
                    if(model.estado === 3){
                        mesa = model.idMesa
                        dialogoConfirmacionBus.open()
                    }
                }
            }
        }
    }

    Dialog {
        id: dialogoConfirmacionBus
        height: 150
        width: 350
        modal: true
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        title: "¿La mesa "+mesa+" ya esta limpia?\nEl cambio de estado no es modificable"
        standardButtons: Dialog.Ok | Dialog.Cancel

        onAccepted: {
            mesaObjModel.setEstadoMesa(mesa,1)
            dialogoConfirmacionBus.close();
        }
    }
}
