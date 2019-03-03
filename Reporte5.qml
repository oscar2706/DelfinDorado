import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtCharts 2.2
import ControlGraficas 1.0

Item {
    id: graficasReporte5
    anchors.fill: parent

    property string nombre1: controlGraficas.nombreComandasAtendidas(1);
    property string nombre2: controlGraficas.nombreComandasAtendidas(2);
    property string nombre3: controlGraficas.nombreComandasAtendidas(3);
    property int valores1: controlGraficas.cantidadComandasAtendidas(1);
    property int valores2: controlGraficas.cantidadComandasAtendidas(2);
    property int valores3: controlGraficas.cantidadComandasAtendidas(3);

    ChartView {
        id: grafica1
        title: "Reporte de eficiencia de meseros"
        anchors.fill: parent
        legend.alignment: Qt.AlignBottom
        antialiasing: true
        BarSeries {
            id: mySeries
            ValueAxis
            {
                id: valorY
                min: 0
                max: valores1 + 5;
                titleText: "Comandas atendidas"
            }
            axisY: valorY
            axisX: BarCategoryAxis
            {
                titleText: "Empleado"
                categories: [""]
            }
            BarSet
            {
                label: nombre1
                values: [valores1]
                onHovered: {
                    if(status)
                        label = nombre1 + "\n(" + valores1 + ")"
                    else
                        label = nombre1
                }
            }
            BarSet
            {
                label: nombre2
                values: [valores2]
                onHovered: {
                    if(status)
                        label = nombre2 + "\n(" + valores2 + ")"
                    else
                        label = nombre2
                }
            }
            BarSet
            {
                label: nombre3
                values: [valores3]
                onHovered: {
                    if(status)
                        label = nombre3 + "\n(" + valores3 + ")"
                    else
                        label = nombre3
                }
            }
        }
    }
}


