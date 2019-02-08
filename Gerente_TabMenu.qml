import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQml.Models 2.3

Item {
    id: element
    visible: true
    width: 1366
    height: 720
    Pane {
        id: menuSuperior
        z: 1
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.topMargin: 0
        anchors.rightMargin: 0
        anchors.bottomMargin: 660
        anchors.leftMargin: 0

        Material.accent: "#008d96"
        Material.foreground: "#008d96"
        Material.background: "#f5f5f5"
        Material.elevation: 2
    }

    Pane{
        id: barraLateral
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.topMargin: 0
        anchors.rightMargin: 1146
        anchors.bottomMargin: 0
        anchors.leftMargin: 0

        Material.accent: "#008d96"
        Material.foreground: "#008d96"
        Material.background: "#f5f5f5"
        Material.elevation: 4

        RowLayout{
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.topMargin: 90
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            Image {
                id: iconAddEmploye
                width: 50
                height: 50
                Layout.maximumHeight: 50
                Layout.maximumWidth: 50
                fillMode: Image.PreserveAspectFit
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                antialiasing: true
                source: "img/addMenu.png"
            }
            Button {
                text: "Registrar"
                Layout.fillHeight: true
                font.weight: Font.DemiBold
                font.pointSize: 14
                font.family: "Verdana"
                Layout.fillWidth: true
                font.capitalization: Font.MixedCase
                focusPolicy: Qt.StrongFocus
                display: AbstractButton.TextBesideIcon
                Material.background: "#FFFFFF"
                Material.elevation: 0
                Menu_RegistrarPlatillo{
                id: ventana_RegistrarPlatillo
                }
                onClicked:{
                    ventana_RegistrarPlatillo.show()
                }
            }
        }

        RowLayout{
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.topMargin: 160
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            Image {
                id: iconUpdateEmploye
                width: 50
                height: 50
                Layout.maximumHeight: 50
                Layout.maximumWidth: 50
                fillMode: Image.PreserveAspectFit
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                antialiasing: true
                source: "img/editMenu.png"
            }
            Button {
                text: "Modificar"
                font.family: "Verdana"
                Layout.fillHeight: true
                font.weight: Font.DemiBold
                font.pointSize: 14
                Layout.fillWidth: true
                font.capitalization: Font.MixedCase
                focusPolicy: Qt.StrongFocus
                display: AbstractButton.TextBesideIcon
                Material.background: "#FFFFFF"
                Material.elevation: 0
                Menu_EditarPlatillo{
                    id: ventana_EditarPlatillo
                }
                onClicked: ventana_EditarPlatillo.show()
            }
        }


        RowLayout{
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.topMargin: 230
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            Image {
                id: iconDeleteEmploye
                width: 50
                height: 50
                Layout.maximumHeight: 50
                Layout.maximumWidth: 50
                fillMode: Image.PreserveAspectFit
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                antialiasing: true
                source: "img/removeMenu.png"
            }
            Button {
                text: "Eliminar"
                font.family: "Verdana"
                Layout.fillHeight: true
                font.weight: Font.DemiBold
                font.pointSize: 14
                Layout.fillWidth: true
                font.capitalization: Font.MixedCase
                focusPolicy: Qt.StrongFocus
                display: AbstractButton.TextBesideIcon
                Material.background: "#FFFFFF"
                Material.elevation: 0
            }
        }



        /*
        Button{
            id: btnAddDish
            height: 50
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 90
            Layout.fillWidth: true
            Material.background: "#ffffff"
            Material.elevation: 1
            RowLayout{
                anchors.fill: parent
                Image{
                    id: image
                    width: 50
                    height: 60
                    Layout.fillHeight: true
                    fillMode: Image.PreserveAspectFit
                    source: "img/addMenu.png"
                }
                Label{
                    //anchors.horizontalCenter: parent.horizontalCenter
                    text: "Agregar platillo"
                    font.weight: Font.DemiBold
                    font.capitalization: Font.MixedCase
                    font.pointSize: 14
                    font.family: "Verdana"
                }
            }
        }


        Button{
            height: 50
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 180
            Layout.fillWidth: true
            Material.background: "#ffffff"
            Material.elevation: 1
            RowLayout{
                anchors.fill: parent
                Image{
                    width: 50
                    height: 60
                    Layout.fillHeight: true
                    fillMode: Image.PreserveAspectFit
                    source: "img/editMenu.png"
                }
                Label{
                    //anchors.horizontalCenter: parent.horizontalCenter
                    text: "Editar platillo"
                    font.weight: Font.DemiBold
                    font.capitalization: Font.MixedCase
                    font.pointSize: 14
                    font.family: "Verdana"
                }
            }
        }

        Button{
            height: 50
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 270
            Layout.fillWidth: true
            Material.background: "#ffffff"
            Material.elevation: 1
            RowLayout{
                anchors.fill: parent
                Image{
                    width: 50
                    height: 60
                    Layout.fillHeight: true
                    fillMode: Image.PreserveAspectFit
                    source: "img/removeMenu.png"
                }
                Label{
                    //anchors.horizontalCenter: parent.horizontalCenter
                    text: "Quitar platillo"
                    font.weight: Font.DemiBold
                    font.capitalization: Font.MixedCase
                    font.pointSize: 14
                    font.family: "Verdana"
                }
            }
        }
        */

    }

    Pane{
        id: tablaPlatillos
        opacity: 1
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.topMargin: 80
        anchors.rightMargin: 583
        anchors.bottomMargin: 20
        anchors.leftMargin: 240
        Material.accent: "#008d96"
        Material.foreground: "#008d96"
        Material.background: "#f5f5f5"
        Material.elevation: 4
    }

    Pane{
        id: infoPlatillo
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.topMargin: 80
        anchors.rightMargin: 20
        anchors.bottomMargin: 20
        anchors.leftMargin: 804
        Material.accent: "#008d96"
        Material.foreground: "#008d96"
        Material.background: "#f5f5f5"
        Material.elevation: 4
    }

}
