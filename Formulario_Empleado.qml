import QtQuick 2.0
import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.4 as Fecha

import Empleado 1.0

Window {
    id: formulario
    width: 800
    height: 600
    modality: Qt.WindowModal

    Popup
    {
        width: 250
        height: 60
        id: mensajeExitoso
        Material.background: "#006677"
        x: 350
        y: 500

        Label
        {
            text: "Empleado Registrado Exitosamente"
            color: "white"
        }
    }

    Pane
    {
        id: panelFormulario
        anchors.fill: parent
        Material.accent: "#008d96"
        Material.foreground: "#008d96"
        Material.background: "#FFFFFF"
        RowLayout
        {
            id: filaPanel
            anchors.fill: parent
            spacing: 40

            ColumnLayout
            {
                id: columnaImagen
                spacing: 20

                /*Image {
                    id: imagenTrabajador
                    source: "Imagenes/foto"
                    width: 300
                    height: 300
                }*/
                Rectangle
                {
                    id: imagenTrabajador
                    width: 200
                    height: 200
                    color: "black"
                    Layout.alignment: Qt.AlignCenter
                }

                Button
                {
                    id: btnImagen
                    text: "Seleccionar imagen"
                    Layout.alignment: Qt.AlignCenter
                }
            }

            ColumnLayout
            {
                id: columnaDatos
                spacing: 8
                Layout.alignment: Qt.AlignHCenter

                TextField
                {
                    id: txtNombre
                    placeholderText: "Nombre"
                    Layout.fillWidth: parent
                }

                TextField
                {
                    id: txtApellidoPaterno
                    placeholderText: "Apellido Paterno"
                    Layout.fillWidth: parent
                }

                TextField
                {
                    id: txtApellidoMaterno
                    placeholderText: "Apellido Materno"
                    Layout.fillWidth: parent
                }

                RowLayout
                {
                    id: filaNacimiento
                    spacing: 10

                    Button
                    {
                        id: fechaNacimiento;
                        Material.background: "#FFFFFF"
                        Material.foreground: "#000000"
                        Material.elevation: 0
                        text: "Fecha de Nacimiento"
                        antialiasing: true
                        onClicked: ventanaFechaNacimiento.open()

                        Popup
                        {
                            id: ventanaFechaNacimiento
                            width: 320
                            height: 320
                            modal: Qt.WindowModal

                            Fecha.Calendar
                            {
                                id: calendarioFechaNacimiento
                                width: 300
                                height: 300
                                x: 0
                                y: 0
                                onClicked: {
                                    ventanaFechaNacimiento.close()
                                    fechaNacimiento.text = Qt.formatDate(selectedDate, "yyyy-MM-dd")
                                }
                            }
                        }
                    }

                    RadioButton
                    {
                        id: radiobtnMasculino
                        checked: true;
                        text: "Masculino"
                    }

                    RadioButton
                    {
                        id: radiobtnFemenino
                        text: "Femenino"
                    }

                    ComboBox
                    {
                        id: seleccionCategoria
                        model: ["Gerente", "Cocinero", "Mesero", "Anfitrión", "Ayudante de Mesero"]
                        Layout.fillWidth: true
                    }
                }

                RowLayout
                {
                    id: filaExtra
                    spacing: 10

                    TextField
                    {
                        id: txtTelefono
                        placeholderText: "Tel/Cel"
                        Layout.fillWidth: parent
                    }

                    TextField
                    {
                        id: txtSalario
                        placeholderText: "Salario"
                        Layout.fillWidth: parent
                    }
                }

                RowLayout
                {
                    id: filaGobierno
                    spacing: 10

                    TextField
                    {
                        id: txtRFC
                        placeholderText: "RFC"
                        Layout.fillWidth: parent
                    }

                    TextField
                    {
                        id: txtSeguroSocial
                        placeholderText: "Numero Seguro Social"
                        Layout.fillWidth: parent
                    }
                }

                TextField
                {
                    id: txtUsuario
                    placeholderText: "Usuario"
                    Layout.fillWidth: parent
                }

                TextField
                {
                    id: txtContrasegna
                    echoMode: TextInput.Password
                    placeholderText: "Contraseña"
                    Layout.fillWidth: parent
                }

                TextField
                {
                    id: txtConfirmacionContrasegna
                    echoMode: TextInput.Password
                    placeholderText: "Confirmación de la Contraseña"
                    Layout.fillWidth: parent
                }

                RowLayout
                {
                    id: filaBotones
                    Layout.alignment: Qt.AlignRight | Qt.AlignBottom
                    Layout.fillWidth: false
                    spacing: 10

                    Button
                    {
                        id:btnRegistrar
                        text: "Guardar"
                        //Material.accent: "#008d96"
                        Material.foreground: "#FFFFFF"
                        Material.background: "#008d96"
                        onClicked:
                        {
                            var sexo
                            if(radiobtnFemenino.checked)
                            {
                                sexo = "Femenino"
                            }
                            else
                            {
                                sexo = "Masculino"
                            }

                            var categoria = (seleccionCategoria.currentIndex+1)
                            empleadoLista.altaUsuario(txtNombre.text, txtApellidoPaterno.text, txtApellidoMaterno.text,
                                                      sexo, txtRFC.text, txtSeguroSocial.text, fechaNacimiento.text,
                                                      txtSalario.text, txtTelefono.text, categoria, txtUsuario.text, txtContrasegna)
                            txtNombre.clear()
                            txtApellidoPaterno.clear()
                            txtApellidoMaterno.clear()
                            fechaNacimiento.text = "Fecha de Nacimiento"
                            radiobtnMasculino.checked = true
                            seleccionCategoria.currentIndex = 0
                            txtRFC.clear()
                            txtSeguroSocial.clear()
                            txtSalario.clear()
                            txtTelefono.clear()
                            txtUsuario.clear()
                            txtConfirmacionContrasegna.clear()
                            txtContrasegna.clear()

                            //empleadoLista.refresh()

                            mensajeExitoso.open()
                        }
                    }
                    Button
                    {
                        id: btnCancelar
                        text: "Cancelar"
                        onClicked: formulario.close()
                        //Material.accent: "#008d96"
                        Material.foreground: "#FFFFFF"
                        Material.background: "#008d96"
                    }
                }
            }
        }
    }
}
