#include "platillocomanda.h"

PlatilloComanda::PlatilloComanda(QObject *parent) : QObject(parent)
{

}

PlatilloComanda::PlatilloComanda(const int &_idComanda, const int &_idPlatillo, const QString &_nombre ,const int &_Cantidad, const float &_precioUnidad, const float &_totalPlatillo,QObject *parent):
    QObject (parent),m_idComanda(_idComanda), m_idPlatillo (_idPlatillo), m_nombrePlatillo(_nombre) ,m_cantidad(_Cantidad), m_precioUnidad(_precioUnidad), m_totalPlatillo (_totalPlatillo)
{

}

int PlatilloComanda::idComanda() const
{
    return m_idComanda;
}

int PlatilloComanda::idPlatillo() const
{
    return m_idPlatillo;
}

int PlatilloComanda::cantidad() const
{
    return m_cantidad;
}

float PlatilloComanda::totalPlatillo() const
{
    return m_totalPlatillo;
}

float PlatilloComanda::precioUnidad() const
{
    return m_precioUnidad;
}

QString PlatilloComanda::nombrePlatillo() const
{
    return m_nombrePlatillo;
}

void PlatilloComanda::setIdComanda(int idComanda)
{
    if (m_idComanda == idComanda)
        return;

    m_idComanda = idComanda;
    emit idComandaChanged(m_idComanda);
}

void PlatilloComanda::setIdPlatillo(int idPlatillo)
{
    if (m_idPlatillo == idPlatillo)
        return;

    m_idPlatillo = idPlatillo;
    emit idPlatilloChanged(m_idPlatillo);
}

void PlatilloComanda::setCantidad(int cantidad)
{
    if (m_cantidad == cantidad)
        return;

    m_cantidad = cantidad;
    emit cantidadChanged(m_cantidad);
}

void PlatilloComanda::setTotalPlatillo(float totalPlatillo)
{
    qWarning("Floating point comparison needs context sanity check");
    if (qFuzzyCompare(m_totalPlatillo, totalPlatillo))
        return;

    m_totalPlatillo = totalPlatillo;
    emit totalPlatilloChanged(m_totalPlatillo);
}

void PlatilloComanda::setPrecioUnidad(float precioUnidad)
{
    qWarning("Floating point comparison needs context sanity check");
    if (qFuzzyCompare(m_precioUnidad, precioUnidad))
        return;

    m_precioUnidad = precioUnidad;
    emit precioUnidadChanged(m_precioUnidad);
}

void PlatilloComanda::setNombrePlatillo(QString nombrePlatillo)
{
    if (m_nombrePlatillo == nombrePlatillo)
        return;

    m_nombrePlatillo = nombrePlatillo;
    emit nombrePlatilloChanged(m_nombrePlatillo);
}
