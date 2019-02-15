#ifndef COMANDAMODELO_H
#define COMANDAMODELO_H

#include <comanda.h>

#include <QObject>
#include <QAbstractListModel>
#include <QDebug>
#include <QtSql>
#include <QSqlDatabase>
#include <QSqlQuery>

class ComandaModelo : public QAbstractListModel
{
    Q_OBJECT
    enum ComandaRole
    {
        idComandaRole,
        fechaRole,
        idEmpleadoRole,
        idMesaRole,
        idEstadoComandaRole
    };

public:
    explicit ComandaModelo(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role) const;
    bool setData(const QModelIndex &index, const QVariant &value, int role);
    Qt::ItemFlags flags(const QModelIndex& index) const;
    QHash<int, QByteArray> roleNames() const;

    void addComanda(Comanda *nuevaComanda);

    Q_INVOKABLE void addComanda(const QString &fecha, const int &idEmpleado, const int &idMesa, const int &idEstadoComanda);
    Q_INVOKABLE QList<Comanda*> getComandasMesero(int idMesero);
    //Q_INVOKABLE QList<Comanda*> getComandasMesero(int idMesero);
    //Q_INVOKABLE QList<Comanda*> getComandasMesero(int idMesero);

private:
    bool insertComandaInDataBase(Comanda *comandaNueva);

    //int idEmpleado;

    QList<Comanda*>::iterator itr;
    QList<Comanda*> misComandas;
};

#endif // COMANDAMODELO_H
