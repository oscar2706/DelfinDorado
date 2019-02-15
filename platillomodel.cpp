#include "platillomodel.h"

PlatilloModel::PlatilloModel(QObject *parent) : QAbstractListModel(parent)
{
    QSqlQuery qryPlatillos;
    qryPlatillos.prepare("SELECT * FROM platillo");
    qryPlatillos.exec();
    while (qryPlatillos.next()) {
        int id = 0;
        QString nombre;
        QString foto;
        float precio;
        QString descripcion;
        QString categoria;
        QString estado;

        int idCategoria = 0;
        int idEstado = 0;

        id = qryPlatillos.value(0).toInt();
        nombre = qryPlatillos.value(1).toString();
        QByteArray arrayIm = qryPlatillos.value(2).toByteArray();
        foto = byteArrayToString(arrayIm);
        precio = qryPlatillos.value(3).toFloat();
        descripcion = qryPlatillos.value(4).toString();
        idCategoria = qryPlatillos.value(5).toInt();
        idEstado = qryPlatillos.value(6).toInt();

        QSqlQuery qryCargaCategoria;
        qryCargaCategoria.prepare("SELECT nombre FROM categoriaPlatillo WHERE idCategoriaPlatillo = :idCategoriaPlatillo");
        qryCargaCategoria.bindValue(":idCategoriaPlatillo", idCategoria);
        qryCargaCategoria.exec();
        qryCargaCategoria.next();
        categoria = qryCargaCategoria.value(0).toString();

        QSqlQuery qryCargaEstado;
        qryCargaEstado.prepare("SELECT nombre FROM estadoPlatillo where idEstadoPlatillo = :idEstado");
        qryCargaEstado.bindValue(":idEstado", idEstado);
        qryCargaEstado.exec();
        qryCargaEstado.next();
        estado = qryCargaEstado.value(0).toString();

        addPlatillo(new Platillo(id,nombre,foto,precio,descripcion,categoria,estado,this));

        qDebug() << "-> Platillo leido";
        qDebug() << qryPlatillos.value(0).toString();
        qDebug() << qryPlatillos.value(1).toString();
        qDebug() << qryPlatillos.value(2).toString();
        qDebug() << qryPlatillos.value(3).toString();
        qDebug() << qryPlatillos.value(4).toString();
        qDebug() << qryCargaCategoria.value(0).toString();
        qDebug() << qryCargaEstado.value(0).toString();
        qDebug() << "-----------------\n";

    }
}

int PlatilloModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent); // Se usa porque el padre no es una lista, esto evita problemas en la compilcacion
    return misPlatilos.size();
}

QVariant PlatilloModel::data(const QModelIndex &index, int role) const
{
    if(index.row() < 0 || index.row() >= misPlatilos.count())
        return QVariant();

    Platillo* platillo = misPlatilos[index.row()];
    if(role == NameRole)
        return platillo->name();
    if(role == IdRole)
        return platillo->id();
    if(role == ImageRole){
        return platillo->image();
    }
    if(role == PriceRole)
        return platillo->price();
    if(role == DescriptionRole)
        return platillo->description();
    if(role == CategoryRole)
        return platillo->category();
    if(role == StatusRole)
        return platillo->status();
    return  QVariant();
}

bool PlatilloModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    Platillo* platillo = misPlatilos[index.row()];
    bool somethingChanged = false;
    switch (role) {
    case NameRole:{
        if(platillo->name() != value.toString()){
            platillo->setName(value.toString());
            somethingChanged = true;
        }
    }
        break;
    case ImageRole:{
        if(platillo->image() != value.toString()){
            QByteArray img = value.toByteArray();
            QString imgaLoaded = byteArrayToString(img);
            platillo->setImage(imgaLoaded);
            somethingChanged = true;
        }
    }
        break;
    case PriceRole:{
        if(platillo->price() != value.toFloat()){
            platillo->setPrice(value.toFloat());
            somethingChanged = true;
        }
    }
        break;
    case DescriptionRole:{
        if(platillo->description() != value.toString()){
            platillo->setDescription(value.toString());
            somethingChanged = true;
        }
    }
        break;
    case CategoryRole:{
        if(platillo->category() != value.toString()){
            platillo->setCategory(value.toString());
            somethingChanged = true;
        }
    }
        break;
    case StatusRole:{
        if(platillo->status() != value.toString()){
            platillo->setStatus(value.toString());
            somethingChanged = true;
        }
    }
    }
        if(somethingChanged){
            emit dataChanged(index,index,QVector<int>() << role);
            return true;
        }
        return  false;
}

