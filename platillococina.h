#ifndef PLATILLOCOCINA_H
#define PLATILLOCOCINA_H

#include <QObject>

class PlatilloCocina : public QObject
{
    Q_OBJECT
public:
    explicit PlatilloCocina(QObject *parent = nullptr);
    PlatilloCocina(const int &_idPlatillosComanda, const int &_idComanda, const int &_idPlatillo,
                   const QString &_nombre, const int &_idEstadoPreparacion, QObject *parent = nullptr);

    Q_PROPERTY(int idPlatillosComanda READ idPlatillosComanda WRITE setIdPlatillosComanda NOTIFY idPlatillosComandaChanged)
    Q_PROPERTY(int idComanda READ idComanda WRITE setIdComanda NOTIFY idComandaChanged)
    Q_PROPERTY(int idPlatillo READ idPlatillo WRITE setIdPlatillo NOTIFY idPlatilloChanged)
    Q_PROPERTY(QString nombrePlatillo READ nombrePlatillo WRITE setNombrePlatillo NOTIFY nombrePlatilloChanged)
    Q_PROPERTY(int idEstadoPreparacion READ idEstadoPreparacion WRITE setIdEstadoPreparacion NOTIFY idEstadoPreparacionChanged)

    int idPlatillosComanda() const;
    int idComanda() const;
    int idPlatillo() const;
    QString nombrePlatillo() const;
    int idEstadoPreparacion() const;

public slots:
    void setIdPlatillosComanda(int idPlatillosComanda);
    void setIdComanda(int idComanda);
    void setIdPlatillo(int idPlatillo);
    void setNombrePlatillo(QString nombrePlatillo);
    void setIdEstadoPreparacion(int idEstadoPreparacion);
signals:
    void idPlatillosComandaChanged(int idPlatillosComanda);
    void idComandaChanged(int idComanda);
    void idPlatilloChanged(int idPlatillo);
    void nombrePlatilloChanged(QString nombrePlatillo);
    void idEstadoPreparacionChanged(int idEstadoPreparacion);

private:
    int m_idPlatillosComanda;
    int m_idComanda;
    int m_idPlatillo;
    QString m_nombrePlatillo;
    int m_idEstadoPreparacion;
};

#endif // PLATILLOCOCINA_H
