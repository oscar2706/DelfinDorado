import QtQuick 2.9
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

Item {
    function openDialog(){
        dialog_NuevoProducto.open();
    }
    Dialog{
        id:dialog_NuevoProducto
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: 500
        height: 400
        parent: Overlay.overlay
        focus: true
        modal: true
        ColumnLayout{
            width: parent.width
            Label {
                id: dialogTitle
                width: parent.width
                height: 40
                color: "#0aa0c1"
                text: qsTr("Nuevo producto")
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 22
                leftPadding: 170
                z:2
            }
            RowLayout{
                spacing: 10
                Layout.leftMargin: 50
                Label{
                    width: 100
                    text: "Nombre del producto"
                }
                TextField{
                    Layout.alignment: Qt.AlignVCenter
                    width: 200
                    text: precioActual
                }
            }
            RowLayout{
                spacing: 10
                Layout.leftMargin: 50
                Label{
                    width: 100
                    text: "Descripcion"
                }
                TextField{
                    Layout.alignment: Qt.AlignVCenter
                    width: 200
                    text: precioActual
                }
            }
            RowLayout{
                spacing: 10
                Layout.leftMargin: 50
                Label{
                    width: 100
                    text: "Costo"
                }
                TextField{
                    Layout.alignment: Qt.AlignVCenter
                    id: inputPrecio
                    width: 200
                    text: precioActual
                }
            }
            RowLayout{
                spacing: 10
                Layout.leftMargin: 50
                Label{
                    width: 100
                    text: "Categoria"
                }
                ComboBox{
                    id: inputCategoria
                    width: 300
                    Layout.minimumWidth: 250
                    Layout.maximumWidth: 250
                    model: ["Productos en almacen", "hola que hace"]
                }
            }
            RowLayout{
                spacing: 10
                Layout.leftMargin: 50
                Label{
                    width: 100
                    text: "Unidad de medida"
                }
                ComboBox{
                    id: inputUnidadMedida
                    Layout.minimumWidth: 200
                    Layout.maximumWidth: 200
                    model: ["Productos en almacen", "hola que hace"]
                }
            }

            Button{
                id:btnRegistrar
                anchors.right: btnCancelar.left
                anchors.bottom: parent.bottom
                anchors.rightMargin: 10
                anchors.bottomMargin: 20
                text: "Registrar"
                Material.foreground: "#FFFFFF"
                Material.background: "#008d96"
                onClicked:{
                    //Guardar cambios
                    dialog_NuevoProducto.close()
                }
            }
            Button{
                id: btnCancelar
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 0
                anchors.bottomMargin: 20
                text: "Cancelar"
                Material.foreground: "#FFFFFF"
                Material.background: "#008d96"
                onClicked: {
                    dialog_NuevoProducto.close()
                }
            }
        }
    }
}