Qt::ItemFlags PlatilloModel::flags(const QModelIndex &index) const
{
    if(!index.isValid())
        return Qt::NoItemFlags;
    return Qt::ItemIsEnabled;
}

QHash<int, QByteArray> PlatilloModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[NameRole] = "name";
    roles[ImageRole] = "image";
    roles[PriceRole] = "price";
    roles[DescriptionRole] = "description";
    roles[CategoryRole] = "category";
    roles[StatusRole] = "status";
    return roles;
}

void PlatilloModel::addPlatillo(Platillo *nuevoPlatillo)
{
    const int index = misPlatilos.size();
    beginInsertRows(QModelIndex(),index,index);
    misPlatilos.append(nuevoPlatillo);
    endInsertRows();
    //printPlatillos();
}

<<<<<<< HEAD
QStringList PlatilloModel::getNamesModel()
{
    QStringList namesModel;
    for (itr = misPlatilos.begin(); itr != misPlatilos.end(); itr++) {
        if((*itr)->status() == "Disponible")
            namesModel.append((*itr)->name());
    }
    namesModel.sort();
    return namesModel;
}

float PlatilloModel::getPrecioPlatillo(QString name)
{
    for (itr = misPlatilos.begin(); itr != misPlatilos.end(); itr++) {
        if((*itr)->name() == name)
            return (*itr)->price();
    }
    return 0;
}

=======
>>>>>>> a3ad55609f1c643c231860c30603fdc8a0a1446a
void PlatilloModel::addPlatillo()
{
    int nuevoId = misPlatilos.last()->id()+1;
    Platillo* nuevoPlatillo = new Platillo(nuevoId,"Platillo nuevo","",100,"","","Disponible",this);
    addPlatillo(nuevoPlatillo);
    //printPlatillos();
}

void PlatilloModel::addPlatillo(const QString &name,const QString &url, const QString &price, const QString &description, const QString &category, const QString &status)
{
    float precio = price.toFloat();

    QString errMsg;
    QFile imgArchivo(url);
    imgArchivo.open(QIODevice::ReadOnly);
    QByteArray bytesFoto=imgArchivo.readAll();
    QString foto = byteArrayToString(bytesFoto);
    //QString imgaLoaded = byteArrayToString(img);

    int nuevoId = misPlatilos.last()->id()+1;
    Platillo* nuevoPlatillo = new Platillo(nuevoId,name,bytesFoto, precio , description,category,status,this);
    //addPlatillo(nuevoPlatillo);

    bool insertedOK = insertPlatilloInDataBase(nuevoPlatillo);
    if(insertedOK){
        QSqlQuery qryPlatillos;
        qryPlatillos.prepare("SELECT foto FROM platillo WHERE idPlatillo = :idPlatillo");
        qryPlatillos.bindValue(":idPlatillo",nuevoPlatillo->id());
        qryPlatillos.exec();
        if(qryPlatillos.next()){
            qDebug() << "Se recupero de la base de datos";
            QByteArray arrayIm = qryPlatillos.value(0).toByteArray();
            QString newfoto = byteArrayToString(arrayIm);
            nuevoPlatillo->setImage(newfoto);
        }
        addPlatillo(nuevoPlatillo);
        qDebug() << "---> Platillo insertado en la base de datos";
        //nuevoPlatillo->setImage(byteArrayToString(bytesFoto));
    }
    else
        qDebug() << "ERROR al insertar";

    //printPlatillos();
}

