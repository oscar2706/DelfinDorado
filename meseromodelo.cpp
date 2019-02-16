#include "meseromodelo.h"
#include "meserolista.h"

meseroModelo::meseroModelo(QObject *parent)
    : QAbstractListModel(parent),mList(nullptr)
{
}

int meseroModelo::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid() || !mList)
        return 0;

    return mList->items().size();
}

QVariant meseroModelo::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || !mList)
        return QVariant();

    const meseroItem item = mList->items().at(index.row());
    switch (role) {
     case IdRole:{return QVariant(item.id);}
     case NombreRole:{return QVariant(item.nombre);}
     case SeleccionRole:{return QVariant(item.seleccion);}

    }
    return QVariant();
}

bool meseroModelo::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if(!mList)
        return false;
    meseroItem item = mList->items().at(index.row());

    switch (role) {
     case IdRole:{ item.id = value.toString(); }break;
     case NombreRole:{ item.nombre = value.toString(); }break;
     case SeleccionRole:{ item.seleccion = value.toBool(); }break;
    }

    if (mList->setItemAt(index.row(),item)) {
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags meseroModelo::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable;
}
QHash<int, QByteArray> meseroModelo::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[NombreRole] = "nombre";
    roles[SeleccionRole]="seleccion";
    return roles;
}

meseroLista *meseroModelo::list()
{
    return mList;
}

void meseroModelo::setList(meseroLista *list)
{
    beginResetModel();
    if(mList)
        mList->disconnect(this);
    mList = list;

    if(mList){
        connect(mList,&meseroLista::preItemAppend,this,[=](){
            const int index = mList->items().size();
            beginInsertRows(QModelIndex(),index,index);
        });
        connect(mList,&meseroLista::preItemAppend,this,[=](){
            endInsertRows();
        });

        connect(mList,&meseroLista::postItemUpdate,this,[=](){
            layoutChanged ();
        });
    }
    endResetModel();
}
