#include "platillocomandamodel.h"

PlatilloComandaModel::PlatilloComandaModel(QObject *parent) : QAbstractListModel(parent)
{
    QSqlQuery qryPlatillosComanda;

    qryPlatillosComanda.prepare("SELECT * FROM platilloscomanda");
    qryPlatillosComanda.exec();

    int idComanda;
    int idPlatillo;
    QString nombre;
    int cantidad;

    qDebug() << "";
    qDebug() << "";
    qDebug() << "Platillos Comanda Leidos: ";

    QList<PlatilloComanda *> platillosDeComanda;

    while(qryPlatillosComanda.next())
    {
        idComanda = qryPlatillosComanda.value(0).toInt();
        idPlatillo = qryPlatillosComanda.value(1).toInt();

        QSqlQuery qryCantidadPlatilloEnComanda;
        qryCantidadPlatilloEnComanda.prepare("SELECT count(idPlatillo) FROM platillosComanda "
                                             "WHERE idComanda = :idComanda and idPlatillo = :idPlatillo");
        qryCantidadPlatilloEnComanda.bindValue(":idComanda", idComanda);
        qryCantidadPlatilloEnComanda.bindValue(":idPlatillo", idPlatillo);
        qryCantidadPlatilloEnComanda.exec();
        qryCantidadPlatilloEnComanda.next();

        cantidad = qryCantidadPlatilloEnComanda.value(0).toInt();

        QSqlQuery qryNombrePlatillo;
        qryNombrePlatillo.prepare("SELECT nombre FROM platillo WHERE idPlatillo = :idPlatillo");
        qryNombrePlatillo.bindValue(":idPlatillo", idPlatillo);
        qryNombrePlatillo.exec();
        qryNombrePlatillo.next();

        nombre = qryNombrePlatillo.value(0).toString();

        QSqlQuery qryPrecioPlatillo;
        qryPrecioPlatillo.prepare("SELECT precio FROM platillo WHERE idPlatillo = :idPlatillo");
        qryPrecioPlatillo.bindValue(":idPlatillo", idPlatillo);
        qryPrecioPlatillo.exec();
        qryPrecioPlatillo.next();

        float precioUnidad = qryPrecioPlatillo.value(0).toFloat();


        PlatilloComanda *nuevoPlatillo = new PlatilloComanda(idComanda, idPlatillo, nombre, cantidad, precioUnidad, precioUnidad);
        addPlatilloComanda(nuevoPlatillo);

        if(misPlatillosComanda.contains(nuevoPlatillo))
            qDebug() << "PLATILLO REPETIDO";
        else
            addPlatilloComanda(nuevoPlatillo);


        qDebug() << "Id Comanda: " << idComanda;
        qDebug() << "Id Platillo: " << idPlatillo;
        qDebug() << "Nombre: " << nombre;
        qDebug() << "Cantidad: " << cantidad;

    }
    qDebug() << "";
    qDebug() << "";
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
    if(role == nombreRole)
        return platilloComanda->nombrePlatillo();
    if(role == cantidadRole)
        return platilloComanda->cantidad();
    if(role == precioUnidadRole)
        return platilloComanda->precioUnidad();
    if(role == totalRole)
        return platilloComanda->totalPlatillo();

    return QVariant();
}

bool PlatilloComandaModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    PlatilloComanda *platilloComanda = misPlatillosComanda[index.row()];
    bool somethingChanged = false;

    switch (role){
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
    case cantidadRole:{
        if(platilloComanda->cantidad() != value.toInt()) {
            platilloComanda->setCantidad(value.toInt());
            somethingChanged = true;
        }
    }
        break;
    case precioUnidadRole:{
        if(platilloComanda->precioUnidad() != value.toInt()) {
            platilloComanda->setPrecioUnidad(value.toInt());
            somethingChanged = true;
        }
    }
        break;
    case totalRole:{
        if(platilloComanda->totalPlatillo() != value.toFloat()){
            platilloComanda->setTotalPlatillo(value.toFloat());
            somethingChanged = true;
        }
    }
    }

    if(somethingChanged) {
        emit dataChanged(index, index, QVector<int>() << role);
        return  true;
    }
    else{
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
    roles[nombreRole] = "nombrePlatillo";
    roles[cantidadRole] = "cantidad";
    roles[precioUnidadRole] = "precioUnidad";
    roles[totalRole] = "totalPlatillo";

    return roles;
}