void PlatilloModel::modifyPlatillo(const int idBuscado, const QString &givenName, const QString &givenUrl, const QString &givenPrice, const QString &givenDescription, const QString &givenCategory, const QString &givenStatus)
{
    printPlatillos();
    qDebug() << "";
    qDebug() << "";
    int indice = 0;
    //bool somethingChanged = false;
    qDebug() << "IdBuscado, pasado de qml: " << idBuscado;
    for (itr = misPlatilos.begin(); itr != misPlatilos.end(); itr++) {
        if(indice == idBuscado){
            qDebug() << "misPlatilos[" << indice << "]";

            if((*itr)->name() != givenName){
                (*itr)->setName(givenName);
                //somethingChanged = true;
            }

            /*if((*itr)->image() != givenUrl){
                (*itr)->setImage(givenUrl);
                somethingChanged = true;
            }*/

            if((*itr)->price() != givenPrice.toFloat()){
                (*itr)->setPrice(givenPrice.toFloat());
                //somethingChanged = true;
            }

            if((*itr)->description() != givenDescription){
                (*itr)->setDescription(givenDescription);
                //somethingChanged = true;
            }

            if((*itr)->category() != givenCategory)
                (*itr)->setCategory(givenCategory);

            if((*itr)->status() != givenStatus){
                (*itr)->setStatus(givenStatus);
                //somethingChanged = true;
            }

            qDebug() << "SE MODIFICA UN PLATILLO: id = " << (*itr)->id();
            qDebug() << "";
            qDebug() << "";

            bool updatedOk = updatePlatilloInDataBase((*itr));
            if(updatedOk){
                qDebug() << "---> Platillo actualizado en la base de datos";
                QModelIndex topLeft = createIndex(0,0);
                QModelIndex bottomRight = createIndex(6,misPlatilos.size()); // 6 = numero de atributos de Platillo
                emit dataChanged(topLeft,bottomRight);
            }
            else
                qDebug() << "ERROR al actualizar";

        }
        indice++;
    }
}

void PlatilloModel::removePlatillo(int index)
{   
    bool deletedOk = false;
    int indice = 0;
    for (itr = misPlatilos.begin(); itr != misPlatilos.end(); itr++) {
        if(indice == index){
            deletedOk = deletePlatilloInDataBase((*itr));
            qDebug() << "---> Platillo removido de la base de datos";
        }
        indice++;
    }

    if(deletedOk){
        beginRemoveRows(QModelIndex(),index,index);
        misPlatilos.removeAt(index);
        endRemoveRows();
    }
    else
        qDebug() << "ERROR al remover";

    //printPlatillos();
}

void PlatilloModel::removeLastPlatillo()
{
    removePlatillo(misPlatilos.size()-1);
    //printPlatillos();
}

QString PlatilloModel::byteArrayToString(QByteArray &img)
{
    if(img != nullptr)
    {
         QImage myImage;
         QBuffer buffer(&img);
         buffer.open(QIODevice::WriteOnly);
         myImage.save(&buffer, "JPEG");
         QString image("data:image/jpg;base64,");
         image.append(QString::fromLatin1(img.toBase64().data()));
         return image;
    }
    else
        return "";
}

bool PlatilloModel::insertPlatilloInDataBase(Platillo *platilloToSave)
{
    bool dataSaved = false;

    QSqlQuery qryInsertPlatillo;
    qryInsertPlatillo.prepare("INSERT INTO platillo(nombre, foto, precio, descripcion, idCategoriaPlatillo, idEstadoPlatillo) "
                              "VALUES(:nombre, :foto, :precio, :descripcion, :idCategoria, :idEstadoPlatillo)");
    qryInsertPlatillo.bindValue(":nombre", platilloToSave->name());
    qryInsertPlatillo.bindValue(":foto", platilloToSave->image());
    qryInsertPlatillo.bindValue(":precio", platilloToSave->price());
    qryInsertPlatillo.bindValue(":descripcion", platilloToSave->description());
    qryInsertPlatillo.bindValue(":idCategoria",  getIdCategoria(platilloToSave->category()));
    qryInsertPlatillo.bindValue(":idEstadoPlatillo", getIdEstado(platilloToSave->status()));
    qryInsertPlatillo.exec();

    if(qryInsertPlatillo.numRowsAffected() != 0)
        dataSaved = true;

    return dataSaved;
}

