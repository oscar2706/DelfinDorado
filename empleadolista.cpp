#include "empleadolista.h"
EmpleadoLista::EmpleadoLista(QObject *parent) : QObject(parent)
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("127.0.0.1");
    /*db.setUserName("root");
    db.setPassword("");*/
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

void EmpleadoLista::refresh()
{
    removeItems();

    QSqlQuery busqueda;
    bool bandera = false;

    busqueda.prepare("SELECT IdEmpleado, Nombre, ApellidoPaterno, ApellidoMaterno, Categoria_idCategoria "
                     "from empleado");
    busqueda.exec();

    while(busqueda.next())
    {
        for(int i=0; i<mItems.size(); i++)
        {
            qDebug() << "Id Table: " + mItems.at(i).idEmpleado + " Id Lista: " + busqueda.value(0).toString();
            if(mItems.at(i).idEmpleado==busqueda.value(0).toString())
            {
                bandera = true;
                break;
            }
        }
        if(!bandera)
        {
            emit preItemAppended();

            ToDoItem item;
            item.idEmpleado = busqueda.value(0).toString();
            item.nombreEmpleado = busqueda.value(1).toString() + " " + busqueda.value(2).toString() + " " + busqueda.value(3).toString();
            switch (busqueda.value(4).toInt()) {
            case 1:
                item.puestoEmpleado = "Gerente";
                break;
            case 2:
                item.puestoEmpleado = "Cocinero";
                break;
            case 3:
                item.puestoEmpleado = "Mesero";
                break;
            case 4:
                item.puestoEmpleado = "Anfitrión";
                break;
            case 5:
                item.puestoEmpleado = "Ayudante de Mesero";
                break;
            default:
                break;
            }
            item.eleccionEmpleado = false;
            mItems.append(item);

            emit postItemAppended();
        }
        bandera = false;
    }
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

void EmpleadoLista::removeItems()
{
    for(int i=0; i<mItems.size();)
    {
        emit preItemRemoved(i);

        mItems.removeAt(i);

        emit postItemRemoved();
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

QString EmpleadoLista::getNombre(QString id)
{
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT Nombre FROM empleado WHERE IdEmpleado = " + id);
    obtenerDato.exec();
    obtenerDato.first();

    return obtenerDato.value(0).toString();
}

QString EmpleadoLista::getApellidoPaterno(QString id)
{
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT ApellidoPaterno FROM empleado WHERE IdEmpleado = " + id);
    obtenerDato.exec();
    obtenerDato.first();

    return obtenerDato.value(0).toString();
}

QString EmpleadoLista::getApellidoMaterno(QString id)
{
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT ApellidoMaterno FROM empleado WHERE IdEmpleado = " + id);
    obtenerDato.exec();
    obtenerDato.first();

    return obtenerDato.value(0).toString();
}

QString EmpleadoLista::getFechaNacimiento(QString id)
{
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT FechaNacimiento FROM empleado WHERE IdEmpleado = " + id);
    obtenerDato.exec();
    obtenerDato.first();

    return obtenerDato.value(0).toString();
}

QString EmpleadoLista::getSexo(QString id)
{
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT sexo FROM empleado WHERE IdEmpleado = " + id);
    obtenerDato.exec();
    obtenerDato.first();

    return obtenerDato.value(0).toString();
}

int EmpleadoLista::getPuesto(QString id)
{
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT Categoria_idCategoria FROM empleado WHERE IdEmpleado = " + id);
    obtenerDato.exec();
    obtenerDato.first();

    return obtenerDato.value(0).toInt();
}

QString EmpleadoLista::getTelefono(QString id)
{
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT Telefono FROM empleado WHERE IdEmpleado = " + id);
    obtenerDato.exec();
    obtenerDato.first();

    return obtenerDato.value(0).toString();
}

QString EmpleadoLista::getSalario(QString id)
{
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT Sueldo FROM empleado WHERE IdEmpleado = " + id);
    obtenerDato.exec();
    obtenerDato.first();

    return obtenerDato.value(0).toString();
}

QString EmpleadoLista::getRFC(QString id)
{
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT RFC FROM empleado WHERE IdEmpleado = " + id);
    obtenerDato.exec();
    obtenerDato.first();

    return obtenerDato.value(0).toString();
}

QString EmpleadoLista::getSeguroSocial(QString id)
{
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT SeguroSocial FROM empleado WHERE IdEmpleado = " + id);
    obtenerDato.exec();
    obtenerDato.first();

    return obtenerDato.value(0).toString();
}

QString EmpleadoLista::getUsuario(QString id)
{
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT Usuario FROM usuario WHERE IdUsuario = " + id);
    obtenerDato.exec();
    obtenerDato.first();

    return obtenerDato.value(0).toString();
}

QString EmpleadoLista::getContrasegna(QString id)
{
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT Contrasena FROM usuario WHERE IdUsuario = " + id);
    obtenerDato.exec();
    obtenerDato.first();

    return obtenerDato.value(0).toString();
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

void EmpleadoLista::modificaUsuario(QString Nombre, QString ApellidoPaterno, QString ApellidoMaterno, QString Sexo,
                                    QString RFC, QString SeguroSocial, QString FechaNacimiento, QString Sueldo, QString Telefono,
                                    int idCategoria, QString Usuario, QString Contrasegna, QString idEmpleado)
{
    QSqlQuery modificaEmpleado, modificaUsuario;
    modificaUsuario.prepare("UPDATE usuario SET "
                            "Usuario = '" + Usuario + "' , Contrasena = '" + Contrasegna + "' "
                            "WHERE IdUsuario = " + idEmpleado);
    modificaUsuario.exec();

    modificaEmpleado.prepare("UPDATE empleado SET "
                             "Nombre = '" + Nombre + "', ApellidoPaterno = '" + ApellidoPaterno + "', "
                             "ApellidoMaterno = '" + ApellidoMaterno + "', "
                             "sexo = '" + Sexo + "', RFC = '" + RFC + "', SeguroSocial = '" + SeguroSocial + "', "
                             "FechaNacimiento = '" + FechaNacimiento + "' , "
                             "Sueldo = '" + Sueldo + "', Telefono = '" + Telefono + "', "
                             "Categoria_idCategoria = " + QString::number(idCategoria) + " "
                             "WHERE IdEmpleado = " + idEmpleado);
    modificaEmpleado.exec();
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
