#ifndef PLATILLOCOMANDA_H
#define PLATILLOCOMANDA_H

#include <QObject>

class PlatilloComanda : public QObject
{
    Q_OBJECT
public:
    explicit PlatilloComanda(QObject *parent = nullptr);
    PlatilloComanda(const int &_idComanda, const int &_idPlatillo, const QString &_nombre ,const int &_Cantidad,
                    const float &_precioUnidad, const float &_totalPlatillo, QObject *parent = nullptr);

    Q_PROPERTY(int idComanda READ idComanda WRITE setIdComanda NOTIFY idComandaChanged)
    Q_PROPERTY(int idPlatillo READ idPlatillo WRITE setIdPlatillo NOTIFY idPlatilloChanged)
    Q_PROPERTY(QString nombrePlatillo READ nombrePlatillo WRITE setNombrePlatillo NOTIFY nombrePlatilloChanged)
    Q_PROPERTY(int cantidad READ cantidad WRITE setCantidad NOTIFY cantidadChanged)
    Q_PROPERTY(float totalPlatillo READ totalPlatillo WRITE setTotalPlatillo NOTIFY totalPlatilloChanged)
    Q_PROPERTY(float precioUnidad READ precioUnidad WRITE setPrecioUnidad NOTIFY precioUnidadChanged)
    int idComanda() const;
    int idPlatillo() const;
    int cantidad() const;
    float totalPlatillo() const;
    float precioUnidad() const;
    QString nombrePlatillo() const;

public slots:
    void setIdComanda(int idComanda);
    void setIdPlatillo(int idPlatillo);
    void setCantidad(int cantidad);
    void setTotalPlatillo(float totalPlatillo);
    void setPrecioUnidad(float precioUnidad);
    void setNombrePlatillo(QString nombrePlatillo);    
signals:
    void idComandaChanged(int idComanda);
    void idPlatilloChanged(int idPlatillo);
    void cantidadChanged(int cantidad);
    void totalPlatilloChanged(float totalPlatillo);
    void precioUnidadChanged(float precioUnidad);

    void nombrePlatilloChanged(QString nombrePlatillo);

private:
    int m_idComanda;
    int m_idPlatillo;
    int m_cantidad;
    float m_totalPlatillo;
    float m_precioUnidad;
    QString m_nombrePlatillo;
};

#endif // PLATILLOCOMANDA_H
