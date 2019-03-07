import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0
import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.3
import QtQuick.Controls.Styles 1.4

Item {
    id: window
    visible: true
    width: 1366
    height: 720

    property int idPlatillosComandaNuevo
    property int idComandaNuevo
    property int idPlatilloNuevo
    property string nombrePlatilloNuevo
    property int platilloNuevoSeleccionado

    property int idPlatillosComandaPreparando
    property int idComandaPreparando
    property int idPlatilloPreparando
    property string nombrePlatilloPreparando
    property int platilloPreparandoSeleccionado

    Pane
    {
        id: fondo
        anchors.fill: parent
        transformOrigin: Item.Center
        Layout.fillHeight: true
        Layout.fillWidth: true
        Material.elevation: 0
    }

    RowLayout
    {
        id: divisorPrincipal
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.topMargin: 45
        spacing: 25

        //PARTE IZQUIERDA
        Pane{
            id: panelPlatillos1
            Material.background: "#f5f5f5"
            Material.elevation: 4
            Layout.preferredHeight: 600
            Layout.minimumHeight: 600
            Layout.maximumHeight: 600
            Layout.minimumWidth: 550
            Layout.preferredWidth: 550
            Layout.maximumWidth: 550
            Layout.leftMargin: 50

            Pane {
                id: panelPlatillosNuevos
                height: 60
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                font.weight: Font.DemiBold
                Material.elevation: 4
                Material.background: "#FFFFFF"

                Label {
                    color: "#53a35f"
                    text: "Platillos Nuevos"
                    anchors.centerIn: parent
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                    font.weight: Font.Bold
                    font.pointSize: 17
                    font.family: "Verdana"
                }
            }

            Pane
            {
                id: panelListaPlatillosNuevos
                anchors.fill: parent
                anchors.topMargin: 80
                anchors.bottomMargin: 20
                Material.elevation: 4
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
                        color: "#53a35f"
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
                    anchors.topMargin: 25
                    anchors.fill: parent
                    spacing: 0
                    clip: true
                    focus: true
                    model: modeloPlatillosNuevos
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
                            text: qsTr("Preparar")
                            color: "white"
                            verticalAlignment: Label.AlignVCenter
                            padding: 12
                            height: parent.height
                            anchors.left: parent.left

                            SwipeDelegate.onClicked:
                            {
                                tablaPlatillosNuevos.currentIndex = index
                                platilloNuevoSeleccionado = index
                                idPlatillosComandaNuevo = model.idPlatillosComanda
                                idComandaNuevo = model.idComanda
                                idPlatilloNuevo = model.idPlatillo
                                nombrePlatilloNuevo = model.nombrePlatillo
                                modeloPlatillosNuevos.modifyStatus(idPlatillosComandaNuevo, 2);
                                modeloPlatillosNuevos.modeloEstado(1);
                                modeloPlatillosPreparados.modeloEstado(2);
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

        //PARTE CENTRAL
        Pane
        {
            id: panelComando
            Material.elevation: 0
            Material.background: "#FFFFFF"
            Layout.preferredHeight: 100
            Layout.minimumHeight: 100
            Layout.maximumHeight: 100
            Layout.preferredWidth: 100
            Layout.minimumWidth: 100
            Layout.maximumWidth: 100

            Image {
                id: imgCocinar
                source: "img/preparar.png"
                width: 100
                height: 100
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.bottom: parent.bottom
            }
        }

        //PARTE DERECHA
        Pane{
            id: panelPlatillos2
            Material.background: "#f5f5f5"
            Material.elevation: 4
            Layout.preferredHeight: 600
            Layout.minimumHeight: 600
            Layout.maximumHeight: 600
            Layout.minimumWidth: 550
            Layout.preferredWidth: 550
            Layout.maximumWidth: 550

            Pane {
                id: panelPlatillosPreparandose
                height: 60
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                font.weight: Font.DemiBold
                Material.elevation: 4
                Material.background: "#FFFFFF"

                Label {
                    color: "#53a35f"
                    text: "Platillos Preparandose"
                    anchors.centerIn: parent
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                    font.weight: Font.Bold
                    font.pointSize: 17
                    font.family: "Verdana"
                }
            }

            Pane
            {
                id: panelListaPlatillosPreparados
                anchors.fill: parent
                anchors.topMargin: 80
                anchors.bottomMargin: 20
                Material.elevation: 4
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
                        color: "#53a35f"
                        text: "Nombre Platillo"
                        font.weight: Font.Bold
                        font.family: "Verdana"
                        font.pointSize: 12
                        font.bold: true
                    }
                }

                ListView {
                    id: tablaPlatillosPreparados
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0
                    boundsBehavior: Flickable.VerticalFlick
                    anchors.topMargin: 25
                    anchors.fill: parent
                    spacing: 0
                    clip: true
                    focus: true
                    model: modeloPlatillosPreparados
                    delegate: SwipeDelegate
                    {
                        id: vistaTactil2
                        width: parent.width
                        text: model.nombrePlatillo

                        ListView.onRemove: SequentialAnimation
                        {
                            PropertyAction
                            {
                                target: vistaTactil2
                                property: "ListView.delayRemove"
                                value: true
                            }
                            NumberAnimation
                            {
                                target: vistaTactil2
                                property: "height"
                                to: 0
                                easing.type: Easing.InOutQuad
                            }
                            PropertyAction
                            {
                                target: vistaTactil2
                                property: "ListView.delayRemove"
                                value: false
                            }
                        }

                        swipe.left: Label
                        {
                            id: lblDelete2
                            text: qsTr("Platillo Listo")
                            color: "white"
                            verticalAlignment: Label.AlignVCenter
                            padding: 12
                            height: parent.height
                            anchors.left: parent.left

                            SwipeDelegate.onClicked:
                            {
                                tablaPlatillosPreparados.currentIndex = index
                                platilloPreparandoSeleccionado = index
                                idPlatillosComandaPreparando = model.idPlatillosComanda
                                idComandaPreparando = model.idComanda
                                idPlatilloPreparando = model.idPlatillo
                                nombrePlatilloPreparando = model.nombrePlatillo
                                modeloPlatillosNuevos.modifyStatus(idPlatillosComandaPreparando, 3);
                                modeloPlatillosNuevos.modeloEstado(1);
                                modeloPlatillosPreparados.modeloEstado(2);
                            }

                            background: Rectangle
                            {
                                color: lblDelete2.SwipeDelegate.pressed ? Qt.darker("#53a35f", 1.1) : "#53a35f"
                            }
                        }
                    }
                }
            }
        }
    }
}
