import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.0
import ModeloMesero 1.0



Window{
    id:ventaAsignar
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
            switch(mesa)
            {
            case "1":mesa1.imagen="img/MesaChica_Ocupada.png";
                meseroLista.setAsignacion(mesa);
                textPopup1.text = meseroLista.getMeseroAsignado(1)
                mesa1.estadoMesa=2;
                break;
            case "2": mesa2.imagen="img/MesaChica_Ocupada.png";
                meseroLista.setAsignacion(mesa);
                textPopup2.text = meseroLista.getMeseroAsignado(2)
                mesa2.estadoMesa=2;
                break;
            case "3": mesa3.imagen="img/MesaChica_Ocupada.png";
                meseroLista.setAsignacion(mesa);
                textPopup3.text = meseroLista.getMeseroAsignado(3)
                mesa3.estadoMesa=2;
                break;
            case "4": mesa4.imagen="img/MesaChica_Ocupada.png";
                meseroLista.setAsignacion(mesa);
                textPopup4.text = meseroLista.getMeseroAsignado(4)
                mesa4.estadoMesa=2;
                break;
            case "5": mesa5.imagen="img/MesaGrande_Ocupada.png";
                meseroLista.setAsignacion(mesa);
                textPopup5.text = meseroLista.getMeseroAsignado(5)
                mesa5.estadoMesa=2;
                break;
            case "6": mesa6.imagen="img/MesaGrande_Ocupada.png";
                meseroLista.setAsignacion(mesa);
                mesa6.estadoMesa=2;
                textPopup6.text = meseroLista.getMeseroAsignado(6)
                mesa6.estadoMesa=2;
                break;
            case "7": mesa7.imagen="img/MesaGrande_Ocupada.png";
                meseroLista2.setAsignacion(mesa);
                textPopup7.text = meseroLista.getMeseroAsignado(7)
                mesa7.estadoMesa=2;
                textPopup7.text = meseroLista.getMeseroAsignado(7)
                mesa7.estadoMesa=2;
                break;
            case "8": mesa8.imagen="img/MesaChica_Ocupada.png";
                meseroLista.setAsignacion(mesa);
                textPopup8.text = meseroLista.getMeseroAsignado(8)
                mesa8.estadoMesa=2;
                break;
            case "9": mesa9.imagen="img/MesaChica_Ocupada.png";
                meseroLista.setAsignacion(mesa);
                textPopup9.text = meseroLista.getMeseroAsignado(9)
                mesa9.estadoMesa=2;
                break;
            case "10": mesa10.imagen="img/MesaChica_Ocupada.png";
                meseroLista.setAsignacion(mesa);
                textPopup10.text = meseroLista.getMeseroAsignado(10)
                mesa10.estadoMesa=2;
                break;
            case "11": mesa11.imagen="img/MesaChica_Ocupada.png";
                meseroLista.setAsignacion(mesa);
                textPopup11.text = meseroLista.getMeseroAsignado(11)
                mesa11.estadoMesa=2;
                break;
            }
            meseroLista.updateItem();
            ventaAsignar.close();
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
