#include "platillocomanda.h"

PlatilloComanda::PlatilloComanda(QObject *parent) : QObject(parent)
{

}

PlatilloComanda::PlatilloComanda(const int &_idComanda, const int &_idPlatillo, const int &_Cantidad, QObject *parent):
    QObject (parent),m_idComanda(_idComanda), m_idPlatillo (_idPlatillo), m_cantidad(_Cantidad)
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
