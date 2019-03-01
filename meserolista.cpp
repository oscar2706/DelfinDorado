#include "meserolista.h"
#include <QDebug>

meseroLista::meseroLista(QObject *parent) : QObject(parent)
{
    QSqlQuery select;

    select.prepare("SELECT idEmpleado,nombre FROM empleado WHERE idPuesto = 3");
    select.exec();

    while(select.next())
    {
         meseroItem empleado;
         empleado.id = select.value(0).toString();
         empleado.nombre = select.value(1).toString();
         empleado.seleccion = false;
         mItems.append(empleado);
    }
}

QVector<meseroItem> meseroLista::items() const
{
    return mItems;
}

bool meseroLista::setItemAt(int index, const meseroItem &item)
{
    if(index < 0 || index >= mItems.size())
        return false;
    const meseroItem &oldItem = mItems.at(index);
    if(item.seleccion == oldItem.seleccion && item.seleccion == oldItem.seleccion)
        return false;
     mItems[index] = item;
     return true;
}

void meseroLista::setComanda(QString mesa)
{
    for(int i= 0; i<mItems.size();i++)
        if(mItems.at(i).seleccion)
        {
            QSqlQuery insert;

            insert.prepare("INSERT INTO comanda(fecha,idEmpleado,idMesa,idEstadoComanda) "
                               "Values(:fecha,:idEmpleado,:idMesa,:idEstadoComanda)");
            insert.bindValue(":fecha",QDate::currentDate());
            insert.bindValue(":idEmpleado",mItems.at(i).id);
            insert.bindValue(":idMesa",mesa);
            insert.bindValue(":idEstadoComanda",1);
            if(!insert.exec())
                 qDebug()<<"ERROR INSERCION COMANDA:"<<insert.lastError().text();
        }
}

bool meseroLista::verificaCampoVacio()
{
    for(int i= 0; i<mItems.size();i++){
        if(mItems.at(i).seleccion){
            return false;
        }
    }
    return true;
}

int meseroLista::verificaEstadoMesa(int idMesa)
{
    QSqlQuery select;

    select.exec("SELECT idEstadoMesa FROM mesa WHERE idMesa = '"+QString::number(idMesa)+"'");

    if(select.next())
        return select.value(0).toInt();

    return 0;
}

QString meseroLista::getMeseroAsignado(int idMesa)
{
    QSqlQuery select;

    select.exec("SELECT empleado.idEmpleado,nombre FROM comanda INNER JOIN empleado ON "
                "comanda.idEmpleado=empleado.idEmpleado "
                "WHERE idMesa = '"+QString::number(idMesa)+"'");

    if(select.next())
        return "Mesa # "+QString::number(idMesa)+"\nAtendiendo: "+select.value(1).toString();

    return "";
}

QString meseroLista::getTipoUsuario(QString tipo)
{
    QSqlQuery select;

    select.exec("SELECT cargo FROM puesto WHERE idPuesto = '"+tipo+"'");

    if(select.next())
        return select.value(0).toString();

    return "";
}

void meseroLista::setEstadoDisponible(QString idMesa)
{
    QSqlQuery update;
    if(!update.exec("UPDATE mesa SET idEstadoMesa=1 WHERE idMesa ='"+idMesa+"'"))
        qDebug()<<"ERROR CAMBIO DE ESTADO MESA: "+update.lastError().text();
}

void meseroLista::restablecerRadioButton()
{
    meseroItem item;
    for(int i= 0; i<mItems.size();i++)
    {
        item = mItems.value(i);
        item.seleccion = false;
        mItems.replace(i,item);
    }
}

void meseroLista::appendItem()
{
    emit preItemAppend();

    meseroItem item;
    mItems.append(item);

    emit postItemAppend();
}

void meseroLista::updateItem(int opc)
{
    if(opc==1)
    {
        for(int i= 0; i<mItems.size();i++){
            if(mItems.at(i).seleccion){
                meseroItem item;
                item.id = mItems.value(i).id;
                item.nombre = mItems.value(i).nombre;
                item.seleccion = false;
                mItems.replace(i,item);
                emit postItemUpdate();
            }
        }
    }
    else {
        emit postItemUpdate();
    }
}
