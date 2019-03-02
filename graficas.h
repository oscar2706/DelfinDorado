#ifndef GRAFICAS_H
#define GRAFICAS_H

#include <QObject>
#include <QDebug>
#include <QtSql>
#include <QSqlDatabase>
#include <QSqlQuery>

class Graficas : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString fechaInicial READ fechaInicial WRITE setFechaInicial NOTIFY fechaInicialChanged)
    Q_PROPERTY(QString fechaFinal READ fechaFinal WRITE setFechaFinal NOTIFY fechaFinalChanged)

    QString m_fechaInicial;
    QString m_fechaFinal;

public:
    explicit Graficas(QObject *parent = nullptr);
    Graficas(const QString &_fechaInicial, const QString &_fechaFinal, QObject * parent = nullptr);

    //graficas
    Q_INVOKABLE QString nombrePlatilloMasVendido(int numeroPlatillo);
    Q_INVOKABLE int cantidadPlatilloMasVendido(int numeroPlatillo);

    Q_INVOKABLE QString categoriaPlatilloMasVendidoCategoria(int numeroCategoria);
    Q_INVOKABLE QString nombrePlatilloMasVendidoCategoria(int numeroCategoria);
    Q_INVOKABLE int cantidadPlatilloMasVendidoCategoria(int numeroCategoria);

    Q_INVOKABLE QString categoriaPlatilloMenosVendidoCategoria(int numeroCategoria);
    Q_INVOKABLE QString nombrePlatilloMenosVendidoCategoria(int numeroCategoria);
    Q_INVOKABLE int cantidadPlatilloMenosVendidoCategoria(int numeroCategoria);

    Q_INVOKABLE QString nombreProductosMasPedidos(int numeroProducto);
    Q_INVOKABLE int cantidadProductosMasPedidos(int numeroProducto);

    Q_INVOKABLE QString nombreComandasAtendidas (int numeroComandas);
    Q_INVOKABLE int cantidadComandasAtendidas(int numeroComandas);

    //valores directos
    Q_INVOKABLE int cantidadComandasGeneradas();
    Q_INVOKABLE float promedioVentas();


    QString fechaInicial() const;
    QString fechaFinal() const;

signals:
    void fechaInicialChanged(QString fechaInicial);
    void fechaFinalChanged(QString fechaFinal);

public slots:
    void setFechaInicial(QString fechaInicial);
    void setFechaFinal(QString fechaFinal);
};

#endif // GRAFICAS_H
