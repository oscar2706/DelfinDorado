import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

Item {
    property string imagen
    property int ancho
    width: ancho
    height: 90
    Rectangle{
        id: rect1
        anchors.fill: parent
        color:"transparent"
        Image {
            id: imgMesa1
            anchors.fill: parent
            x: 368
            y: 63
            source: imagen
        }
        MouseArea{
            anchors.fill: parent


            onClicked:{
                mainWindowAsignar.show()
            }
        }
    }
}
