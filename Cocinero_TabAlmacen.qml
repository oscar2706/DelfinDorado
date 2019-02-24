import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQml.Models 2.3

Item {
    id: tabAlmacen
    visible: true
    Rectangle{
        id: fondo
        width: 1366
        height: 720
        Pane {
            id: leftMenu
            width: parent.width/12*2-20
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            Material.background: "#FFFFFF"
            Material.foreground: "#50A45C"
            Material.accent: "#50A45C"
            Material.elevation: 4

            ColumnLayout{
                anchors.leftMargin: 0
                anchors.bottomMargin: 70
                anchors.rightMargin: 0
                anchors.topMargin: 90
                spacing: 0
                anchors.fill: parent
                RowLayout{
                    id: area_Boton_DescontarProducto
                    Image{
                        width: 50
                        height: 50
                        Layout.maximumHeight: 50
                        Layout.maximumWidth: 50
                        fillMode: Image.PreserveAspectFit
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        antialiasing: true
                        source: "img/almacen_Descontar.png"
                    }
                    Button{
                        text: "Retirar"
                        font.weight: Font.DemiBold
                        font.pointSize: 14
                        font.family: "Verdana"
                        Layout.fillWidth: true
                        font.capitalization: Font.MixedCase
                        focusPolicy: Qt.StrongFocus
                        display: AbstractButton.TextBesideIcon
                        Material.background: "#FFFFFF"
                        Material.elevation: 0
                        onClicked:{
                            popup_DescontarProducto.open();
                        }
                    }
                }
            }
        }


        Popup{
            id:popup_DescontarProducto
            x: Math.round((parent.width - width) / 2)
            y: Math.round((parent.height - height) / 2)
            width: 400
            height: 270
            modal: true
            focus: true
            closePolicy: Popup.CloseOnPressOutside
            ColumnLayout{
                id: columnaDatos
                width: 350
                height: 240
                Layout.maximumHeight: 240
                Layout.minimumHeight: 240
                Layout.preferredHeight: 300
                Layout.fillHeight: true
                Label {
                    id: text1
                    width: 200
                    height: 40
                    leftPadding: 150
                    color: "#50A45C"
                    text: qsTr("Productos")
                    font.pixelSize: 22
                }
                RowLayout{
                    spacing: 10
                    Layout.leftMargin: 50
                    ComboBox{
                        id: inputCategoria
                        width: 300
                        Layout.minimumWidth: 300
                        Layout.maximumWidth: 300
                        model: ["Productos en almacen", "hola que hace"]
                    }
                }
                RowLayout{
                    spacing: 10
                    Layout.leftMargin: 50
                    Label{
                        width: 80
                        text: "Cantidad actual:"
                    }
                    Label{
                        Layout.maximumWidth: 20
                        Layout.minimumWidth: 20
                        text: "40"
                    }
                    Label{
                        width: 100
                        text: "Unidad medida" //Se cargara dependiendo el producto seleccionado
                    }
                }
                RowLayout{
                    spacing: 10
                    Layout.leftMargin: 50
                    Label{
                        width: 80
                        text: "Cantidad a retirar:"
                    }
                    TextField{
                        Layout.maximumWidth: 50
                        Layout.minimumWidth: 50
                        text: ""
                    }
                    Label{
                        width: 100
                        text: "Unidad medida" //Se cargara dependiendo el producto seleccionado
                    }
                }

                RowLayout{
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    spacing: 20
                    Layout.topMargin: 40
                    Layout.leftMargin: 80
                    Button{
                        text: "Retirar"
                        Material.foreground: "#FFFFFF"
                        Material.background: "#50A45C"
                        onClicked:{
                            popup_DescontarProducto.close()
                        }
                    }
                    Button{
                        text: "Cancelar"
                        Material.foreground: "#FFFFFF"
                        Material.background: "#50A45C"
                        onClicked: {
                            popup_DescontarProducto.close()
                        }
                    }
                }

            }

        }


        Pane{
            id: paneContentLeft
            width: parent.width/12*10-20
            anchors.left: leftMenu.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            anchors.bottomMargin: 40
            anchors.topMargin: 80
            Material.background: "#D7D7D7"
            Material.elevation: 4
            //TableView
        }
    }
}
