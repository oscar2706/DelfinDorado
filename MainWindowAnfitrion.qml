import QtQuick 2.0
import QtQuick 2.9
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.0


ApplicationWindow {
    visible: true
    title: "Mapa mesas"
    width: 1366
    height: 720
    background: BorderImage {source: "img/mapaAnfitrion.jpg" }

    MainWindowAsignar{
        id: mainWindowAsignar
        visible: false
    }
    Anfitrion_Pedido{
        id: dialog_Pedido
        visible: false
    }

    GridView{
        id:listaMeseros
        x: 279
        y: 44
        width: 862
        height: 777

        model: mesaObjModel
        cellHeight: height /3
        cellWidth: width /4
        delegate:Rectangle{
            property string numMesa: "mesa"+model.idMesa
            id: numMesa
            height: model.alto
            width: model.ancho
            color:"transparent"
            Image {
                anchors.fill: parent
                source: model.imgMesa
            }
            MouseArea{
                anchors.fill: parent
                onClicked:{
                        if(model.estado === 1){
                            mainWindowAsignar.mesa = model.idMesa;
                            mainWindowAsignar.show()
                        }
                        else if(model.estado === 2){

                            switch(model.idMesa)
                            {
                                case 1:
                                    popupMesero.popX = listaMeseros.width / 4
                                    popupMesero.popY =  125
                                    textPopup.text = meseroLista.getMeseroAsignado(1);
                                break;
                                case 2:
                                    popupMesero.popX = (listaMeseros.width / 4)*2
                                    popupMesero.popY = 125
                                    textPopup.text = meseroLista.getMeseroAsignado(2);
                                break;
                                case 3:
                                    popupMesero.popX = (listaMeseros.width / 4)*3
                                    popupMesero.popY = 125
                                    textPopup.text = meseroLista.getMeseroAsignado(3);
                                break;
                                case 4:
                                    popupMesero.popX = (listaMeseros.width / 4)*4
                                    popupMesero.popY = 125
                                    textPopup.text = meseroLista.getMeseroAsignado(4);
                                break;

                                case 5:
                                    popupMesero.popX = (listaMeseros.width / 4) + 20
                                    popupMesero.popY = (listaMeseros.height / 4) *2
                                    textPopup.text = meseroLista.getMeseroAsignado(5);
                                break;
                                case 6:
                                    popupMesero.popX = ((listaMeseros.width / 4)*2)+ 20
                                    popupMesero.popY = (listaMeseros.height / 4) *2
                                    textPopup.text = meseroLista.getMeseroAsignado(6);
                                break;
                                case 7:
                                    popupMesero.popX = ((listaMeseros.width / 4)*3)+ 20
                                    popupMesero.popY = (listaMeseros.height / 4) *2
                                    textPopup.text = meseroLista.getMeseroAsignado(7);
                                break;
                                case 8:
                                    popupMesero.popX = ((listaMeseros.width / 4)*4)+ 20
                                    popupMesero.popY = (listaMeseros.height / 4) *2
                                    textPopup.text = meseroLista.getMeseroAsignado(8);
                                break;

                                case 9:
                                    popupMesero.popX = listaMeseros.width / 4
                                    popupMesero.popY =  650
                                    textPopup.text = meseroLista.getMeseroAsignado(9);
                                break;
                                case 10:
                                    popupMesero.popX = (listaMeseros.width / 4)*2
                                    popupMesero.popY =  650
                                    textPopup.text = meseroLista.getMeseroAsignado(10);
                                break;
                                case 11:
                                    popupMesero.popX = (listaMeseros.width / 4)*3
                                    popupMesero.popY =  650
                                    textPopup.text = meseroLista.getMeseroAsignado(11);
                                break;
                                case 12:
                                    popupMesero.popX = (listaMeseros.width / 4)*4
                                    popupMesero.popY =  650
                                    textPopup.text = meseroLista.getMeseroAsignado(12);
                                break;
                            }
                            popupMesero.open();
                        }
                    }
                }
        }
    }


    Pane{
        id: menuOpciones
        width: 180
        height: 720
        Material.background:"white"
        antialiasing: true
        Material.elevation: 16
        Column
        {
            id:panelIzq
            width: 160
            height: 680
            spacing: 1

            Rectangle{
                id: visualizar
                height: 60
                width: panelIzq.width
                border.color: "black"
                border.width: 1
                radius: 8
                Image {
                    id: imgVisualizar
                    Layout.maximumHeight: 50
                    Layout.maximumWidth: 50
                    height: 50
                    width: 50
                    anchors.verticalCenter: parent.verticalCenter
                    source: "img/Anfitrion_pedido.png"
                }
                Text {
                    id: textVisualizar
                    text: qsTr("        Para llevar")
                    anchors.centerIn: parent
                    font.weight: Font.Normal
                    font.pointSize: 14
                    font.family: "Verdana"
                    Material.background: "#FFFFFF"
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked:{
                        dialog_Pedido.open()
                    }
                }
            }
            Rectangle{
                id: salir
                height: 40
                width: panelIzq.width
                radius: 10
                border.color: "black"
                border.width: 1

                Image {
                    id: imgSalir
                    height: 40
                    width: 40
                    source: "img/salir.png"
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text {
                    id: textSalir
                    text: qsTr(" Salir")
                    anchors.centerIn: parent
                    font.weight: Font.Normal
                    font.pointSize: 14
                    font.family: "Verdana"
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: close();
                    onEntered: salir.color = "#cbae82"
                    onExited:  salir.color = "white"
                }
            }
        }
    }
    Popup
    {
        property int popX
        property int popY

        id: popupMesero
        width: 200
        height: 50
        x: popX
        y: popY
        Text {
            id:textPopup
            anchors.centerIn: parent
            font.pixelSize: 18
        }
    }
}
