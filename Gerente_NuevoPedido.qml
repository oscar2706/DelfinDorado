import QtQuick 2.9
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

Item {
    property int idGerente
    property int idPedido
    property var totalPedido: modeloPedidoProductos.getTotalPedido()
    property var unidadCategoria//: modeloPedidoProductos.getUnidadMedida(inputCategoria.currentText);
    property int selectedProducto
    property int idSelectedProducto
    property int cantidadProducto
    property int costoProducto: 0
    property var modeloUnidades: almacen.getInfoContenido(3)

    function openDialog(){
        dialog_NuevoPedido.open();
    }
    Dialog{
        id: dialog_NuevoPedido
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: 500
        height: 600
        parent: Overlay.overlay
        focus: true
        modal: true

        Rectangle{
            id:fondoTitulo
            width: parent.width
            height: 40
            Material.background: "#ffffff"
            z:1
        }
        Label {
            id: dialogTitle
            width: parent.width
            height: 40
            color: "#0aa0c1"
            text: qsTr("Nuevo pedido")
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 22
            z:2
        }

        ListView{
            id: productosDelPedido
            width: dialog_NuevoPedido.width-50
            height: 500
            contentHeight: 500
            topMargin: 40
            bottomMargin: 60
            clip: true
            model: modeloPedidoProductos
            footer: footerPedido
            delegate: SwipeDelegate {
                id: delegateItem
                width: parent.width
                height: 50

                Text{
                    id: nombreProducto
                    Layout.minimumWidth: 250
                    Layout.maximumWidth: 250
                    topPadding: 20
                    leftPadding: 60
                    text: nombre
                    font.family: "Verdana"
                    font.pointSize: 12
                }
                Text{
                    id: cantidadProducto
                    Layout.minimumWidth: 200
                    Layout.maximumWidth: 200
                    topPadding: 20
                    leftPadding: 150
                    text: cantidad + " " + unidadMedida
                    font.family: "Verdana" //+ unidadMedida
                    font.pointSize: 12
                }
                Text{
                    id: costoProducto
                    Layout.minimumWidth: 200
                    Layout.maximumWidth: 200
                    topPadding: 20
                    leftPadding: 260
                    text: costo
                    font.family: "Verdana" //+ unidadMedida
                    font.pointSize: 12
                }
                Text{
                    id: totalProductos
                    Layout.minimumWidth: 200
                    Layout.maximumWidth: 200
                    topPadding: 20
                    leftPadding: 340
                    text: "$ "+totalProducto
                    font.bold: true
                    font.family: "Verdana"
                    font.pointSize: 12
                    opacity: delegateItem.pressed ? 0 : 1
                    Behavior on opacity { NumberAnimation { } }
                }
                MouseArea{
                    id:modifyQuantityMouseArea
                    anchors.fill: parent
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 360
                    onClicked: {
                    }
                }
                swipe.onCompleted: {
                    totalProductos.opacity = 0;
                }
                swipe.onClosed: {
                    totalProductos.opacity = 1;
                }
                swipe.right: Rectangle {
                    anchors.right: parent.right
                    width: 80
                    height: parent.height
                    clip: true
                    color: SwipeDelegate.pressed ? "white" : Material.color(Material.Red)
                    Label {
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        text: "Borrar"
                        padding: 12
                        anchors.fill: parent
                        horizontalAlignment: Qt.AlignRight
                        verticalAlignment: Qt.AlignVCenter
                        color: "white"
                    }
                    SwipeDelegate.onClicked: {
                        modeloPedidoProductos.removeProducto(idSelectedProducto)
                        totalPedido = modeloPedidoProductos.getTotalPedido()
                    }
                }
            }
            //Animaciones
            add: Transition {
                ParallelAnimation{
                    NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
                    NumberAnimation { properties: "x"; from: 240; duration: 350; easing.type: Easing.InOutExpo}
                }
            }
            remove: Transition {
                ParallelAnimation {
                    NumberAnimation{ target: btn_QuitaPlatillo; property: "opacity"; from:1.0; to: 0; duration: 100}
                    NumberAnimation { property: "height"; to: 0; duration: 300; easing.type: Easing.OutCirc}
                }
            }
            displaced: Transition {
                id: dispTrans
                    SequentialAnimation {
                        PauseAnimation {
                            duration: (dispTrans.ViewTransition.index -
                                    dispTrans.ViewTransition.targetIndexes[0]) * 100
                        }
                        NumberAnimation { properties: "x,y"; duration: 150; easing.type: Easing.InSine}
                    }
            }
        }


        Component{
            id:footerPedido
            Item{
                width: productosDelPedido.width
                height: 110
                Pane{
                    Material.background: "#ffffff"
                    width: parent.width
                    height: parent.height
                    anchors.fill: parent
                    Label{
                        id: totalPedidos
                        text: "Total = " + totalPedido
                        font.pointSize: 14
                        font.family: "Verdana"
                        font.weight: Font.DemiBold
                        anchors.right: parent.right
                        anchors.rightMargin: 30
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 70
                    }
                    RoundButton{
                        id:btn_AgregarProducto
                        width: 250
                        height: 50
                        anchors.centerIn: parent
                        anchors.topMargin: 10
                        anchors.bottomMargin: 10
                        anchors.right: parent.right
                        anchors.left: parent.left
                        anchors.top: parent.top
                        Material.background: "#008D9E"
                        Material.foreground: "#ffffff"
                        radius: 5
                        text: "Agregar Producto"
                        font.weight: Font.DemiBold
                        font.pointSize: 14
                        onClicked:{
                            popup_AgregarProducto.open()
                        }
                    }
                }
            }
        }

       Popup{
           id:popup_AgregarProducto
           x: Math.round((parent.width - width) / 2)
           y: Math.round((parent.height - height) / 2)
           width: 400
           height: 300
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
                   color: "#0aa0c1"
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
                       model: modeloUnidades
                       onCurrentTextChanged:
                       {
                           unidadCategoria = modeloPedidoProductos.getUnidadMedida(inputCategoria.currentText);
                           lblPrecio.text = modeloPedidoProductos.getTotalProducto(inputCategoria.currentText, costoProducto);
                       }
                   }
               }
               RowLayout{
                   spacing: 10
                   Layout.leftMargin: 50
                   Label{
                       id: lblCantidad
                       width: 80
                       text: "Cantidad"
                   }
                   TextField{
                       id: txtCosto
                       Layout.maximumWidth: 90
                       Layout.minimumWidth: 90
                       text: ""
                       onEditingFinished:
                       {
                            costoProducto = parseInt(txtCosto.text);
                            lblPrecio.text = modeloPedidoProductos.getTotalProducto(inputCategoria.currentText, costoProducto);
                       }
                   }
                   Label{
                       id: lblUnidadMedida
                       width: 100
                       text: unidadCategoria
                   }
               }
               RowLayout{
                   spacing: 10
                   Layout.leftMargin: 50
                   Label{
                       id: lblTotal
                       width: 100
                       text: "Total"
                   }
                   Label{
                       id: lblPrecio
                       width: 100
                   }
               }

               RowLayout{
                   Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                   spacing: 20
                   Layout.topMargin: 40
                   Layout.leftMargin: 40
                   Button{
                       text: "Agregar"
                       Material.foreground: "#FFFFFF"
                       Material.background: "#008d96"
                       onClicked:{
                            modeloPedidoProductos.addPedidoProductos(0, inputCategoria.currentText, parseInt(txtCosto.text));
                           totalPedido = modeloPedidoProductos.getTotalPedido();
                           popup_AgregarProducto.close()
                       }
                   }
                   Button{
                       text: "Cancelar"
                       Material.foreground: "#FFFFFF"
                       Material.background: "#008d96"
                       onClicked: {
                           popup_AgregarProducto.close()
                       }
                   }
               }

           }

       }

       Row{
            id: filaBotones
            spacing: 20
            topPadding: 520
            leftPadding: 220
            Layout.alignment: Qt.AlignRight //| Qt.AlignVCenter
            width: dialog_NuevoPedido.width
            Button{
                id:btnRegistrar
                text: "Realizar pedido"
                Material.foreground: "#FFFFFF"
                Material.background: "#008d96"
                onClicked:{
                    modeloPedidos.addPedido(totalPedido, idGerente);
                    modeloPedidoProductos.saveNewPedidoInDataBase(modeloPedidos.getUltimoPedido());
                    dialog_NuevoPedido.close()
                }
            }
            Button{
                id: btnCancelar
                text: "Cancelar"
                Material.foreground: "#FFFFFF"
                Material.background: "#008d96"
                onClicked: {
                    dialog_NuevoPedido.close()
                }
            }
        }
    }
}
