import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.0

//import QtQuick.Dialogs 1.2

ApplicationWindow{
    id: login
    visible: true
    width: 1366
    height: 720
    title: qsTr("Prueba inicial")
    Component.onCompleted: {
        setX(screen.width / 2 - width / 2);
        setY(screen.height / 2 - height / 2);
    }
    onActiveFocusControlChanged: {
    visible: false
    }

    MainWindowGerente{
        id: mainWindowGerente
        title: qsTr("Gerente")
        visible: false
    }
    MainWindowAnfitrion{
        id: mainWindowAnfitrion
        title: qsTr("Anfitrion")
        visible: false
    }
    MainWindowMesero
    {
        id: mainWindowMesero
        title: qsTr("Mesero")
        visible: false

        onVentanaCerrada:
        {
            login.visible = true;
        }
    }
    MainWindowCocinero
    {
        id: mainWindowCocinero
        title: qsTr("Cocinero")
        visible: false
    }

    Popup
    {
        id: ventanaError
        width: 200
        height: 50
        x: Math.round((parent.width - width) / 2)
        y: 450

        Label
        {
            id: lblVentanaError
            text: "Campos Vacios Encontrados"
        }
    }

    function usuarios()
    {
        if(txtUsuario.text==""||txtContrasegna.text=="")
        {
            ventanaError.open()
        }
        else
        {
            switch(empleadoLista.buscarCategoria(txtUsuario.text, txtContrasegna.text))
            {
            case 0:
                lblVentanaError.text = "Usuario Incorrecto"
                ventanaError.open()
                txtContrasegna.clear()
            break;
            case 1:
                //gerente
                mainWindowGerente.idGerente = empleadoLista.buscarIdMesero(txtUsuario.text, txtContrasegna.text)
                mainWindowGerente.show()
                txtUsuario.clear()
                txtContrasegna.clear()
                ventanaError.close()
            break;
            case 2:
                //cocinero
                modeloPlatillosNuevos.modeloEstado(1);
                modeloPlatillosPreparados.modeloEstado(2);
                mainWindowCocinero.show()
                txtUsuario.clear()
                txtContrasegna.clear()
                ventanaError.close()
            break;
            case 3:
                //mesero
                login.visible = false
                mainWindowMesero.idMesero = empleadoLista.buscarIdMesero(txtUsuario.text, txtContrasegna.text)
                modeloComandas.getComandasMesero(mainWindowMesero.idMesero, 0)
                modeloPlatillosMesero.platillosMesero(mainWindowMesero.idMesero);
                mainWindowMesero.show()
                txtUsuario.clear()
                txtContrasegna.clear()
                ventanaError.close()
            break;
            case 4:
                //anfitrion
                mainWindowAnfitrion.show()
                txtUsuario.clear()
                txtContrasegna.clear()
                ventanaError.close()
            break;
            case 5:
                //busboy
            break;
            default:
                lblVentanaError.text = "Error Desconocido"
                ventanaError.open()
            }
        }
    }

    Image {
        id: name
        fillMode: Image.Tile
        opacity: 1
        anchors.fill: parent
        source: "img/loginBackground.png"
    }

    Image {
        id: image
        x: 30
        y: 30
        width: 70
        height: 70
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.top: parent.top
        anchors.topMargin: 30
        fillMode: Image.PreserveAspectFit
        source: "img/logo.png"
    }

    Pane {
        id: panelSesion
        x: 483
        y: 160
        width: 350
        height: 400
        antialiasing: true
        anchors.centerIn: parent
        Material.elevation: 8
        Material.background: "#FFFFFF"

        ColumnLayout{
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            spacing: 0
            clip: true

            Image {
                smooth: true
                antialiasing: true
                Layout.minimumHeight: 100
                Layout.minimumWidth: 100
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.columnSpan: 1
                Layout.rowSpan: 1
                Layout.maximumHeight: 100
                Layout.maximumWidth: 100
                fillMode: Image.PreserveAspectFit
                visible: true
                source: "img/loginUser.png"
            }

            RowLayout{
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillWidth: false
                spacing: 10
                Label {
                    text: qsTr("Empleado:")
                }
                TextField {
                    id: txtUsuario
                    onAccepted:
                    {
                        usuarios()
                    }
                }
            }

            RowLayout{
                spacing: 10
                Layout.alignment: Qt.AlignHCenter
                Label {
                    text: qsTr("Contraseña:")
                }
                TextField {
                    id: txtContrasegna
                    echoMode: TextInput.Password
                    onAccepted:
                    {
                        usuarios();
                    }
                }
            }
            RoundButton{
                id: btnLogin
                radius: 20
                width: 120
                text: qsTr("Iniciar sesión")
                antialiasing: true
                autoRepeat: false
                spacing: 0
                Layout.minimumHeight: 50
                Layout.minimumWidth: 120
                Layout.preferredHeight: 50
                Layout.preferredWidth: 120
                hoverEnabled: true
                focusPolicy: Qt.NoFocus
                padding: 0
                font.capitalization: Font.MixedCase
                font.family: "Verdana"
                flat: false
                font.pointSize: 10
                highlighted: true
                Material.background: "#006677"
                display: AbstractButton.TextBesideIcon
                Layout.fillWidth: false
                wheelEnabled: false
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                onClicked:
                {
                    usuarios()
                }
            }
        }
    }
}
