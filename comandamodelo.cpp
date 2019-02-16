#include "comandamodelo.h"

ComandaModelo::ComandaModelo(QObject *parent) : QAbstractListModel (parent)
{
    QSqlQuery comandasBD;
    comandasBD.prepare("SELECT idComanda, fecha, idEmpleado, idMesa, idEstadoComanda FROM comanda");
    comandasBD.exec();

    int id;
    QString fecha;
    int idEmpleado;
    int idMesa;
    int idEstadoComanda;

    while (comandasBD.next())
    {
        id = comandasBD.value(0).toInt();
        fecha = comandasBD.value(1).toString();
        idEmpleado = comandasBD.value(2).toInt();
        idMesa = comandasBD.value(3).toInt();
        idEstadoComanda = comandasBD.value(4).toInt();

        qDebug() << "Comanda " << id;
        qDebug() << "Fecha " << fecha;
        qDebug() << "Empleado " << idEmpleado;
        qDebug() << "Mesa " << idMesa;
        qDebug() << "Estado " << idEstadoComanda;

        addComanda(new Comanda(id, fecha, idEmpleado, idMesa, idEstadoComanda));
    }
}

int ComandaModelo::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return misComandas.size();
}

QVariant ComandaModelo::data(const QModelIndex &index, int role) const
{
    if(index.row() < 0 || index.row() >= misComandas.count())
        return QVariant();

    Comanda* comanda = misComandas[index.row()];

    if(role == idEmpleadoRole)
        return comanda->idComanda();
    if(role == fechaRole)
        return comanda->fecha();
    if(role == idEmpleadoRole)
        return comanda->idEmpleado();
    if(role == idMesaRole)
        return comanda->idMesa();
    if(role == idComandaRole)
        return comanda->idComanda();
    return QVariant();
}

bool ComandaModelo::setData(const QModelIndex &index, const QVariant &value, int role)
{
    Comanda *comanda = misComandas[index.row()];
    bool somethingChanged = false;

    switch(role)
    {
    case idComandaRole:
    {
        if(comanda->idComanda() != value.toInt())
        {
            comanda->setIdComanda(value.toInt());
            somethingChanged = true;
        }
    }
    break;
    case fechaRole:
    {
        if(comanda->fecha() != value.toString())
        {
            comanda->setFecha(value.toString());
            somethingChanged = true;
        }
    }
    break;
    case idEmpleadoRole:
    {
        if(comanda->idEmpleado() != value.toInt())
        {
            comanda->setIdEmpleado(value.toInt());
            somethingChanged = true;
        }
    }
    break;
    case idMesaRole:
    {
        if(comanda->idMesa() != value.toInt())
        {
            comanda->setIdMesa(value.toInt());
            somethingChanged = true;
        }
    }
    break;
    case idEstadoComandaRole:
    {
        if(comanda->idEstadoComanda() != value.toInt())
        {
            comanda->setIdEstadoComanda(value.toInt());
            somethingChanged = true;
        }
    }
    }

    if(somethingChanged)
    {
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    else
    {
        return false;
    }
}

Qt::ItemFlags ComandaModelo::flags(const QModelIndex &index) const
{
    if(!index.isValid())
        return Qt::NoItemFlags;
    else
        return Qt::ItemIsEnabled;
}

QHash<int, QByteArray> ComandaModelo::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[idComandaRole] = "idComanda";
    roles[fechaRole] = "fecha";
    roles[idEmpleadoRole] = "idEmpleado";
    roles[idMesaRole] = "idMesa";
    roles[idEstadoComandaRole] = "idEstadoComanda";

    return roles;
}

void ComandaModelo::addComanda(Comanda *nuevaComanda)
{
    const int index = misComandas.size();

    beginInsertRows(QModelIndex(), index, index);
    misComandas.append(nuevaComanda);
    endInsertRows();
}

void ComandaModelo::addComanda(const QString &fecha, const int &idEmpleado, const int &idMesa, const int &idEstadoComanda)
{
    int nuevoId = misComandas.last()->idComanda()+1;
    Comanda *nuevaComanda = new Comanda(nuevoId, fecha, idEmpleado, idMesa, idEstadoComanda);

    bool insertedOk = insertComandaInDataBase(nuevaComanda);

    if(insertedOk)
    {
        addComanda(nuevaComanda);
        qDebug() << "Insercion correcta";
    }
    else
    {
        qDebug() << "Error al insertar comanda";
    }
}

void ComandaModelo::getComandasMesero(int idMesero, int EstadoComanda)
{
    //qDebug() << "SE CARGAN SOLO LAS COMANDAS ESPECIFICAS";

    while(misComandas.size()>0)
    {
        beginRemoveRows(QModelIndex(),0,0);
        misComandas.removeAt(0);
        endRemoveRows();
    }

    QSqlQuery comandasBD;

    if(EstadoComanda==0)
        comandasBD.prepare("SELECT idComanda, fecha, idEmpleado, idMesa, idEstadoComanda FROM comanda "
                        "WHERE idEmpleado = " + QString::number(idMesero) + "");
    else
        comandasBD.prepare("SELECT idComanda, fecha, idEmpleado, idMesa, idEstadoComanda FROM comanda "
                        "WHERE idEmpleado = " + QString::number(idMesero) + " AND idEstadoComanda = " + QString::number(EstadoComanda) +"");

    comandasBD.exec();

    int id;
    QString fecha;
    int idEmpleado;
    int idMesa;
    int idEstadoComanda;

    while (comandasBD.next())
    {
        id = comandasBD.value(0).toInt();
        fecha = comandasBD.value(1).toString();
        idEmpleado = comandasBD.value(2).toInt();
        idMesa = comandasBD.value(3).toInt();
        idEstadoComanda = comandasBD.value(4).toInt();

        /*qDebug() << "Comanda " << id;
        qDebug() << "Fecha " << fecha;
        qDebug() << "Empleado " << idEmpleado;
        qDebug() << "Mesa " << idMesa;
        qDebug() << "Estado " << idEstadoComanda;*/

        addComanda(new Comanda(id, fecha, idEmpleado, idMesa, idEstadoComanda));
    }
}

bool ComandaModelo::insertComandaInDataBase(Comanda *comandaNueva)
{
    bool comandaSaved = false;

    QSqlQuery insertar;

    insertar.prepare("INSERT INTO comanda(fecha, idEmpleado, idMesa, idEstadoComanda) "
                     "VALUES(:fecha, :idEmpleado, :idMesa, :idEstadoComanda)");

    insertar.bindValue(":fecha", comandaNueva->fecha());
    insertar.bindValue(":idEmpleado", comandaNueva->idEmpleado());
    insertar.bindValue(":idMesa", comandaNueva->idMesa());
    insertar.bindValue(":idEstadoComanda", comandaNueva->idEstadoComanda());

    if(insertar.exec())
        comandaSaved = true;

    return comandaSaved;
}
