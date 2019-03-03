import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtCharts 2.2
import ControlGraficas 1.0

Item {
    id: graficasReporte3
    anchors.fill: parent

    property string categoria1: controlGraficas.categoriaPlatilloMenosVendidoCategoria(1);
    property string categoria2: controlGraficas.categoriaPlatilloMenosVendidoCategoria(2);
    property string categoria3: controlGraficas.categoriaPlatilloMenosVendidoCategoria(3);
    property string categoria4: controlGraficas.categoriaPlatilloMenosVendidoCategoria(4);
    property string categoria5: controlGraficas.categoriaPlatilloMenosVendidoCategoria(5);
    property string categoria6: controlGraficas.categoriaPlatilloMenosVendidoCategoria(6);
    property string categoria7: controlGraficas.categoriaPlatilloMenosVendidoCategoria(7);
    property string categoria8: controlGraficas.categoriaPlatilloMenosVendidoCategoria(8);
    property string categoria9: controlGraficas.categoriaPlatilloMenosVendidoCategoria(9);
    property string categoria10: controlGraficas.categoriaPlatilloMenosVendidoCategoria(10);
    property string nombre1: controlGraficas.nombrePlatilloMenosVendidoCategoria(1);
    property string nombre2: controlGraficas.nombrePlatilloMenosVendidoCategoria(2);
    property string nombre3: controlGraficas.nombrePlatilloMenosVendidoCategoria(3);
    property string nombre4: controlGraficas.nombrePlatilloMenosVendidoCategoria(4);
    property string nombre5: controlGraficas.nombrePlatilloMenosVendidoCategoria(5);
    property string nombre6: controlGraficas.nombrePlatilloMenosVendidoCategoria(6);
    property string nombre7: controlGraficas.nombrePlatilloMenosVendidoCategoria(7);
    property string nombre8: controlGraficas.nombrePlatilloMenosVendidoCategoria(8);
    property string nombre9: controlGraficas.nombrePlatilloMenosVendidoCategoria(9);
    property string nombre10: controlGraficas.nombrePlatilloMenosVendidoCategoria(10);
    property int valores1: controlGraficas.cantidadPlatilloMenosVendidoCategoria(1);
    property int valores2: controlGraficas.cantidadPlatilloMenosVendidoCategoria(2);
    property int valores3: controlGraficas.cantidadPlatilloMenosVendidoCategoria(3);
    property int valores4: controlGraficas.cantidadPlatilloMenosVendidoCategoria(4);
    property int valores5: controlGraficas.cantidadPlatilloMenosVendidoCategoria(5);
    property int valores6: controlGraficas.cantidadPlatilloMenosVendidoCategoria(6);
    property int valores7: controlGraficas.cantidadPlatilloMenosVendidoCategoria(7);
    property int valores8: controlGraficas.cantidadPlatilloMenosVendidoCategoria(8);
    property int valores9: controlGraficas.cantidadPlatilloMenosVendidoCategoria(9);
    property int valores10: controlGraficas.cantidadPlatilloMenosVendidoCategoria(10);

    ChartView {
        id: chart
        title: "Platillo menos vendido por categoria"
        anchors.fill: parent
        legend.visible: false
        antialiasing: true

        PieSeries {
            id: categorias
            size: 0.9
            holeSize: 0.7
            PieSlice
            {
                label: categoria1
                value: valores1
                color: "#FF0000"
            }
            PieSlice
            {
                label: categoria2
                value: valores2
                color: "#FD7500"
            }
            PieSlice
            {
                label: categoria3
                value: valores3
                color: "#39FF00"
            }
            PieSlice
            {
                label: categoria4
                value: valores4
                color: "#00FF89"
            }
            PieSlice
            {
                label: categoria5
                value: valores5
                color: "#00FFFA"
            }
            PieSlice
            {
                label: categoria6
                value: valores6
                color: "#003CFA"
            }
            PieSlice
            {
                label: categoria7
                value: valores7
                color: "#7100FF"
            }
            PieSlice
            {
                label: categoria8
                value: valores8
                color: "#E700FF"
            }
            PieSlice
            {
                label: categoria9
                value: valores9
                color: "#FF00B3"
            }
            PieSlice
            {
                label: categoria10
                value: valores10
                color: "#C20237"
            }
        }

        PieSeries {
            size: 0.7
            id: platillos
            holeSize: 0.25

            PieSlice
            {
                label: nombre1
                value: valores1
                color: "#FE7E7E"
                onHovered: {
                    if(state)
                        label = nombre1 + "\n(" + valores1 + ")"
                    else
                        label = nombre1
                }
            }
            PieSlice
            {
                label: nombre2
                value: valores2
                color: "#FDB679"
                onHovered: {
                    if(state)
                        label = nombre2 + "\n(" + valores2 + ")"
                    else
                        label = nombre2
                }
            }
            PieSlice
            {
                label: nombre3
                value: valores3
                color: "#94FE76"
                onHovered: {
                    if(state)
                        label = nombre3 + "\n(" + valores3 + ")"
                    else
                        label = nombre3
                }
            }
            PieSlice
            {
                label: nombre4
                value: valores4
                color: "#78FDBF"
                onHovered: {
                    if(state)
                        label = nombre4 + "\n(" + valores4 + ")"
                    else
                        label = nombre4
                }
            }
            PieSlice
            {
                label: nombre5
                value: valores5
                color: "#79FFFD"
                onHovered: {
                    if(state)
                        label = nombre5 + "\n(" + valores5 + ")"
                    else
                        label = nombre5
                }
            }
            PieSlice
            {
                label: nombre6
                value: valores6
                color: "#7F9EFF"
                onHovered: {
                    if(state)
                        label = nombre6 + "\n(" + valores6 + ")"
                    else
                        label = nombre6
                }
            }PieSlice
            {
                label: nombre7
                value: valores7
                color: "#B274FF"
                onHovered: {
                    if(state)
                        label = nombre7 + "\n(" + valores7 + ")"
                    else
                        label = nombre7
                }
            }
            PieSlice
            {
                label: nombre8
                value: valores8
                color: "#F26FFF"
                onHovered: {
                    if(state)
                        label = nombre8 + "\n(" + valores8 + ")"
                    else
                        label = nombre8
                }
            }
            PieSlice
            {
                label: nombre9
                value: valores9
                color: "#FF73D6"
                onHovered: {
                    if(state)
                        label = nombre9 + "\n(" + valores9 + ")"
                    else
                        label = nombre9
                }
            }
            PieSlice
            {
                label: nombre10
                value: valores10
                color: "#C25F7A"
                onHovered: {
                    if(state)
                        label = nombre10 + "\n(" + valores10 + ")"
                    else
                        label = nombre10
                }
            }
        }
    }

    Component.onCompleted: {
        for (var i = 0; i < categorias.count; i++) {
            categorias.at(i).labelPosition = PieSlice.LabelOutside;
            categorias.at(i).labelVisible = true;
            categorias.at(i).borderWidth = 3;
        }
        for (i = 0; i < platillos.count; i++) {
            platillos.at(i).labelPosition = PieSlice.LabelInsideNormal;
            platillos.at(i).labelVisible = true;
            platillos.at(i).borderWidth = 2;
        }
    }
}
