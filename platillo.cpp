#include "platillo.h"

Platillo::Platillo(QObject *parent) : QObject(parent)
{

}

Platillo::Platillo(int id, const QString &name, const QString &image, const float &price, const QString &description,
                   const QString &category, const QString &status, QObject * parent):
    QObject (parent),m_id (id), m_name(name), m_image(image), m_price(price),m_description(description),m_category(category),m_status(status)
{

}

QString Platillo::name() const
{
    return m_name;
}

float Platillo::price() const
{
    return m_price;
}

QString Platillo::description() const
{
    return m_description;
}

QString Platillo::category() const
{
    return m_category;
}

int Platillo::id() const
{
    return m_id;
}

QString Platillo::image() const
{
    return m_image;
}

QString Platillo::status() const
{
    return m_status;
}


void Platillo::setName(QString names)
{
    if (m_name == names)
        return;
    qDebug() << "--> Nombre modificado:" << names;
    m_name = names;
    emit nameChanged(m_name);
}

void Platillo::setPrice(float price)
{
    if (m_price == price)
        return;
    qDebug() << "--> Precio modificado:" << price;
    m_price = price;
    emit priceChanged(m_price);
}

void Platillo::setDescription(QString description)
{
    if (m_description == description)
        return;
    qDebug() << "--> Descripcion modificada:" << description;
    m_description = description;
    emit descriptionChanged(m_description);
}

void Platillo::setCategory(QString category)
{
    if (m_category == category)
        return;
    qDebug() << "--> Categoria modificado:" << category;
    m_category = category;
    emit categoryChanged(m_category);
}

void Platillo::setId(int id)
{
    if (m_id == id)
        return;

    m_id = id;
    emit idChanged(m_id);
}

void Platillo::setImage(QString image)
{
    if (m_image == image)
        return;

    m_image = image;
    emit imageChanged(m_image);
}

void Platillo::setStatus(QString status)
{
    if (m_status == status)
        return;

    m_status = status;
    emit statusChanged(m_status);
}
