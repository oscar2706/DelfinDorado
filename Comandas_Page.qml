import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

Page{
    id: comandasTodas
    title: "Todas"

    ListView {
        id: listaComandas
        boundsBehavior: Flickable.VerticalFlick
        anchors.fill: parent
        spacing: 0
        clip: true
        focus: true
        model: modeloComandas
        highlight: Button {
            id: btn2
            Material.background: "#cfd8dc"
            Material.elevation: 4
            Layout.fillWidth: true
            Layout.fillHeight: true
            hoverEnabled: true
        }
        highlightFollowsCurrentItem: true
        removeDisplaced: Transition {
            NumberAnimation { properties: "x,y"; duration: 300 }
        }
        delegate: Component {
            Item{
                width: parent.width
                height: 50
                property string select: "#ffffff"
                property int elevacion: 2
                //property bool selectedItem: false
                Pane{
                    anchors.fill: parent
                    Material.background: select
                    Material.elevation: elevacion
                }
                Text{
                    Layout.minimumWidth: 450
                    Layout.maximumWidth: 450
                    topPadding: 20
                    leftPadding: 50
                    text: "N° Comanda: "+idComanda
                    font.family: "Verdana"
                    font.pointSize: 12
                }
                Text{
                    Layout.minimumWidth: 200
                    Layout.maximumWidth: 200
                    topPadding: 20
                    leftPadding: 200
                    text: "Mesa: "+idMesa
                    font.family: "Verdana"
                    font.pointSize: 12
                }

                MouseArea{
                    anchors.fill: parent
                    onPressed: {
                        console.log("Se presiono la comanda: "+ idComanda)
                        console.log("su mesa es la:"+idMesa)
                        select = "#cfd8dc"
                        selectedComanda  = idComanda
                        selectedMesa = idMesa
                        selectedFecha = fecha
                        //comandaCompleta.fechaSeleccionada
                    }
                    onReleased: {
                        select = "#ffffff"
                        stackView.push(comandaSeleccionada)
                    }
                    onClicked: {
                        //Abrir la pestaña de la comanda
                    }
                }
            }
        }
    }

    Component{
        id: comandaSeleccionada
        ComandaSeleccionada_Page{
            id: comanda
            idComanda: selectedComanda
            mesaAsignada: selectedMesa
            fechaComanda: selectedFecha
        }
    }
}