void PlatilloComandaModel::addPlatilloComanda(PlatilloComanda *nuevoPlatilloComanda)
{
    qDebug() << "->Platillo agregado:" << nuevoPlatilloComanda->nombrePlatillo() << ", cantidad  =" << nuevoPlatilloComanda->cantidad();
    const int index = misPlatillosComanda.size();
    beginInsertRows(QModelIndex(), index, index);
    misPlatillosComanda.append(nuevoPlatilloComanda);
    endInsertRows();
}

bool PlatilloComandaModel::comandaAlreadySent()
{
    if(comandaEnviada)
        return true;
    else
        return false;
}

bool PlatilloComandaModel::saveNewComandaInDataBase()
{
    if(comandaEnviada)
        return false;
    else {
        bool datosInsertados = false;
        qDebug() << "\n-->Guardando platillos en BD ...";
        for (itr = misPlatillosComanda.begin(); itr != misPlatillosComanda.end(); itr++) {
            if(insertPlatilloComandaInDataBase((*itr)) == false)
                return false;
            else{
                datosInsertados = true;
                comandaEnviada = true;
            }
        }
        qDebug() << "";
        return datosInsertados;
    }
}

void PlatilloComandaModel::setIdComanda(const int &nuevoIdComanda)
{
    comandaEnviada = false;
    for (itr = misPlatillosComanda.begin(); itr != misPlatillosComanda.end(); itr++) {
        removePlatillo((*itr)->idPlatillo());
    }

    idComandaActual = nuevoIdComanda;

    QSqlQuery qryPlatillosComanda;
    qryPlatillosComanda.prepare("SELECT * FROM platilloscomanda WHERE idComanda = :idComanda");
    qryPlatillosComanda.bindValue(":idComanda",idComandaActual);
    qryPlatillosComanda.exec();

    while(qryPlatillosComanda.next())
    {
        qDebug() << "\n-->Platillos de la comanda " << nuevoIdComanda;
        int miIdPlatillo = qryPlatillosComanda.value(1).toInt();

        QSqlQuery qryCantidadPlatilloEnComanda;
        qryCantidadPlatilloEnComanda.prepare("SELECT count(idPlatillo) FROM platillosComanda "
                                             "WHERE idComanda = :idComanda and idPlatillo = :idPlatillo");
        qryCantidadPlatilloEnComanda.bindValue(":idComanda",idComandaActual);
        qryCantidadPlatilloEnComanda.bindValue(":idPlatillo", miIdPlatillo);
        qryCantidadPlatilloEnComanda.exec();
        qryCantidadPlatilloEnComanda.next();

        int miCantidad = qryCantidadPlatilloEnComanda.value(0).toInt();

        QString nombre;

        QSqlQuery qryNombrePlatillo;
        qryNombrePlatillo.prepare("SELECT nombre FROM platillo WHERE idPlatillo = :idPlatillo");
        qryNombrePlatillo.bindValue(":idPlatillo", miIdPlatillo);
        qryNombrePlatillo.exec();
        qryNombrePlatillo.next();
        nombre = qryNombrePlatillo.value(0).toString();

        QSqlQuery qryPrecioPlatillo;
        qryPrecioPlatillo.prepare("SELECT precio FROM platillo WHERE idPlatillo = :idPlatillo");
        qryPrecioPlatillo.bindValue(":idPlatillo", miIdPlatillo);
        qryPrecioPlatillo.exec();
        qryPrecioPlatillo.next();

        float precioUnidad = qryPrecioPlatillo.value(0).toFloat();
        float total = precioUnidad*miCantidad;

        bool platilloRepetido = false;
        for (itr = misPlatillosComanda.begin(); itr != misPlatillosComanda.end(); itr++) {
            if((*itr)->idPlatillo() == miIdPlatillo)
                platilloRepetido = true;
        }
        if(!platilloRepetido){
            addPlatilloComanda(new PlatilloComanda(nuevoIdComanda, miIdPlatillo, nombre, miCantidad, precioUnidad, total));
            qDebug() << "Id Platillo: " << miIdPlatillo;
            qDebug() << "Nombre: " << nombre;
            qDebug() << "Cantidad: " << miCantidad;

            comandaEnviada = true; //TODO: Checarlo bien

        }
    }
    qDebug() << "";
    //qDebug() << "";
}

