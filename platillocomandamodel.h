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
      cantidadRole
    };
public:
    explicit PlatilloComandaModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role) const;
    bool setData(const QModelIndex &index, const QVariant &value, int role);
    Qt::ItemFlags flags(const QModelIndex& index) const;
    QHash<int, QByteArray> roleNames() const;

    void addPlatilloComanda(PlatilloComanda *nuevoPlatilloComanda);

    Q_INVOKABLE void addPlatillo(const int &idComanda, const int &idPlatillo, const int &cantidad);

signals:

private:
    bool insertPlatilloComandaInDataBase(PlatilloComanda *platilloComandaToSave);

    QList<PlatilloComanda *>::iterator itr;
    QList<PlatilloComanda *> misPlatillosComanda;
};

#endif // PLATILLOCOMANDAMODEL_H
