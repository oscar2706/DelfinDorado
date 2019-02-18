import QtQuick 2.9
//import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
Item {
    property int idComanda
    property int idEmpleado
    property int selectedPlatillo
    property string mesaAsignada
    property string estadoComanda
    property string fechaComanda
    property int cantidadPlatilloSeleccionado
    property int idSelectedPlatillo

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
                    text: "Comanda: "+idComanda
                }
                Label{
                    text: "Mesa: "+mesaAsignada
                }
                Label{
                    text: "Fecha: "+fechaComanda
                }
            }
            Row{
                spacing: 50
                padding: 10
                Label{
                    text: "Cantidad"
                }
                Label{
                    text: "Nombre platillo"
                }
                Label{
                    text: "Precio x Unidad"
                }
                Label{
                    text: "Total"
                }
            }
        }
    }

    Component{
        id:footerComandas
        Item{
            width: platillosOrdenados.width
            height: 50
            Pane{
                Material.background: "#ffffff"
                width: parent.width
                height: parent.height
                anchors.fill: parent
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
            modeloPlatillosComandas.setIdComanda(idComanda)
            modeloPlatillosComandas
        }
        footer: footerComandas
        spacing: 0
        ScrollBar.vertical: ScrollBar {
        }
        delegate: Component {
            id: delegateItem
            Item{
                width: parent.width
                height: 50
                property string select: "#ffffff"
                property int elevacion: 2
                Pane{
                    id: elementoPlatillo
                    anchors.fill: parent
                    Material.background: select
                    Material.elevation: elevacion
                }
                Button{
                    id: btn_QuitaPlatillo
                    Material.background: "#ffffff"
                    Material.foreground: "#f44242"
                    Layout.minimumWidth: 70
                    Layout.maximumWidth: 70
                    Layout.minimumHeight: 50
                    Layout.maximumHeight: 50
                    text: qsTr("del")
                    onClicked: {
                        cantidadPlatilloSeleccionado = cantidad-1;
                        idSelectedPlatillo = idPlatillo
                        if(!modeloPlatillosComandas.removePlatillo(idSelectedPlatillo)){
                            deletedFail.open()
                        }
                    }
                }
                Text{
                    id: cantidadPlatillo
                    Layout.minimumWidth: 250
                    Layout.maximumWidth: 250
                    topPadding: 20
                    leftPadding: 80
                    text: cantidad
                    font.family: "Verdana"
                    font.pointSize: 10
                }
                Text{
                    id: nombreDelPlatillo
                    Layout.minimumWidth: 200
                    Layout.maximumWidth: 200
                    topPadding: 20
                    leftPadding: 120
                    text: nombrePlatillo
                    font.family: "Verdana"
                    font.pointSize: 10
                }
                Text{
                    id: precioPorUnidad
                    Layout.minimumWidth: 200
                    Layout.maximumWidth: 200
                    topPadding: 20
                    leftPadding: 310
                    text: "$"+precioUnidad
                    font.family: "Verdana"
                    font.pointSize: 10
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
                    font.pointSize: 10
                }
                MouseArea{
                    anchors.fill: parent
                    anchors.left: parent.left
                    anchors.leftMargin: 70
                    onPressed:  select = "#cfd8dc"
                    onClicked: {
                        cantidadPlatilloSeleccionado = cantidad-1;
                        idSelectedPlatillo = idPlatillo
                        popChangeQuantity.open()
                    }
                    onReleased: select = "#ffffff"
                }
            }
        }
    }
    ListView.onAdd: SequentialAnimation {
        PropertyAction { target: delegateItem; property: "height"; value: 0 }
        NumberAnimation { target: delegateItem; property: "height"; to: 80; duration: 350; easing.type: Easing.InOutQuad }
    }

    Popup{
        id: deletedFail
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
            font.pointSize: 15
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
            font.pointSize: 16
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
                onClicked: {
                    modeloPlatillosComandas.setQuantity(idComanda,idSelectedPlatillo, selectorCantidad.currentIndex+1)
                    popChangeQuantity.close()
                }
            }
            Button{
                id: cancelar_CambioCantidad
                Material.background: "#ffffff"
                Material.foreground: "#ffb03a"
                width: (pop_confirmacionAgregar.width/2)-20
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
                onClicked: {
                    pop_confirmacionAgregar.close()
                    modeloPlatillosComandas.addPlatillo(idComanda, inputPlatilloPorAgregar.currentText, 1);
                }
            }
            Button{
                id:cancelAdd
                Material.background: "#ffffff"
                Material.foreground: "#ffb03a"
                width: (pop_confirmacionAgregar.width/2)-20
                text: "Cancelar"
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
        text: "Enviar a cocina"
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
            if(modeloPlatillosComandas.comandaAlreadySent()){
                pop_confirmacionCocina.close()
                pop_anteriormenteEnviada.open()
            }
        }
        onOpened: {
            if(modeloPlatillosComandas.comandaAlreadySent()){
                pop_confirmacionCocina.close()
            }
        }
        Column{
            Label{
                text: "¿Desea enviar platillos a la cocina?"
            }
            Row{
                spacing: 10
                Button{
                    text: "Enviar"
                    Material.background: "#ba8637"
                    Material.foreground: "#ffffff"
                    width: (pop_confirmacionCocina.width/2)-15
                    onClicked: {
                        if(modeloPlatillosComandas.saveNewComandaInDataBase()){
                            pop_confirmacionCocina.close()
                            pop_comandaEnviada.open()
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
        id: pop_anteriormenteEnviada
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
            font.pointSize: 15
            font.family: "Verdana"
            width: 300
            height: 70
            wrapMode: Text.WordWrap
            text: "La comanda ya se habia mandado! C:"
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
