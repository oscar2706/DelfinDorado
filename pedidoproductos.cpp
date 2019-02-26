#include "pedidoproductos.h"

PedidoProductos::PedidoProductos(QObject *parent) : QObject(parent)
{

}

PedidoProductos::PedidoProductos(const int &_idPedido, const int &_idProducto, const QString &_nombre, const int &_cantidad, const QString &_unidadMedida, const float &_costo, const float &_totalProducto, QObject *parent):
    QObject (parent),m_idPedido(_idPedido),m_idProducto(_idProducto),m_nombre(_nombre),m_cantidad(_cantidad),m_unidaMedida(_unidadMedida),m_costo(_costo),m_totalProducto(_totalProducto)
{

}

int PedidoProductos::idPedido() const
{
    return m_idPedido;
}

int PedidoProductos::idProducto() const
{
    return m_idProducto;
}

QString PedidoProductos::nombre() const
{
    return m_nombre;
}

int PedidoProductos::cantidad() const
{
    return m_cantidad;
}

QString PedidoProductos::unidadMedida() const
{
    return m_unidaMedida;
}

float PedidoProductos::costo() const
{
    return m_costo;
}

float PedidoProductos::totalProducto() const
{
    return m_totalProducto;
}

void PedidoProductos::setIdPedido(int idPedido)
{
    if(m_idPedido == idPedido)
        return;
    else {
        m_idPedido = idPedido;
        emit idPedidoChanged(m_idPedido);
    }
}

void PedidoProductos::setIdProducto(int idProducto)
{
    if(m_idProducto == idProducto)
        return;
    else {
        m_idProducto = idProducto;
        emit idProductoChanged(m_idProducto);
    }
}

void PedidoProductos::setNombre(QString nombre)
{
    if(m_nombre == nombre)
        return;
    else {
        m_nombre = nombre;
        emit nombreChanged(m_nombre);
    }
}

void PedidoProductos::setCantidad(int cantidad)
{
    if(m_cantidad == cantidad)
        return;
    else {
        m_cantidad = cantidad;
        emit cantidadChanged(m_cantidad);
    }
}

void PedidoProductos::setUnidadMedida(QString unidadMedida)
{
    if(m_unidaMedida == unidadMedida)
        return;
    else {
        m_unidaMedida = unidadMedida;
        emit unidadMedidaChanged(m_unidaMedida);
    }
}

void PedidoProductos::setCosto(float costo)
{
    if(m_costo == costo)
        return;
    else {
        m_costo = costo;
        emit costoChanged(m_costo);
    }
}

void PedidoProductos::setTotalProducto(float totalProducto)
{
    if(m_totalProducto == totalProducto)
        return;
    else {
        m_totalProducto = totalProducto;
        emit totalProductoChanged(m_totalProducto);
    }
}
