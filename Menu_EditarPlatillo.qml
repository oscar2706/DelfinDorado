import QtQuick 2.0
import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.4 as Fecha

Window {
    id: formulario
    width: 750
    height: 400
    color: "#0aa0c1"
    modality: Qt.WindowModal

    Popup
    {
        width: 250
        height: 60
        id: mensajeExitoso
        Material.background: "#006677"
        x: 275
        y: 300

        Label
        {
            text: "Cambios Guardados Exitosamente"
            color: "white"
        }
    }

    Popup
    {
        id: nombreFaltante
        width: 150
        height: 35
        Material.background: "#DBAB0D"
        x: 420
        y: 85

        Label
        {
            id: lblNombreFaltante
            text: "Nombre incompleto"
            color: "black"
        }
    }
    Popup
    {
        id: descripcionFaltante
        width: 166
        height: 35
        Material.background: "#DBAB0D"
        x: 407
        y: 135

        Label
        {
            id: lblDescripcionFaltante
            text: "Descripcion incompleta"
            color: "black"
        }
    }
    Popup
    {
        id: precioFaltante
        width: 140
        height: 35
        Material.background: "#DBAB0D"
        x: 425
        y: 245

        Label
        {
            id: lblPrecioFaltante
            text: "Precio incompleto"
            color: "black"
        }
    }

    Pane
    {
        id: panelFormulario
        topPadding: 0
        bottomPadding: 0
        padding: 20
        anchors.fill: parent
        Material.accent: "#008d96"
        Material.foreground: "#008d96"
        Material.background: "#FFFFFF"

        Image
        {
            id: btnRegresar
            source: "img/back_Blue.png"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 40
            height: 40

            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    txtNombre.clear()
                    txtDescripcion.clear()
                    seleccionCategoria.currentIndex=0
                    txtSalario.clear()
                    formulario.close()
                }
            }
        }

        RowLayout
        {
            id: filaPanel
            anchors.fill: parent
            spacing: 40

            ColumnLayout
            {
                id: columnaImagen
                smooth: true
                enabled: true
                spacing: 20

                Rectangle
                {
                    id: imagenTrabajador
                    width: 200
                    height: 200
                    //source: "img/mari"
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
                width: 400
                height: 300
                Layout.maximumHeight: 300
                Layout.minimumHeight: 300
                Layout.preferredHeight: 300
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                //Layout.fillHeight: true
                Layout.fillWidth: true

                Text {
                    id: text1
                    width: 263
                    height: 40
                    color: "#0aa0c1"
                    text: qsTr("Edita el platillo")
                    font.pixelSize: 22
                }

                TextField
                {
                    id: txtNombre
                    placeholderText: "Nombre del platillo"
                    Layout.fillWidth: parent
                }

                TextField
                {
                    id: txtDescripcion
                    placeholderText: "Descripcion"
                    Layout.fillWidth: parent
                }

                RowLayout
                {
                    id: filaNacimiento
                    spacing: 10

                    ComboBox
                    {
                        id: seleccionCategoria
                        model: ["Disponible", "Fuera de temporada"]
                        Layout.fillWidth: true
                    }
                }

                RowLayout
                {
                    id: filaExtra
                    spacing: 10

                    TextField
                    {
                        id: txtSalario
                        placeholderText: "Costo del platillo"
                        Layout.fillWidth: parent
                    }
                }

                RowLayout
                {
                    id: filaBotones
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    //Layout.alignment: Qt.AlignRight | Qt.AlignBottom
                    //Layout.fillWidth: false
                    spacing: 20

                    Button
                    {
                        id:btnRegistrar
                        text: "Guardar"
                        Material.foreground: "#FFFFFF"
                        Material.background: "#008d96"
                        onClicked:
                        {
                            var camposCorrectos = 0

                            if(txtNombre.text=="")
                            {
                                nombreFaltante.open()
                            }
                            else
                            {
                                camposCorrectos++;
                            }
                            if(txtDescripcion.text=="")
                            {
                                descripcionFaltante.open()
                            }
                            else
                            {
                                camposCorrectos++;
                            }
                            if(txtSalario.text=="")
                            {
                                precioFaltante.open()
                            }
                            else
                            {
                                camposCorrectos++;
                            }

                            if(camposCorrectos==3)
                            {
                                mensajeExitoso.open()
                                txtNombre.clear()
                                txtDescripcion.clear()
                                txtSalario.clear()
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
