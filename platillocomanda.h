#ifndef PLATILLOCOMANDA_H
#define PLATILLOCOMANDA_H

#include <QObject>

class PlatilloComanda : public QObject
{
    Q_OBJECT
public:
    explicit PlatilloComanda(QObject *parent = nullptr);
    PlatilloComanda(const int &_idComanda, const int &_idPlatillo, const int &_Cantidad, QObject *parent = nullptr);

    Q_PROPERTY(int idComanda READ idComanda WRITE setIdComanda NOTIFY idComandaChanged)
    Q_PROPERTY(int idPlatillo READ idPlatillo WRITE setIdPlatillo NOTIFY idPlatilloChanged)
    Q_PROPERTY(int cantidad READ cantidad WRITE setCantidad NOTIFY cantidadChanged)

    int idComanda() const;
    int idPlatillo() const;
    int cantidad() const;

public slots:
    void setIdComanda(int idComanda);
    void setIdPlatillo(int idPlatillo);
    void setCantidad(int cantidad);

signals:
    void idComandaChanged(int idComanda);
    void idPlatilloChanged(int idPlatillo);
    void cantidadChanged(int cantidad);

private:
    int m_idComanda;
    int m_idPlatillo;
    int m_cantidad;
};

#endif // PLATILLOCOMANDA_H
