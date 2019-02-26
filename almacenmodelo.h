class almacenProducto;

#ifndef ALMACENMODELO_H
#define ALMACENMODELO_H

#include <QAbstractTableModel>
#include <almacenProducto.h>
#include <QtSql>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QDebug>

class almacenModelo : public QAbstractTableModel
{
    Q_OBJECT
    enum RoleAlmacen
    {
        IdProducto,
        Nombre,
        Descripcion,
        Cantidad,
        Costo,
        Categoria,
        UnidadMedida
    };

public:
    explicit almacenModelo(QObject *parent = nullptr);

    Q_INVOKABLE int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    Q_INVOKABLE int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    Q_INVOKABLE QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    Qt::ItemFlags flags(const QModelIndex& index) const override;
    Q_INVOKABLE QStringList getInfoContenido(int);
    Q_INVOKABLE bool setProductoAlmacen(QString,QString,QString,QString,QString);
    Q_INVOKABLE QString getInfoProd(QString,int);
    Q_INVOKABLE bool verificarCantidad(QString,QString);
    Q_INVOKABLE void actualizarCantidad(QString,QString,QString);
    Q_INVOKABLE QHash<int, QByteArray> roleNames() const override;


private:
    QList<almacenProducto *>::iterator itr;
    QList<almacenProducto *> m_producto;
};

#endif // ALMACENMODELO_H
