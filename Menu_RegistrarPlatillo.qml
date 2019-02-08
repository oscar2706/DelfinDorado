import QtQuick 2.0
import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.4 as Fecha

Window {
    id: formulario
    width: 700
    height: 400
    color: "#0aa0c1"
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
            text: "Producto Registrado Exitosamente"
            color: "white"
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
                //anchors.top: parent.top
                //anchors.bottom: parent.bottom
                //anchors.topMargin: 40
                //anchors.bottomMargin: 10
                //spacing: 10

                Text {
                    id: text1
                    width: 263
                    height: 40
                    color: "#0aa0c1"
                    text: qsTr("Registrar un nuevo platillo")
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
                        text: "Registrar"
                        //Material.accent: "#008d96"
                        Material.foreground: "#FFFFFF"
                        Material.background: "#008d96"
                        onClicked:
                        {
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

        Image {
            id: image
            x: 11
            y: 144
            width: 195
            height: 190
            //source: "img/mari.jpg"
        }
    }
}
