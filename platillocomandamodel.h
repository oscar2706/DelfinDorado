#ifndef PLATILLOCOMANDAMODEL_H
#define PLATILLOCOMANDAMODEL_H

#include <platillocomanda.h>

#include <QObject>
#include <QAbstractListModel>
#include <QDebug>
#include <QtSql>
#include <QSqlDatabase>
#include <QSqlQuery>

class PlatilloComandaModel : public QAbstractListModel
{
    Q_OBJECT
    enum PlatilloComandaRoles {
      idComandaRole,
      idPlatilloRole,
      nombreRole,
      cantidadRole,
      precioUnidadRole,
      totalRole
    };
public:
    explicit PlatilloComandaModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role) const;
    bool setData(const QModelIndex &index, const QVariant &value, int role);
    Qt::ItemFlags flags(const QModelIndex& index) const;
    QHash<int, QByteArray> roleNames() const;

    void addPlatilloComanda(PlatilloComanda *nuevoPlatilloComanda);

    //Q_INVOKABLE void setIdMesero(const int &idEmpleado);
    Q_INVOKABLE bool comandaAlreadySent();
    Q_INVOKABLE bool saveNewComandaInDataBase();
    Q_INVOKABLE void setComandaTaken();
    Q_INVOKABLE void setIdComanda(const int &idComanda);
    Q_INVOKABLE void addPlatillo(const int &idComanda, const QString &nombrePlatillo, const int &cantidad);
    Q_INVOKABLE bool removePlatillo(const int idPlatillo);
    Q_INVOKABLE void setQuantity(const int &idComanda, const int &idPlatillo, const int &cantidad);
    Q_INVOKABLE void modeloEstado(const int &idEstadoPreparacion);
    Q_INVOKABLE void modifyStatus(const int &idPlatillosComanda, const int &idNuevoEstado);
    Q_INVOKABLE float getTotalComanda();
signals:

private:
    bool comandaEnviada = false;
    int idComandaActual;
    bool cargandoComanda = false;
    float total;
    bool insertPlatilloComandaInDataBase(PlatilloComanda *platilloComandaToSave);
    QList<PlatilloComanda *>::iterator itr;
    QList<PlatilloComanda *> misPlatillosComanda;
};

#endif // PLATILLOCOMANDAMODEL_H
