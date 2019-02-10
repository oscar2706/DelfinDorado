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
        float costo;
        QString descripcion;
        int idCategoria = 0;
        QString categoria;

        id = qryPlatillos.value(0).toInt();
        nombre = qryPlatillos.value(1).toString();
        QByteArray arrayIm = qryPlatillos.value(2).toByteArray();
        foto = byteArrayToString(arrayIm);
        costo = qryPlatillos.value(3).toFloat();
        descripcion = qryPlatillos.value(4).toString();
        idCategoria = qryPlatillos.value(5).toInt();

        QSqlQuery qryCargaCategoria;
        qryCargaCategoria.prepare("select nombre from categoria where idCategoria = :idCategoria");
        qryCargaCategoria.bindValue(":idCategoria", idCategoria);

        qryCargaCategoria.exec();

        qryCargaCategoria.next();
            categoria = qryCargaCategoria.value(0).toString();


        addPlatillo(new Platillo(id,nombre,foto,costo,descripcion,categoria,"Disponible",this));

        qDebug() << qryPlatillos.value(0).toString();
        qDebug() << qryPlatillos.value(1).toString();
        qDebug() << qryPlatillos.value(2).toString();
        qDebug() << qryPlatillos.value(3).toString();
        qDebug() << qryPlatillos.value(4).toString();
        qDebug() << qryPlatillos.value(5).toString();
        qDebug() << qryCargaCategoria.value(0).toString();
        qDebug() << "";
        qDebug() << "";
    }
    /*
    Platillo* nuevoPlatillo = new Platillo(1,"","",100,"No tiene","Coctel","Disponible",this);
    addPlatillo(nuevoPlatillo);
    printPlatillos();
    */
}

int PlatilloModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent); // Se usa porque el padre no es una lista, esto evita problemas en la compilcacion
    return misPlatilos.size();
}

QVariant PlatilloModel::data(const QModelIndex &index, int role) const
{
    if(index.row() < 0 || index.row() >=misPlatilos.count())
        return QVariant(); //Se devuelve vacio porque no es valido
    Platillo* platillo = misPlatilos[index.row()];
    //Todas los atributos del platillo seran convertidos a tipo QVariant para que funcionen con el modelo
    if(role == NameRole)
        return platillo->name();
    if(role == IdRole)
        return platillo->id();
    if(role == ImageRole)
        return platillo->image();
    if(role == PriceRole)
        return platillo->price();
    if(role == DescriptionRole)
        return platillo->description();
    if(role == CategoryRole)
        return platillo->category();
    if(role == StatusRole)
        return platillo->status();
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
            platillo->setImage(value.toString());
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
        break;
    }
    if(somethingChanged){
        emit dataChanged(index,index,QVector<int>() << role);
        return true;
    }
    else
        return false;
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

void PlatilloModel::printPlatillos()
{
    int indice = 0;
    for (itr = misPlatilos.begin(); itr != misPlatilos.end(); itr++) {
         qDebug() << "misPlatilos[" << indice << "]";
         qDebug() <<(*itr)->name();
         qDebug() <<(*itr)->image();
         qDebug() <<(*itr)->price();
         qDebug() <<(*itr)->category();
         qDebug() <<(*itr)->description();
         indice++;
    }
}

void PlatilloModel::addPlatillo()
{
    int nuevoId = misPlatilos.last()->id()+1;
    Platillo* nuevoPlatillo = new Platillo(nuevoId,"","",100,"No tiene","Coctel","Disponible",this);
    misPlatilos.append(nuevoPlatillo);
    //printPlatillos();
}

void PlatilloModel::addPlatillo(const QString &name, const QString &price)
{
    int nuevoId = misPlatilos.last()->id()+1;
    Platillo* nuevoPlatillo = new Platillo(nuevoId,name,price, 100, "Un platillo tipico","","Disponible",this);
    misPlatilos.append(nuevoPlatillo);
    //printPlatillos();
}

void PlatilloModel::removePlatillo(int index)
{
    beginRemoveRows(QModelIndex(),index,index);
    misPlatilos.removeAt(index);
    endRemoveRows();
    //printPlatillos();
}

void PlatilloModel::removeLastPlatillo()
{
    removePlatillo(misPlatilos.size()-1);
    //printPlatillos();
}

QString PlatilloModel::byteArrayToString(QByteArray &img)
{
    //qDebug() << "Imagen: registro";
    if(img != nullptr)
    {
         QImage myImage;
         QBuffer buffer(&img);
         buffer.open(QIODevice::WriteOnly);
         myImage.save(&buffer, "JPEG");
         QString image("data:image/jpg;base64,");
         //qDebug() << "Imagen: " << image;
         image.append(QString::fromLatin1(img.toBase64().data()));
         //qDebug() << "Imagen: " << image;
         return image;
    }
    else
    {
        //qDebug() << "Imagen: sale";
        return "";
    }
}
