import QtQuick 2.0
import QtQuick 2.9
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.4 as Fecha

Item{
    id: agregarPlatillo
    function openDialog(){
        dialog_RegistraPlatillo.open();
    }

    function clearDialog(){
        inputNombre.clear()
        inputPrecio.clear()
        inputDescripcion.clear()
    }

    property alias d_nombre: inputNombre.text
    property alias d_url:btnImagen.url
    property alias fotoPlatillo: selectorImagen.fileUrl
    property alias d_precio: inputPrecio.text
    property alias d_descripcion: inputDescripcion.text
    property alias d_categoria: inputCategoria.currentText
    property alias d_estado: inputEstado.currentText
    signal inputAccepted

Dialog {
    id: dialog_RegistraPlatillo
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    width: 700
    height: 450
    parent: Overlay.overlay
    focus: true
    modal: true
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

                //cargado de imagenes
                FileDialog
                {
                    id: selectorImagen
                    title: "Abrir archivo"
                    folder: shortcuts.home
                    selectExisting: true
                    nameFilters: ["*.jpg *.png"]
                    property int dialogoAbierto: 0
                    onAccepted:
                    {
                        imagenPlatillo.source = fileUrl
                        btnImagen.url = fileUrl
                    }
                    onRejected:
                    {
                        fileUrl = ""
                    }
                }
                Image
                {
                    id: imagenPlatillo
                    width: 200
                    height: 200
                    Layout.maximumHeight: 200
                    Layout.maximumWidth: 200
                    cache: false
                    x: 25
                    //anchors.left: parent.left
                    //source: idUsuario == "0" ? "" : empleadoLista.visualizarImg(idUsuario)
                }

                Button
                {
                    id: btnImagen
                    text: "Seleccionar imagen"
                    Layout.alignment: Qt.AlignCenter
                    property string url: ""
                    onClicked: selectorImagen.open()
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
                    id: inputNombre
                    placeholderText: "Nombre del platillo"
                    Layout.fillWidth: parent
                }

                TextField
                {
                    id: inputDescripcion
                    placeholderText: "Descripcion"
                    Layout.fillWidth: parent
                }

                RowLayout
                {
                    spacing: 10
                    ComboBox
                    {
                        id: inputCategoria
                        model: ["Botanas", "Entradas","Ensaladas y ceviches","Sopas","Filetes","Alambres",
                            "Carnes","Especialidades","Postres","Bebidas"]
                        Layout.fillWidth: true
                    }
                }

                RowLayout
                {
                    spacing: 10
                    ComboBox
                    {
                        id: inputEstado
                        model: ["Disponible", "Fuera de temporada"]
                        Layout.fillWidth: true
                    }
                }

                RowLayout
                {
                    spacing: 10

                    TextField
                    {
                        id: inputPrecio
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
                            agregarPlatillo.inputAccepted()
                            //dialog_RegistraPlatillo.close()
                        }
                    }
                    Button
                    {
                        id: btnCancelar
                        text: "Cancelar"
                        //Material.accent: "#008d96"
                        Material.foreground: "#FFFFFF"
                        Material.background: "#008d96"
                        onClicked: {
                            dialog_RegistraPlatillo.rejected()
                            dialog_RegistraPlatillo.close()
                        }
                    }
                }

            }
        }

        Image {
            id: inputFoto
            x: 11
            y: 144
            width: 190
            height: 190
        }
    }
}
}
