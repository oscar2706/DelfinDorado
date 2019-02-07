import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQml.Models 2.3

import Empleado 1.0

Item {
    property int selectedEmploye: -1
    property string nombre: ""
    property string cargo: ""
    id: element
    visible: true
    //title: "Basic layouts"
    width: 1366
    height: 720

    EmpleadoModelo{
        id: modelo
        list: empleadoLista
    }

    Pane{
        id: fondo
        anchors.fill: parent
        transformOrigin: Item.Center
        Layout.fillHeight: true
        Layout.fillWidth: true
        Material.elevation: 0
    }

    RowLayout{
        id: rowLayout
        width: 200
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        spacing: 0
        Pane{
            id: menuOpciones
            width: 200
            Layout.fillWidth: true
            Layout.fillHeight: true
            Material.accent: "#008d96"
            Material.foreground: "#008d96"
            Material.background: "#ffffff"

            Material.elevation: 4

            ColumnLayout{
                anchors.leftMargin: 0
                anchors.bottomMargin: 70
                anchors.rightMargin: 0
                anchors.topMargin: 90
                spacing: 0
                anchors.fill: parent
                RowLayout{
                    Image {
                        id: iconAddEmploye
                        width: 50
                        height: 50
                        Layout.maximumHeight: 50
                        Layout.maximumWidth: 50
                        fillMode: Image.PreserveAspectFit
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        antialiasing: true
                        source: "img/addEmploye.png"
                    }
                    Button {
                        text: "Registrar"
                        font.weight: Font.DemiBold
                        font.pointSize: 14
                        font.family: "Verdana"
                        Layout.fillWidth: true
                        font.capitalization: Font.MixedCase
                        focusPolicy: Qt.StrongFocus
                        display: AbstractButton.TextBesideIcon
                        Material.background: "#FFFFFF"
                        Material.elevation: 0

                        Formulario_Empleado{
                            id: form_Empleado
                        }
                        onClicked:
                        {
                            form_Empleado.idUsuario = "0"
                            form_Empleado.show()
                        }
                    }
                }
                RowLayout{
                    Image {
                        id: iconUpdateEmploye
                        //width: 0
                        height: 50
                        Layout.maximumHeight: 50
                        //Layout.maximumWidth: 50
                        fillMode: Image.PreserveAspectFit
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        antialiasing: true
                        source: "img/updateEmploye.png"
                    }
                    Button {
                        text: "Actualizar"
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
                            var idUsuario = ""
                            idUsuario = empleadoLista.getDato(idUsuario)

                            if(idUsuario!="")
                            {
                                form_Empleado.idUsuario = idUsuario.toString()
                                form_Empleado.show()
                            }
                            else
                            {
                                falloSeleccion.y = 390
                                falloSeleccion.open()
                            }
                        }
                    }
                }
                RowLayout{
                    Image {
                        id: iconDeleteEmploye
                        width: 50
                        height: 50
                        Layout.maximumHeight: 50
                        Layout.maximumWidth: 50
                        fillMode: Image.PreserveAspectFit
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        antialiasing: true
                        source: "img/deleteEmploye.png"
                    }
                    Button {
                        text: "Eliminar"
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
                            var idUsuario = ""
                            idUsuario = empleadoLista.getDato(idUsuario)

                            if(idUsuario!="")
                                confirmarEliminacion.open()
                            else
                            {
                                falloSeleccion.y = 580
                                falloSeleccion.open()
                            }
                        }
                    }
                }
            }
        }
    }
    Popup
    {
        id: falloSeleccion
        width: 200
        height: 75
        x: 125
        y: 580
        Material.background: "#006677"

        Label
        {
            text: "Empleado no seleccionado"
            color: "white"
        }
    }

    Popup
    {
        id: confirmarEliminacion
        width: 300
        height: 100
        x: 125
        y: 580
        Material.background: "#006677"

        ColumnLayout
        {
            Label
            {
                text: "¿Dar de baja empleado permanentemente?"
                color: "white"
            }

            RowLayout
            {
                Button
                {
                    text: "Aceptar"
                    Layout.fillWidth: true
                    onClicked:
                    {
                        var usuarioEliminado
                        var idUsuario = ""
                        usuarioEliminado = empleadoLista.getDato(idUsuario)
                        empleadoLista.bajaUsuario(usuarioEliminado)
                        empleadoLista.removeCheckedItem()
                        confirmarEliminacion.close()
                    }
                }
                Button
                {
                    text: "Cancelar"
                    Layout.fillWidth: true
                    onClicked: confirmarEliminacion.close()
                }
            }
        }
    }

    RowLayout{
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
            id: listaEmpleadosPane
            Material.background: "#f5f5f5"
            Material.elevation: 4
            Layout.fillHeight: true
            Layout.preferredHeight: 600
            Layout.minimumHeight: 600
            Layout.maximumHeight: 600
            Layout.minimumWidth: 550
            Layout.preferredWidth: 550
            Layout.maximumWidth: 550
            Pane{
                id: listHeader
                Material.background: "#ffffff"
                Material.elevation: 1
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                RowLayout {
                    spacing: 10
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    Label{
                        width: 10
                        color: "#006677"
                        text: ""
                        font.pointSize: 10
                        font.bold: true
                    }
                    Label{
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
                        text: "Puesto"
                        font.weight: Font.Bold
                        font.family: "Verdana"
                        font.pointSize: 12
                        font.bold: true
                        //Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    }
                }
            }
            ListView {
                id: tablaEmpleados
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                boundsBehavior: Flickable.VerticalFlick
                anchors.topMargin: 50
                anchors.fill: parent
                spacing: 0
                clip: true
                focus: true
                model: modelo
                delegate: Component {
                    Item{
                        width: parent.width
                        height: 50
                        MouseArea{
                            anchors.fill: parent
                            GridLayout{
                                anchors.fill: parent
                                columns: 3
                                CheckBox{
                                    Layout.alignment: Qt.AlignLeft
                                    checked: model.eleccionEmpleado
                                    onClicked: {
                                        model.eleccionEmpleado = checked
                                        tablaEmpleados.currentIndex = index
                                        selectedEmploye = index
                                    }
                                }
                                Text{
                                    Layout.minimumWidth: 250
                                    Layout.maximumWidth: 250
                                    leftPadding: 0
                                    text: model.nombreEmpleado
                                    font.family: "Verdana"
                                    font.pointSize: 10
                                }
                                Text{
                                    Layout.minimumWidth: 200
                                    Layout.maximumWidth: 200
                                    leftPadding: 0
                                    text: model.puestoEmpleado
                                    font.family: "Verdana"
                                    font.pointSize: 10
                                }
                            }
                            onClicked: {
                                tablaEmpleados.currentIndex = index
                                selectedEmploye = index
                                nombre = model.nombreEmpleado
                                cargo = model.puestoEmpleado
                            }
                        }
                    }
                }
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
                    text: "Datos del empleado: "
                    font.weight: Font.Bold
                    font.family: "Verdana"
                    font.pointSize: 12
                    font.bold: true
                }
            }

            Text{
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: 60

                font.weight: Font.Medium
                font.family: "Verdana"
                font.pointSize: 12
                font.bold: false

                text: nombre
            }
            Text{
                anchors.top: parent.top
                anchors.topMargin: 100
                anchors.left: parent.left
                anchors.right: parent.right

                font.weight: Font.Medium
                font.family: "Verdana"
                font.pointSize: 12
                font.bold: false

                text: cargo
            }
        }
    }
}











/*##^## Designer {
    D{i:24;anchors_width:1150}
}
 ##^##*/
