import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtCharts 2.2
import QtQuick.Controls 1.4 as Fecha
import ControlGraficas 1.0

Item {
    id: tabAdministracion
    property bool activadorLoader: false
    property int selectedIndex: 0

    Popup
    {
        id: ventanaFechaInicial
        width: 320
        height: 320
        modal: Qt.WindowModal
        x: 300
        y: Math.round((parent.height-height)/2)

        Fecha.Calendar
        {
            id: calendarioFecha1
            anchors.fill: parent
            visibleMonth: 2
            visibleYear: 1995
            onClicked: {
                fechaInicial.text = Qt.formatDate(selectedDate, "yyyy-MM-dd")
                controlGraficas.setFechaInicial(fechaInicial.text)
                if(fechaFinal.text != "Fecha Final")
                {
                    activadorLoader = true
                }
                ventanaFechaInicial.close()
            }
        }
    }

    Popup
    {
        id: ventanaFechaFinal
        width: 320
        height: 320
        modal: Qt.WindowModal
        x: 300
        y: Math.round((parent.height-height)/2)

        Fecha.Calendar
        {
            id: calendarioFecha2
            anchors.fill: parent
            visibleMonth: 2
            visibleYear: 1995
            onClicked: {
                fechaFinal.text = Qt.formatDate(selectedDate, "yyyy-MM-dd")
                controlGraficas.setFechaFinal(fechaFinal.text)
                if(fechaInicial.text != "Fecha Inicial")
                {
                    activadorLoader = true
                }
                ventanaFechaFinal.close()
            }
        }
    }

    Pane
    {
        id: panelControlReportes
        Material.elevation: 4
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.topMargin: 60
        width: 300
        Material.background: "#FFFFFF"
        Material.foreground: "#008d96"
        Material.accent: "#008d96"

        ColumnLayout
        {
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: parent.top
            id: layoutControlReportes
            spacing: 20

            Label
            {
                id: lblReporte
                text: "Tipo de reporte"
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.weight: Font.DemiBold
                font.pointSize: 15
                font.family: "Verdana"
                Material.background: "#FFFFFF"
                Material.foreground: "#000000"
            }
            ComboBox
            {
                id: comboReporte
                Layout.fillWidth: true
                model: ["Platillos mas vendidos",
                        "Mejor platillo por categoria",
                        "Peor platillo por categoria",
                        "Productos mas solicitados",
                        "Efectividad de los meseros"]
                font.pointSize: 12
                font.family: "Verdana"
                font.weight: Font.DemiBold
                Material.background: "#FFFFFF"
                Material.foreground: "#008d96"
                Material.accent: "#008d96"
                currentIndex: selectedIndex
                onCurrentIndexChanged: selectedIndex = comboReporte.currentIndex
            }
            Label
            {
                id: lblFechas
                text: "Selección de fechas"
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.weight: Font.DemiBold
                font.pointSize: 15
                font.family: "Verdana"
                Material.background: "#FFFFFF"
                Material.foreground: "#000000"
            }

            Button
            {
                id: fechaInicial;
                Material.elevation: 0
                text: "Fecha Inicial"
                antialiasing: true
                Layout.fillWidth: true
                font.weight: Font.DemiBold
                font.capitalization: Font.MixedCase
                font.pointSize: 12
                font.family: "Verdana"
                Material.background: "#FFFFFF"
                onClicked: ventanaFechaInicial.open()
            }
            Button
            {
                id: fechaFinal;
                Material.elevation: 0
                text: "Fecha Final"
                antialiasing: true
                Layout.fillWidth: true
                font.weight: Font.DemiBold
                font.capitalization: Font.MixedCase
                font.pointSize: 12
                font.family: "Verdana"
                Material.background: "#FFFFFF"
                onClicked: ventanaFechaFinal.open()
            }
            Pane
            {
                id: panelMensajes
                Layout.fillWidth: true
                Layout.minimumHeight: 300
                Layout.maximumHeight: 300
                //Layout.bottomMargin: 50
                Material.elevation: 0
                Material.background: "#000000"

                ColumnLayout
                {
                    id: layoutMensaje
                    anchors.fill: parent
                    spacing: 0

                    Image {
                        id: iconoMensaje
                        source: "/img/warning.png"
                        Layout.minimumHeight: 75
                        Layout.maximumHeight: 75
                        Layout.minimumWidth: 75
                        Layout.maximumWidth: 75
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Label
                    {
                        id: lblMensaje
                        text: "TEXTO DE PRUEBA"
                        font.weight: Font.DemiBold
                        font.pointSize: 14
                        font.family: "Verdana"
                        Material.foreground: "#FFFFFF"
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }
        }
    }

    Pane
    {
        id: panelGraficas
        Material.elevation: 4
        anchors.fill: parent
        anchors.leftMargin: 350
        anchors.topMargin: 110
        anchors.rightMargin: 50
        anchors.bottomMargin: 50

        ListView
        {
            id: vistaGraficas
            anchors.fill: parent
            focus: true
            snapMode: ListView.SnapOneItem
            highlightRangeMode: ListView.StrictlyEnforceRange
            highlightMoveDuration: 1000
            orientation: ListView.Horizontal
            boundsBehavior: Flickable.StopAtBounds
            spacing: 1366
            cacheBuffer: 0
            currentIndex: selectedIndex
            onCurrentIndexChanged: selectedIndex = vistaGraficas.currentIndex
            model: ListModel
            {
                ListElement {component: "Reporte1.qml"}
                ListElement {component: "Reporte2.qml"}
                ListElement {component: "Reporte3.qml"}
                ListElement {component: "Reporte4.qml"}
                ListElement {component: "Reporte5.qml"}
            }
            delegate: Loader
            {
                id: graficaCargada
                width: vistaGraficas.width
                height: vistaGraficas.height
                source: component
                asynchronous: true
                active: activadorLoader
            }
        }
    }
}
