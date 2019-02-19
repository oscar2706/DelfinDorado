#ifndef PLATILLOCOCINAMODELO_H
#define PLATILLOCOCINAMODELO_H

#include <platillococina.h>

#include <QObject>
#include <QAbstractListModel>
#include <QDebug>
#include <QtSql>
#include <QSqlDatabase>
#include <QSqlQuery>

class PlatilloCocinaModelo : public QAbstractListModel
{
    Q_OBJECT
    enum PlatilloCocinaRoles
    {
        idPlatillosComandaRole,
        idComandaRole,
        idPlatilloRole,
        nombreRole,
        idEstadoPreparacionRole
    };
public:
    explicit PlatilloCocinaModelo(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role) const;
    bool setData(const QModelIndex &index, const QVariant &value, int role);
    Qt::ItemFlags flags(const QModelIndex& index) const;
    QHash<int, QByteArray> roleNames() const;

    void addPlatilloCocina(PlatilloCocina *nuevoPlatilloComanda);

    Q_INVOKABLE void modeloEstado(const int &idEstadoPreparacion);
    Q_INVOKABLE void modifyStatus(const int &idPlatillosComanda, const int &idNuevoEstado);
signals:

private:
    QList<PlatilloCocina *>::iterator itr;
    QList<PlatilloCocina *> misPlatillosCocina;
};

#endif // PLATILLOCOCINAMODELO_H
