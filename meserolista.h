#ifndef MESEROLISTA_H
#define MESEROLISTA_H

#include <QObject>
#include<QVector>
#include <QtSql>
#include <QSqlDatabase>
#include <QSqlQuery>

struct meseroItem{
    QString id;
    QString nombre;
    bool seleccion;
};

class meseroLista : public QObject
{
    Q_OBJECT

private:
    QVector<meseroItem> mItems;
    QSqlDatabase mDatabase;

public:
    explicit meseroLista(QObject *parent = nullptr);
    QVector<meseroItem> items() const;
    bool setItemAt(int index,const meseroItem &item);
    Q_INVOKABLE void setComanda(QString);
    Q_INVOKABLE bool verificaCampoVacio();
    Q_INVOKABLE int verificaEstadoMesa(int);
    Q_INVOKABLE QString getMeseroAsignado(int);
    Q_INVOKABLE void restablecerRadioButton();
    Q_INVOKABLE void setEstadoDisponible(QString);

signals:
    void preItemAppend();
    void postItemAppend();

    void postItemUpdate();

public slots:
    void appendItem();
    void updateItem(int);

};

#endif // MESEROLISTA_H
