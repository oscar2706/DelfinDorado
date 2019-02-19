#include "platillococinamodelo.h"

PlatilloCocinaModelo::PlatilloCocinaModelo(QObject *parent) : QAbstractListModel(parent)
{
    QSqlQuery qryPlatillosComanda;

    qryPlatillosComanda.prepare("SELECT * FROM platilloscomanda");
    qryPlatillosComanda.exec();

    int idPlatillosComanda;
    int idComanda;
    int idPlatillo;
    QString nombre;
    int idEstadoPreparacion;

    QList<PlatilloCocina *> platillosDeComanda;

    while(qryPlatillosComanda.next())
    {
        idPlatillosComanda = qryPlatillosComanda.value(0).toInt();
        idComanda = qryPlatillosComanda.value(2).toInt();
        idPlatillo = qryPlatillosComanda.value(1).toInt();
        idEstadoPreparacion = qryPlatillosComanda.value(3).toInt();

        QSqlQuery qryNombrePlatillo;
        qryNombrePlatillo.prepare("SELECT nombre FROM platillo WHERE idPlatillo = :idPlatillo");
        qryNombrePlatillo.bindValue(":idPlatillo", idPlatillo);
        qryNombrePlatillo.exec();
        qryNombrePlatillo.next();

        nombre = qryNombrePlatillo.value(0).toString();

        qDebug() << "PLATILLOS COCINA";
        qDebug() << idPlatillosComanda << " " << idComanda << " " << idPlatillo << " " << nombre << " " << idEstadoPreparacion;
        qDebug() << "----------------------";
        PlatilloCocina *nuevoPlatillo = new PlatilloCocina(idPlatillosComanda, idComanda, idPlatillo, nombre, idEstadoPreparacion);
        addPlatilloCocina(nuevoPlatillo);
    }
}

int PlatilloCocinaModelo::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return misPlatillosCocina.size();
}

QVariant PlatilloCocinaModelo::data(const QModelIndex &index, int role) const
{
    if(index.row() < 0 || index.row() >= misPlatillosCocina.count())
        return QVariant();

    PlatilloCocina* platilloComanda = misPlatillosCocina[index.row()];

    if(role == idPlatillosComandaRole)
        return platilloComanda->idPlatillosComanda();
    if(role == idComandaRole)
        return platilloComanda->idComanda();
    if(role == idPlatilloRole)
        return platilloComanda->idPlatillo();
    if(role == nombreRole)
        return platilloComanda->nombrePlatillo();
    if(role == idEstadoPreparacionRole)
        return platilloComanda->idEstadoPreparacion();

    return QVariant();
}

bool PlatilloCocinaModelo::setData(const QModelIndex &index, const QVariant &value, int role)
{
    PlatilloCocina *platilloComanda = misPlatillosCocina[index.row()];
    bool somethingChanged = false;

    switch (role){
    case idPlatillosComandaRole:
    {
        if(platilloComanda->idPlatillosComanda() != value.toInt())
        {
            platilloComanda->setIdPlatillosComanda(value.toInt());
            somethingChanged = true;
        }
    }
        break;
    case idComandaRole:{
        if(platilloComanda->idComanda() != value.toInt()) {
            platilloComanda->setIdComanda(value.toInt());
            somethingChanged = true;
        }
    }
        break;
    case idPlatilloRole:{
        if(platilloComanda->idPlatillo() != value.toInt()) {
            platilloComanda->setIdPlatillo(value.toInt());
            somethingChanged = true;
        }
    }
        break;
    case nombreRole:{
        if(platilloComanda->nombrePlatillo() != value.toString()) {
            platilloComanda->setNombrePlatillo(value.toString());
            somethingChanged = true;
        }
    }
        break;
    case idEstadoPreparacionRole:
    {
        if(platilloComanda->idEstadoPreparacion() != value.toString())
        {
            platilloComanda->setIdEstadoPreparacion(value.toInt());
            somethingChanged = true;
        }
    }
        break;
    }

    if(somethingChanged) {
        emit dataChanged(index, index, QVector<int>() << role);
        return  true;
    }
    else{
        return false;
    }
}

Qt::ItemFlags PlatilloCocinaModelo::flags(const QModelIndex &index) const
{
    if(!index.isValid())
        return Qt::NoItemFlags;
    else
        return Qt::ItemIsEnabled;
}

QHash<int, QByteArray> PlatilloCocinaModelo::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[idPlatillosComandaRole] = "idPlatillosComanda";
    roles[idComandaRole] = "idComanda";
    roles[idPlatilloRole] = "idPlatillo";
    roles[nombreRole] = "nombrePlatillo";
    roles[idEstadoPreparacionRole] = "idEstadoPreparacion";

    return roles;
}

