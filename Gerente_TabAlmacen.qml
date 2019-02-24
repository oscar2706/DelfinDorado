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
    Pane {
        id: leftMenu
        width: parent.width/12*2-20
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        Material.background: "#FFFFFF"
        Material.foreground: "#008d96"
        Material.accent: "#008d96"
        Material.elevation: 4

        ColumnLayout{
            anchors.leftMargin: 0
            anchors.bottomMargin: 70
            anchors.rightMargin: 0
            anchors.topMargin: 90
            spacing: 0
            anchors.fill: parent

            RowLayout{
                id: area_Boton_NuevoProducto
                Image{
                    width: 50
                    height: 50
                    Layout.maximumHeight: 50
                    Layout.maximumWidth: 50
                    fillMode: Image.PreserveAspectFit
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    antialiasing: true
                    source: "img/almacen_NuevoProducto.png"
                }
                Button{
                    text: "Nuevo producto"
                    font.weight: Font.DemiBold
                    font.pointSize: 12
                    font.family: "Verdana"
                    Layout.fillWidth: true
                    font.capitalization: Font.MixedCase
                    focusPolicy: Qt.StrongFocus
                    display: AbstractButton.TextBesideIcon
                    Material.background: "#FFFFFF"
                    Material.elevation: 0
                    onClicked:{
                        //
                    }
                }
            }

            RowLayout{
                id: area_Boton_Pedido
                Image{
                    width: 50
                    height: 50
                    Layout.maximumHeight: 50
                    Layout.maximumWidth: 50
                    fillMode: Image.PreserveAspectFit
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    antialiasing: true
                    source: "img/almacen_Pedido.png"
                }
                Gerente_NuevoPedido{
                    id: dialog_nuevoPedido
                }
                Button{
                    text: "Pedido"
                    Material.background: "#FFFFFF"
                    Material.elevation: 0
                    font.weight: Font.DemiBold
                    font.pointSize: 14
                    font.family: "Verdana"
                    Layout.fillWidth: true
                    font.capitalization: Font.MixedCase
                    focusPolicy: Qt.StrongFocus
                    display: AbstractButton.TextBesideIcon
                    onClicked:{
                        dialog_nuevoPedido.openDialog()
                    }
                }
            }
        }
    }
    Pane{
        id: paneContentLeft
        width: parent.width/12*5-20
        anchors.left: leftMenu.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 20
        anchors.bottomMargin: 20
        anchors.topMargin: 80
        Material.background: "#D7D7D7"
        Material.elevation: 4

        Pane{
            Material.background: "#FFFFFF"
            Material.elevation: 2
            width: parent.width
            height: 50
            id: productosHeader
            Label{
                width: parent.width
                text: "En almacen"
                color: "#008d96"
                anchors.centerIn: parent
                anchors.verticalCenter: parent.verticalCenter
                font.bold: true
                font.weight: Font.Bold
                font.pointSize: 17
                font.family: "Verdana"
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
    Pane{
        id: paneContentRight
        width: parent.width/12*5-20
        anchors.left: paneContentLeft.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 20
        anchors.bottomMargin: 20
        anchors.topMargin: 80
        Material.background: "#D7D7D7"
        Material.elevation: 4

        Pane{
            Material.background: "#FFFFFF"
            Material.elevation: 2
            width: parent.width
            height: 50
            id: historialPedidosHeader
            Label{
                width: parent.width
                text: "Historial de pedidos"
                color: "#008d96"
                anchors.centerIn: parent
                anchors.verticalCenter: parent.verticalCenter
                font.bold: true
                font.weight: Font.Bold
                font.pointSize: 17
                font.family: "Verdana"
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
}
