#include "pedidoproductosmodelo.h"

PedidoProductosModelo::PedidoProductosModelo(QObject *parent) : QAbstractListModel (parent)
{
    int idPedido;
    int idProducto;
    QString nombre;
    int cantidad;
    int idUnidadMedida;
    QString unidadMedida;
    float costo;
    float totalProducto;

    QSqlQuery qryPedidoProductos, qryProducto, qryUnidadMedida;

    qryPedidoProductos.prepare("SELECT * from pedidoproductos");
    qryPedidoProductos.exec();

    while(qryPedidoProductos.next())
    {
        idPedido = qryPedidoProductos.value(0).toInt();
        idProducto = qryPedidoProductos.value(1).toInt();
        cantidad = qryPedidoProductos.value(2).toInt();

        qryProducto.prepare("SELECT nombre, idUnidadMedida, costo FROM producto "
                            "WHERE idProducto = :idProducto");
        qryProducto.bindValue(":idProducto", idProducto);
        qryProducto.exec();
        qryProducto.next();

        nombre = qryProducto.value(0).toString();
        idUnidadMedida = qryProducto.value(1).toInt();
        costo = qryProducto.value(2).toFloat();
        totalProducto = costo * cantidad;

        qryUnidadMedida.prepare("SELECT nombre FROM unidadmedida "
                                "WHERE idUnidadMedida = :idUnidadMedida");
        qryUnidadMedida.bindValue(":idUnidadMedida", idUnidadMedida);
        qryUnidadMedida.exec();
        qryUnidadMedida.next();

        unidadMedida = qryUnidadMedida.value(0).toString();

        PedidoProductos *nuevoPedidoProductos = new PedidoProductos(idPedido, idProducto, nombre, cantidad, unidadMedida, costo, totalProducto);

        addPedidoProductos(nuevoPedidoProductos);

        if(misPedidoProductos.contains(nuevoPedidoProductos))
            qDebug() << "Producto Repetido";
        else {
            addPedidoProductos(nuevoPedidoProductos);
        }
    }
}

int PedidoProductosModelo::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return misPedidoProductos.size();
}

QVariant PedidoProductosModelo::data(const QModelIndex &index, int role) const
{
    if(index.row() < 0 || index.row() >= misPedidoProductos.count())
        return QVariant();

    PedidoProductos* pedidoProductos = misPedidoProductos[index.row()];

    if(role == idPedidoRole)
        return pedidoProductos->idPedido();
    if(role == idProductoRole)
        return pedidoProductos->idProducto();
    if(role == nombreRole)
        return pedidoProductos->nombre();
    if(role == cantidadRole)
        return pedidoProductos->cantidad();
    if(role == unidadMedidaRole)
        return pedidoProductos->unidadMedida();
    if(role == costoRole)
        return pedidoProductos->costo();
    if(role == totalProductoRole)
        return pedidoProductos->totalProducto();

    return QVariant();
}

