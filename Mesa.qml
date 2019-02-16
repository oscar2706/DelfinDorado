import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

Item {
    property string imagen
    property int ancho
    property string numMesa
    property int estadoMesa

    width: ancho
    height: 90
    Rectangle{
        id: rect
        anchors.fill: parent
        color:"transparent"
        Image {
            id: imgMesa
            anchors.fill: parent
            x: 368
            y: 63
            source: imagen
        }
        MouseArea{
            anchors.fill: parent
            onClicked:{
                if(estadoMesa==1){
                    mainWindiwAsignar.mesa = numMesa;
                    mainWindiwAsignar.show()
                }
                else
                {
                    switch(numMesa)
                    {
                       case "1": popupMesero1.open(); break;
                       case "2": popupMesero2.open(); break;
                       case "3": popupMesero3.open(); break;
                       case "4": popupMesero4.open(); break;
                       case "5": popupMesero5.open(); break;
                       case "6": popupMesero6.open(); break;
                       case "7": popupMesero7.open(); break;
                       case "8": popupMesero8.open(); break;
                       case "9": popupMesero9.open(); break;
                       case "10":popupMesero10.open(); break;
                       case "11":popupMesero11.open(); break;
                    }
                }
            }
        }
    }
}