void PlatilloComandaModel::addPlatillo(const int &idComanda, const QString &nombrePlatillo, const int &cantidad)
{
    //QString nombreEnBaseDatos = nombrePlatillo;
    //nombreEnBaseDatos.front()
    nombrePlatillo.front() = nombrePlatillo.front().toUpper();

    QSqlQuery qryIdPlatillo;
    qryIdPlatillo.prepare("SELECT idPlatillo FROM platillo WHERE nombre = :nombrePlatillo");
    qryIdPlatillo.bindValue(":nombrePlatillo", nombrePlatillo);
    qryIdPlatillo.exec();
    qryIdPlatillo.next();
    int idPlatillo = 0;
    idPlatillo = qryIdPlatillo.value(0).toInt();

    //qDebug() << "Id platillo = " << idPlatillo << ", Nombre = " << nombrePlatillo;

    bool platilloEnComanda = false;
    for (itr = misPlatillosComanda.begin(); itr != misPlatillosComanda.end(); itr++) {
        if((*itr)->idPlatillo() == idPlatillo){
            (*itr)->setCantidad( (*itr)->cantidad()+1 );
            platilloEnComanda = true;
        }
    }

    if(platilloEnComanda){
        qDebug() << "->Aumento cantidad el platillo id:"<< idPlatillo << " nombre:" << nombrePlatillo << " --- nueva cantidad = " << cantidad;
        QModelIndex topLeft = createIndex(0,0);
        QModelIndex bottomRight = createIndex(6,misPlatillosComanda.size()); // 6 = numero de atributos de Platillo
        emit dataChanged(topLeft,bottomRight);
    }

    else{
        QSqlQuery qryPrecioPlatillo;
        qryPrecioPlatillo.prepare("SELECT precio FROM platillo WHERE idPlatillo = :idPlatillo");
        qryPrecioPlatillo.bindValue(":idPlatillo", idPlatillo);
        qryPrecioPlatillo.exec();
        qryPrecioPlatillo.next();
        float precioUnidad = 0;
        precioUnidad = qryPrecioPlatillo.value(0).toFloat();
        addPlatilloComanda(new PlatilloComanda(idComanda, idPlatillo, nombrePlatillo, cantidad, precioUnidad, precioUnidad));
    }
}

bool PlatilloComandaModel::removePlatillo(const int idPlatillo)
{
    if(comandaEnviada && !cargandoComanda)
        return false;
    else {
        qDebug() << "\n-->Se quiere removeer platillo!";
        bool platilloEncontrado = false;
        int indice = 0;
        for (itr = misPlatillosComanda.begin(); itr != misPlatillosComanda.end(); itr++) {
            if((*itr)->idPlatillo() == idPlatillo){
                platilloEncontrado = true;
                qDebug() << "-> Platillo removido de comanda: " << (*itr)->idComanda() <<", " << (*itr)->nombrePlatillo();
                break;
            }
            indice++;
        }

        if(platilloEncontrado){
            beginRemoveRows(QModelIndex(),indice,indice);
            misPlatillosComanda.removeAt(indice);
            endRemoveRows();
            return true;
        }
        /*
        else
            qDebug() << "ERROR al remover platillo con id = " << idPlatillo;
        qDebug() << "";
        */
    }
}

void PlatilloComandaModel::setQuantity(const int &idComanda, const int &idPlatillo, const int &cantidad)
{
    qDebug() << "";
    qDebug() << "-->SE QUIERE MODIFICAR UNA CANTIDAD";
    qDebug() << "idComanda = " << idComanda;
    qDebug() << "idPlatillo = " << idPlatillo;
    bool cantidadCambio = false;
    float total = 0;

    for (itr = misPlatillosComanda.begin(); itr != misPlatillosComanda.end(); itr++) {
        if((*itr)->idComanda() == idComanda && (*itr)->idPlatillo() == idPlatillo){
            qDebug() << "nombre = " << (*itr)->nombrePlatillo();
            qDebug() << "cantidad vieja = " << (*itr)->cantidad();
            (*itr)->setCantidad(cantidad);

            total = (*itr)->precioUnidad() *cantidad;
            (*itr)->setTotalPlatillo(total);

            cantidadCambio = true;
        }
    }

    if(cantidadCambio){
        qDebug() << "nueva cantidadd = " << cantidad;
        qDebug() <<"total = " << total;
        QModelIndex topLeft = createIndex(0,0);
        QModelIndex bottomRight = createIndex(6,misPlatillosComanda.size()); // 6 = numero de atributos de Platillo
        emit dataChanged(topLeft,bottomRight);
    }
    qDebug() << "";

}

