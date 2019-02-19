import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

Page {
    id: platillos
    title: "Platillos"

    property int platilloSeleccionado
    property int idPlatillosComanda
    property int idComanda
    property int idPlatillo
    property string nombre
    property int idEstadoPreparacion
    property int idMeseroModelo

    Pane
    {
        id: panelPlatillosMesero
        anchors.fill: parent
        anchors.topMargin: 0
        anchors.bottomMargin: 20
        Material.elevation: 0
        Material.background: "#FFFFFF"

        RowLayout
        {
            spacing: 10
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0

            Label
            {
                color: "black"
                text: "Nombre Platillo"
                font.weight: Font.Bold
                font.family: "Verdana"
                font.pointSize: 12
                font.bold: true
            }
        }

        ListView {
            id: tablaPlatillosNuevos
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            boundsBehavior: Flickable.VerticalFlick
            anchors.topMargin: 30
            anchors.fill: parent
            spacing: 0
            clip: true
            focus: true
            model: modeloPlatillosMesero
            delegate: SwipeDelegate
            {
                id: vistaTactil1
                width: parent.width
                text: model.nombrePlatillo

                ListView.onRemove: SequentialAnimation
                {
                    PropertyAction
                    {
                        target: vistaTactil1
                        property: "ListView.delayRemove"
                        value: true
                    }
                    NumberAnimation
                    {
                        target: vistaTactil1
                        property: "height"
                        to: 0
                        easing.type: Easing.InOutQuad
                    }
                    PropertyAction
                    {
                        target: vistaTactil1
                        property: "ListView.delayRemove"
                        value: false
                    }
                }

                swipe.left: Label
                {
                    id: lblDelete1
                    text: qsTr("Entregar")
                    color: "white"
                    verticalAlignment: Label.AlignVCenter
                    padding: 12
                    height: parent.height
                    anchors.left: parent.left

                    SwipeDelegate.onClicked:
                    {
                        tablaPlatillosNuevos.currentIndex = index
                        platilloSeleccionado = index
                        idPlatillosComanda = model.idPlatillosComanda
                        idComanda = model.idComanda
                        idPlatillo = model.idPlatillo
                        nombre = model.nombrePlatillo
                        modeloPlatillosMesero.modifyStatus(idPlatillosComanda, 4);
                        modeloPlatillosMesero.platillosMesero(idMeseroModelo);
                    }

                    background: Rectangle
                    {
                        color: lblDelete1.SwipeDelegate.pressed ? Qt.darker("#53a35f", 1.1) : "#53a35f"
                    }
                }
            }
        }
    }
}
