import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQml.Models 2.3

Item
{
    property int selectedEmploye: -1
    property string nombre: ""
    property string foto: ""
    property string precio: ""
    property string descripcion: ""
    property string categoria: ""
    property string estado: ""

    id: element
    visible: true
    width: 1366
    height: 720
    Pane
    {
        id: fondo
        anchors.fill: parent
        transformOrigin: Item.Center
        Layout.fillHeight: true
        Layout.fillWidth: true
        Material.elevation: 0
    }

    RowLayout
    {
        id: rowLayout
        width: 200
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        spacing: 0

        Pane
        {
            id: menuOpciones
            width: 200
            Layout.fillWidth: true
            Layout.fillHeight: true
            Material.accent: "#008d96"
            Material.foreground: "#008d96"
            Material.background: "#ffffff"

            Material.elevation: 4

            ColumnLayout
            {
                anchors.leftMargin: 0
                anchors.bottomMargin: 70
                anchors.rightMargin: 0
                anchors.topMargin: 90
                spacing: 0
                anchors.fill: parent

                RowLayout
                {
                    Image
                    {
                        id: iconAddDish
                        width: 50
                        height: 50
                        Layout.maximumHeight: 50
                        Layout.maximumWidth: 50
                        fillMode: Image.PreserveAspectFit
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        antialiasing: true
                        source: "img/addMenu.png"
                    }
                    Button
                    {
                        text: "Añadir"
                        font.weight: Font.DemiBold
                        font.pointSize: 14
                        font.family: "Verdana"
                        Layout.fillWidth: true
                        font.capitalization: Font.MixedCase
                        focusPolicy: Qt.StrongFocus
                        display: AbstractButton.TextBesideIcon
                        Material.background: "#FFFFFF"
                        Material.elevation: 0

                        onClicked:
                        {
                            form_Platillo.openDialog();
                        }
                        Menu_RegistrarPlatillo
                        {
                            id: form_Platillo
                            onInputAccepted:{
                                var pathFoto;
                                pathFoto = d_url.toString();
                                pathFoto = pathFoto.replace(/^(file:\/{3})/,"");

                                modeloPlatillos.addPlatillo(d_nombre, pathFoto , d_precio, d_descripcion, d_categoria, d_estado)
                                clearDialog()
                            }
                        }

                    }
                }
                RowLayout
                {
                    Image
                    {
                        id: iconUpdateDish
                        width: 50
                        height: 50
                        Layout.maximumHeight: 50
                        Layout.maximumWidth: 50
                        fillMode: Image.PreserveAspectFit
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        antialiasing: true
                        source: "img/editMenu.png"
                    }
                    Button
                    {
                        text: "Editar"
                        font.family: "Verdana"
                        font.weight: Font.DemiBold
                        font.pointSize: 14
                        Layout.fillWidth: true
                        font.capitalization: Font.MixedCase
                        focusPolicy: Qt.StrongFocus
                        display: AbstractButton.TextBesideIcon
                        Material.background: "#FFFFFF"
                        Material.elevation: 0

                        onClicked:
                        {
                            //edit_Platillo.setOldValues(tablaPlatillos.model.name)
                            edit_Platillo.openDialog()
                            //edit_Platillo.setDatosActuales(mode.name,model.price)
                        }
                        Menu_EditarPlatillo
                        {
                            id: edit_Platillo
                            nombreActual: nombre
                            precioActual: precio
                            descripcionActual: descripcion
                            categoriaActual: categoria
                            estadoActual: estado
                            fotoActual: foto

                            onInputAccepted:{
                                modeloPlatillos.modifyPlatillo(selectedEmploye, d_nombre, foto ,d_precio, d_descripcion, d_categoria, d_estado)
                                clearDialog()
                                /*nombre = ""
                                precio = ""
                                foto = ""
                                descripcion = ""
                                categoria = ""
                                estado = ""*/
                            }
                        }

                    }
                }
            }
        }
    }

    RowLayout
    {
        id: layoutTablas
        anchors.left: parent.left
        anchors.leftMargin: 220
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.rightMargin: 20
        anchors.bottomMargin: 20
        anchors.topMargin: 70
        spacing: 20

        Pane
        {
            id: listaPlatillosPane
            Material.background: "#f5f5f5"
            Material.elevation: 4
            Layout.fillHeight: true
            Layout.preferredHeight: 600
            Layout.minimumHeight: 600
            Layout.maximumHeight: 600
            Layout.minimumWidth: 550
            Layout.preferredWidth: 550
            Layout.maximumWidth: 550

            Pane
            {
                id: listHeader
                Material.background: "#ffffff"
                Material.elevation: 1
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right

                RowLayout
                {
                    spacing: 10
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0

                    Label
                    {
                        width: 10
                        color: "#006677"
                        text: ""
                        font.pointSize: 10
                        font.bold: true
                    }
                    Label
                    {
                        color: "#006677"
                        text: "Nombre"
                        font.weight: Font.Bold
                        font.family: "Verdana"
                        font.pointSize: 12
                        font.bold: true
                        //Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }
                    Label{
                        color: "#006677"
                        text: "Precio"
                        font.weight: Font.Bold
                        font.family: "Verdana"
                        font.pointSize: 12
                        font.bold: true
                        //Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    }
                }
            }
            ListView {
                id: tablaPlatillos
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                boundsBehavior: Flickable.VerticalFlick
                anchors.topMargin: 50
                anchors.fill: parent
                spacing: 0
                clip: true
                focus: true
                model: modeloPlatillos
                highlight: Button {
                    id: btn
                    Material.background: "#cfd8dc"
                    Material.elevation: 2
                    Layout.fillWidth: true
                    hoverEnabled: true
                }
                highlightFollowsCurrentItem: true
                removeDisplaced: Transition {
                    NumberAnimation { properties: "x,y"; duration: 300 }
                }
                delegate: Component {
                    Item{
                        width: parent.width
                        height: 50
                        MouseArea{
                            anchors.fill: parent
                            GridLayout{
                                anchors.fill: parent
                                columns: 2
                                /*CheckBox{
                                    Layout.alignment: Qt.AlignLeft
                                    checked: model.eleccionEmpleado
                                    onClicked: {
                                        model.eleccionEmpleado = checked
                                        tablaEmpleados.currentIndex = index
                                        selectedEmploye = index
                                    }
                                }*/
                                Text{
                                    Layout.minimumWidth: 250
                                    Layout.maximumWidth: 250
                                    leftPadding: 0
                                    text: model.name
                                    font.family: "Verdana"
                                    font.pointSize: 10
                                }
                                Text{
                                    Layout.minimumWidth: 200
                                    Layout.maximumWidth: 200
                                    leftPadding: 0
                                    text: model.price
                                    font.family: "Verdana"
                                    font.pointSize: 10
                                }
                            }
                            onClicked: {
                                tablaPlatillos.currentIndex = index
                                selectedEmploye = index

                                nombre = model.name
                                foto = model.image
                                precio = model.price
                                descripcion = model.description
                                categoria = model.category
                                estado = model.status
                            }
                        }
                    }
                }
            }
        }
        Pane{
            id:datosEmpleadoPane
            Material.background: "#f5f5f5"
            Layout.fillHeight: true
            Layout.maximumHeight: 600
            Layout.maximumWidth: 550
            Layout.minimumHeight: 600
            Layout.minimumWidth: 550
            Layout.preferredHeight: 600
            Layout.preferredWidth: 550
            Material.elevation: 4

            Pane{
                id: infoEmpleadoHeader
                font.weight: Font.DemiBold
                font.pointSize: 12
                font.family: "Verdana"
                Material.elevation: 1
                Material.background: "#ffffff"
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                Label{
                    width: 10
                    color: "#006677"
                    text: "Infomración del platillo: "
                    font.weight: Font.Bold
                    font.family: "Verdana"
                    font.pointSize: 12
                    font.bold: true
                }
            }

            Pane
            {
                id: infoPlatillo
                font.weight: Font.DemiBold
                font.pointSize: 12
                font.family: "Verdana"
                Material.elevation: 5
                Material.background: "#ffffff"
                anchors.topMargin: 60
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.top: parent.top

                Image
                {
                    width: 150
                    height: 150
                    source: foto
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    Material.elevation: 1
                }
                Text{
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.topMargin: 5
                }
                Text{
                    anchors.top: parent.top
                    anchors.topMargin: 65
                    x: 200

                    font.weight: Font.Medium
                    font.family: "Verdana"
                    font.pointSize: 12
                    font.bold: false
                    Material.elevation: 1

                    text: "Nombre: "+nombre
                }
                Text{
                    anchors.top: parent.top
                    anchors.topMargin: 85
                    x: 200

                    font.weight: Font.Medium
                    font.family: "Verdana"
                    font.pointSize: 12
                    font.bold: false
                    Material.elevation: 1

                    text: "Precio: "+precio
                }
                Text{
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.topMargin: 180

                    font.weight: Font.Medium
                    font.family: "Verdana"
                    font.pointSize: 12
                    font.bold: false
                    Material.elevation: 1

                    text: "Descripcion: "+descripcion
                }
                Text{
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.topMargin: 240

                    font.weight: Font.Medium
                    font.family: "Verdana"
                    font.pointSize: 12
                    font.bold: false
                    Material.elevation: 1

                    text: "Categoria: "+categoria
                }
                Text{
                    anchors.top: parent.top
                    anchors.topMargin: 300
                    anchors.left: parent.left
                    font.weight: Font.Medium
                    font.family: "Verdana"
                    font.pointSize: 12
                    font.bold: false
                    Material.elevation: 1

                    text: "Estado: "+estado
                }
            }
        }
    }
}
