#ifndef PEDIDO_H
#define PEDIDO_H

#include <QObject>
#include <QDebug>

class Pedido : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int idPedido READ idPedido WRITE setIdPedido NOTIFY idPedidoChanged)
    Q_PROPERTY(float total READ total WRITE setTotal NOTIFY totalChanged)
    Q_PROPERTY(QString fecha READ fecha WRITE setFecha NOTIFY fechaChanged)
    Q_PROPERTY(int idEmpleado READ idEmpleado WRITE setIdEmpleado NOTIFY idEmpleadoChanged)

public:
    explicit Pedido(QObject *parent = nullptr);
    Pedido(int _idPedido, const float &_total, const QString &_fecha, const int &_idEmpleado, QObject * parent = nullptr);
    int idPedido() const;
    float total() const;
    QString fecha() const;
    int idEmpleado() const;

signals:
    void idPedidoChanged(int idPedido);
    void totalChanged(float total);
    void fechaChanged(QString fecha);
    void idEmpleadoChanged(int idEmpleado);

public slots:
    void setIdPedido(int idPedido);
    void setTotal(float total);
    void setFecha(QString fecha);
    void setIdEmpleado(int idEmpleado);

private:
    int m_idPedido;
    float m_total;
    QString m_fecha;
    int m_idEmpleado;
};

#endif // PEDIDO_H
