import QtQuick 2.9
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

Item {
    function openDialog(){
        dialog_NuevoProducto.open();
    }
    function restFormulario(){
        inputNombre.clear();
        inputDescripcion.clear();
        inputPrecio.clear();
    }
    Dialog{
        id: dialog_NuevoProducto
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
                    id: inputNombre
                    Layout.alignment: Qt.AlignVCenter
                    width: 200
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
                    id: inputDescripcion
                    Layout.alignment: Qt.AlignVCenter
                    width: 200
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
                    id: inputPrecio
                    Layout.alignment: Qt.AlignVCenter
                    width: 200
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
                    model: almacen.getInfoContenido(1);
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
                    model: almacen.getInfoContenido(2);
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
                    if(inputNombre.text !="" && inputDescripcion.text !="" && inputPrecio.text !="")
                        dialogoConfirmacionProducto.open();
                    else
                        popupErrorProducto.open();

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
                    restFormulario();
                }
            }
        }
    }
    Dialog {
        id: dialogoConfirmacionProducto
        height: 150
        width: 350
        modal: true
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        parent: Overlay.overlay

        title: "El registro generado se guardara \nen la base de datos,¿Desea continuar?"
        standardButtons: Dialog.Ok | Dialog.Cancel

        onAccepted: {
              almacen.setProductoAlmacen(inputNombre.text,inputDescripcion.text,inputPrecio.text,
              inputCategoria.currentText,inputUnidadMedida.currentText);
              restFormulario();
              dialog_NuevoProducto.close();
        }
    }

    Popup
    {
        id: popupErrorProducto
        x: 646
        y: 325
        width: 200
        height: 50
        Text {
            anchors.centerIn: parent
            font.pixelSize: 18
            text: qsTr("¡Campos vacios!")
        }
    }
}
