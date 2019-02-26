#include "pedidomodelo.h"

PedidoModelo::PedidoModelo(QObject *parent) : QAbstractListModel (parent)
{
    int idPedido;
    float total;
    QString fecha;
    int idEmpleado;

    QSqlQuery qryPedidos;

    qryPedidos.prepare("SELECT * FROM pedido");
    qryPedidos.exec();

    while (qryPedidos.next())
    {
        idPedido = qryPedidos.value(0).toInt();
        total = qryPedidos.value(2).toFloat();
        fecha = qryPedidos.value(3).toString();
        idEmpleado = qryPedidos.value(4).toInt();

        addPedido(new Pedido(idPedido, total, fecha, idEmpleado));
    }
}

int PedidoModelo::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return misPedidos.size();
}

QVariant PedidoModelo::data(const QModelIndex &index, int role) const
{
    if(index.row() < 0 || index.row() >= misPedidos.count())
        return QVariant();

    Pedido* pedido = misPedidos[index.row()];
    if(role == idPedidoRole)
        return pedido->idPedido();
    if(role == totalRole)
        return pedido->total();
    if(role == fechaRole)
        return pedido->fecha();
    if(role == idEmpleadoRole)
        return pedido->idEmpleado();
    return  QVariant();
}

bool PedidoModelo::setData(const QModelIndex &index, const QVariant &value, int role)
{
    Pedido* pedido = misPedidos[index.row()];
    bool somethingChanged = false;

    switch (role)
    {
    case idPedidoRole: {
        if(pedido->idPedido() != value.toInt())
        {
            pedido->setIdPedido(value.toInt());
            somethingChanged = true;
        }
    }
        break;
    case totalRole: {
        if(pedido->total() != value.toFloat())
        {
            pedido->setTotal(value.toFloat());
            somethingChanged = true;
        }
    }
        break;
    case fechaRole: {
        if(pedido->fecha() != value.toString())
        {
            pedido->setFecha(value.toString());
            somethingChanged = true;
        }
    }
        break;
    case idEmpleadoRole: {
        if(pedido->idEmpleado() != value.toInt())
        {
            pedido->setIdEmpleado(value.toInt());
            somethingChanged = true;
        }
    }
    }

    if(somethingChanged)
    {
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    else {
        return false;
    }
}

Qt::ItemFlags PedidoModelo::flags(const QModelIndex &index) const
{
    if(!index.isValid())
        return Qt::NoItemFlags;
    return Qt::ItemIsEnabled;
}

QHash<int, QByteArray> PedidoModelo::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[idPedidoRole] = "idPedido";
    roles[totalRole] = "total";
    roles[fechaRole] = "fecha";
    roles[idEmpleadoRole] = "idEmpleado";
    return roles;
}

void PedidoModelo::addPedido(Pedido *nuevoPedido)
{
    const int index = misPedidos.size();

    beginInsertRows(QModelIndex(), index, index);
    misPedidos.append(nuevoPedido);
    endInsertRows();
}

void PedidoModelo::addPedido(const float &total, const int &idEmpleado)
{
    QDate nuevaFecha = QDate::currentDate();
    QString hoy = nuevaFecha.toString("yyyy-MM-dd");
    int nuevoId;
    if(misPedidos.size() == 0)
        nuevoId = 1;
    else
        nuevoId = misPedidos.last()->idPedido() + 1;
    Pedido* nuevoPedido = new Pedido(nuevoId, total, hoy, idEmpleado);

    bool insertedPedido = insertPedidoInDataBase(nuevoPedido);

    if(insertedPedido)
    {
        addPedido(nuevoPedido);
    }
    else {
        qDebug() << "Error en la inserción";
    }
}

int PedidoModelo::getUltimoPedido()
{
    return ultimoPedido;
}

bool PedidoModelo::insertPedidoInDataBase(Pedido *pedidoToSave)
{
    bool pedidoSaved = false;

    QSqlQuery insertar, ultimo;

    insertar.prepare("INSERT INTO pedido(total, fecha, idEmpleado) "
                     "VALUES(:total, :fecha, :idEmpleado)");
    insertar.bindValue(":total", pedidoToSave->total());
    insertar.bindValue(":fecha", pedidoToSave->fecha());
    insertar.bindValue(":idEmpleado", pedidoToSave->idEmpleado());

    if(insertar.exec())
        pedidoSaved = true;

    ultimo.prepare("SELECT idPedido FROM pedido ORDER BY idPedido desc");
    ultimo.exec();
    ultimo.next();

    ultimoPedido = ultimo.value(0).toInt();
    qDebug() << "Ultimo pedido: " << ultimoPedido;

    return pedidoSaved;
}
