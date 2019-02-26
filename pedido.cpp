#include "pedido.h"

Pedido::Pedido(QObject *parent) : QObject(parent)
{

}

Pedido::Pedido(int _idPedido, const float &_total, const QString &_fecha, const int &_idEmpleado, QObject *parent):
    QObject (parent),m_idPedido (_idPedido), m_total (_total), m_fecha (_fecha), m_idEmpleado (_idEmpleado)
{

}

int Pedido::idPedido() const
{
    return m_idPedido;
}

float Pedido::total() const
{
    return m_total;
}

QString Pedido::fecha() const
{
    return m_fecha;
}

int Pedido::idEmpleado() const
{
    return m_idEmpleado;
}

void Pedido::setIdPedido(int idPedido)
{
    if(m_idPedido == idPedido)
        return;
    else
    {
        m_idPedido = idPedido;
        emit idPedidoChanged(m_idPedido);
    }
}

void Pedido::setTotal(float total)
{
    qWarning();
    if(qFuzzyCompare(m_total, total))
        return;
    else
    {
        m_total = total;
        emit totalChanged(m_total);
    }
}

void Pedido::setFecha(QString fecha)
{
    if(m_fecha == fecha)
        return;
    else
    {
        m_fecha = fecha;
        emit fechaChanged(m_fecha);
    }
}

void Pedido::setIdEmpleado(int idEmpleado)
{
    if(m_idEmpleado == idEmpleado)
        return;
    else
    {
        m_idEmpleado = idEmpleado;
        emit idEmpleadoChanged(m_idEmpleado);
    }
}
