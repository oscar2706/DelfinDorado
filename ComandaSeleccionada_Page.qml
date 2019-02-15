import QtQuick 2.9
//import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
Item {
    property int idComanda
    property int selectedPlatillo
    property string mesaAsignada
    property string estadoComanda
    property string fechaComanda
    /*function changeCantidad(platillo){

    }*/


    //TODO: Crear modelo para cargar platillos de la comanda desde la base de datos

    ListModel{
        id: orden
        ListElement{
            cantidad: 2
            nombrePlatillo: "Arroz"
            precioUnidad: 60
            precioTotal: 60
        }
    }

    ListView.onAdd: SequentialAnimation {
        PropertyAction { target: delegateItem; property: "height"; value: 0 }
        NumberAnimation { target: delegateItem; property: "height"; to: 80; duration: 250; easing.type: Easing.InOutQuad }
    }


    Pane{
        id: comandasHeader
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
        id:listFooter
        Item{
            width: platillosOrdenados.width
            height: 50
            Pane{
                Material.background: "#ffffff"
                //Material.elevation: 2
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
                        popup.open()
                    }
                    /*
                    onPressed: {
                        btn_AgregarPlatillo .Material.background = "#ba8637"
                    }
                    */
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
        model:orden
        //header: listHeaderComponent
        footer: listFooter
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
                //property bool selectedItem: false
                Pane{
                    id: elementoPlatillo
                    anchors.fill: parent
                    Material.background: select
                    Material.elevation: elevacion
                }
                Text{
                    Layout.minimumWidth: 250
                    Layout.maximumWidth: 250
                    topPadding: 20
                    leftPadding: 40
                    text: cantidad
                    font.family: "Verdana"
                    font.pointSize: 10
                }
                Text{
                    Layout.minimumWidth: 200
                    Layout.maximumWidth: 200
                    topPadding: 20
                    leftPadding: 150
                    text: nombrePlatillo
                    font.family: "Verdana"
                    font.pointSize: 10
                }
                Text{
                    Layout.minimumWidth: 200
                    Layout.maximumWidth: 200
                    topPadding: 20
                    leftPadding: 310
                    text: "$"+precioUnidad
                    font.family: "Verdana"
                    font.pointSize: 10
                }
                Text{
                    Layout.minimumWidth: 200
                    Layout.maximumWidth: 200
                    topPadding: 20
                    leftPadding: 420
                    text: "$"+precioTotal
                    font.bold: true
                    font.family: "Verdana"
                    font.pointSize: 10
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:  select = "#cfd8dc"
                    onClicked: popChangeQuantity.open()
                    onReleased: select = "#ffffff"
                    //selectedPlatillo = ejemploOrden.currentIndex;
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
        anchors.centerIn: parent
        topMargin: 20
        Column{
            Label{
                text: "¿Desea enviar platillos a la cocina?"
            }
            Row{
                spacing: 10
                Button{
                    text: "Enviar"
                    Material.background: "#ffffff"
                    Material.foreground: "#ffb03a"
                    width: (pop_confirmacionCocina.width/2)-15
                    onClicked: {
                        pop_confirmacionCocina.close()
                    }
                }
                Button{
                    text: "Cancelar"
                    Material.background: "#ffffff"
                    Material.foreground: "#ffb03a"
                    width: (pop_confirmacionCocina.width/2)-15
                    onClicked: {
                        pop_confirmacionCocina.close()
                    }
                }
            }
        }
    }

    Popup{
        id: popChangeQuantity
        width: 300
        height: 140
        modal: true
        focus: true
        closePolicy: Popup.CloseOnPressOutside
        anchors.centerIn: parent
        topMargin: 20
        TextField{
            anchors.topMargin: 300
            placeholderText: "Nueva cantidad"
        }
        Row{
            anchors.centerIn: parent
            topPadding: 40
            spacing: 20
            Button{
                id: nuevaCantidad
                Material.background: "#ba8637"
                Material.foreground: "#ffffff"
                width: (popup.width/2)-20
                text: "Modificar"
                onClicked: {
                    popChangeQuantity.close()
                    ejemploOrden.setData(1,10 , "cantidad")
                }
            }
            Button{
                Material.background: "#ba8637"
                Material.foreground: "#ffffff"
                width: (popup.width/2)-20
                text: "Cancelar"
                onClicked: {
                    popChangeQuantity.close()
                }
            }
        }
    }

    Popup {
        id: popup
        width: 300
        height: 140
        modal: true
        focus: true
        closePolicy: Popup.CloseOnPressOutside
        anchors.centerIn: parent
        topMargin: 20

        ComboBox{
            id: inputPlatilloPorAgregar
            //anchors.top: popup
            //anchors.topMargin: 0
            anchors.topMargin: 300
            //anchors.centerIn: parent
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
                Material.background: "#ba8637"
                Material.foreground: "#ffffff"
                width: (popup.width/2)-20
                text: "Agregar"
                onClicked: {
                    popup.close()
                    ejemploOrden.append({
                                            "cantidad": 1,
                                            "nombrePlatillo": inputPlatilloPorAgregar.currentText,
                                            "precioUnidad": modeloPlatillos.getPrecioPlatillo(inputPlatilloPorAgregar.currentText),
                                            "precioTotal": modeloPlatillos.getPrecioPlatillo(inputPlatilloPorAgregar.currentText)
                                        })
                }
            }
            Button{
                id:cancelAdd
                Material.background: "#ba8637"
                Material.foreground: "#ffffff"
                width: (popup.width/2)-20
                text: "Cancelar"
                onClicked: {
                    popup.close()
                }
            }
        }
    }
}
