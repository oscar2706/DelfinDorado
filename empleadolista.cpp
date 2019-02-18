#include "empleadolista.h"
EmpleadoLista::EmpleadoLista(QObject *parent) : QObject(parent)
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("127.0.0.1");

    /*db.setUserName("root");
    db.setPassword("Spat2706");*/
    db.setUserName("Leonardo");
    db.setPassword("football26398");
    db.setDatabaseName("dorado");

    /*db.setUserName("oscar_soluciones");
    db.setPassword("dandelot2012");
    db.setDatabaseName("dorado");*/
    db.setPort(3306);

    if(db.open()){
        QSqlQuery query;
        qDebug() << "Se conecto la base de datos! :D";
    }else{
        qDebug() << "Sigue intentando! D:";
    }

    QSqlQuery queryConsulta, queryUsuario;

    queryConsulta.prepare("SELECT * FROM empleado");
    queryConsulta.exec();

    queryUsuario.prepare("SELECT * FROM usuario");
    queryUsuario.exec();

    while(queryConsulta.next())
    {
        queryUsuario.next();

        ToDoItem empleadoEncontrado;

        empleadoEncontrado.idEmpleado = queryConsulta.value(0).toString();
        //qDebug() << "Id: " <<  empleadoEncontrado.idEmpleado;
        empleadoEncontrado.nombreEmpleado = queryConsulta.value(1).toString() + " " + queryConsulta.value(2).toString() +
                                            " " + queryConsulta.value(3).toString();
        //qDebug() << "Nombre: " << empleadoEncontrado.nombreEmpleado;
        empleadoEncontrado.apellidoPaterno = queryConsulta.value(2).toString();
        empleadoEncontrado.apellidoMaterno = queryConsulta.value(3).toString();
        empleadoEncontrado.rfc = queryConsulta.value(4).toString();
        //qDebug() << "RFC: " << empleadoEncontrado.rfc;
        empleadoEncontrado.seguroSocial = queryConsulta.value(5).toString();
        //qDebug() << "Seguro Social: " << empleadoEncontrado.seguroSocial;
        empleadoEncontrado.fechaNacimiento = queryConsulta.value(6).toString();
        //qDebug() << "Fecha Nacimiento: " << empleadoEncontrado.fechaNacimiento;
        empleadoEncontrado.sueldo = queryConsulta.value(7).toString();
        //qDebug() << "Sueldo: " << empleadoEncontrado.sueldo;

        empleadoEncontrado.foto = visualizarImg(queryConsulta.value(0).toString());
        //qDebug() << "Foto: " << empleadoEncontrado.foto;

        empleadoEncontrado.telefono = queryConsulta.value(9).toString();
        //qDebug() << "Telefono: " << empleadoEncontrado.telefono;

        switch (queryConsulta.value(10).toInt()) {
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
        //qDebug() << "Puesto: " << empleadoEncontrado.puestoEmpleado;

        if(queryConsulta.value(11).toInt() == 1)
        {
            empleadoEncontrado.sexo = "Masculino";
        }
        else
        {
            empleadoEncontrado.sexo = "Femenino";
        }
        //qDebug() << "Sexo: " << empleadoEncontrado.sexo;

        empleadoEncontrado.usuario = queryUsuario.value(1).toString();
        //qDebug() << "Usuario: " << empleadoEncontrado.usuario;
        empleadoEncontrado.contrasegna = queryUsuario.value(2).toString();
        //qDebug() << "Contraseña: " << empleadoEncontrado.contrasegna;
        //qDebug() << "-----------------------------------------------";

        empleadoEncontrado.eleccionEmpleado = false;

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
            (item.nombreEmpleado == oldItem.idEmpleado) && (item.apellidoPaterno == oldItem.apellidoPaterno) &&
            (item.apellidoMaterno == oldItem.apellidoMaterno) && (item.rfc == oldItem.rfc) &&
            (item.seguroSocial == oldItem.seguroSocial) && (item.fechaNacimiento == oldItem.fechaNacimiento) &&
            (item.sueldo == oldItem.sueldo) && (item.foto == oldItem.foto) && (item.telefono == oldItem.telefono) &&
            (item.puestoEmpleado == oldItem.puestoEmpleado) && (item.sexo == oldItem.sexo) &&
            (item.usuario == oldItem.usuario) && (item.contrasegna == oldItem.contrasegna))
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

    QSqlQuery queryConsulta, queryUsuario;

    queryConsulta.prepare("SELECT * FROM empleado");
    queryConsulta.exec();

    queryUsuario.prepare("SELECT * FROM usuario");
    queryUsuario.exec();

    while(queryConsulta.next())
    {
        queryUsuario.next();

        emit preItemAppended();

        ToDoItem empleadoEncontrado;

        empleadoEncontrado.idEmpleado = queryConsulta.value(0).toString();
        empleadoEncontrado.nombreEmpleado = queryConsulta.value(1).toString() + " " + queryConsulta.value(2).toString() +
                                            " " + queryConsulta.value(3).toString();
        empleadoEncontrado.apellidoPaterno = queryConsulta.value(2).toString();
        empleadoEncontrado.apellidoMaterno = queryConsulta.value(3).toString();
        empleadoEncontrado.rfc = queryConsulta.value(4).toString();
        empleadoEncontrado.seguroSocial = queryConsulta.value(5).toString();
        empleadoEncontrado.fechaNacimiento = queryConsulta.value(6).toString();
        empleadoEncontrado.sueldo = queryConsulta.value(7).toString();

        QImage myImage;
        QByteArray bArray=queryConsulta.value(8).toByteArray();
        QBuffer buffer(&bArray);
        buffer.open(QIODevice::WriteOnly);
        myImage.save(&buffer, "JPEG");
        QString image("data:image/jpg;base64,");
        image.append(QString::fromLatin1(bArray.toBase64().data()));
        empleadoEncontrado.foto = image;

        empleadoEncontrado.telefono = queryConsulta.value(9).toString();

        switch (queryConsulta.value(10).toInt()) {
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

        if(queryConsulta.value(11).toInt() == 1)
        {
            empleadoEncontrado.sexo = "Masculino";
        }
        else
        {
            empleadoEncontrado.sexo = "Femenino";
        }

        empleadoEncontrado.usuario = queryUsuario.value(1).toString();
        empleadoEncontrado.contrasegna = queryUsuario.value(2).toString();

        empleadoEncontrado.eleccionEmpleado = false;

        mItems.append(empleadoEncontrado);

        emit postItemAppended();
    }
}

void EmpleadoLista::removeCheckedItem(QString idEliminar)
{
    for(int i=0; i<mItems.size();)
    {
        if(mItems.at(i).idEmpleado == idEliminar)
        {
            emit preItemRemoved(i);

            mItems.removeAt(i);

            emit postItemRemoved();

            break;
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
    //qDebug() << "Entra nombre";
    if(id!="0")
    {
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT nombre FROM empleado WHERE idEmpleado = " + id);

    if(obtenerDato.exec())
    {
        obtenerDato.first();
        return obtenerDato.value(0).toString();
    }
    else
    {
        qDebug() << obtenerDato.lastError();
        return "";
    }
    }
    else
    {
        return "";
    }
}

QString EmpleadoLista::getApellidoPaterno(QString id)
{
    //qDebug() << "Entra apeP";
    if(id!="0")
    {
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT apellidoPaterno FROM empleado WHERE idEmpleado = " + id);

    if(obtenerDato.exec())
    {
        obtenerDato.first();
        return obtenerDato.value(0).toString();
    }
    else
    {
        qDebug() << obtenerDato.lastError();
        return "";
    }
    }
    else
    {
        return "";
    }
}

QString EmpleadoLista::getApellidoMaterno(QString id)
{
    //qDebug() << "Entra apM";
    if(id!="0")
    {
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT apellidoMaterno FROM empleado WHERE idEmpleado = " + id);

    if(obtenerDato.exec())
    {
        obtenerDato.first();
        return obtenerDato.value(0).toString();
    }
    else
    {
        qDebug() << obtenerDato.lastError();
        return "";
    }
    }
    else
    {
        return "";
    }
}

QString EmpleadoLista::getFechaNacimiento(QString id)
{
    //qDebug() << "Entra fecha";
    if(id!="0")
    {
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT fechaNacimiento FROM empleado WHERE idEmpleado = " + id);

    if(obtenerDato.exec())
    {
        obtenerDato.first();
        return obtenerDato.value(0).toString();
    }
    else
    {
        qDebug() << obtenerDato.lastError();
        return "";
    }
    }
    else
    {
        return "Fecha de Nacimiento";
    }
}

QString EmpleadoLista::getSexo(QString id)
{
    //qDebug() << "Entra sexo";
    if(id!="0")
    {
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT idSexo FROM empleado WHERE idEmpleado = " + id);

    if(obtenerDato.exec())
    {
        obtenerDato.first();
        return obtenerDato.value(0).toString();
    }
    else
    {
        qDebug() << obtenerDato.lastError();
        return "";
    }
    }
    else
    {
        return "1";
    }
}

int EmpleadoLista::getPuesto(QString id)
{
    //qDebug() << "Entra puesto";
    if(id!="0")
    {
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT idCategoria FROM empleado WHERE idEmpleado = " + id);

    if(obtenerDato.exec())
    {
        obtenerDato.first();
        return obtenerDato.value(0).toInt();
    }
    else
    {
        qDebug() << obtenerDato.lastError();
        return 1;
    }
    }
    else
    {
        return 1;
    }
}

QString EmpleadoLista::getTelefono(QString id)
{
    //qDebug() << "Entra telefono";
    if(id!="0")
    {
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT telefono FROM empleado WHERE idEmpleado = " + id);

    if(obtenerDato.exec())
    {
        obtenerDato.first();
        return obtenerDato.value(0).toString();
    }
    else
    {
        qDebug() << obtenerDato.lastError();
        return "";
    }
    }
    else
    {
        return "";
    }
}

QString EmpleadoLista::getSalario(QString id)
{
    //qDebug() << "Entra salario";
    if(id!="0")
    {
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT sueldo FROM empleado WHERE idEmpleado = " + id);

    if(obtenerDato.exec())
    {
        obtenerDato.first();
        return obtenerDato.value(0).toString();
    }
    else
    {
        qDebug() << obtenerDato.lastError();
        return "";
    }
    }
    else
    {
        return "";
    }
}

QString EmpleadoLista::getRFC(QString id)
{
    //qDebug() << "Entra rfc";
    if(id!="0")
    {
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT rfc FROM empleado WHERE idEmpleado = " + id);

    if(obtenerDato.exec())
    {
        obtenerDato.first();
        return obtenerDato.value(0).toString();
    }
    else
    {
        qDebug() << obtenerDato.lastError();
        return "";
    }
    }
    else
    {
        return "";
    }
}

QString EmpleadoLista::getSeguroSocial(QString id)
{
    //qDebug() << "Entra ss";
    if(id!="0")
    {
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT seguroSocial FROM empleado WHERE idEmpleado = " + id);

    if(obtenerDato.exec())
    {
        obtenerDato.first();
        return obtenerDato.value(0).toString();
    }
    else
    {
        qDebug() << obtenerDato.lastError();
        return "";
    }
    }
    else
    {
        return "";
    }
}

QString EmpleadoLista::getUsuario(QString id)
{
    //qDebug() << "Entra usuario";
    if(id!="0")
    {
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT usuario FROM usuario WHERE idEmpleado = " + id);

    if(obtenerDato.exec())
    {
        obtenerDato.first();
        return obtenerDato.value(0).toString();
    }
    else
    {
        qDebug() << obtenerDato.lastError();
        return "";
    }
    }
    else
    {
        return "";
    }
}

QString EmpleadoLista::getContrasegna(QString id)
{
    //qDebug() << "Entra contrasegna";
    if(id!="0")
    {
    QSqlQuery obtenerDato;
    obtenerDato.prepare("SELECT contrasena FROM usuario WHERE idEmpleado = " + id);

    if(obtenerDato.exec())
    {
        obtenerDato.first();
        return obtenerDato.value(0).toString();
    }
    else
    {
        qDebug() << obtenerDato.lastError();
        return "";
    }
    }
    else
    {
        return "";
    }
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
                              "idPuesto, foto) "
                              "VALUES(:idNombre, :idApellidoPaterno,"
                              ":idApellidoMaterno, :idSexo, :idRFC, :idSeguroSocial, :idFechaNacimiento,"
                              ":idSueldo, :idTelefono, :idPuesto, :archivo)");

    qryDatosEmpleados.bindValue(":idNombre",Nombre);
    qryDatosEmpleados.bindValue(":idApellidoPaterno",ApellidoPaterno);
    qryDatosEmpleados.bindValue(":idApellidoMaterno",ApellidoMaterno);
    qryDatosEmpleados.bindValue(":idSexo",Sexo);
    qryDatosEmpleados.bindValue(":idRFC",RFC);
    qryDatosEmpleados.bindValue(":idSeguroSocial",SeguroSocial);
    qryDatosEmpleados.bindValue(":idFechaNacimiento",FechaNacimiento);
    qryDatosEmpleados.bindValue(":idSueldo",Sueldo);
    qryDatosEmpleados.bindValue(":idTelefono",Telefono);
    qryDatosEmpleados.bindValue(":idPuesto",idCategoria);
    qryDatosEmpleados.bindValue(":archivo",bytesFoto);

    if(qryDatosEmpleados.exec())
        qDebug() << "Se inserto el empleado! :D";
    else{
        qDebug() << "Ya deidicate a otra cosa :C";
        qDebug() << qryDatosEmpleados.lastError();
    }

    idEmpleado.prepare("SELECT idEmpleado FROM empleado ORDER BY idEmpleado DESC");
    idEmpleado.exec();
    idEmpleado.first();

    qryDatosUsuario.prepare("INSERT INTO usuario(usuario, contrasena, idEmpleado) VALUES"
                            "(:idUsuario, :idContrasena, :idEmpleado)");

    qryDatosUsuario.bindValue(":idUsuario", Usuario);
    qryDatosUsuario.bindValue(":idContrasena", Contrasegna);
    qryDatosUsuario.bindValue(":idEmpleado", idEmpleado.value(0).toInt());

    if(qryDatosUsuario.exec())
        qDebug() << "Se inserto el usuario! :D";
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

    if(modificaUsuario.exec())
        qDebug() << "Se modificó el usuario :D";
    else
    {
        qDebug() << "Ya dedícate a otra cosa";
        qDebug() << modificaUsuario.lastError();
    }


    modificaEmpleado.prepare("UPDATE empleado SET "
                             "nombre = '" + Nombre + "', apellidoPaterno = '" + ApellidoPaterno + "', "
                             "apellidoMaterno = '" + ApellidoMaterno + "', "
                             "idSexo = " + Sexo + ", rfc = '" + RFC + "', seguroSocial = '" + SeguroSocial + "', "
                             "fechaNacimiento = '" + FechaNacimiento + "' , "
                             "sueldo = " + Sueldo + ", telefono = '" + Telefono + "', "
                             "idPuesto = " + QString::number(idCategoria) + " "
                             "WHERE idEmpleado = " + idEmpleado);

    modificaEmpleado.exec();

    if(modificaEmpleado.exec())
        qDebug() << "Se modificó el usuario :D";
    else
    {
        qDebug() << "Ya dedícate a otra cosa";
        qDebug() << modificaEmpleado.lastError();
    }
}

void EmpleadoLista::modificaUsuarioImagen(QString Nombre, QString ApellidoPaterno, QString ApellidoMaterno, QString Sexo,
                                    QString RFC, QString SeguroSocial, QString FechaNacimiento, QString Sueldo, QString Telefono,
                                    int idCategoria, QString Usuario, QString Contrasegna, QString idEmpleado, QString urlEnviada)
{
    qDebug() << urlEnviada;

    QFile imgArchivo(urlEnviada);
    imgArchivo.open(QIODevice::ReadOnly);
    QByteArray bytesFoto=imgArchivo.readAll();

    QSqlQuery modificaEmpleado, modificaUsuario;
    modificaUsuario.prepare("UPDATE usuario SET "
                            "usuario = '" + Usuario + "' , contrasena = '" + Contrasegna + "' "
                            "WHERE idUsuario = " + idEmpleado);
    modificaUsuario.exec();

    if(modificaUsuario.exec())
        qDebug() << "Se modificó el usuario :D";
    else
    {
        qDebug() << "Ya dedícate a otra cosa";
        qDebug() << modificaUsuario.lastError();
    }


    modificaEmpleado.prepare("UPDATE empleado SET "
                             "nombre = '" + Nombre + "', apellidoPaterno = '" + ApellidoPaterno + "', "
                             "apellidoMaterno = '" + ApellidoMaterno + "', "
                             "idSexo = " + Sexo + ", rfc = '" + RFC + "', seguroSocial = '" + SeguroSocial + "', "
                             "foto = :archivo, fechaNacimiento = '" + FechaNacimiento + "' , "
                             "sueldo = " + Sueldo + ", telefono = '" + Telefono + "', "
                             "idPuesto = " + QString::number(idCategoria) + " "
                             "WHERE idEmpleado = " + idEmpleado);
    modificaEmpleado.bindValue(":archivo",bytesFoto);

    modificaEmpleado.exec();

    if(modificaEmpleado.exec())
        qDebug() << "Se modificó el usuario :D";
    else
    {
        qDebug() << "Ya dedícate a otra cosa";
        qDebug() << modificaEmpleado.lastError();
    }
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
        qDebug() << "Se elimino el usuario! :D";
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
        puesto.prepare("SELECT idPuesto FROM empleado WHERE "
                       "idEmpleado = " + busqueda.value(0).toString() + "");
        puesto.exec();
        puesto.first();

        qDebug() << "Sale " << puesto.value(0).toString();

        return puesto.value(0).toInt();
    }
    else
        return idUsuario;
}

int EmpleadoLista::buscarIdMesero(QString nombreUsuario, QString contrasegna)
{
    QSqlQuery busqueda;

    busqueda.prepare("SELECT idEmpleado FROM usuario WHERE "
                     "usuario = '" + nombreUsuario + "' AND contrasena = '" + contrasegna + "'");
    busqueda.exec();
    busqueda.first();

    return busqueda.value(0).toInt();
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

QString EmpleadoLista::visualizarImg(QString id_foto)
{
    //qDebug() << "Imagen: entra";
    QSqlQuery busqueda;
    busqueda.exec("SELECT foto FROM empleado WHERE idEmpleado = " + id_foto + "");

        qDebug() << "entra foto";
        //qDebug() << "Imagen: query";
        busqueda.next();
            //qDebug() << "Imagen: registro";
            if(busqueda.value(0).toByteArray()!=nullptr)
            {
                 QImage myImage;
                 QByteArray bArray=busqueda.value(0).toByteArray();
                 QBuffer buffer(&bArray);
                 buffer.open(QIODevice::WriteOnly);
                 myImage.save(&buffer, "JPEG");
                 QString image("data:image/jpg;base64,");
                 //qDebug() << "Imagen: " << image << "\nExtra: ";
                 //qDebug() << QString::fromLatin1(bArray.toBase64().data());
                 image.append(QString::fromLatin1(bArray.toBase64().data()));
                 //qDebug() << "Imagen: " << image;
                 return image;
            }
            else
            {
                //qDebug() << "Imagen: sale";
                return "";
            }
        /*else
        {
            return "";
        }*/

    /*else
    {
        return "";
    }*/
}
