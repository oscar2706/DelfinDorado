import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

import Empleado 1.0

Item {
    id: element
    visible: true
    //title: "Basic layouts"
    width: 1366
    height: 720

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
        width: 170
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        spacing: 0
        Pane{
            id: menuOpciones
            width: 180
            Layout.fillWidth: true
            Layout.fillHeight: true
            Material.accent: "#008d96"
            Material.foreground: "#008d96"
            Material.background: "#FFFFFF"

            Material.elevation: 4



            ColumnLayout{
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
                        onClicked:  form_Empleado.show()
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
                        font.pointSize: 14
                        Layout.fillWidth: true
                        font.capitalization: Font.MixedCase
                        focusPolicy: Qt.StrongFocus
                        display: AbstractButton.TextBesideIcon
                        Material.background: "#FFFFFF"
                        Material.elevation: 0
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
                                falloSeleccion.open()
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
        anchors.rightMargin: 20
        anchors.leftMargin: 200
        anchors.bottomMargin: 20
        anchors.topMargin: 70
        anchors.fill: parent
        spacing: 20

        Pane
        {
            id: tablePane
            Material.elevation: 4
            Layout.fillHeight: true
            Layout.preferredHeight: 600
            Layout.minimumHeight: 600
            Layout.maximumHeight: 600
            Layout.minimumWidth: 500
            Layout.preferredWidth: 500
            Layout.maximumWidth: 500
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
                    font.bold: false
                    //Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                }
            }
            ListView {
                id: tablaEmpleados
                boundsBehavior: Flickable.StopAtBounds
                anchors.topMargin: 30
                anchors.fill: parent
                spacing: 0
                clip: true
                focus: true
                model: EmpleadoModelo
                {
                    list: empleadoLista
                }
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
                                    }
                                }
                                Text{
                                    Layout.minimumWidth: 200
                                    Layout.maximumWidth: 200
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
                            }
                        }
                    }
                }
                highlight: RoundButton {
                    Material.background: "#4db6c8"
                    Material.elevation: 4
                    Layout.fillWidth: true
                    radius: 5
                }
                highlightFollowsCurrentItem: true
                removeDisplaced: Transition {
                    NumberAnimation { properties: "x,y"; duration: 300 }
                }
            }
        }
        Pane{
            id:paneDatosCompletos
            Material.elevation: 4
            Layout.fillHeight: true
            Layout.maximumHeight: 600
            Layout.maximumWidth: 500
            Layout.minimumHeight: 600
            Layout.minimumWidth: 500
            Layout.preferredHeight: 600
            Layout.preferredWidth: 500

        }
    }
}



















/*##^## Designer {
    D{i:2;anchors_width:170}
}
 ##^##*/
