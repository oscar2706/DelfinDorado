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
        anchors.leftMargin: 150
        transformOrigin: Item.Center
        anchors.fill: parent
        Layout.fillHeight: true
        Layout.fillWidth: true
        Material.elevation: 0
        ColumnLayout{
        }
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
                        Layout.fillWidth: true
                        font.capitalization: Font.MixedCase
                        focusPolicy: Qt.StrongFocus
                        display: AbstractButton.TextBesideIcon
                        Material.background: "#FFFFFF"
                        Material.elevation: 0

                        Formulario_Empleado{
                            id: form_Empleado
                            //onClosing: empleadoLista.refresh()
                        }
                        onClicked:  form_Empleado.show()

                        //empleadoLista.refresh()
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

    ColumnLayout{
        spacing: 20
        anchors.topMargin: 90
        anchors.leftMargin: 200
        anchors.fill: parent
        //Layout.alignment: Qt.AlignCenter
        Label{
            id: etiqueta
            width: 60
            height: 40
            font.bold: true
            font.pointSize: 9
            textFormat: Text.PlainText
            horizontalAlignment: Text.AlignHCenter
            Layout.fillHeight: true
            Layout.fillWidth: true

        }

        Frame
        {
            ListView
            {
                id: tablaEmpleados
                spacing: 10
                anchors.fill: parent
                implicitWidth: 600
                implicitHeight: 500
                clip: true
                highlightFollowsCurrentItem : true
                RowLayout {
                    spacing: 70
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    Label{
                        color: "#006677"
                        text: "Nombre"
                        font.pointSize: 10
                        font.bold: true
                    }
                    Label{
                        color: "#006677"
                        text: "Puesto"
                        font.pointSize: 10
                        font.bold: true
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }
                    Label{
                        color: "#006677"
                        text: "Seleccionado"
                        font.pointSize: 10
                        font.bold: true
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    }
                }
                model: EmpleadoModelo
                {
                    list: empleadoLista
                }

                delegate: RowLayout
                {
                    width: parent.width

                    /*Label
                    {
                        text: model.idEmpleado
                        Layout.fillWidth: true
                    }*/
                    Label
                    {
                        text: model.nombreEmpleado
                        Layout.fillWidth: true
                    }
                    Label
                    {
                        text: model.puestoEmpleado
                        Layout.fillWidth: true
                    }
                    CheckBox
                    {
                        Layout.alignment: Qt.AlignRight
                        checked: model.eleccionEmpleado
                        onClicked: model.eleccionEmpleado = checked
                    }
                }
            }
        }
    }
}
