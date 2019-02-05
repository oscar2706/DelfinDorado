import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.0


ApplicationWindow {
    visible: true
    title: "Basic layouts"
    width: 1000
    height: 500

    ColumnLayout{
        id: columnLayout
        x: 17
        y: 19
        width: 111
        height: 462
        Label{text: "Panel de tareas" ; verticalAlignment: Text.AlignVCenter;horizontalAlignment: Text.AlignHCenter }
        Button { text: "Registrar" }
        Button { text: "Modificar" }
        Button { text: "Eliminar" }
    }
    RowLayout{
        id: rowLayout
        x: 679
        y: 19
        width: 304
        height: 40
        TextField {
            placeholderText: "Buscar empleado"
            Layout.fillWidth: true
        }

    }
    TableView {
        x: 134
        y: 65
        width: 856
        height: 422
        TableViewColumn {
            role: "title"
            title: "ID"
            width: 100
        }
        TableViewColumn {
            role: "author"
            title: "Puesto"
            width: 200
        }
        TableViewColumn {
            role: "author"
            title: "Nombre"
            width: 200
        }

    }
}
