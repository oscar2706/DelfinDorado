#ifndef PEDIDOMODELO_H
#define PEDIDOMODELO_H

#include <pedido.h>

#include <QObject>
#include <QAbstractListModel>
#include <QDebug>
#include <QtSql>
#include <QSqlDatabase>
#include <QSqlQuery>

class PedidoModelo : public QAbstractListModel
{
    Q_OBJECT
    enum PedidoRoles{
        idPedidoRole,
        totalRole,
        fechaRole,
        idEmpleadoRole
    };

public:
    explicit PedidoModelo(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role) const;
    bool setData(const QModelIndex &index, const QVariant &value, int role);
    Qt::ItemFlags flags(const QModelIndex& index) const;
    QHash<int, QByteArray> roleNames() const;

    void addPedido(Pedido *nuevoPedido);

    Q_INVOKABLE void addPedido(const float &total, const int &idEmpleado);
    Q_INVOKABLE int getUltimoPedido();
private:
    int ultimoPedido;
    bool insertPedidoInDataBase(Pedido *pedidoToSave);

    QList<Pedido *>::iterator itr;
    QList<Pedido *> misPedidos;
};

#endif // PEDIDOMODELO_H
