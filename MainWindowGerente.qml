import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

import Empleado 1.0

Window {
    id: windowGerente
    visible: true
    title: "System Dialogs Gallery"
    width: 1366
    height: 720

    StackLayout{
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        Gerente_TabEmpleados{
            id: tabEmpleados
        }
        Item {
            id: tabFinanzas
        }
        Gerente_TabAlmacen{
            id: tabAlmacen
        }
        Gerente_TabMenu {
            id: tabMenu
        }
    }

    Pane{
        x: 0
        Material.background: "#006677"
        Material.accent: "#FFFFFF"
        Material.foreground: Material.Grey
        width: 1366
        height: 60
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.right: parent.right
        Layout.fillWidth: true
        Material.elevation: 4
        TabBar {
            id: tabBar
            width: 800
            height: 40
            hoverEnabled: false
            antialiasing: true
            focusPolicy: Qt.NoFocus
            font.capitalization: Font.Capitalize
            font.weight: Font.DemiBold
            bottomPadding: 0
            topPadding: 0
            contentHeight: 60
            contentWidth: 700
            currentIndex: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 50
            rightPadding: 0
            leftPadding: 0
            font.pointSize: 16
            font.family: "Verdana"
            anchors.margins: 8
            spacing: 10

            TabButton {
                height: 40
                text: "Empleados"
                focusPolicy: Qt.NoFocus
                display: AbstractButton.TextOnly
                spacing: 0
                antialiasing: true
                anchors.verticalCenter: parent.verticalCenter
                leftPadding: 0
                padding: 0
            }
            TabButton {
                height: 40
                text: "Administración"
                focusPolicy: Qt.NoFocus
                display: AbstractButton.TextOnly
                spacing: 0
                antialiasing: true
                anchors.verticalCenter: parent.verticalCenter
            }
            TabButton{
                height: 40
                text: "Almacen"
                focusPolicy: Qt.NoFocus
                display: AbstractButton.TextOnly
                spacing: 0
                antialiasing: true
                anchors.verticalCenter: parent.verticalCenter
            }
            TabButton{
                height: 40
                text: "Menú"
                focusPolicy: Qt.NoFocus
                display: AbstractButton.TextOnly
                spacing: 0
                antialiasing: true
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Image {
            id: btnSalida
            source: "img/exit_White.png"
            width: 40
            height: 40
            anchors.right: parent.right
            anchors.top: parent.top

            MouseArea{
                anchors.fill: parent
                onClicked: windowGerente.close()
            }
        }
    }
}
