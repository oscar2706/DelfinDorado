#ifndef PLATILLOMODEL_H
#define PLATILLOMODEL_H

#include <platillo.h>

#include <QObject>
#include <QAbstractListModel>
#include <QDebug>
#include <QtSql>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QImage>
#include <QFile>

class PlatilloModel : public QAbstractListModel
{
    Q_OBJECT
    enum PlatilloRoles{
        NameRole = Qt::UserRole +1,
        IdRole,
        ImageRole,
        PriceRole,
        DescriptionRole,
        CategoryRole,
        StatusRole
    };
public:
    explicit PlatilloModel(QObject *parent = nullptr);

    //Metodos necesarios para que el model funcione
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role) const;
    bool setData(const QModelIndex &index, const QVariant &value, int role);
    Qt::ItemFlags flags(const QModelIndex& index) const;
    QHash<int, QByteArray> roleNames() const;

    void addPlatillo(Platillo *nuevoPlatillo);

    void printPlatillos();
    //Metodos accesibles en QML
    Q_INVOKABLE void addPlatillo();
    Q_INVOKABLE void addPlatillo(const QString &name, const QString &price);
    Q_INVOKABLE void removePlatillo(int index);
    Q_INVOKABLE void removeLastPlatillo();
signals:

public slots:
private:
    QString byteArrayToString(QByteArray &img);
    QList<Platillo *>::iterator itr;
    QList<Platillo*> misPlatilos;
};

#endif // PLATILLOMODEL_H
