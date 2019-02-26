#ifndef ALMACENPRODUCTO_H
#define ALMACENPRODUCTO_H

#include <QObject>
#include <QtSql>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QDebug>


class almacenProducto
{

private:
    int idProducto;
    QString nombre;
    QString descripcion;
    int cantidad;
    float costo;
    QString categoria;
    QString medida;
public:
    almacenProducto();
    almacenProducto(int,QString,QString,int,float,QString,QString);
    int getIdProducto();
    QString getNombre();
    QString getDescripcion();
    int getCantidad();
    float getCosto();
    QString getCategoria();
    QString getMedida();
    void setCantidad(int);

};

#endif // ALMACENPRODUCTO_H

