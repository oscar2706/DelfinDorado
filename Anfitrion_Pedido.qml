import QtQuick 2.0
import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import Ticket 1.0

Dialog {
    id:dialog_Pedido
    width: 500
    height: 600
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    parent: Overlay.overlay
    focus: true
    modal: true
    onAboutToShow: {
        modeloPlatillosComandas.clearModeal()
        idComandaPedido = modeloPlatillosComandas.getNuevoIdComanda()
    }
    //property int idComandaNueva: modeloPlatillosComandas.getIdComanda() ajustar para generar comanda nueva, que regrese un numero nuevo
    property date currentDate: new Date()
    property string dateString
    property string idComandaPedido
    property int idSelectedPlatillo
    property string totalCuenta: modeloPlatillosComandas.getTotalComanda()
    Pane{
        id: fondoHeader
        z:1
        width: parent.width;
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        height: 100
        Material.background: "#FFE0B2"
        Material.elevation: 1
        spacing: 0
        Column{
            spacing: 0
            Row{
                spacing: 40
                padding: 10
                Label{
                    font.weight: Font.DemiBold
                    text: "Comanda: "+ idComandaPedido
                    font.pointSize: 14
                    font.family: "Verdana"
                }
                Label{
                    text: "Fecha: " + Qt.formatDateTime(new Date(), "dd/MM/yyyy")
                    font.pointSize: 14
                    font.family: "Verdana"
                }
            }
            Row{
                spacing: 30
                Label{
                    text: "Cantidad"
                    font.pointSize: 14
                    font.family: "Verdana"
                }
                Label{
                    text: "Nombre platillo"
                    font.pointSize: 14
                    font.family: "Verdana"
                }
                Label{
                    text: "Precio x Unidad"
                    font.pointSize: 14
                    font.family: "Verdana"
                }
                Label{
                    text: "Total"
                    font.pointSize: 14
                    font.family: "Verdana"
                }
            }
        }
    }

    Component{
        id:footerComandas
        Item{
            width: platillosOrdenados.width
            height: 110
            Pane{
                Material.background: "#ffffff"
                width: parent.width
                height: parent.height
                anchors.fill: parent
                Label{
                    id:totalPagar
                    text: "Total = $" + totalCuenta
                    font.pointSize: 14
                    font.family: "Verdana"
                    font.weight: Font.DemiBold
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 70
                }
                RoundButton{
                    id:btn_AgregarPlatillo
                    width: parent.width
                    height: 50
                    anchors.centerIn: parent
                    anchors.topMargin: 10
                    anchors.bottomMargin: 10
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.top: parent.top
                    Material.background: "#CBAE82"
                    Material.foreground: "#FFFFFF"
                    radius: 5
                    text: "Agregar Platillo"
                    font.weight: Font.DemiBold
                    font.pointSize: 14
                    onClicked: {
                        pop_confirmacionAgregar.open()
                        inputCantidad.text = "1"
                    }
                }
            }
        }
    }

    ListView{
        id: platillosOrdenados
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        topMargin: 100
        anchors.bottom: parent.bottom
        bottomMargin: 60
        clip: true
        model: {
            modeloPlatillosComandas.setIdComandaPedido(modeloPlatillosComandas.getNuevoIdComanda())
            //idComandaPedido = modeloPlatillosComandas.getIdComanda()
            modeloPlatillosComandas
        }
        footer: footerComandas
        spacing: 0
        ScrollBar.vertical: ScrollBar {
        }
        delegate: SwipeDelegate {
            id: delegateItem
            width: parent.width
            height: 50

            Text{
                id: cantidadPlatillo
                Layout.minimumWidth: 250
                Layout.maximumWidth: 250
                topPadding: 20
                leftPadding: 50
                text: cantidad
                font.family: "Verdana"
                font.pointSize: 12
            }
            Text{
                id: nombreDelPlatillo
                Layout.minimumWidth: 200
                Layout.maximumWidth: 200
                topPadding: 20
                leftPadding: 120
                text: nombrePlatillo
                font.family: "Verdana"
                font.pointSize: 12
            }
            Text{
                id: precioPorUnidad
                Layout.minimumWidth: 200
                Layout.maximumWidth: 200
                topPadding: 20
                leftPadding: 310
                text: "$"+precioUnidad
                font.family: "Verdana"
                font.pointSize: 12
            }
            Text{
                id: precioTotal
                Layout.minimumWidth: 200
                Layout.maximumWidth: 200
                topPadding: 20
                leftPadding: 400
                text: "$"+totalPlatillo
                font.bold: true
                font.family: "Verdana"
                font.pointSize: 12
                opacity: delegateItem.pressed ? 0 : 1
                Behavior on opacity { NumberAnimation { } }
            }
            swipe.onCompleted: {
                precioTotal.opacity = 0;
            }
            swipe.onClosed: {
                precioTotal.opacity = 1;
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
                    idSelectedPlatillo = idPlatillo
                    modeloPlatillosComandas.removePlatillo(idSelectedPlatillo)
                    totalCuenta = modeloPlatillosComandas.getTotalComanda()
                }
            }
        }
        ScrollIndicator.vertical: ScrollIndicator { }
        //Animaciones
        add: Transition {
            ParallelAnimation{
                NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
                NumberAnimation { properties: "x"; from: 240; duration: 350; easing.type: Easing.InOutExpo}
            }
        }
        remove: Transition {
            ParallelAnimation {
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
        populate: Transition {
            id: populateTransition
            ParallelAnimation{
                NumberAnimation {property: "x"; from: 480; duration: 200}
                NumberAnimation {property: "opacity"; from: 0; to: 1.0; duration: 200 }
        }
        }
    }

    Popup {
        id: pop_confirmacionAgregar
        width: 300
        height: 200
        modal: true
        focus: true
        closePolicy: Popup.CloseOnPressOutside
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        topMargin: 20
        onAboutToShow: inputPlatilloPorAgregar.currentIndex = 0
        ComboBox{
            id: inputPlatilloPorAgregar
            anchors.topMargin: 20
            Material.accent: "#B23D01"
            model: modeloPlatillos.getNamesModel()
            width: 260
            height: 60
            editable: true

        }
        Label{
            id: label_Cantidad
            anchors.top: inputPlatilloPorAgregar.bottom
            anchors.left: inputPlatilloPorAgregar.left
            anchors.topMargin: 10
            anchors.leftMargin: 80
            text: "Cantidad:"
            verticalAlignment: Text.AlignVCenter
            height: 30
        }
        TextField{
            id:inputCantidad
            horizontalAlignment: Text.AlignHCenter
            anchors.bottom: label_Cantidad.bottom
            anchors.left: label_Cantidad.right
            anchors.bottomMargin: -10
            anchors.leftMargin: 10
            Material.accent: "#B23D01"
            width: 50
            height: 50
        }

        Row{
            anchors.top: label_Cantidad.bottom
            anchors.topMargin: 20
            //topPadding: 140
            spacing: 20
            Button{
                id:confirmAdd
                Material.background: "#CBAE82"
                Material.foreground: "#FFFFFF"
                width: (pop_confirmacionAgregar.width/2)-20
                text: "Agregar"
                font.weight: Font.DemiBold
                font.family: "Verdana"
                font.pointSize: 12
                onClicked: {
                    pop_confirmacionAgregar.close()
                    var cantidadDePlatillo;
                    cantidadDePlatillo = Number.fromLocaleString(inputCantidad.text);
                    modeloPlatillosComandas.addPlatillo(idComandaPedido, inputPlatilloPorAgregar.currentText, cantidadDePlatillo);
                    totalCuenta = modeloPlatillosComandas.getTotalComanda()
                    totalPagar.text = "Total = $" + totalCuenta
                }
            }
            Button{
                id:cancelAdd
                Material.background: "#CBAE82"
                Material.foreground: "#FFFFFF"
                width: (pop_confirmacionAgregar.width/2)-20
                text: "Cancelar"
                font.family: "Verdana"
                font.weight: Font.DemiBold
                font.pointSize: 12
                onClicked: {
                    pop_confirmacionAgregar.close()
                }
            }
        }
    }

    Popup {
        id: pop_enviarYCobrar
        width: 250
        height: 100
        modal: true
        focus: true
        closePolicy: Popup.CloseOnPressOutside
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        topMargin: 20
        Column{
            Label{
                text: "¿Esta seguro?"
            }
            Row{
                spacing: 10
                Button{
                    text: "Aceptar"
                    Material.background: "#CBAE82"
                    Material.foreground: "#ffffff"
                    font.family: "Verdana"
                    width: (pop_enviarYCobrar.width/2)-15
                    onClicked: {
                        modeloComandas.addComandaPedido(3);
                        modeloPlatillosComandas.saveNewPedidoInDataBase()
                        ticketPago.fecha = Qt.formatDateTime(new Date(), "dd/MM/yyyy")
                        ticketPago.platillosList = modeloPlatillosComandas.getPlatillosCuenta()
                        ticketPago.total = modeloPlatillosComandas.getTotalComanda()
                        ticketWindow.show()

                        modeloPlatillosComandas.setComandaPagada()
                        modeloPlatillosComandas.clearModeal()
                        totalCuenta = 0
                        pop_enviarYCobrar.close()
                        dialog_Pedido.close()
                    }
                }
                Button{
                    text: "Cancelar"
                    Material.background: "#CBAE82"
                    Material.foreground: "#ffffff"
                    font.family: "Verdana"
                    width: (pop_enviarYCobrar.width/2)-15
                    onClicked: {
                        pop_enviarYCobrar.close()
                    }
                }
            }
        }
    }

    RoundButton {
        id: btn_EnviarCobrar
        Material.background: "#CBAE82"
        Material.foreground: "#FFFFFF"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 160
        anchors.bottomMargin: 0
        height: 50
        width: 150
        radius: 5
        text: "Enviar y cobrar"
        display: AbstractButton.TextOnly
        font.weight: Font.DemiBold
        font.pointSize: 14
        onClicked: {
            pop_enviarYCobrar.open()
        }
    }

    RoundButton {
        id: btn_Cancelar
        Material.background: "#CBAE82"
        Material.foreground: "#FFFFFF"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.rightMargin: 0
        height: 50
        width: 150
        radius: 5
        text: "Cancelar"
        display: AbstractButton.TextOnly
        font.weight: Font.DemiBold
        font.pointSize: 14
        onClicked: {
            totalCuenta = 0
            modeloPlatillosComandas.clearModeal();
            dialog_Pedido.close()
        }
    }

    Window {
        id: ticketWindow
        width: 400
        height: 650
        maximumHeight: 650
        maximumWidth: 400
        minimumHeight: 650
        minimumWidth: 400
        Component.onCompleted: {
            setX(screen.width / 2 - width / 2);
            setY(screen.height / 2 - height / 2);
        }
        TicketPrinter{
            id: ticketPago
        }
        RoundButton{
            anchors.top: ticketPago.bottom
            anchors.right: ticketPago.right
            anchors.rightMargin: 10
            Material.background: "#ffb03a"
            Material.foreground: "#ffffff"
            radius: 5
            text: "Aceptar"
            onClicked: {
                ticketWindow.close()
            }
        }
    }
}
