#include "mesamodelo.h"

mesaModelo::mesaModelo(QObject *parent)
    : QAbstractListModel(parent)
{
    QSqlQuery *select = new QSqlQuery();
    QString imagenMesa;
    int ancho=0;
    if(select->exec("SELECT * FROM mesa ORDER BY idMesa"))
    {
        while (select->next())
        {
            if(select->value(1).toInt()==6)
                ancho=90;
            else
                ancho=130;

            imagenMesa=getImagenMesa(select->value(2).toInt(),select->value(1).toInt());

            m_mesa.append(new mesa(select->value(0).toInt(),select->value(2).toInt(),90,ancho,
                                   select->value(1).toInt(),imagenMesa));
        }
    }
}

int mesaModelo::rowCount(const QModelIndex &parent) const
{
    (void) parent;
    return m_mesa.size();
}

QVariant mesaModelo::data(const QModelIndex &index, int role) const
{
    QVariant variant;
    const int row = index.row();

    switch (role)
    {
      case IdMesa:variant = m_mesa.at(row)->getIdMesa();break;
      case Estado:variant = m_mesa.at(row)->getEstado();break;
      case Height:variant = m_mesa.at(row)->getHeight();break;
      case Width:variant = m_mesa.at(row)->getWidth();break;
      case Capacidad:variant = m_mesa.at(row)->getCapacidad();break;
      case Img:variant = m_mesa.at(row)->getImg();break;
    }

    return variant;
}

bool mesaModelo::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {
        // FIXME: Implement me!
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags mesaModelo::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

QHash<int, QByteArray> mesaModelo::roleNames() const
{
    QHash<int,QByteArray> roles;

    roles[IdMesa] = "idMesa";
    roles[Estado] = "estado";
    roles[Width] = "ancho";
    roles[Height] = "alto";
    roles[Capacidad] = "capacidad";
    roles[Img] = "imgMesa";

    return roles;
}

void mesaModelo::setEstadoMesa(int idMesaBusq,int estado)
{
    for (itr = m_mesa.begin(); itr != m_mesa.end(); itr++)
    {
        if((*itr)->getIdMesa() == idMesaBusq)
        {
            QSqlQuery update;
            if(update.exec("UPDATE mesa SET idEstadoMesa='"+QString::number(estado)+"' "
                           "WHERE idMesa ='"+QString::number(idMesaBusq)+"'"))
            {
                (*itr)->setEstado(estado);
                (*itr)->setImg(getImagenMesa(estado, (*itr)->getCapacidad()));
                layoutChanged();
            }
            return;
        }
    }
}

QString mesaModelo::getImagenMesa(int opcEstado, int capacidad)
{
    QString imagenMesa;
    switch (opcEstado) {
        case 1:{
           if(capacidad==6)
               return imagenMesa = "img/MesaChica_Disponible.png";
           else
               return imagenMesa = "img/MesaGrandeDisponible.png";
        }
        case 2:{
            if(capacidad==6)
                return imagenMesa = "img/MesaChica_Ocupada.png";
            else
                return imagenMesa = "img/MesaGrande_Ocupada.png";
        }
        case 3:{
            if(capacidad==6)
                return imagenMesa = "img/MesaChica_Sucia.png";
            else
                return imagenMesa = "img/MesaGrande_Sucia.png";
        }
    }
    return "";
}

