#ifndef PEDIDOPRODUCTOS_H
#define PEDIDOPRODUCTOS_H

#include <QObject>

class PedidoProductos : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int idPedido READ idPedido WRITE setIdPedido NOTIFY idPedidoChanged)
    Q_PROPERTY(int idProducto READ idProducto WRITE setIdProducto NOTIFY idProductoChanged)
    Q_PROPERTY(QString nombre READ nombre WRITE setNombre NOTIFY nombreChanged)
    Q_PROPERTY(int cantidad READ cantidad WRITE setCantidad NOTIFY cantidadChanged)
    Q_PROPERTY(QString unidadMedida READ unidadMedida WRITE setUnidadMedida NOTIFY unidadMedidaChanged)
    Q_PROPERTY(float costo READ costo WRITE setCosto NOTIFY costoChanged)
    Q_PROPERTY(float totalProducto READ totalProducto WRITE setTotalProducto NOTIFY totalProductoChanged)

public:
    explicit PedidoProductos(QObject *parent = nullptr);
    PedidoProductos(const int &_idPedido, const int &_idProducto, const QString &_nombre, const int &_cantidad, const QString &_unidadMedida, const float &_costo, const float &_totalProducto, QObject * parent = nullptr);
    int idPedido() const;
    int idProducto() const;
    QString nombre() const;
    int cantidad() const;
    QString unidadMedida() const;
    float costo() const;
    float totalProducto() const;

signals:
    void idPedidoChanged(int idPedido);
    void idProductoChanged(int idProducto);
    void nombreChanged(QString nombre);
    void cantidadChanged(int cantidad);
    void unidadMedidaChanged(QString unidadMedida);
    float costoChanged(float costo);
    float totalProductoChanged(float totalProducto);

public slots:
    void setIdPedido(int idPedido);
    void setIdProducto(int idProducto);
    void setNombre(QString nombre);
    void setCantidad(int cantidad);
    void setUnidadMedida(QString unidadMedida);
    void setCosto(float costo);
    void setTotalProducto(float totalProducto);

private:
    int m_idPedido;
    int m_idProducto;
    QString m_nombre;
    int m_cantidad;
    QString m_unidaMedida;
    float m_costo;
    float m_totalProducto;
};

#endif // PEDIDOPRODUCTOS_H