void PlatilloCocinaModelo::addPlatilloCocina(PlatilloCocina *nuevoPlatilloComanda)
{
    const int index = misPlatillosCocina.size();
    beginInsertRows(QModelIndex(), index, index);
    misPlatillosCocina.append(nuevoPlatilloComanda);
    endInsertRows();
}

void PlatilloCocinaModelo::modeloEstado(const int &idEstadoPreparacion)
{
    while(misPlatillosCocina.size() > 0)
    {
        beginRemoveRows(QModelIndex(), 0, 0);
        misPlatillosCocina.removeAt(0);
        endRemoveRows();
    }

    QSqlQuery qryPlatillosComanda;

    qryPlatillosComanda.prepare("SELECT * FROM platilloscomanda "
                                "WHERE idEstadoPreparacion = " + QString::number(idEstadoPreparacion) + "");
    qryPlatillosComanda.exec();

    int idPlatillosComanda;
    int idComanda;
    int idPlatillo;
    QString nombre;

    QList<PlatilloCocina *> platillosDeComanda;

    while(qryPlatillosComanda.next())
    {
        idPlatillosComanda = qryPlatillosComanda.value(0).toInt();
        idComanda = qryPlatillosComanda.value(2).toInt();
        idPlatillo = qryPlatillosComanda.value(1).toInt();

        QSqlQuery qryNombrePlatillo;
        qryNombrePlatillo.prepare("SELECT nombre FROM platillo WHERE idPlatillo = :idPlatillo");
        qryNombrePlatillo.bindValue(":idPlatillo", idPlatillo);
        qryNombrePlatillo.exec();
        qryNombrePlatillo.next();

        nombre = qryNombrePlatillo.value(0).toString();

        PlatilloCocina *nuevoPlatillo = new PlatilloCocina(idPlatillosComanda, idComanda, idPlatillo, nombre, idEstadoPreparacion);
        addPlatilloCocina(nuevoPlatillo);
    }
}

void PlatilloCocinaModelo::modifyStatus(const int &idPlatillosComanda, const int &idNuevoEstado)
{
    QSqlQuery modificar;

    modificar.prepare("UPDATE platilloscomanda SET idEstadoPreparacion = :idEstadoPreparacion "
                      "WHERE idPlatillosComanda = :idPlatillosComanda");
    modificar.bindValue(":idEstadoPreparacion", idNuevoEstado);
    modificar.bindValue(":idPlatillosComanda", idPlatillosComanda);

    if(!modificar.exec())
        qDebug() << modificar.lastError().text();
}

void PlatilloCocinaModelo::platillosMesero(const int &idMesero)
{
    while(misPlatillosCocina.size() > 0)
    {
        beginRemoveRows(QModelIndex(), 0, 0);
        misPlatillosCocina.removeAt(0);
        endRemoveRows();
    }

    QSqlQuery platillosMesero, nombrePlatillo;

    platillosMesero.prepare("SELECT idPlatillosComanda, idPlatillo, idComanda FROM platilloscomanda WHERE "
                            "idComanda IN (SELECT idComanda from comanda WHERE idEmpleado = :idMesero) "
                            "AND idEstadoPreparacion = 3");
    platillosMesero.bindValue(":idMesero", idMesero);
    platillosMesero.exec();

    int idPlatillosComanda;
    int idPlatillo;
    int idComanda;
    QString nombre;

    while(platillosMesero.next())
    {
        idPlatillosComanda = platillosMesero.value(0).toInt();
        idPlatillo = platillosMesero.value(1).toInt();
        idComanda = platillosMesero.value(2).toInt();

        nombrePlatillo.prepare("SELECT nombre FROM platillo WHERE idPlatillo = :idPlatillo");
        nombrePlatillo.bindValue(":idPlatillo", idPlatillo);
        nombrePlatillo.exec();
        nombrePlatillo.first();

        nombre = nombrePlatillo.value(0).toString();

        PlatilloCocina *nuevoPlatillo = new PlatilloCocina(idPlatillosComanda, idComanda, idPlatillo, nombre, 3);
        addPlatilloCocina(nuevoPlatillo);

        qDebug() << "Platillo Mesro 1";
    }
}

QString PlatilloCocinaModelo::tamagnoModelo()
{
    qDebug() << misPlatillosCocina.size();
    return QString::number(misPlatillosCocina.size());
}