bool PlatilloModel::deletePlatilloInDataBase(Platillo *platilloToDelete)
{
    bool dataDeleted = false;
    QSqlQuery qryDeletePlatillo;
    qryDeletePlatillo.prepare("DELETE FROM platillo WHERE idPlatillo = :idPlatillo");
    qryDeletePlatillo.bindValue(":idPlatillo",platilloToDelete->id());
    qryDeletePlatillo.exec();

    if(qryDeletePlatillo.numRowsAffected() != 0)
        dataDeleted = true;

    return dataDeleted;
}

bool PlatilloModel::updatePlatilloInDataBase(Platillo *platilloToUpdate)
{
    qDebug() << "Platillo modificado";
    qDebug() << platilloToUpdate->id();
    qDebug() << platilloToUpdate->name();
    qDebug() << platilloToUpdate->price();
    qDebug() << platilloToUpdate->description();
    qDebug() << platilloToUpdate->category();
    qDebug() << platilloToUpdate->status();
    qDebug() << "";
    qDebug() << "";

    bool dataUpdated = false;
    QSqlQuery qryUpdatePlatillo;
    qryUpdatePlatillo.prepare("UPDATE platillo SET "
                              "nombre = :nombre, "

                              "precio = :precio, "
                              "descripcion = :descripcion, "
                              "idCategoriaPlatillo = :idCategoria, "
                              "idEstadoPlatillo = :idEstado "
                              "WHERE idPlatillo = :idPlatillo");
    qryUpdatePlatillo.bindValue(":idPlatillo", platilloToUpdate->id());
    qryUpdatePlatillo.bindValue(":nombre", platilloToUpdate->name());
    //qryUpdatePlatillo.bindValue(":foto", platilloToUpdate->image());
    qryUpdatePlatillo.bindValue(":precio", platilloToUpdate->price());
    qryUpdatePlatillo.bindValue(":descripcion", platilloToUpdate->description());
    qryUpdatePlatillo.bindValue(":idCategoria", getIdCategoria(platilloToUpdate->category()));
    qryUpdatePlatillo.bindValue(":idEstado", getIdEstado(platilloToUpdate->status()));
    qryUpdatePlatillo.exec();

    if(qryUpdatePlatillo.numRowsAffected() > 0)
        dataUpdated = true;

    return dataUpdated;
}

int PlatilloModel::getIdCategoria(QString categoria)
{
    if(categoria == "Botanas")
        return 1;
    if(categoria == "Entradas")
        return 2;
    if(categoria == "Ensaladas y ceviches")
        return 3;
    if(categoria == "Sopas")
        return 4;
    if(categoria == "Filetes")
        return 5;
    if(categoria == "Alambres")
        return 6;
    if(categoria == "Carnes")
        return 7;
    if(categoria == "Especialidades")
        return 8;
    if(categoria == "Postres")
        return 9;
    if(categoria == "Bebidas")
        return 10;
    return -1;
}

int PlatilloModel::getIdEstado(QString estado)
{
    if(estado == "Disponible")
        return 1;
    if(estado == "Fuera de temporada")
        return 2;
    return -1;
}

void PlatilloModel::printPlatillos()
{
    int indice = 1;
    for (itr = misPlatilos.begin(); itr != misPlatilos.end(); itr++) {
        qDebug() << "------------------------------";
        qDebug() << "misPlatilos[" << indice << "]";
         qDebug() <<(*itr)->id();
         qDebug() <<(*itr)->name();
         //qDebug() <<(*itr)->image();
         qDebug() <<(*itr)->price();
         qDebug() <<(*itr)->category();
         qDebug() <<(*itr)->description();
         qDebug() << "------------------------------";
         indice++;
    }
}
