import QtQuick 2.9
//import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
Item {
    id:page_ComandaSeleccionada
    property int idComanda
    property int idEmpleado
    property int selectedPlatillo
    property string mesaAsignada
    property string estadoComanda
    property string fechaComanda
    property int cantidadPlatilloSeleccionado
    property int idSelectedPlatillo
    property var totalCuenta: modeloPlatillosComandas.getTotalComanda()

    property string textoBoton: {
        modeloPlatillosComandas.setIdComanda(idComanda)
        if(modeloPlatillosComandas.comandaInKitchen())
            textoBoton = "Cobrar cuenta"
        if(modeloPlatillosComandas.alreadyPaid()){
            textoBoton = "Cobrada"
            btn_EnviarOrden.enabled = false
            platillosOrdenados.enabled = false
            btn_AgregarPlatillo.enabled = false
        }
        if(!modeloPlatillosComandas.comandaInKitchen() && !modeloPlatillosComandas.alreadyPaid())
            textoBoton = "Enviar a cocina"
    }

    Pane{
        id: detallesComanda
        z:1
        width: platillosOrdenados.width;
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        height: 100
        Material.background: "#ffd699"
        Material.elevation: 4
        spacing: 0
        ColumnLayout{
            spacing: 0
            Row{
                spacing: 40
                padding: 10
                Label{
                    font.weight: Font.DemiBold
                    text: "Comanda: "+idComanda
                    font.pointSize: 14
                    font.family: "Verdana"
                }
                Label{
                    font.weight: Font.DemiBold
                    text: "Mesa: "+mesaAsignada
                    font.pointSize: 14
                    font.family: "Verdana"
                }
                Label{
                    text: "Fecha: "+fechaComanda
                    font.pointSize: 14
                    font.family: "Verdana"
                }
            }
            Row{
                spacing: 40
                padding: 10
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
                    text: "Total = $"+totalCuenta
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
                    Material.background: "#ffb03a"
                    Material.foreground: "#ffffff"
                    radius: 5
                    text: "Agregar Platillo"
                    font.weight: Font.DemiBold
                    font.pointSize: 14
                    onReleased: {
                        btn_AgregarPlatillo.Material.background = "#ffb03a"
                        pop_confirmacionAgregar.open()
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
            //modeloPlatillosComandas.setIdComanda(idComanda)
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
                leftPadding: 420
                text: "$"+totalPlatillo
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
                    cantidadPlatilloSeleccionado = cantidad-1;
                    idSelectedPlatillo = idPlatillo
                    popChangeQuantity.open()
                }
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
                    if(modeloPlatillosComandas.comandaAlreadySent()){
                        delegateItem.swipe.close()
                        pop_deletedFail.open()
                    }
                    else{
                        modeloPlatillosComandas.removePlatillo(idSelectedPlatillo)
                        totalCuenta = modeloPlatillosComandas.getTotalComanda()
                    }
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
        populate: Transition {
            id: populateTransition
            ParallelAnimation{
                NumberAnimation {property: "x"; from: 480; duration: 200}
                NumberAnimation {property: "opacity"; from: 0; to: 1.0; duration: 200 }
        }
        }
    }

    Popup{
        id: pop_deletedFail
        width: 300
        height: 100
        modal: true
        focus: true
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        closePolicy: Popup.CloseOnPressOutside
        Label{
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.weight: Font.DemiBold
            font.pointSize: 14
            font.family: "Verdana"
            width: 300
            height: 70
            wrapMode: Text.WordWrap
            text: "Platillo enviado, no se puede eliminar!"
        }
    }

    Popup{
        id: popChangeQuantity
        width: 300
        height: 200
        modal: true
        focus: true
        closePolicy: Popup.CloseOnPressOutside
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        topMargin: 20
        onAboutToShow: {
            selectorCantidad.positionViewAtIndex(cantidadPlatilloSeleccionado, Tumbler.Center)
        }
        Tumbler{
            id: selectorCantidad
            anchors.centerIn: parent
            bottomPadding: 40
            model: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
            visibleItemCount: 3
            width: parent.width
            height: 150
            font.weight: Font.Medium
            font.pointSize: 14
            font.family: "Verdana"
        }
        Row{
            anchors.centerIn: parent
            topPadding: 120
            spacing: 20
            Button{
                id: aceptar_CambioCantidad
                Material.background: "#ffffff"
                Material.foreground: "#ffb03a"
                width: (pop_confirmacionAgregar.width/2)-20
                text: "Modificar"
                font.weight: Font.DemiBold
                font.pointSize: 12
                font.family: "Verdana"
                onClicked: {
                    modeloPlatillosComandas.setQuantity(idComanda,idSelectedPlatillo, selectorCantidad.currentIndex+1)
                    popChangeQuantity.close()
                    totalCuenta = modeloPlatillosComandas.getTotalComanda()
                }
            }
            Button{
                id: cancelar_CambioCantidad
                Material.background: "#ffffff"
                Material.foreground: "#ffb03a"
                width: (pop_confirmacionAgregar.width/2)-20
                font.weight: Font.DemiBold
                font.pointSize: 12
                font.family: "Verdana"
                text: "Cancelar"
                onClicked: {
                    popChangeQuantity.close()
                }
            }
        }
    }

    Popup {
        id: pop_confirmacionAgregar
        width: 300
        height: 140
        modal: true
        focus: true
        closePolicy: Popup.CloseOnPressOutside
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        topMargin: 20
        onAboutToShow: inputPlatilloPorAgregar.currentIndex = 0
        ComboBox{
            id: inputPlatilloPorAgregar
            anchors.topMargin: 300
            model: modeloPlatillos.getNamesModel()
            width: 260
            height: 60
            editable: true

        }
        Row{
            anchors.centerIn: parent
            topPadding: 40
            spacing: 20
            Button{
                id:confirmAdd
                Material.background: "#ffffff"
                Material.foreground: "#ffb03a"
                width: (pop_confirmacionAgregar.width/2)-20
                text: "Agregar"
                font.weight: Font.DemiBold
                font.family: "Verdana"
                font.pointSize: 12
                onClicked: {
                    pop_confirmacionAgregar.close()
                    modeloPlatillosComandas.addPlatillo(idComanda, inputPlatilloPorAgregar.currentText, 1);
                    totalCuenta = modeloPlatillosComandas.getTotalComanda()
                }
            }
            Button{
                id:cancelAdd
                Material.background: "#ffffff"
                Material.foreground: "#ffb03a"
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

    RoundButton {
        id: btn_EnviarOrden
        Material.background: "#ffb03a"
        Material.foreground: "#ffffff"
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        height: 60
        radius: 5
        text: textoBoton
        font.weight: Font.DemiBold
        font.pointSize: 16
        onClicked: {
            pop_confirmacionCocina.open()
        }
    }

    Popup {
        id: pop_confirmacionCocina
        width: 300
        height: 100
        modal: true
        focus: true
        closePolicy: Popup.CloseOnPressOutside
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        topMargin: 20
        onAboutToShow: {
            if(textoBoton == "Cobrar cuenta"){
                pop_confirmacionCocina.close()
                pop_cobrarCuenta.open()
            }
        }
        onOpened: {
            if(textoBoton == "Cobrar cuenta"){
                pop_confirmacionCocina.close()
            }
        }
        Column{
            Label{
                anchors.horizontalCenter: platillosOrdenados.horizontalCenter
                text: "¿Desea enviar platillos a la cocina?"
            }
            Row{
                spacing: 10
                Button{
                    text: "Aceptar"
                    Material.background: "#ba8637"
                    Material.foreground: "#ffffff"
                    width: (pop_confirmacionCocina.width/2)-15
                    onClicked: {
                        if(modeloPlatillosComandas.saveNewComandaInDataBase()){
                            pop_confirmacionCocina.close()
                            pop_comandaEnviada.open()
                            textoBoton = "Cobrar cuenta"
                            modeloPlatillosComandas.setComandaTaken()
                        }
                    }
                }
                Button{
                    text: "Cancelar"
                    Material.background: "#ba8637"
                    Material.foreground: "#ffffff"
                    width: (pop_confirmacionCocina.width/2)-15
                    onClicked: {
                        pop_confirmacionCocina.close()
                    }
                }
            }
        }
    }

    Popup{
        id: pop_cobrarCuenta
        width: 300
        height: 100
        modal: true
        focus: true
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        closePolicy: Popup.CloseOnPressOutside
        onOpened: pop_confirmaCobro.open()
        Label{
            id: label_seCobro
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.weight: Font.DemiBold
            font.pointSize: 15
            font.family: "Verdana"
            width: 300
            height: 70
            wrapMode: Text.WordWrap
            //text: "Se va a cobrar la cuenta"
        }
    }

    Popup {
        id: pop_confirmaCobro
        width: 300
        height: 100
        modal: true
        focus: true
        closePolicy: Popup.CloseOnPressOutside
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        topMargin: 20
        Column{
            Label{
                anchors.horizontalCenter: platillosOrdenados.horizontalCenter
                text: "¿Esta seguro?"
            }
            Row{
                spacing: 10
                Button{
                    text: "Aceptar"
                    Material.background: "#ba8637"
                    Material.foreground: "#ffffff"
                    width: (pop_confirmaCobro.width/2)-15
                    onClicked: {
                        pop_confirmaCobro.close()
                        if(modeloPlatillosComandas.setComandaPagada(1)){
                            label_seCobro.text = "Se cobro la cuenta"
                            platillosOrdenados.enabled = false
                            btn_EnviarOrden.text = "Cobrada"
                            btn_EnviarOrden.enabled = false
                        }
                        else
                            label_seCobro.text = "No se cobro la cuenta"
                    }
                }
                Button{
                    text: "Cancelar"
                    Material.background: "#ba8637"
                    Material.foreground: "#ffffff"
                    width: (pop_confirmaCobro.width/2)-15
                    onClicked: {
                        pop_confirmaCobro.close()
                        pop_cobrarCuenta.close()
                    }
                }
            }
        }
    }

    Popup{
    id: pop_comandaEnviada
    width: 300
    height: 140
    modal: true
    focus: true
    closePolicy: Popup.CloseOnPressOutside
    x: Math.round((parent.width - width) / 2)
    y: Math.round((parent.height - height) / 2)
    topMargin: 20
    Label{
        color: "#4caf50"
        text: "Comanda enviada a la cocina! :D"
        font.weight: Font.DemiBold
        font.pointSize: 15
        font.family: "Verdana"
    }
    Image {
        id: img_envioOk
        fillMode: Image.PreserveAspectFit
        source: "img/savedOk.png"
        Layout.leftMargin: 220
        Layout.minimumWidth: 40
        Layout.maximumWidth: 40
        Layout.minimumHeight: 40
        Layout.maximumHeight: 40
        x: detallesComanda.width/5
        y:detallesComanda.height/5
    }
    }
}
