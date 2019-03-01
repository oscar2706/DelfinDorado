#ifndef MESAMODELO_H
#define MESAMODELO_H

#include <QAbstractListModel>
#include <mesa.h>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QDebug>

class mesaModelo : public QAbstractListModel
{
    Q_OBJECT
    enum RoleMesa
    {
        IdMesa,
        Estado,
        Width,
        Height,
        Capacidad,
        Img
    };

public:
    explicit mesaModelo(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex &index, const QVariant &value,int role = Qt::EditRole) override;
    Qt::ItemFlags flags(const QModelIndex& index) const override;
    QHash<int, QByteArray> roleNames() const override;
    Q_INVOKABLE void setEstadoMesa(int,int);
    QString getImagenMesa(int,int);


private:
    QList<mesa *>::iterator itr;
    QList<mesa *> m_mesa;
};

#endif // MESAMODELO_H
