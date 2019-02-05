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
    case puestoRole:
        return QVariant(item.puestoEmpleado);
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
    case puestoRole:
        item.puestoEmpleado = value.toString();
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
    names[puestoRole] = "puestoEmpleado";
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

