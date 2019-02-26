#ifndef PEDIDOPRODUCTOSMODELO_H
#define PEDIDOPRODUCTOSMODELO_H

#include <pedidoproductos.h>

#include <QObject>
#include <QAbstractListModel>
#include <QDebug>
#include <QtSql>
#include <QSqlDatabase>
#include <QSqlQuery>

class PedidoProductosModelo : public QAbstractListModel
{
    Q_OBJECT
    enum PedidoProductosRoles {
        idPedidoRole,
        idProductoRole,
        nombreRole,
        cantidadRole,
        unidadMedidaRole,
        costoRole,
        totalProductoRole
    };

public:
    explicit PedidoProductosModelo(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role) const;
    bool setData(const QModelIndex &index, const QVariant &value, int role);
    Qt::ItemFlags flags(const QModelIndex& index) const;
    QHash<int, QByteArray> roleNames() const;

    void addPedidoProductos(PedidoProductos *nuevoPedidoProductos);

    Q_INVOKABLE void addPedidoProductos(const int &idPedido, const QString &nombre, const int &cantidad);
    Q_INVOKABLE bool saveNewPedidoInDataBase(int idPedido);
    Q_INVOKABLE bool removeProducto(const int idProducto);
    Q_INVOKABLE void setCantidad(const int &idPedido, const int &idProducto, const int &cantidad);
    Q_INVOKABLE void clearModel();
    Q_INVOKABLE float getTotalPedido();
    Q_INVOKABLE float getTotalProducto(const QString &nombre, const int &cantidad);
    Q_INVOKABLE QString getUnidadMedida(const QString &nombre);

private:
    float totalPedido;

    bool insertPedidoProductosInDataBase(PedidoProductos *pedidoProductosToSave);

    QList<PedidoProductos *>::iterator itr;
    QList<PedidoProductos *> misPedidoProductos;
};

#endif // PEDIDOPRODUCTOSMODELO_H
