import QtQuick 2.0
import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.4 as Fecha

Window {
    id: formulario
    width: 800
    height: 600
    modality: Qt.WindowModal
    x: 333
    y: 110

    Pane
    {
        id: panelFormulario
        width: 720
        height: 500

        RowLayout
        {
            id: filaPanel
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
                        text: "Fecha de Nacimiento"

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
                }

                TextField
                {
                    id: txtTelefono
                    placeholderText: "Tel/Cel"
                    Layout.fillWidth: parent
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
                    placeholderText: "Contraseña"
                    Layout.fillWidth: parent
                }

                TextField
                {
                    id: txtConfirmacionContrasegna
                    placeholderText: "Confirmación de la Contraseña"
                    Layout.fillWidth: parent
                }

                RowLayout
                {
                    id: filaBotones
                    spacing: 10

                    Button
                    {
                        id:btnRegistrar
                        text: "Guardar"
                    }

                    Button
                    {
                        id: btnCancelar
                        text: "Cancelar"
                        onClicked: formulario.close()
                    }
                }
            }
        }
    }
}
