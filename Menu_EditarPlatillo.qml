import QtQuick 2.0
import QtQuick 2.9
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.4 as Fecha

Item{
    id: editarPlatillo
    function openDialog(){
        dialog_RegistraPlatillo.open();
    }

    function clearDialog(){
        inputNombre.clear()
        inputPrecio.clear()
        inputDescripcion.clear()
    }

    function setOldValues(nombreActual){
        inputNombre.text = "nombreActual"
        nombreActual = valueOf(nombreActual)
        console.log("Nombre pasado a la funcion = "+valueOf(nombreActual))
    }

    property string nombreActual: ({})
    property string fotoActual: ({})
    property string precioActual: ({})
    property string descripcionActual: ({})
    property string categoriaActual: ({})
    property string estadoActual: ({})

    property alias d_nombre: inputNombre.text
    property alias d_url: btnImagen.url
    property alias d_fotoPlatillo: selectorImagen.fileUrl
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
    onAboutToShow: {
        if(categoriaActual == "Botanas")
            inputCategoria.currentIndex = 0
        if(categoriaActual == "Entradas")
            inputCategoria.currentIndex = 1
        if(categoriaActual == "Ensaladas y ceviches")
            inputCategoria.currentIndex = 2
        if(categoriaActual == "Sopas")
            inputCategoria.currentIndex = 3
        if(categoriaActual == "Filetes")
            inputCategoria.currentIndex = 4
        if(categoriaActual == "Alambres")
            inputCategoria.currentIndex = 5
        if(categoriaActual == "Carnes")
            inputCategoria.currentIndex = 6
        if(categoriaActual == "Especialidades")
            inputCategoria.currentIndex = 7
        if(categoriaActual == "Postres")
            inputCategoria.currentIndex = 8
        if(categoriaActual == "Bebidas")
            inputCategoria.currentIndex = 9
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
                        dialogoAbierto = 1
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
                    source: foto
                }

                Button
                {
                    id: btnImagen
                    text: "Seleccionar imagen"
                    property string url:""
                    Layout.alignment: Qt.AlignCenter
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
                Layout.fillWidth: true

                Text {
                    id: text1
                    width: 263
                    height: 40
                    color: "#0aa0c1"
                    text: qsTr("Edicion platillo")
                    font.pixelSize: 22
                }

                TextField
                {
                    id: inputNombre
                    placeholderText: "Nombre del platillo"
                    Layout.fillWidth: parent
                    text: nombreActual
                }

                TextField
                {
                    id: inputDescripcion
                    placeholderText: "Descripcion"
                    Layout.fillWidth: parent
                    text: descripcionActual
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
                        text: precioActual
                    }
                }

                RowLayout
                {
                    id: filaBotones
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    spacing: 20

                    Button
                    {
                        id:btnRegistrar
                        text: "Modificar"
                        Material.foreground: "#FFFFFF"
                        Material.background: "#008d96"
                        onClicked:
                        {
                            var path2 = selectorImagen.fileUrl.toString();
                            path2 = path2.replace(/^(file:\/{3})/,"");
                            path2 = path2.toString;
                            editarPlatillo.inputAccepted()
                            dialog_RegistraPlatillo.close()
                        }
                    }
                    Button
                    {
                        id: btnCancelar
                        text: "Cancelar"
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