bool PedidoProductosModelo::setData(const QModelIndex &index, const QVariant &value, int role)
{
    PedidoProductos *pedidoProductos = misPedidoProductos[index.row()];
    bool somethingChanged = false;

    switch (role){
    case idPedidoRole: {
        if(pedidoProductos->idPedido() != value.toInt()) {
            pedidoProductos->setIdPedido(value.toInt());
            somethingChanged = true;
        }
    }
        break;
    case idProductoRole: {
        if(pedidoProductos->idProducto() != value.toInt()) {
            pedidoProductos->setIdProducto(value.toInt());
            somethingChanged = true;
        }
    }
        break;
    case nombreRole: {
        if(pedidoProductos->nombre() != value.toString()) {
            pedidoProductos->setNombre(value.toString());
            somethingChanged = true;
        }
    }
        break;
    case cantidadRole: {
        if(pedidoProductos->cantidad() != value.toInt()) {
            pedidoProductos->setCantidad(value.toInt());
            somethingChanged = true;
        }
    }
        break;
    case unidadMedidaRole: {
        if(pedidoProductos->unidadMedida() != value.toString()) {
            pedidoProductos->setUnidadMedida(value.toString());
            somethingChanged = true;
        }
    }
        break;
    case costoRole: {
        if(pedidoProductos->costo() != value.toFloat()) {
            pedidoProductos->setCosto(value.toFloat());
            somethingChanged = true;
        }
    }
        break;
    case totalProductoRole: {
        if(pedidoProductos->totalProducto() != value.toFloat()) {
            pedidoProductos->setTotalProducto(value.toFloat());
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

Qt::ItemFlags PedidoProductosModelo::flags(const QModelIndex &index) const
{
    if(!index.isValid())
        return Qt::NoItemFlags;
    else
        return Qt::ItemIsEnabled;
}

QHash<int, QByteArray> PedidoProductosModelo::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[idPedidoRole] = "idPedido";
    roles[idProductoRole] = "idProducto";
    roles[nombreRole] = "nombre";
    roles[cantidadRole] = "cantidad";
    roles[unidadMedidaRole] = "unidadMedida";
    roles[costoRole] = "costo";
    roles[totalProductoRole] = "totalProducto";

    return roles;
}

void PedidoProductosModelo::addPedidoProductos(PedidoProductos *nuevoPedidoProductos)
{
    const int index = misPedidoProductos.size();

    beginInsertRows(QModelIndex(), index, index);
    misPedidoProductos.append(nuevoPedidoProductos);
    endInsertRows();
}

void PedidoProductosModelo::addPedidoProductos(const int &idPedido, const QString &nombre, const int &cantidad)
{
    nombre.front() = nombre.front().toUpper();

    int idProducto;
    float costo;
    int idUnidadMedida;
    float totalProducto;
    QString unidadMedida;
    QSqlQuery qryProducto, qryUnidadMedida;

    qryProducto.prepare("SELECT idProducto, costo, idUnidadMedida FROM producto "
                        "WHERE nombre = :nombre");
    qryProducto.bindValue(":nombre", nombre);
    qryProducto.exec();
    qryProducto.next();

    idProducto = qryProducto.value(0).toInt();
    costo = qryProducto.value(1).toFloat();
    idUnidadMedida = qryProducto.value(2).toInt();
    totalProducto = costo * cantidad;

    qryUnidadMedida.prepare("SELECT nombre FROM unidadmedida "
                            "WHERE idUnidadMedida = :idUnidadMedida");
    qryUnidadMedida.bindValue(":idUnidadMedida", idUnidadMedida);
    qryUnidadMedida.exec();
    qryUnidadMedida.next();

    unidadMedida = qryUnidadMedida.value(0).toString();

    bool pedidoProductos = false;

    for(itr = misPedidoProductos.begin(); itr != misPedidoProductos.end(); itr++)
    {
        if((*itr)->idProducto() == idProducto)
        {
            (*itr)->setCantidad((*itr)->cantidad() + cantidad);
            (*itr)->setTotalProducto(costo * (*itr)->cantidad());
            pedidoProductos = true;
        }
    }

    if(pedidoProductos)
    {
        QModelIndex topLeft = createIndex(0,0);
        QModelIndex bottomRight = createIndex(7, misPedidoProductos.size());
        emit dataChanged(topLeft, bottomRight);
    }
    else {
        addPedidoProductos(new PedidoProductos(idPedido, idProducto, nombre, cantidad, unidadMedida, costo, totalProducto));
    }
}

bool PedidoProductosModelo::saveNewPedidoInDataBase(int idPedido)
{
    qDebug() << "Pedido a registrar para los productos: " << idPedido;
    bool datosInsertados = false;

    for(itr = misPedidoProductos.begin(); itr != misPedidoProductos.end(); itr++)
    {
        (*itr)->setIdPedido(idPedido);

        if(insertPedidoProductosInDataBase((*itr)) == false)
            return false;
        else {
            datosInsertados = true;
        }
    }

    return datosInsertados;
}

bool PedidoProductosModelo::removeProducto(const int idProducto)
{
    bool productoEncontrado = false;
    int indice = 0;

    for(itr = misPedidoProductos.begin(); itr != misPedidoProductos.end(); itr++)
    {
        if((*itr)->idProducto() == idProducto)
        {
            productoEncontrado = true;
        }
        indice++;
    }

    if(productoEncontrado)
    {
        beginRemoveRows(QModelIndex(), indice, indice);
        misPedidoProductos.removeAt(indice);
        endRemoveRows();
        return true;
    }
    else {
        return false;
    }
}

void PedidoProductosModelo::setCantidad(const int &idPedido, const int &idProducto, const int &cantidad)
{
    bool cantidadCambio = false;
    float total = 0;

    for(itr = misPedidoProductos.begin(); itr != misPedidoProductos.end(); itr++)
    {
        if((*itr)->idPedido() == idPedido && (*itr)->idProducto() == idProducto)
        {
            (*itr)->setCantidad(cantidad);

            total = (*itr)->costo() * cantidad;
            (*itr)->setTotalProducto(total);

            cantidadCambio = true;
        }
    }

    if(cantidadCambio)
    {
        QModelIndex topLeft = createIndex(0,0);
        QModelIndex bottomRight = createIndex(7, misPedidoProductos.size());
        emit dataChanged(topLeft, bottomRight);
    }
}

void PedidoProductosModelo::clearModel()
{
    while (misPedidoProductos.size() > 0) {
        beginRemoveRows(QModelIndex(), 0, 0);
        misPedidoProductos.removeAt(0);
        endRemoveRows();
    }
}

float PedidoProductosModelo::getTotalPedido()
{
    totalPedido = 0;

    for(itr = misPedidoProductos.begin(); itr != misPedidoProductos.end(); itr++)
    {
        totalPedido += (*itr)->totalProducto();
    }

    return totalPedido;
}

float PedidoProductosModelo::getTotalProducto(const QString &nombre, const int &cantidad)
{
    QSqlQuery buscarCosto;

    qDebug() << "Entra en la funcion: " << nombre << " y " << cantidad;
    buscarCosto.prepare("SELECT costo FROM producto WHERE nombre = :nombre");
    buscarCosto.bindValue(":nombre", nombre);
    if(buscarCosto.exec())
    {
        buscarCosto.next();
        qDebug() << "Llega hasta el final: " << buscarCosto.value(0).toFloat();

        return buscarCosto.value(0).toFloat() * cantidad;
    }
    else {
        qDebug() << "Error del primer query: " << buscarCosto.lastError().text();
        return 0;
    }
}

QString PedidoProductosModelo::getUnidadMedida(const QString &nombre)
{
    qDebug() << "Entra en la función unidad de medida: " << nombre;
    QSqlQuery buscarId, obtenerNombre;

    buscarId.prepare("SELECT idUnidadMedida FROM producto WHERE nombre = :nombre");
    buscarId.bindValue(":nombre", nombre);
    if(buscarId.exec())
    {
        buscarId.next();

        obtenerNombre.prepare("SELECT nombre FROM unidadMedida WHERE idUnidadMedida = :idUnidadMedida");
        obtenerNombre.bindValue(":idUnidadMedida", buscarId.value(0).toInt());
        if(obtenerNombre.exec())
        {
            obtenerNombre.next();
            qDebug() << "Llega hasta el final unidad de medida: " << obtenerNombre.value(0).toString();

            return obtenerNombre.value(0).toString();
        }
        else {
            qDebug() << "Error segundo query: " << obtenerNombre.lastError().text();
            return "";
        }
    }
    else {
        qDebug() << "Error del primer query: " << buscarId.lastError().text();
        return "";
    }
}

bool PedidoProductosModelo::insertPedidoProductosInDataBase(PedidoProductos *pedidoProductosToSave)
{
    bool dataSaved = false;
    int cantidadAntigua, cantidadNueva;

    QSqlQuery insertar, cantidad, actualizar;

    insertar.prepare("INSERT INTO pedidoproductos(idPedido, idProducto, cantidad) "
                     "VALUES(:idPedido, :idProducto, :cantidad)");
    insertar.bindValue(":idPedido", pedidoProductosToSave->idPedido());
    insertar.bindValue(":idProducto", pedidoProductosToSave->idProducto());
    insertar.bindValue(":cantidad", pedidoProductosToSave->cantidad());

    if(insertar.exec()) {
        cantidad.prepare("SELECT cantidad FROM producto WHERE idProducto = :idProducto");
        cantidad.bindValue(":idProducto", pedidoProductosToSave->idProducto());
        cantidad.exec();
        cantidad.next();

        cantidadAntigua = cantidad.value(0).toInt();
        cantidadNueva = cantidadAntigua + pedidoProductosToSave->cantidad();

        qDebug() << "Id: " + QString::number(pedidoProductosToSave->idProducto()) +
                    " CA: " + QString::number(cantidadAntigua) + " CN: " + QString::number(cantidadNueva);

        actualizar.prepare("UPDATE producto SET cantidad = :cantidadNueva WHERE idProducto = :idProducto");
        actualizar.bindValue(":cantidadNueva", cantidadNueva);
        actualizar.bindValue(":idProducto", pedidoProductosToSave->idProducto());
        if(!actualizar.exec())
            qDebug() << "Error en la actualizacion: " << actualizar.lastError().text();
        dataSaved = true;
    }
    else {
        qDebug() << "Error durante la insercion: " << insertar.lastError().text();
    }

    return dataSaved;
}