void PlatilloComandaModel::modeloEstado(const int &idEstadoPreparacion)
{
    while(misPlatillosComanda.size() > 0)
    {
        beginRemoveRows(QModelIndex(), 0, 0);
        misPlatillosComanda.removeAt(0);
        endRemoveRows();
    }

    QSqlQuery qryPlatillosComanda;

    qryPlatillosComanda.prepare("SELECT * FROM platilloscomanda "
                                "WHERE idEstadoPreparacion = " + QString::number(idEstadoPreparacion) + "");
    qryPlatillosComanda.exec();

    int idComanda;
    int idPlatillo;
    QString nombre;
    int cantidad;

    QList<PlatilloComanda *> platillosDeComanda;

    while(qryPlatillosComanda.next())
    {
        idComanda = qryPlatillosComanda.value(0).toInt();
        idPlatillo = qryPlatillosComanda.value(1).toInt();

        QSqlQuery qryCantidadPlatilloEnComanda;
        qryCantidadPlatilloEnComanda.prepare("SELECT count(idPlatillo) FROM platillosComanda "
                                             "WHERE idComanda = :idComanda AND idPlatillo = :idPlatillo "
                                             "AND idEstadoPreparacion = :idEstadoPreparacion");
        qryCantidadPlatilloEnComanda.bindValue(":idComanda", idComanda);
        qryCantidadPlatilloEnComanda.bindValue(":idPlatillo", idPlatillo);
        qryCantidadPlatilloEnComanda.bindValue(":idEstadoPreparacion", idEstadoPreparacion);
        qryCantidadPlatilloEnComanda.exec();
        qryCantidadPlatilloEnComanda.next();

        cantidad = qryCantidadPlatilloEnComanda.value(0).toInt();

        QSqlQuery qryNombrePlatillo;
        qryNombrePlatillo.prepare("SELECT nombre FROM platillo WHERE idPlatillo = :idPlatillo");
        qryNombrePlatillo.bindValue(":idPlatillo", idPlatillo);
        qryNombrePlatillo.exec();
        qryNombrePlatillo.next();

        nombre = qryNombrePlatillo.value(0).toString();

        QSqlQuery qryPrecioPlatillo;
        qryPrecioPlatillo.prepare("SELECT precio FROM platillo WHERE idPlatillo = :idPlatillo");
        qryPrecioPlatillo.bindValue(":idPlatillo", idPlatillo);
        qryPrecioPlatillo.exec();
        qryPrecioPlatillo.next();

        float precioUnidad = qryPrecioPlatillo.value(0).toFloat();

        PlatilloComanda *nuevoPlatillo = new PlatilloComanda(idComanda, idPlatillo, nombre, cantidad, precioUnidad, precioUnidad);
        addPlatilloComanda(nuevoPlatillo);

        if(misPlatillosComanda.contains(nuevoPlatillo))
            qDebug() << "PLATILLO REPETIDO";
        else
            addPlatilloComanda(nuevoPlatillo);


        qDebug() << "Id Comanda: " << idComanda;
        qDebug() << "Id Platillo: " << idPlatillo;
        qDebug() << "Nombre: " << nombre;
        qDebug() << "Cantidad: " << cantidad;

    }
    qDebug() << "";
    qDebug() << "";
}

void PlatilloComandaModel::modifyStatus(const int &idComanda, const int &idPlatillo, const int &idNuevoEstado)
{
    QSqlQuery modificar;

    modificar.prepare("UPDATE platilloscomanda SET idEstadoPreparacion = :idEstadoPreparacion "
                      "WHERE idComanda = :idComanda AND idPlatillo = :idPlatillo");
    modificar.bindValue(":idEstadoPreparacion", idNuevoEstado);
    modificar.bindValue(":idPlatillo", idPlatillo);
    modificar.bindValue(":idComanda", idComanda);

    if(!modificar.exec())
        qDebug() << modificar.lastError().text();
}

bool PlatilloComandaModel::insertPlatilloComandaInDataBase(PlatilloComanda *platilloComandaToSave)
{
    bool dataSaved = false;

    QSqlQuery insertar;

    insertar.prepare("INSERT INTO platillosComanda(idComanda, idPlatillo, idEstadoPreparacion) "
                     "VALUES(:idComanda, :idPlatillo, 1)");
    insertar.bindValue(":idComanda", platilloComandaToSave->idComanda());
    insertar.bindValue(":idPlatillo", platilloComandaToSave->idPlatillo());
    insertar.exec();

    if(insertar.numRowsAffected() > 0){
        dataSaved = true;
        qDebug() << "Platillo: "<< platilloComandaToSave->idPlatillo() << " - " << platilloComandaToSave->nombrePlatillo() << " INSERTADO EN DB";
    }
    else
        qDebug() << "Error al guardar platillo: "<< platilloComandaToSave->idPlatillo() << " - " << platilloComandaToSave->nombrePlatillo();

    return dataSaved;
}
