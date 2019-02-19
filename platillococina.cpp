#include "platillococina.h"

PlatilloCocina::PlatilloCocina(QObject *parent) : QObject(parent)
{

}

PlatilloCocina::PlatilloCocina(const int &_idPlatilloComanda, const int &_idComanda, const int &_idPlatillo, const QString &_nombre, const int &_idEstadoPreparacion, QObject *parent):
    QObject (parent),m_idPlatillosComanda(_idPlatilloComanda),m_idComanda(_idComanda), m_idPlatillo (_idPlatillo), m_nombrePlatillo(_nombre) ,m_idEstadoPreparacion(_idEstadoPreparacion)
{

}

int PlatilloCocina::idPlatillosComanda() const
{
    return m_idPlatillosComanda;
}

int PlatilloCocina::idComanda() const
{
    return m_idComanda;
}

int PlatilloCocina::idPlatillo() const
{
    return m_idPlatillo;
}

QString PlatilloCocina::nombrePlatillo() const
{
    return m_nombrePlatillo;
}

int PlatilloCocina::idEstadoPreparacion() const
{
    return m_idEstadoPreparacion;
}

void PlatilloCocina::setIdPlatillosComanda(int idPlatillosComanda)
{
    if (m_idPlatillosComanda == idPlatillosComanda)
        return;

    m_idPlatillosComanda = idPlatillosComanda;
    emit idPlatillosComandaChanged(m_idPlatillosComanda);
}

void PlatilloCocina::setIdComanda(int idComanda)
{
    if (m_idComanda == idComanda)
        return;

    m_idComanda = idComanda;
    emit idComandaChanged(m_idComanda);
}

void PlatilloCocina::setIdPlatillo(int idPlatillo)
{
    if (m_idPlatillo == idPlatillo)
        return;

    m_idPlatillo = idPlatillo;
    emit idPlatilloChanged(m_idPlatillo);
}

void PlatilloCocina::setNombrePlatillo(QString nombrePlatillo)
{
    if (m_nombrePlatillo == nombrePlatillo)
        return;

    m_nombrePlatillo = nombrePlatillo;
    emit nombrePlatilloChanged(m_nombrePlatillo);
}

void PlatilloCocina::setIdEstadoPreparacion(int idEstadoPreparacion)
{
    if(m_idEstadoPreparacion == idEstadoPreparacion)
        return;

    m_idEstadoPreparacion = idEstadoPreparacion;
    emit idEstadoPreparacionChanged(m_idEstadoPreparacion);
}
