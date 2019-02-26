import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQml.Models 2.3
import QtQuick.Controls 1.4 as Aux


Item {

    function restFormulario(){
        inputRetirar.clear();
        labelExistente.text = almacen.getInfoProd(inputProducto.currentText,1)
        labelExistenteMedida.text = almacen.getInfoProd(inputProducto.currentText,2)
        labelRetiroMedida.text = almacen.getInfoProd(inputProducto.currentText,2)
    }
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
                        id: inputProducto
                        width: 300
                        Layout.minimumWidth: 300
                        Layout.maximumWidth: 300
                        model: almacen.getInfoContenido(3);
                    }
                }
                RowLayout{
                    spacing: 10
                    Layout.leftMargin: 50
                    Label{
                        width: 80
                        text: "Cantidad existente: "
                    }
                    Label{
                        id: labelExistente
                        Layout.maximumWidth: 20
                        Layout.minimumWidth: 20
                        text: almacen.getInfoProd(inputProducto.currentText,1)
                    }
                    Label{
                        id: labelExistenteMedida
                        width: 100
                        text: almacen.getInfoProd(inputProducto.currentText,2)
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
                        id: inputRetirar
                        Layout.maximumWidth: 50
                        Layout.minimumWidth: 50
                    }
                    Label{
                        id: labelRetiroMedida
                        width: 100
                        text: almacen.getInfoProd(inputProducto.currentText,2)
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
                            if(inputRetirar.text!="" && almacen.verificarCantidad(
                               labelExistente.text,inputRetirar.text))
                               dialogoConfirmacionRetiro.open()
                            else
                                popupErrorRetiro.open();
                        }
                    }
                    Button{
                        text: "Cancelar"
                        Material.foreground: "#FFFFFF"
                        Material.background: "#50A45C"
                        onClicked: {
                            restFormulario();
                            popup_DescontarProducto.close()
                        }
                    }
                }

            }

        }
        Dialog {
            id: dialogoConfirmacionRetiro
            height: 150
            width: 350
            modal: true
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
            parent: Overlay.overlay

            title: "El retiro generado se guardara \nen la base de datos,¿Desea continuar?"
            standardButtons: Dialog.Ok | Dialog.Cancel

            onAccepted: {
               almacen.actualizarCantidad(labelExistente.text,
                                         inputRetirar.text,
                                         inputProducto.currentText)
               restFormulario();
               popup_DescontarProducto.close()
            }
        }

        Popup
        {
            id: popupErrorRetiro
            x: 646
            y: 325
            width: 200
            height: 50
            Text {
                anchors.centerIn: parent
                font.pixelSize: 18
                text: qsTr("¡Verifica la cantidad!")
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

            Aux.SplitView{

                anchors.fill: parent

                Aux.TableView
                {
                    model: almacen
                    style: TableViewStyle {
                        headerDelegate: Rectangle {
                            height: textItem.implicitHeight * 1.2
                            width: textItem.implicitWidth
                            color: "#33673A"
                            Text {
                                id: textItem
                                font.pixelSize: 16
                                anchors.fill: parent
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: styleData.textAlignment
                                anchors.leftMargin: 12
                                text: styleData.value
                                elide: Text.ElideRight
                                color: textColor
                                renderType: Text.NativeRendering
                            }
                            Rectangle {
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 1
                                anchors.topMargin: 1
                                width: 1
                                color: "#ccc"
                            }
                        }
                    }
                    alternatingRowColors: false
                    backgroundVisible: false
                    itemDelegate: Item {
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            color: styleData.textColor = "#000000"
                            elide: styleData.elideMode
                            text: styleData.value
                            font.pixelSize: 14
                        }
                    }
                    Aux.TableViewColumn
                    {
                        role: "id"
                        title: "Id"
                        width: 30
                    }
                    Aux.TableViewColumn
                    {
                        role: "nombre"
                        title: "Nombre"
                        width: 250
                    }
                    Aux.TableViewColumn
                    {
                        role: "descripcion"
                        title: "Descripcion"
                        width: 500
                    }
                    Aux.TableViewColumn
                    {
                        role: "cantidad"
                        title: "Cantidad"
                        width: 75
                    }
                    Aux.TableViewColumn
                    {
                        role: "costo"
                        title: "Costo"
                        width: 75
                    }
                    Aux.TableViewColumn
                    {
                        role: "categoria"
                        title: "Categoria"
                        width: 75
                    }
                    Aux.TableViewColumn
                    {
                        role: "unidad"
                        title: "Medida"
                        width: 75
                    }
                }
            }
        }
    }
}
