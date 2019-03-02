import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtCharts 2.2
import ControlGraficas 1.0

Item {
    id: graficasReporte1
    anchors.fill: parent

    property string nombre1: controlGraficas.nombrePlatilloMasVendido(1);
    property string nombre2: controlGraficas.nombrePlatilloMasVendido(2);
    property string nombre3: controlGraficas.nombrePlatilloMasVendido(3);
    property int valores1: controlGraficas.cantidadPlatilloMasVendido(1);
    property int valores2: controlGraficas.cantidadPlatilloMasVendido(2);
    property int valores3: controlGraficas.cantidadPlatilloMasVendido(3);

    ChartView {
        id: grafica1
        title: "Reporte de platillos mas vendidos"
        anchors.fill: parent
        legend.alignment: Qt.AlignBottom
        antialiasing: true
        BarSeries {
            id: mySeries
            ValueAxis
            {
                id: valorY
                min: 0
                max: 15
            }
            axisY: valorY
            axisX: BarCategoryAxis { categories: ["Resultados"] }
            BarSet { label: nombre1; values: [valores1] }
            BarSet { label: nombre2; values: [valores2] }
            BarSet { label: nombre3; values: [valores3] }
        }
    }
}


