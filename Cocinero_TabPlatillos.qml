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

    property int idComandaNuevo
    property int idPlatilloNuevo
    property string nombrePlatilloNuevo
    property int platilloNuevoSeleccionado

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

    Popup
    {
        id: confirmarPlatilloListo
        width: 230
        height: 100
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        Material.background: "#53a35f"

        ColumnLayout
        {
            Label
            {
                id: lblConfirmarPlatilloListo
                text: "¿Marcar platillo como preparado?"
                Layout.fillWidth: true
                Material.foreground: "#FFFFFF"
            }

            RowLayout
            {
                Button
                {
                    id: btnConfirmarPlatilloListo
                    text: "Aceptar"
                    Layout.fillWidth: true

                    onClicked:
                    {
                        modeloPlatillosNuevos.modifyStatus(idComandaPreparando, idPlatilloPreparando, 3);
                        modeloPlatillosNuevos.modeloEstado(1);
                        modeloPlatillosPreparados.modeloEstado(2);
                        confirmarPlatilloListo.close()
                    }
                }
                Button
                {
                    id: btnCancelarPlatilloListo
                    text: "Cancelar"
                    Layout.fillWidth: true

                    onClicked:
                    {
                        confirmarPlatilloListo.close()
                    }
                }
            }
        }
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
            Material.background: "#53a35f"
            Material.elevation: 0
            Layout.preferredHeight: 600
            Layout.minimumHeight: 600
            Layout.maximumHeight: 600
            Layout.minimumWidth: 550
            Layout.preferredWidth: 550
            Layout.maximumWidth: 550
            Layout.leftMargin: 50

            Pane {
                id: panelTextoPlatillosNuevos
                height: 60
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
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
                    highlight: Button {
                        id: btnPlatillosNuevos
                        Material.background: "#aef9ba"
                        Material.elevation: 2
                        Layout.fillWidth: true
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
                            MouseArea{
                                anchors.fill: parent
                                GridLayout{
                                    anchors.fill: parent
                                    columns: 2
                                    Text{
                                        Layout.minimumWidth: 250
                                        Layout.maximumWidth: 250
                                        text: model.nombrePlatillo
                                        font.family: "Verdana"
                                        font.pointSize: 10
                                    }
                                }
                                onClicked: {
                                    tablaPlatillosNuevos.currentIndex = index
                                    platilloNuevoSeleccionado = index
                                    idComandaNuevo = model.idComanda
                                    idPlatilloNuevo = model.idPlatillo
                                    nombrePlatilloNuevo = model.nombrePlatillo
                                }
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

                MouseArea
                {
                    id: btnCocinar
                    anchors.fill: parent

                    onClicked:
                    {
                        modeloPlatillosNuevos.modifyStatus(idComandaNuevo, idPlatilloNuevo, 2);
                        modeloPlatillosNuevos.modeloEstado(1);
                        modeloPlatillosPreparados.modeloEstado(2);
                    }
                }
            }
        }

        //PARTE DERECHA
        Pane{
            id: panelPlatillos2
            Material.background: "#53a35f"
            Material.elevation: 0
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
                    highlight: Button {
                        id: btnPlatillosPreparados
                        Material.background: "#aef9ba"
                        Material.elevation: 2
                        Layout.fillWidth: true
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
                            MouseArea{
                                anchors.fill: parent
                                GridLayout{
                                    anchors.fill: parent
                                    columns: 2
                                    Text{
                                        Layout.minimumWidth: 250
                                        Layout.maximumWidth: 250
                                        text: model.nombrePlatillo
                                        font.family: "Verdana"
                                        font.pointSize: 10
                                    }
                                }
                                onClicked: {
                                    tablaPlatillosPreparados.currentIndex = index
                                    platilloPreparandoSeleccionado = index
                                    idComandaPreparando = model.idComanda
                                    idPlatilloPreparando = model.idPlatillo
                                    nombrePlatilloPreparando = model.nombrePlatillo
                                }
                                onDoubleClicked:
                                {
                                    tablaPlatillosPreparados.currentIndex = index
                                    platilloPreparandoSeleccionado = index
                                    idComandaPreparando = model.idComanda
                                    idPlatilloPreparando = model.idPlatillo
                                    nombrePlatilloPreparando = model.nombrePlatillo
                                    confirmarPlatilloListo.open()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
