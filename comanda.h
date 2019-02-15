#ifndef COMANDA_H
#define COMANDA_H

#include <QObject>
#include <QDebug>

class Comanda : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int idComanda READ idComanda WRITE setIdComanda NOTIFY idComanda)
    Q_PROPERTY(QString fecha READ fecha WRITE setFecha NOTIFY fechaChanged)
    Q_PROPERTY(int idEmpleado READ idEmpleado WRITE setIdEmpleado NOTIFY idEmpleadoChanged)
    Q_PROPERTY(int idMesa READ idMesa WRITE setIdMesa NOTIFY idMesaChanged)
    Q_PROPERTY(int idEstadoComanda READ idEstadoComanda WRITE setIdEstadoComanda NOTIFY idEstadoComandaChanged)
public:
    explicit Comanda(QObject *parent = nullptr);
    Comanda(int _idComanda, const QString &_fecha,
            const int &_idEmpleado, const int &_idMesa, const int &_idEstadoComanda, QObject * parent = nullptr);
    int idComanda() const;
    QString fecha() const;
    int idEmpleado() const;
    int idMesa() const;
    int idEstadoComanda() const;

signals:
    void idComandaChanged(int idComanda);
    void fechaChanged(QString fecha);
    void idEmpleadoChanged(int idEmpleado);
    void idMesaChanged(int idMesa);
    void idEstadoComandaChanged(int idEstadoComanda);

public slots:
    void setIdComanda(int idComanda);
    void setFecha(QString fecha);
    void setIdEmpleado(int idEmpleado);
    void setIdMesa(int idMesa);
    void setIdEstadoComanda(int idEstadoComanda);

private:
    int m_idComanda;
    QString m_fecha;
    int m_idEmpleado;
    int m_idMesa;
    int m_idEstadoComanda;
};

#endif // COMANDA_H
