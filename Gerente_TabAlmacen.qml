import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4

Item {
    id: tabAlmacen
    visible: true
    width: 1366
    height: 717
    Pane{
        anchors.topMargin: 90
        anchors.fill: parent
        TableView {
            x: 80
            y: 39
            width: 518
            height: 526
            TableViewColumn {
                role: "id"
                title: "ID Producto"
                width: 100
            }
            TableViewColumn {
                role: "producto"
                title: "Producto"
                width: 200
            }

            TableViewColumn {
                role: "cantidad"
                title: "Cantidad"
                width: 200
            }
        }

        ColumnLayout {
            id: columnLayout
            x: 35
            y: 40
            width: 1299
            height: 643
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 34
            clip: false
        }

        ColumnLayout {
            id: columnLayout1
            x: 795
            y: 228
            width: 470
            height: 280
        }

        Text {
            id: text2
            x: 845
            y: 298
            width: 143
            height: 36
            text: qsTr("Producto:")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 19
        }

        Text {
            id: text3
            x: 845
            y: 351
            width: 143
            height: 34
            text: qsTr("Cantidad:")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 19

            ComboBox {
                id: comboBox2
                x: 121
                y: 3
                width: 76
                height: 34
            }
        }

        ComboBox {
            id: comboBox
            x: 966
            y: 298
            width: 226
            height: 36
        }

        Text {
            id: text4
            x: 1046
            y: 356
            width: 157
            height: 34
            text: qsTr("Unidad de Medida")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 19
        }

        Button {
            id: button
            x: 829
            y: 424
            Material.foreground: "#FFFFFF"
            Material.background: "#008d96"
            width: 124
            height: 37
            text: qsTr("Retirar Producto")
        }

        Button {
            id: button1
            x: 1103
            y: 424
            Material.foreground: "#FFFFFF"
            Material.background: "#008d96"
            width: 123
            height: 37
            text: qsTr("Reiniciar")
        }
    }
}
