import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.0
import ModeloMesero 1.0



Window{
    visible: true
    width:400
    height:600
    modality: Qt.WindowModal
    property string mesa

    title: "Asignar mesa #"+mesa

    ButtonGroup {
        id: grupo
    }

    Column{
        spacing: 30
        anchors.fill: parent
        Pane{
            Material.elevation: 4
            width: 400
            height: 50
            Material.background: "#ffe0b2"
            Text {
                anchors.centerIn: parent
                text: qsTr("Meseros")
                font.pixelSize: 30
            }
        }
        ListView{
            id:listaMeseros
            width: parent.width
            height: 430
            model: MeseroModelo{
                list: meseroLista
            }
            delegate:
                RowLayout{

                Rectangle{
                    width: 400;
                    height: 50;
                    RowLayout{
                        anchors.fill: parent
                        Rectangle{
                            width: 50
                            RadioButton {
                                checked: model.seleccion
                                ButtonGroup.group: grupo
                                anchors.centerIn: parent
                                onClicked: {
                                     meseroLista.restablecerRadioButton()
                                     model.seleccion = checked
                                }
                            }
                        }
                        Rectangle{
                            width: 175
                            Text{
                                text: model.id
                                font.pixelSize: 20
                                anchors.centerIn: parent
                            }
                        }
                        Rectangle{
                            width: 175
                            Text{
                                text: model.nombre
                                font.pixelSize: 20
                                anchors.centerIn: parent
                            }
                        }
                    }
                }
            }
        }
        Row{
            id:filaBoton
            height:50
            width: 400
            Button{
                id:asignar
                hoverEnabled: true
                focusPolicy: Qt.NoFocus
                padding: 0
                font.family: "Verdana"
                font.pointSize: 12
                Material.background: "#ffe0b2"
                display: AbstractButton.TextBesideIcon
                width: 200
                text: "Asignar"
                onClicked: {
                    if(!meseroLista.verificaCampoVacio())
                        dialogoConfirmacion.open();
                    else
                        popupError.open();
                }
            }
            Button{
                id:cancelar
                hoverEnabled: true
                focusPolicy: Qt.NoFocus
                padding: 0
                font.family: "Verdana"
                font.pointSize: 12
                Material.background: "#ffe0b2"
                display: AbstractButton.TextBesideIcon
                width: 200
                text: "Cancelar"
                onClicked: close();
            }
        }
    }

    Dialog {
        id: dialogoConfirmacion
        height: 150
        width: 300
        modal: true
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        title: "La asignacion de mesa no es \nmodificable,¿Desea continuar?"
        standardButtons: Dialog.Ok | Dialog.Cancel

        onAccepted: {
            meseroLista.setComanda(mesa);
            mesaObjModel.setEstadoMesa(mesa,2)

            meseroLista.updateItem(1);
            mainWindowAsignar.close();
        }
    }
    Popup
    {
        id: popupError
        x: 19
        y: 480
        width: 200
        height: 50
        Text {
            anchors.centerIn: parent
            font.pixelSize: 18
            text: qsTr("¡Mesero sin seleccionar!")
        }
    }
}
