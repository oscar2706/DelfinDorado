import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQml.Models 2.3

Item
{
    id: element
    visible: true
    width: 1366
    height: 720

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
        id: rowLayout
        width: 200
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        spacing: 0

        Pane
        {
            id: menuOpciones
            width: 200
            Layout.fillWidth: true
            Layout.fillHeight: true
            Material.accent: "#008d96"
            Material.foreground: "#008d96"
            Material.background: "#ffffff"

            Material.elevation: 4

            ColumnLayout
            {
                anchors.leftMargin: 0
                anchors.bottomMargin: 70
                anchors.rightMargin: 0
                anchors.topMargin: 90
                spacing: 0
                anchors.fill: parent

                RowLayout
                {
                    Image
                    {
                        id: iconAddDish
                        width: 50
                        height: 50
                        Layout.maximumHeight: 50
                        Layout.maximumWidth: 50
                        fillMode: Image.PreserveAspectFit
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        antialiasing: true
                        source: "img/addMenu.png"
                    }
                    Button
                    {
                        text: "Añadir"
                        font.weight: Font.DemiBold
                        font.pointSize: 14
                        font.family: "Verdana"
                        Layout.fillWidth: true
                        font.capitalization: Font.MixedCase
                        focusPolicy: Qt.StrongFocus
                        display: AbstractButton.TextBesideIcon
                        Material.background: "#FFFFFF"
                        Material.elevation: 0

                        Menu_RegistrarPlatillo
                        {
                            id: form_Platillo
                        }
                        onClicked:
                        {
                            form_Platillo.show()
                        }
                    }
                }
                RowLayout
                {
                    Image
                    {
                        id: iconUpdateDish
                        width: 50
                        height: 50
                        Layout.maximumHeight: 50
                        Layout.maximumWidth: 50
                        fillMode: Image.PreserveAspectFit
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        antialiasing: true
                        source: "img/editMenu.png"
                    }
                    Button
                    {
                        text: "Editar"
                        font.weight: Font.DemiBold
                        font.pointSize: 14
                        Layout.fillWidth: true
                        font.capitalization: Font.MixedCase
                        focusPolicy: Qt.StrongFocus
                        display: AbstractButton.TextBesideIcon
                        Material.background: "#FFFFFF"
                        Material.elevation: 0

                        Menu_EditarPlatillo
                        {
                            id: mod_Platillo
                        }

                        onClicked:
                        {
                            mod_Platillo.show()
                        }
                    }
                }
            }
        }
    }

    RowLayout
    {
        id: layoutTablas
        anchors.left: parent.left
        anchors.leftMargin: 220
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.rightMargin: 20
        anchors.bottomMargin: 20
        anchors.topMargin: 70
        spacing: 20

        Pane
        {
            id: listaPlatillosPane
            Material.background: "#f5f5f5"
            Material.elevation: 4
            Layout.fillHeight: true
            Layout.preferredHeight: 600
            Layout.minimumHeight: 600
            Layout.maximumHeight: 600
            Layout.minimumWidth: 550
            Layout.preferredWidth: 550
            Layout.maximumWidth: 550

            Pane
            {
                id: listHeader
                Material.background: "#ffffff"
                Material.elevation: 1
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right

                RowLayout
                {
                    spacing: 10
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0

                    Label
                    {
                        width: 10
                        color: "#006677"
                        text: ""
                        font.pointSize: 10
                        font.bold: true
                    }
                    Label
                    {
                        color: "#006677"
                        text: "Nombre"
                        font.weight: Font.Bold
                        font.family: "Verdana"
                        font.pointSize: 12
                        font.bold: true
                        //Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }
                    Label{
                        color: "#006677"
                        text: "Precio"
                        font.weight: Font.Bold
                        font.family: "Verdana"
                        font.pointSize: 12
                        font.bold: true
                        //Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    }
                }
            }
            ListView {
                id: tablaPlatillos
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                boundsBehavior: Flickable.VerticalFlick
                anchors.topMargin: 50
                anchors.fill: parent
                spacing: 0
                clip: true
                focus: true
                model: modeloPlatillos
                delegate: Component {
                    Item{
                        width: parent.width
                        height: 300
                        MouseArea{
                            anchors.fill: parent
                            ColumnLayout{
                                anchors.fill: parent
                                //columns: 3
                                TextField{
                                    font.family: "Verdana"
                                    font.pointSize: 10
                                    text: model.id
                                }
                                TextField{
                                    font.family: "Verdana"
                                    font.pointSize: 10
                                    text: model.name
                                    onEditingFinished: {
                                        model.name = text

                                    }
                                }
                                Image
                                {
                                    width: 50
                                    height: 50
                                    Layout.maximumHeight: 50
                                    Layout.maximumWidth: 50
                                    fillMode: Image.PreserveAspectFit
                                    Layout.alignment: Qt.AlignHLeft | Qt.AlignVCenter
                                    antialiasing: true
                                    source: model.image
                                    Material.elevation: 1
                                }
                                TextField{
                                    font.family: "Verdana"
                                    font.pointSize: 10
                                    text: model.price
                                    onEditingFinished: model.price = text
                                }
                                TextField{
                                    font.family: "Verdana"
                                    font.pointSize: 10
                                    text: model.description
                                    onEditingFinished: model.description = text
                                }
                                TextField{
                                    font.family: "Verdana"
                                    font.pointSize: 10
                                    text: model.category
                                }
                                TextField{
                                    font.family: "Verdana"
                                    font.pointSize: 10
                                    text: model.status
                                }
                            }
                        }
                    }
                }
                highlight: Button {
                    id: btn
                    Material.background: "#cfd8dc"
                    Material.elevation: 2
                    Layout.fillWidth: true
                    hoverEnabled: true
                }
                highlightFollowsCurrentItem: true
                removeDisplaced: Transition {
                    NumberAnimation { properties: "x,y"; duration: 300 }
                }
            }
        }
        Pane{
            id:datosEmpleadoPane
            Material.background: "#f5f5f5"
            Layout.fillHeight: true
            Layout.maximumHeight: 600
            Layout.maximumWidth: 550
            Layout.minimumHeight: 600
            Layout.minimumWidth: 550
            Layout.preferredHeight: 600
            Layout.preferredWidth: 550
            Material.elevation: 4

            Pane{
                id: infoEmpleadoHeader
                font.weight: Font.DemiBold
                font.pointSize: 12
                font.family: "Verdana"
                Material.elevation: 1
                Material.background: "#ffffff"
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                Label{
                    width: 10
                    color: "#006677"
                    text: "Datos del empleado: "
                    font.weight: Font.Bold
                    font.family: "Verdana"
                    font.pointSize: 12
                    font.bold: true
                }
            }

            Text{
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: 60

                font.weight: Font.Medium
                font.family: "Verdana"
                font.pointSize: 12
                font.bold: false
                text: "nombre"
            }
            Text{
                anchors.top: parent.top
                anchors.topMargin: 100
                anchors.left: parent.left
                anchors.right: parent.right

                font.weight: Font.Medium
                font.family: "Verdana"
                font.pointSize: 12
                font.bold: false
                text: "cargo"
            }
        }
    }
}
