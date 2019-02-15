#include "comanda.h"

Comanda::Comanda(QObject *parent) : QObject(parent)
{

}

Comanda::Comanda(int _idComanda, const QString &_fecha, const int &_idEmpleado, const int &_idMesa, const int &_idEstadoComanda, QObject * parent) :
    QObject (parent),m_idComanda(_idComanda), m_fecha(_fecha), m_idEmpleado(_idEmpleado), m_idMesa(_idMesa), m_idEstadoComanda(_idEstadoComanda)
{

}

int Comanda::idComanda() const
{
    return m_idComanda;
}

QString Comanda::fecha() const
{
    return m_fecha;
}

int Comanda::idEmpleado() const
{
    return m_idEmpleado;
}

int Comanda::idMesa() const
{
    return m_idMesa;
}

int Comanda::idEstadoComanda() const
{
    return m_idEstadoComanda;
}

void Comanda::setIdComanda(int idComanda)
{
    if(m_idComanda == idComanda)
        return;
    else
    {
        m_idComanda = idComanda;
        emit idComandaChanged(m_idComanda);
    }
}

void Comanda::setFecha(QString fecha)
{
    if(m_fecha == fecha)
        return;
    else
    {
        m_fecha = fecha;
        emit fechaChanged(m_fecha);
    }
}

void Comanda::setIdEmpleado(int idEmpleado)
{
    if(m_idEmpleado == idEmpleado)
        return;
    else
    {
        m_idEmpleado = idEmpleado;
        emit idEmpleadoChanged(m_idEmpleado);
    }
}

void Comanda::setIdMesa(int idMesa)
{
    if(m_idMesa == idMesa)
        return;
    else
    {
        m_idMesa = idMesa;
        emit idMesaChanged(m_idMesa);
    }
}

void Comanda::setIdEstadoComanda(int idEstadoComanda)
{
    if(m_idEstadoComanda == idEstadoComanda)
        return;
    else
    {
        m_idEstadoComanda = idEstadoComanda;
        emit idEstadoComandaChanged(m_idEstadoComanda);
    }
}
