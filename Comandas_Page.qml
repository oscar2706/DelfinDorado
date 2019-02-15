import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

Item{
    id: comanda
    ListModel{
        id:modelComandas
        ListElement{
            idComanda: 1
            idMesa:1
        }
        ListElement{
            idComanda: 2
            idMesa:2
        }
        ListElement{
            idComanda: 3
            idMesa:3
        }
        ListElement{
            idComanda: 4
            idMesa:4
        }
        ListElement{
            idComanda: 5
            idMesa:5
        }
        ListElement{
            idComanda: 6
            idMesa:6
        }
    }
    ListView {
        id: tablaPlatillos
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        boundsBehavior: Flickable.VerticalFlick
        anchors.topMargin: 0
        anchors.fill: parent
        spacing: 4
        clip: true
        focus: true
        model: modelComandas
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
                    Layout.minimumWidth: 250
                    Layout.maximumWidth: 250
                    topPadding: 20
                    leftPadding: 50
                    text: "N° Comanda:"+idComanda
                    font.family: "Verdana"
                    font.pointSize: 10
                }
                Text{
                    Layout.minimumWidth: 200
                    Layout.maximumWidth: 200
                    topPadding: 20
                    leftPadding: 150
                    text: "Mesa:"+idMesa
                    font.family: "Verdana"
                    font.pointSize: 10
                }

                MouseArea{
                    anchors.fill: parent
                    onPressed: {
                        console.log("Se presiono el indice: "+ index)
                        //index
                        select = "#cfd8dc"
                    }
                    onReleased: {
                        select = "#ffffff"
                        cargaComandaCompleta(index)
                    }
                    onClicked: {
                        //Abrir la pestaña de la comanda
                    }
                }
            }
        }
    }
}
