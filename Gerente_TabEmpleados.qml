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
                    }
                }
            }
        }
    }


    ColumnLayout{
        spacing: 20
        anchors.topMargin: 90
        anchors.leftMargin: 200
        anchors.fill: parent

        ColumnLayout
        {
            Frame
            {
                ListView
                {
                    id: tablaEmpleados
                    implicitWidth: 250
                    implicitHeight: 250
                    clip: true

                    model: EmpleadoModelo
                    {
                        list: empleadoLista
                    }

                    delegate: RowLayout
                    {
                        width: parent.width

                        Label
                        {
                            text: model.idEmpleado
                            Layout.fillWidth: true
                        }
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
            RowLayout
            {
                Button
                {
                    text: "Agregar"
                    Layout.fillWidth: true
                    onClicked: empleadoLista.appendItem()
                }
                Button
                {
                    text: "Remover"
                    Layout.fillWidth: true
                    onClicked: empleadoLista.removeCheckedItem()
                }
            }
        }


        /*
        RowLayout{
            Layout.fillWidth: true
            spacing: 10
            //Layout.alignment: Qt.AlignRight | Qt.AlignTop
            Label{
                text: "Buscar:"
            }
            TextField{
                placeholderText: "Nombre"
            }
        }
        ListView{
            y: 90
            width: 300
            height: 500
            clip: true
            //Layout.fillHeight: true
            //implicitWidth: 400
            model: 100
            delegate: RowLayout{
                Image {
                    Layout.maximumHeight: 30
                    Layout.maximumWidth: 30
                    source: "img/deleteEmploye.png"
                }
                Label{
                    text: qsTr("Id")
                }
                Label{
                    text: qsTr("Nombre")
                }
                Label{
                    text: qsTr("Cargo")
                }
            }
        }
        */
    }
}
