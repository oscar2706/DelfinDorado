#include "empleadolista.h"
EmpleadoLista::EmpleadoLista(QObject *parent) : QObject(parent)
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("127.0.0.1");
    db.setUserName("root");
    db.setPassword("");
    db.setDatabaseName("dorado");
    if(db.open()){
        QSqlQuery query;
        qDebug() << "Se conecto la base de datos! :D";
        /*
        if (query.exec("SELECT * FROM persona")) {
            while (query.next()) {
                qDebug() << query.value(0).toString() << ", "<< query.value(1).toString() << "," << query.value(2).toString();
            }
        }
        */
    }else{
        qDebug() << "Sigue intentando! D:";
    }
    //mItems.append({QStringLiteral("1"), QStringLiteral("Oscar"), QStringLiteral("Gerente"), false});
}

QVector<ToDoItem> EmpleadoLista::items() const
{
    return mItems;
}

bool EmpleadoLista::setItemAt(int indice, const ToDoItem &item)
{
    if(indice<0 || indice>mItems.size())
    {
        return false;
    }

    const ToDoItem &oldItem = mItems.at(indice);

    if((item.eleccionEmpleado == oldItem.eleccionEmpleado)&&(item.idEmpleado == oldItem.idEmpleado) && (item.nombreEmpleado == oldItem.idEmpleado) && (item.puestoEmpleado == oldItem.puestoEmpleado))
    {
        return false;
    }

    mItems[indice] = item;
    return true;
}

void EmpleadoLista::appendItem()
{
    emit preItemAppended();

    ToDoItem item;
    item.eleccionEmpleado = false;
    item.idEmpleado = "1";
    mItems.append(item);
    QSqlQuery qryDatosEmpleados,qryDatosUsuario;
    qryDatosEmpleados.prepare("INSERT INTO empleado(IdEmpleado,Nombre,ApellidoPaterno,ApellidoMaterno,"
                              "sexo,RFC,SeguroSocial,FechaNacimiento,FechaContratacion,Sueldo,Telefono,"
                              "Categoria_idCategoria) "
                              "VALUES(:idIdEmpleado, :idNombre, :idApellidoPaterno,"
                              ":idApellidoMaterno, :idSexo, :idRFC, :idSeguroSocial, :idFechaNacimiento,"
                              "NOW(), :idSueldo, :idTelefono, :idCategoria)");

    qryDatosUsuario.prepare("INSERT INTO usuario(IdUsuario,Usuario,Contrasena,Empleado_idEmpleado) VALUES"
                            "(:idIdUsuario, :idUsuario, :idContrasena, :idEmpleado)");
    qryDatosEmpleados.bindValue(":idIdEmpleado",1);
    qryDatosEmpleados.bindValue(":idNombre","Dylan");
    qryDatosEmpleados.bindValue(":idApellidoPaterno","Lozada");
    qryDatosEmpleados.bindValue(":idApellidoMaterno","Mendoza");
    qryDatosEmpleados.bindValue(":idSexo","Masculino");
    qryDatosEmpleados.bindValue(":idRFC","MELM8305MCLP12");
    qryDatosEmpleados.bindValue(":idSeguroSocial","3217DS432");
    qryDatosEmpleados.bindValue(":idFechaNacimiento","1995-03-18");
    qryDatosEmpleados.bindValue(":idSueldo","5000");
    qryDatosEmpleados.bindValue(":idTelefono","2222154908");
    qryDatosEmpleados.bindValue(":idCategoria",5);
    qryDatosUsuario.bindValue(":idIdUsuario", 1);

    qryDatosUsuario.bindValue(":idUsuario", "Meserin");
    qryDatosUsuario.bindValue(":idContrasena", "default");
    qryDatosUsuario.bindValue(":idEmpleado", "1");
    if(qryDatosEmpleados.exec())
        qDebug() << "Se inserto el empleado! :D";
    else{
        qDebug() << "Ya deidicate a otra cosa :C";
        qDebug() << qryDatosEmpleados.lastError();
    }

    /*
    if(qryDatosUsuario.exec())
        qDebug() << "Se inserto el Usuario! :D";
    else{
        qDebug() << "Ya deidicate a otra cosa :C";
        qDebug() << qryDatosUsuario.lastError();
    }
    */




    emit postItemAppended();
}

void EmpleadoLista::removeCheckedItem()
{
    for(int i=0; i<mItems.size();)
    {
        if(mItems.at(i).eleccionEmpleado)
        {
            emit preItemRemoved(i);

            mItems.removeAt(i);

            emit postItemRemoved();
        }
        else
        {
            i++;
        }
    }
}
