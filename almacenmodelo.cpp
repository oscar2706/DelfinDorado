#include "almacenmodelo.h"

almacenModelo::almacenModelo(QObject *parent)
    : QAbstractTableModel(parent)
{
    QSqlQuery *select = new QSqlQuery();
    if(select->exec("SELECT idProducto,producto.nombre,descripcion,cantidad,costo,categoria.nombre,"
                    "unidadmedida.nombre  "
                   "FROM producto INNER JOIN categoria ON producto.idCategoria = categoria.idCategoria "
                   "INNER JOIN  unidadmedida ON producto.idunidadmedida = unidadmedida.idunidadmedida "
                   "ORDER BY idProducto"))
    {
        while (select->next())
            m_producto.append(new almacenProducto(select->value(0).toInt(),select->value(1).toString(),
                                                  select->value(2).toString(),select->value(3).toInt(),
                                                  select->value(4).toFloat(),select->value(5).toString(),
                                                  select->value(6).toString()));
    }
    else
        qDebug()<<select->lastError().text();

    delete  select;
}

int almacenModelo::rowCount(const QModelIndex &parent) const
{
    (void) parent;
    return m_producto.size();
}

int almacenModelo::columnCount(const QModelIndex &parent) const
{
    (void) parent;
    return roleNames().size();
}

QVariant almacenModelo::data(const QModelIndex &index, int role) const
{
    QVariant variant;
    const int row = index.row();

    switch (role)
    {
      case IdProducto:variant = m_producto.at(row)->getIdProducto();break;
      case Nombre:variant = m_producto.at(row)->getNombre();break;
      case Descripcion:variant = m_producto.at(row)->getDescripcion();break;
      case Cantidad:variant = m_producto.at(row)->getCantidad();break;
      case Costo:variant = m_producto.at(row)->getCosto();break;
      case Categoria:variant = m_producto.at(row)->getCategoria();break;
      case UnidadMedida:variant = m_producto.at(row)->getMedida();break;
    }

    return variant;
}

Qt::ItemFlags almacenModelo::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

QStringList almacenModelo::getInfoContenido(int opc)
{
    QStringList namesModel;
    QSqlQuery *select = new QSqlQuery();
    switch (opc) {
        case 1:
        {
            if(select->exec("SELECT nombre FROM categoria"))
                while (select->next())
                    namesModel.append(select->value(0).toString());
        }break;
        case 2:
        {
            if(select->exec("SELECT nombre FROM unidadMedida"))
                while (select->next())
                    namesModel.append(select->value(0).toString());
        }break;
        case 3:
        {
            if(select->exec("SELECT nombre FROM producto"))
                while (select->next())
                    namesModel.append(select->value(0).toString());
        }break;
    }
    delete select;
    namesModel.sort();
    return namesModel;
}

bool almacenModelo::setProductoAlmacen(QString nombre,QString descripcion,QString costo,
                                       QString categoria,QString medida)
{
    QSqlQuery *consulta = new QSqlQuery();
    int idProducto=0,idCategoria=0,idMedida=0;

    consulta->exec("SELECT idCategoria FROM categoria WHERE nombre = '"+ categoria +"'");
    if(consulta->next())
        idCategoria = consulta->value(0).toInt();


    consulta->exec("SELECT idUnidadMedida FROM unidadMedida WHERE nombre = '"+ medida +"'");
    if(consulta->next())
        idMedida = consulta->value(0).toInt();

    if(consulta->exec("INSERT INTO producto(nombre,descripcion,cantidad,costo,idCategoria,idUnidadMedida) "
                      "VALUES('"+nombre+"','"+descripcion+"','0','"+costo+"',"
                      "'"+QString::number(idCategoria)+"','"+QString::number(idMedida)+"')"))
    {
        consulta->exec("SELECT MAX(idProducto) FROM producto");
        if(consulta->next())
               idProducto=consulta->value(0).toInt();

        const int index = m_producto.size();
        beginInsertRows(QModelIndex(),index,index);
        m_producto.append(new almacenProducto(idProducto,nombre,descripcion,0,costo.toFloat(),
                          categoria,medida));
        endInsertRows();
        return true;
    }
    else
    {
        return false;
    }
}

QString almacenModelo::getInfoProd(QString busq,int opc)
{
    for (itr = m_producto.begin(); itr != m_producto.end(); itr++)
    {
        if((*itr)->getNombre() == busq)
        {
            if(opc==1)
                return QString::number((*itr)->getCantidad());
            else
                return (*itr)->getMedida();
        }
    }
    return "0";
}

bool almacenModelo::verificarCantidad(QString existente, QString retiro)
{
    if(retiro.toInt()<=existente.toInt())
        return true;
    else
        return false;
}

void almacenModelo::actualizarCantidad(QString existente, QString retiro, QString busqProd)
{
    int nuevaCantidad = existente.toInt() - retiro.toInt();
    QSqlQuery *update = new QSqlQuery();
    if(update->exec("UPDATE producto SET cantidad = '"+QString::number(nuevaCantidad)+"' "
                    "WHERE nombre = '"+busqProd+"'"))
    {
        for (itr = m_producto.begin(); itr != m_producto.end(); itr++)
        {
            if((*itr)->getNombre() == busqProd)
            {
                (*itr)->setCantidad(nuevaCantidad);
                layoutChanged ();
            }
        }
    }
    else
        qDebug()<<update->lastError().text();

}

QHash<int, QByteArray> almacenModelo::roleNames() const
{
    QHash<int,QByteArray> roles;

    roles[IdProducto] = "id";
    roles[Nombre] = "nombre";
    roles[Descripcion] = "descripcion";
    roles[Cantidad] = "cantidad";
    roles[Costo] = "costo";
    roles[Categoria] = "categoria";
    roles[UnidadMedida] = "unidad";

    return roles;
}
