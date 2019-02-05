#include "empleadolista.h"
EmpleadoLista::EmpleadoLista(QObject *parent) : QObject(parent)
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("127.0.0.1");
    db.setUserName("Leonardo");
    db.setPassword("football26398");
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

    QSqlQuery queryConsulta;

    queryConsulta.prepare("SELECT IdEmpleado, Nombre, ApellidoPaterno, ApellidoMaterno, Categoria_idCategoria "
                          "from empleado");
    queryConsulta.exec();

    while(queryConsulta.next())
    {
        ToDoItem empleadoEncontrado;

        empleadoEncontrado.idEmpleado = queryConsulta.value(0).toString();
        empleadoEncontrado.nombreEmpleado = queryConsulta.value(1).toString() + " " + queryConsulta.value(2).toString() +
                                            " " + queryConsulta.value(3).toString();
        switch (queryConsulta.value(4).toInt()) {
        case 1:
            empleadoEncontrado.puestoEmpleado = "Gerente";
            break;
        case 2:
            empleadoEncontrado.puestoEmpleado = "Cocinero";
            break;
        case 3:
            empleadoEncontrado.puestoEmpleado = "Mesero";
            break;
        case 4:
            empleadoEncontrado.puestoEmpleado = "Anfitrión";
            break;
        case 5:
            empleadoEncontrado.puestoEmpleado = "Ayudante de Mesero";
            break;
        default:
            break;
        }

        mItems.append(empleadoEncontrado);
    }
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
    mItems.append(item);

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

QString EmpleadoLista::getDato(QString comprobacion)
{
    for(int i=0; i<mItems.size();)
    {
        if(mItems.at(i).eleccionEmpleado)
        {
            comprobacion = mItems.at(i).idEmpleado;
            break;
        }
        else
        {
            i++;
        }
    }

    return comprobacion;
}

void EmpleadoLista::altaUsuario(QString Nombre, QString ApellidoPaterno, QString ApellidoMaterno, QString Sexo,
                                QString RFC, QString SeguroSocial, QString FechaNacimiento, QString Sueldo, QString Telefono,
                                int idCategoria, QString Usuario, QString Contrasegna)
{
    QSqlQuery qryDatosEmpleados,qryDatosUsuario;
    qryDatosEmpleados.prepare("INSERT INTO empleado(IdEmpleado,Nombre,ApellidoPaterno,ApellidoMaterno,"
                              "sexo,RFC,SeguroSocial,FechaNacimiento,FechaContratacion,Sueldo,Telefono,"
                              "Categoria_idCategoria) "
                              "VALUES(:idIdEmpleado, :idNombre, :idApellidoPaterno,"
                              ":idApellidoMaterno, :idSexo, :idRFC, :idSeguroSocial, :idFechaNacimiento,"
                              "NOW(), :idSueldo, :idTelefono, :idCategoria)");

    qryDatosUsuario.prepare("INSERT INTO usuario(IdUsuario,Usuario,Contrasena,Empleado_idEmpleado) VALUES"
                            "(:idIdUsuario, :idUsuario, :idContrasena, :idEmpleado)");
    qryDatosEmpleados.bindValue(":idIdEmpleado",Telefono.toInt());
    qryDatosEmpleados.bindValue(":idNombre",Nombre);
    qryDatosEmpleados.bindValue(":idApellidoPaterno",ApellidoPaterno);
    qryDatosEmpleados.bindValue(":idApellidoMaterno",ApellidoMaterno);
    qryDatosEmpleados.bindValue(":idSexo",Sexo);
    qryDatosEmpleados.bindValue(":idRFC",RFC);
    qryDatosEmpleados.bindValue(":idSeguroSocial",SeguroSocial);
    qryDatosEmpleados.bindValue(":idFechaNacimiento",FechaNacimiento);
    qryDatosEmpleados.bindValue(":idSueldo",Sueldo);
    qryDatosEmpleados.bindValue(":idTelefono",Telefono);
    qryDatosEmpleados.bindValue(":idCategoria",idCategoria);

    qryDatosUsuario.bindValue(":idIdUsuario", Telefono.toInt());
    qryDatosUsuario.bindValue(":idUsuario", Usuario);
    qryDatosUsuario.bindValue(":idContrasena", Contrasegna);
    qryDatosUsuario.bindValue(":idEmpleado", Telefono.toInt());

    if(qryDatosEmpleados.exec())
        qDebug() << "Se inserto el empleado! :D";
    else{
        qDebug() << "Ya deidicate a otra cosa :C";
        qDebug() << qryDatosEmpleados.lastError();
    }

    if(qryDatosUsuario.exec())
        qDebug() << "Se inserto el empleado! :D";
    else{
        qDebug() << "Ya deidicate a otra cosa :C";
        qDebug() << qryDatosUsuario.lastError();
    }
}

void EmpleadoLista::bajaUsuario(QString usuario)
{
    QSqlQuery bajaEmpleado, bajaUsuario;
    bajaUsuario.prepare("DELETE FROM usuario WHERE Empleado_idEmpleado = " + usuario);
    bajaUsuario.exec();
    bajaEmpleado.prepare("DELETE FROM empleado WHERE IdEmpleado = " + usuario);
    bajaEmpleado.exec();

    if(bajaEmpleado.exec())
        qDebug() << "Se elimino el empleado! :D";
    else{
        qDebug() << "Ya deidicate a otra cosa :C";
        qDebug() << bajaEmpleado.lastError();
    }

    if(bajaUsuario.exec())
        qDebug() << "Se elimino el empleado! :D";
    else{
        qDebug() << "Ya deidicate a otra cosa :C";
        qDebug() << bajaUsuario.lastError();
    }
}
