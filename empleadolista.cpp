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
    }else{
        qDebug() << "Sigue intentando! D:";
    }

    QSqlQuery queryConsulta;

    queryConsulta.prepare("SELECT idEmpleado, nombre, apellidoPaterno, apellidoMaterno, idCategoria "
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

    if((item.eleccionEmpleado == oldItem.eleccionEmpleado)&&(item.idEmpleado == oldItem.idEmpleado) &&
            (item.nombreEmpleado == oldItem.idEmpleado) && (item.puestoEmpleado == oldItem.puestoEmpleado))
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

    busqueda.prepare("SELECT idEmpleado, nombre, apellidoPaterno, apellidoMaterno, idCategoria "
                     "from empleado");
    busqueda.exec();

    while(busqueda.next())
    {
        for(int i=0; i<mItems.size(); i++)
        {
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
    obtenerDato.prepare("SELECT nombre FROM empleado WHERE idEmpleado = " + id);
    obtenerDato.exec();
    obtenerDato.first();

    return obtenerDato.value(0).toString();
}

QString EmpleadoLista::getApellidoPaterno(QString id)
{
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT apellidoPaterno FROM empleado WHERE idEmpleado = " + id);
    obtenerDato.exec();
    obtenerDato.first();

    return obtenerDato.value(0).toString();
}

QString EmpleadoLista::getApellidoMaterno(QString id)
{
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT apellidoMaterno FROM empleado WHERE idEmpleado = " + id);
    obtenerDato.exec();
    obtenerDato.first();

    return obtenerDato.value(0).toString();
}

QString EmpleadoLista::getFechaNacimiento(QString id)
{
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT fechaNacimiento FROM empleado WHERE idEmpleado = " + id);
    obtenerDato.exec();
    obtenerDato.first();

    return obtenerDato.value(0).toString();
}

QString EmpleadoLista::getSexo(QString id)
{
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT idSexo FROM empleado WHERE idEmpleado = " + id);
    obtenerDato.exec();
    obtenerDato.first();

    return obtenerDato.value(0).toString();
}

int EmpleadoLista::getPuesto(QString id)
{
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT idCategoria FROM empleado WHERE idEmpleado = " + id);
    obtenerDato.exec();
    obtenerDato.first();

    return obtenerDato.value(0).toInt();
}

QString EmpleadoLista::getTelefono(QString id)
{
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT telefono FROM empleado WHERE idEmpleado = " + id);
    obtenerDato.exec();
    obtenerDato.first();

    return obtenerDato.value(0).toString();
}

QString EmpleadoLista::getSalario(QString id)
{
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT sueldo FROM empleado WHERE idEmpleado = " + id);
    obtenerDato.exec();
    obtenerDato.first();

    return obtenerDato.value(0).toString();
}

QString EmpleadoLista::getRFC(QString id)
{
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT rfc FROM empleado WHERE idEmpleado = " + id);
    obtenerDato.exec();
    obtenerDato.first();

    return obtenerDato.value(0).toString();
}

QString EmpleadoLista::getSeguroSocial(QString id)
{
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT seguroSocial FROM empleado WHERE idEmpleado = " + id);
    obtenerDato.exec();
    obtenerDato.first();

    return obtenerDato.value(0).toString();
}

QString EmpleadoLista::getUsuario(QString id)
{
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT usuario FROM usuario WHERE idUsuario = " + id);
    obtenerDato.exec();
    obtenerDato.first();

    return obtenerDato.value(0).toString();
}

QString EmpleadoLista::getContrasegna(QString id)
{
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT contrasena FROM usuario WHERE idUsuario = " + id);
    obtenerDato.exec();
    obtenerDato.first();

    return obtenerDato.value(0).toString();
}

void EmpleadoLista::altaUsuario(QString Nombre, QString ApellidoPaterno, QString ApellidoMaterno, QString Sexo,
                                QString RFC, QString SeguroSocial, QString FechaNacimiento, QString Sueldo, QString Telefono,
                                int idCategoria, QString Usuario, QString Contrasegna, QString urlEnviada)
{
    QFile imgArchivo(urlEnviada);
    imgArchivo.open(QIODevice::ReadOnly);
    QByteArray bytesFoto=imgArchivo.readAll();

    QSqlQuery qryDatosEmpleados,qryDatosUsuario, idEmpleado;
    qryDatosEmpleados.prepare("INSERT INTO empleado(nombre, apellidoPaterno, apellidoMaterno,"
                              "idSexo, rfc, seguroSocial, fechaNacimiento, sueldo, telefono,"
                              "idCategoria, foto) "
                              "VALUES(:idNombre, :idApellidoPaterno,"
                              ":idApellidoMaterno, :idSexo, :idRFC, :idSeguroSocial, :idFechaNacimiento,"
                              ":idSueldo, :idTelefono, :idCategoria, :archivo)");

    idEmpleado.prepare("SELECT idEmpleado FROM empleado ORDER BY idEmpleado DESC");
    idEmpleado.exec();
    idEmpleado.first();

    qryDatosUsuario.prepare("INSERT INTO usuario(usuario, contrasena, idEmpleado) VALUES"
                            "(:idUsuario, :idContrasena, :idEmpleado)");

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
    qryDatosEmpleados.bindValue(":archivo",bytesFoto);

    qryDatosUsuario.bindValue(":idUsuario", Usuario);
    qryDatosUsuario.bindValue(":idContrasena", Contrasegna);
    qryDatosUsuario.bindValue(":idEmpleado", idEmpleado.value(0));

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
                            "usuario = '" + Usuario + "' , contrasena = '" + Contrasegna + "' "
                            "WHERE idUsuario = " + idEmpleado);
    modificaUsuario.exec();

    modificaEmpleado.prepare("UPDATE empleado SET "
                             "nombre = '" + Nombre + "', apellidoPaterno = '" + ApellidoPaterno + "', "
                             "apellidoMaterno = '" + ApellidoMaterno + "', "
                             "idSexo = " + Sexo + ", rfc = '" + RFC + "', seguroSocial = '" + SeguroSocial + "', "
                             "fechaNacimiento = '" + FechaNacimiento + "' , "
                             "sueldo = " + Sueldo + ", telefono = '" + Telefono + "', "
                             "idCategoria = " + QString::number(idCategoria) + " "
                             "WHERE idEmpleado = " + idEmpleado);
    modificaEmpleado.exec();
}

void EmpleadoLista::bajaUsuario(QString usuario)
{
    QSqlQuery bajaEmpleado, bajaUsuario;
    bajaUsuario.prepare("DELETE FROM usuario WHERE idEmpleado = " + usuario);
    bajaUsuario.exec();
    bajaEmpleado.prepare("DELETE FROM empleado WHERE idEmpleado = " + usuario);
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

int EmpleadoLista::getUltimoId()
{
    QSqlQuery ultimo;
    ultimo.prepare("SELECT idEmpleado FROM empleado ORDER BY idEmpleado DESC");
    ultimo.exec();
    ultimo.first();

    return ultimo.value(0).toInt();
}

int EmpleadoLista::buscarCategoria(QString nombreUsuario, QString contrasegna)
{
    int idUsuario = 0;

    QSqlQuery busqueda;
    busqueda.prepare("SELECT idEmpleado FROM usuario WHERE "
                     "usuario = '" + nombreUsuario + "' AND contrasena = '" + contrasegna + "'");

    if(busqueda.exec())
    {
        busqueda.first();

        QSqlQuery puesto;
        puesto.prepare("SELECT idCategoria FROM empleado WHERE "
                       "idEmpleado = " + busqueda.value(0).toString() + "");
        puesto.exec();
        puesto.first();

        qDebug() << "Sale " << puesto.value(0).toString();

        return puesto.value(0).toInt();
    }
    else
        return idUsuario;
}

//cargado de imagenes
void EmpleadoLista::insertarBD(QString urlEnviada, QString idEmpleado)
{
    QSqlQuery insert;
    QFile imgArchivo(urlEnviada);
    imgArchivo.open(QIODevice::ReadOnly);
    QByteArray bytesFoto=imgArchivo.readAll();
    insert.prepare("INSERT INTO empleado(archivo) values(:archivo) WHERE idEmpleado = " + idEmpleado);
    insert.bindValue(":archivo",bytesFoto);
    if(!insert.exec())
        qDebug ()<<"ERROR EN LA INSERCION: "<<insert.lastError().text();
}

QString EmpleadoLista::visualizarImg(int id_foto)
{
    QSqlQuery select;
    if(select.exec("SELECT archivo FROM foto WHERE id_foto ='"+QString::number(id_foto)+"'"))
    {
        if(select.next())
        {
            if(select.value(0).toByteArray()!=nullptr)
            {
                 QImage myImage;
                 QByteArray bArray=select.value(0).toByteArray();
                 QBuffer buffer(&bArray);
                 buffer.open(QIODevice::WriteOnly);
                 myImage.save(&buffer, "JPEG");
                 QString image("data:image/jpg;base64,");
                 image.append(QString::fromLatin1(bArray.toBase64().data()));
                 return image;
            }
            else
            {
                return "";
            }
        }
        else
        {
            return "";
        }
    }
    else
    {
        return "";
    }
}
