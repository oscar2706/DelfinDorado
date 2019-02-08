#include "empleadomodelo.h"
#include "empleadolista.h"

EmpleadoModelo::EmpleadoModelo(QObject *parent)
    : QAbstractListModel(parent), mList(nullptr)
{
}

int EmpleadoModelo::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid() || !mList)
        return 0;

    return mList->items().size();
}

QVariant EmpleadoModelo::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || !mList)
        return QVariant();

    const ToDoItem item = mList->items().at(index.row());

    switch (role)
    {
    case idRole:
        return QVariant(item.idEmpleado);
    case nombreRole:
        return QVariant(item.nombreEmpleado);
    case apellidoPaternoRole:
        return QVariant(item.apellidoPaterno);
    case apellidoMaternoRole:
        return QVariant(item.apellidoMaterno);
    case rfcRole:
        return QVariant(item.rfc);
    case seguroSocialRole:
        return QVariant(item.seguroSocial);
    case fechaNacimientoRole:
        return QVariant(item.fechaNacimiento);
    case sueldoRole:
        return QVariant(item.sueldo);
    case fotoRole:
        return QVariant(item.foto);
    case telefonoRole:
        return QVariant(item.telefono);
    case puestoRole:
        return QVariant(item.puestoEmpleado);
    case sexoRole:
        return QVariant(item.sexo);
    case usuarioRole:
        return QVariant(item.usuario);
    case contrasegnaRole:
        return QVariant(item.contrasegna);
    case eleccionRole:
        return QVariant(item.eleccionEmpleado);
    }

    return QVariant();
}

bool EmpleadoModelo::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if(!mList)
    {
        return false;
    }

    ToDoItem item = mList->items().at(index.row());

    switch (role)
    {
    case idRole:
        item.idEmpleado = value.toString();
        break;
    case nombreRole:
        item.nombreEmpleado = value.toString();
        break;
    case apellidoPaternoRole:
        item.apellidoPaterno = value.toString();
        break;
    case apellidoMaternoRole:
        item.apellidoMaterno = value.toString();
        break;
    case rfcRole:
        item.rfc = value.toString();
        break;
    case seguroSocialRole:
        item.seguroSocial = value.toString();
        break;
    case fechaNacimientoRole:
        item.fechaNacimiento = value.toString();
        break;
    case sueldoRole:
        item.sueldo = value.toString();
        break;
    case fotoRole:
        item.foto = value.toString();
        break;
    case telefonoRole:
        item.telefono = value.toString();
        break;
    case puestoRole:
        item.puestoEmpleado = value.toString();
        break;
    case sexoRole:
        item.sexo = value.toString();
        break;
    case usuarioRole:
        item.usuario = value.toString();
        break;
    case contrasegnaRole:
        item.contrasegna = value.toString();
        break;
    case eleccionRole:
        item.eleccionEmpleado = value.toBool();
        break;
    }

    if (mList->setItemAt(index.row(), item)) {
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags EmpleadoModelo::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable;
}

QHash<int, QByteArray> EmpleadoModelo::roleNames() const
{
    QHash<int, QByteArray> names;
    names[idRole] = "idEmpleado";
    names[nombreRole] = "nombreEmpleado";
    names[apellidoPaternoRole] = "apellidoPaterno";
    names[apellidoMaternoRole] = "apellidoMaterno";
    names[rfcRole] = "rfc";
    names[seguroSocialRole] = "seguroSocial";
    names[fechaNacimientoRole] = "fechaNacimiento";
    names[sueldoRole] = "sueldo";
    names[fotoRole] = "foto";
    names[telefonoRole] = "telefono";
    names[puestoRole] = "puestoEmpleado";
    names[sexoRole] = "sexo";
    names[usuarioRole] = "usuario";
    names[contrasegnaRole] = "contrasegna";
    names[eleccionRole] = "eleccionEmpleado";

    return names;
}

EmpleadoLista *EmpleadoModelo::list() const
{
    return mList;
}

void EmpleadoModelo::setList(EmpleadoLista *list)
{
    beginResetModel();

    if(mList)
    {
        mList->disconnect(this);
    }

    mList = list;

    if(mList)
    {
        connect(mList, &EmpleadoLista::preItemAppended, this, [=]()
        {
            const int indice = mList->items().size();

            beginInsertRows(QModelIndex(), indice, indice);
        });

        connect(mList, &EmpleadoLista::postItemAppended, this, [=]()
        {
            endInsertRows();
        });

        connect(mList, &EmpleadoLista::preItemRemoved, this, [=](int indice)
        {
            beginRemoveRows(QModelIndex(), indice, indice);
        });

        connect(mList, &EmpleadoLista::postItemRemoved, this, [=]()
        {
            endRemoveRows();
        });
    }

    endResetModel();
}

