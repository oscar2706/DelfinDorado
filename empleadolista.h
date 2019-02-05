#ifndef EMPLEADOLISTA_H
#define EMPLEADOLISTA_H

#include <QObject>
#include <QVector>
#include <QString>
#include <QDate>
#include <QtSql>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QDebug>

struct ToDoItem
{
    QString idEmpleado;
    QString nombreEmpleado;
    QString puestoEmpleado;
    bool eleccionEmpleado;
};

class EmpleadoLista: public QObject
{
    Q_OBJECT
public:
    explicit EmpleadoLista(QObject *parent = nullptr);

    QVector<ToDoItem> items() const;

    bool setItemAt(int indice, const ToDoItem &item);

signals:
    void preItemAppended();
    void postItemAppended();

    void preItemRemoved(int indice);
    void postItemRemoved();

public slots:
    void appendItem();

    void removeCheckedItem();

private:
    QVector<ToDoItem> mItems;
};

#endif // EMPLEADOLISTA_H
