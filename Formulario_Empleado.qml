import QtQuick 2.0
import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.4 as Fecha
//cargado de imagenes
import QtQuick.Dialogs 1.2

import Empleado 1.0

Window {
    id: formulario
    width: 800
    height: 600
    modality: Qt.WindowModal
    property string idUsuario: "0"

    Popup
    {
        id: fotoFaltante
        width: 150
        height: 35
        Material.background: "#DBAB0D"
        x: 40
        y: 200

        Label
        {
            id: lblFotoFaltante
            text: "Foto no seleccionada"
            color: "black"
        }
    }
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
            id: lblMensajeExitoso
            text: "Empleado Registrado Exitosamente"
            color: "white"
        }
    }
    Popup
    {
        width: 150
        height: 35
        id: nombreIncompleto
        Material.background: "#DBAB0D"
        x: 425
        y: 90

        Label
        {
            id: lblNombreIncompleto
            text: "Nombre incompleto"
            color: "black"
        }
    }
    Popup
    {
        width: 170
        height: 35
        id: fechaIncompleta
        Material.background: "#DBAB0D"
        x: 425
        y: 200

        Label
        {
            id: lblFechaIncompleta
            text: "Fecha no seleccionada"
            color: "black"
        }
    }
    Popup
    {
        width: 150
        height: 35
        id: telefonoIncompleto
        Material.background: "#DBAB0D"
        x: 325
        y: 250

        Label
        {
            id: lblTelefonoIncompleto
            text: "Telefono incompleto"
            color: "black"
        }
    }
    Popup
    {
        width: 150
        height: 35
        id: telefonoInvalido
        Material.background: "#DBAB0D"
        x: 325
        y: 250

        Label
        {
            id: lblTelefonoInvalido
            text: "Telefono invalido"
            color: "black"
        }
    }
    Popup
    {
        width: 140
        height: 35
        id: salarioIncompleto
        Material.background: "#DBAB0D"
        x: 590
        y: 250

        Label
        {
            id: lblSalarioIncompleto
            text: "Salario incompleto"
            color: "black"
        }
    }
    Popup
    {
        width: 125
        height: 35
        id: _RFCIncompleto
        Material.background: "#DBAB0D"
        x: 340
        y: 300

        Label
        {
            id: lblRFCIncompleto
            text: "RFC incompleto"
            color: "black"
        }
    }
    Popup
    {
        width: 220
        height: 35
        id: seguroIncompleto
        Material.background: "#DBAB0D"
        x: 550
        y: 300

        Label
        {
            id: lblSeguroIncompleto
            text: "Numero de seguro incompleto"
            color: "black"
        }
    }
    Popup
    {
        width: 145
        height: 35
        id: usuarioIncompleto
        Material.background: "#DBAB0D"
        x: 425
        y: 405

        Label
        {
            id: lblUsuarioIncompleto
            text: "Usuario incompleto"
            color: "black"
        }
    }
    Popup
    {
        width: 250
        height: 35
        id: contrasegnaIncorrecta
        Material.background: "#DBAB0D"
        x: 365
        y: 455

        Label
        {
            id: lblContrasegnaIncorrecta
            text: "Campos de contraseña no coinciden"
            color: "black"
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

            Column
            {
                id: columnaImagen
                spacing: 20
                Layout.alignment: Qt.AlignCenter

                //cargado de imagenes
                FileDialog
                {
                    id: openDialog
                    title: "Abrir archivo"
                    folder: shortcuts.home
                    selectExisting: true
                    nameFilters: ["*.jpg *.png"]
                    onAccepted:
                    {
                        imagenTrabajador.source = fileUrl
                        btnImagen.url = fileUrl
                    }
                    onRejected:
                    {
                        fileUrl = ""
                    }
                }

                Image
                {
                    id: imagenTrabajador
                    width: 200
                    height: 200
                    x: 25
                    anchors.left: parent.left
                    source: idUsuario == "0" ? "" : empleadoLista.visualizarImg(parseInt(idUsuario))
                }

                Button
                {
                    id: btnImagen
                    text: "Seleccionar imagen"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: 0
                    property string url: ""
                    onClicked:
                    {
                        openDialog.open();
                    }
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
                    text: idUsuario=="0" ? "" : empleadoLista.getNombre(idUsuario)
                }

                TextField
                {
                    id: txtApellidoPaterno
                    placeholderText: "Apellido Paterno"
                    Layout.fillWidth: parent
                    text: idUsuario=="0" ? "" : empleadoLista.getApellidoPaterno(idUsuario)
                }

                TextField
                {
                    id: txtApellidoMaterno
                    placeholderText: "Apellido Materno"
                    Layout.fillWidth: parent
                    text: idUsuario=="0" ? "" : empleadoLista.getApellidoMaterno(idUsuario)
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
                        text: idUsuario=="0" ? "Fecha de Nacimiento" : empleadoLista.getFechaNacimiento(idUsuario)
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
                                visibleYear: 1995
                                visibleMonth: 2
                                minimumDate: "1960-01-01"
                                maximumDate: "2000-12-31"
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
                        checked: if(idUsuario=="0")
                                 {
                                     return true;
                                 }
                                 else
                                 {
                                    if(empleadoLista.getSexo(idUsuario) === "1")
                                    {
                                        return true;
                                    }
                                    else
                                    {
                                        return false;
                                    }
                                 }

                        text: "Masculino"
                    }

                    RadioButton
                    {
                        id: radiobtnFemenino
                        checked: if(idUsuario=="0")
                                 {
                                     return false;
                                 }
                                 else
                                 {
                                    if(empleadoLista.getSexo(idUsuario) === "2")
                                    {
                                        return true;
                                    }
                                    else
                                    {
                                        return false;
                                    }
                                 }
                        text: "Femenino"
                    }

                    ComboBox
                    {
                        id: seleccionCategoria
                        model: ["Gerente", "Cocinero", "Mesero", "Anfitrión", "Ayudante de Mesero"]
                        Layout.fillWidth: true
                        currentIndex: idUsuario=="0" ? 0 : (empleadoLista.getPuesto(idUsuario)-1)
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
                        text: idUsuario=="0" ? "" : empleadoLista.getTelefono(idUsuario)
                    }

                    TextField
                    {
                        id: txtSalario
                        placeholderText: "Salario"
                        Layout.fillWidth: parent
                        text: idUsuario=="0" ? "" : empleadoLista.getSalario(idUsuario)
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
                        text: idUsuario=="0" ? "" : empleadoLista.getRFC(idUsuario)
                    }

                    TextField
                    {
                        id: txtSeguroSocial
                        placeholderText: "Numero Seguro Social"
                        Layout.fillWidth: parent
                        text: idUsuario=="0" ? "" : empleadoLista.getSeguroSocial(idUsuario)
                    }
                }

                TextField
                {
                    id: txtUsuario
                    placeholderText: "Usuario"
                    Layout.fillWidth: parent
                    text: idUsuario=="0" ? "" : empleadoLista.getUsuario(idUsuario)
                }

                TextField
                {
                    id: txtContrasegna
                    echoMode: TextInput.Password
                    placeholderText: "Contraseña"
                    Layout.fillWidth: parent
                    text: idUsuario=="0" ? "" : empleadoLista.getContrasegna(idUsuario)
                }

                TextField
                {
                    id: txtConfirmacionContrasegna
                    echoMode: TextInput.Password
                    placeholderText: "Confirmación de la Contraseña"
                    Layout.fillWidth: parent
                    text: idUsuario=="0" ? "" : empleadoLista.getContrasegna(idUsuario)
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
                            var camposCorrectos = 0;
                            var contrasegnaValida = false;

                            if((txtNombre.text == "")||(txtApellidoPaterno.text == "")||(txtApellidoMaterno.text == ""))
                            {
                                nombreIncompleto.open()
                            }
                            else
                            {
                                camposCorrectos++;
                            }
                            if(fechaNacimiento.text == "Fecha de Nacimiento")
                            {
                                fechaIncompleta.open()
                            }
                            else
                            {
                                camposCorrectos++;
                            }
                            if(txtTelefono.text == "")
                            {
                                telefonoIncompleto.open()
                            }
                            else
                            {
                                camposCorrectos++;
                            }
                            if(txtSalario.text == "")
                            {
                                salarioIncompleto.open()
                            }
                            else
                            {
                                camposCorrectos++;
                            }
                            if(txtRFC.text == "")
                            {
                                _RFCIncompleto.open()
                            }
                            else
                            {
                                camposCorrectos++;
                            }
                            if(txtSeguroSocial.text == "")
                            {
                                seguroIncompleto.open()
                            }
                            else
                            {
                                camposCorrectos++;
                            }
                            if((txtUsuario.text == "")||(txtContrasegna.text == "")||(txtConfirmacionContrasegna.text == ""))
                            {
                                usuarioIncompleto.open()
                            }
                            else
                            {
                                camposCorrectos++;
                            }
                            if(btnImagen.url == "")
                            {
                                fotoFaltante.open()
                            }
                            else
                            {
                                camposCorrectos++;
                            }

                            if(txtContrasegna.text == txtConfirmacionContrasegna.text)
                            {
                                contrasegnaValida = true;
                            }
                            else
                            {
                                contrasegnaIncorrecta.open()
                            }


                            if((camposCorrectos==8)&&(contrasegnaValida))
                            {
                                var sexo
                                if(radiobtnFemenino.checked)
                                {
                                    sexo = "2"
                                }
                                else
                                {
                                    sexo = "1"
                                }

                                var categoria = (seleccionCategoria.currentIndex+1)

                                var path = openDialog.fileUrl.toString();
                                path = path.replace(/^(file:\/{3})/,"");


                                if(idUsuario=="0")
                                {
                                    empleadoLista.altaUsuario(txtNombre.text, txtApellidoPaterno.text, txtApellidoMaterno.text,
                                                              sexo, txtRFC.text, txtSeguroSocial.text, fechaNacimiento.text,
                                                              txtSalario.text, txtTelefono.text, categoria, txtUsuario.text,
                                                              txtContrasegna.text, path.toString())

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
                                    imagenTrabajador.source = ""
                                    btnImagen.url = ""

                                    empleadoLista.refresh()

                                    lblMensajeExitoso.text = "Empleado Registrado Exitosamente"
                                    mensajeExitoso.open()
                                }
                                else
                                {
                                    empleadoLista.modificaUsuario(txtNombre.text, txtApellidoPaterno.text, txtApellidoMaterno.text,
                                                                  sexo, txtRFC.text, txtSeguroSocial.text, fechaNacimiento.text,
                                                                  txtSalario.text, txtTelefono.text, categoria, txtUsuario.text,
                                                                  txtContrasegna.text, idUsuario, path.toString())

                                    empleadoLista.refresh()

                                    lblMensajeExitoso.text = "Cambios Guardados Exitosamente"
                                    mensajeExitoso.open()
                                }
                            }
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
