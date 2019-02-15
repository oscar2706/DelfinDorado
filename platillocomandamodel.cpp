#include "platillocomandamodel.h"

PlatilloComandaModel::PlatilloComandaModel(QObject *parent) : QAbstractListModel(parent)
{
    QSqlQuery qryPlatillosComanda;

    qryPlatillosComanda.prepare("SELECT * FROM platilloscomanda");
    qryPlatillosComanda.exec();

    int idComanda;
    int idPlatillo;
    int cantidad;

    while(qryPlatillosComanda.next())
    {
        idComanda = qryPlatillosComanda.value(0).toInt();
        idPlatillo = qryPlatillosComanda.value(1).toInt();
        cantidad = qryPlatillosComanda.value(2).toInt();

        addPlatilloComanda(new PlatilloComanda(idComanda, idPlatillo, cantidad));

        qDebug() << "Id Comanda: " << idComanda;
        qDebug() << "Id Platillo: " << idPlatillo;
        qDebug() << "Cantidad: " << cantidad;
    }
}

int PlatilloComandaModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return misPlatillosComanda.size();
}

QVariant PlatilloComandaModel::data(const QModelIndex &index, int role) const
{
    if(index.row() < 0 || index.row() >= misPlatillosComanda.count())
        return QVariant();

    PlatilloComanda* platilloComanda = misPlatillosComanda[index.row()];

    if(role == idComandaRole)
        return platilloComanda->idComanda();
    if(role == idPlatilloRole)
        return platilloComanda->idPlatillo();
    if(role == cantidadRole)
        return platilloComanda->cantidad();

    return QVariant();
}

bool PlatilloComandaModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    PlatilloComanda *platilloComanda = misPlatillosComanda[index.row()];
    bool somethingChanged = false;

    switch (role)
    {
    case idComandaRole:
    {
        if(platilloComanda->idComanda() != value.toInt())
        {
            platilloComanda->setIdComanda(value.toInt());
            somethingChanged = true;
        }
    }
    break;
    case idPlatilloRole:
    {
        if(platilloComanda->idPlatillo() != value.toInt())
        {
            platilloComanda->setIdPlatillo(value.toInt());
            somethingChanged = true;
        }
    }
    break;
    case cantidadRole:
    {
        if(platilloComanda->cantidad() != value.toInt())
        {
            platilloComanda->setCantidad(value.toInt());
            somethingChanged = true;
        }
    }
    }

    if(somethingChanged)
    {
        emit dataChanged(index, index, QVector<int>() << role);
        return  true;
    }
    else
    {
        return false;
    }
}

Qt::ItemFlags PlatilloComandaModel::flags(const QModelIndex &index) const
{
    if(!index.isValid())
        return Qt::NoItemFlags;
    else
        return Qt::ItemIsEnabled;
}

QHash<int, QByteArray> PlatilloComandaModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[idComandaRole] = "idComanda";
    roles[idPlatilloRole] = "idPlatillo";
    roles[cantidadRole] = "cantidad";

    return roles;
}

void PlatilloComandaModel::addPlatilloComanda(PlatilloComanda *nuevoPlatilloComanda)
{
    const int index = misPlatillosComanda.size();

    beginInsertRows(QModelIndex(), index, index);
    misPlatillosComanda.append(nuevoPlatilloComanda);
    endInsertRows();
}

void PlatilloComandaModel::addPlatillo(const int &idComanda, const int &idPlatillo, const int &cantidad)
{
    PlatilloComanda* nuevoPlatilloComanda = new PlatilloComanda(idComanda, idPlatillo, cantidad);
    bool insertedOk = insertPlatilloComandaInDataBase(nuevoPlatilloComanda);

    if(insertedOk)
    {
        addPlatilloComanda(nuevoPlatilloComanda);
        qDebug() << "PlatilloComanda insertado en la base de datos";
    }
    else
    {
        qDebug() << "Error al insertar";
    }
}

bool PlatilloComandaModel::insertPlatilloComandaInDataBase(PlatilloComanda *platilloComandaToSave)
{
    bool dataSaved = false;

    QSqlQuery insertar;

    insertar.prepare("INSERT INTO platilloscomanda(idComanda, idPlatillo, cantidad) "
                     "VALUES(:idComanda, :idPlatillo, :cantidad)");
    insertar.bindValue(":idComanda", platilloComandaToSave->idComanda());
    insertar.bindValue(":idPlatillo", platilloComandaToSave->idPlatillo());
    insertar.bindValue(":cantidad", platilloComandaToSave->cantidad());
    insertar.exec();

    if(insertar.numRowsAffected() != 0)
        dataSaved = true;

    return dataSaved;
}
