#include "almacenProducto.h"

almacenProducto::almacenProducto()
{

}

almacenProducto::almacenProducto(int id_,QString nombre_,QString descripcion_, int cantidad_,
                                 float costo_,QString categoria_,QString medida_)
{
    idProducto = id_;
    nombre = nombre_;
    descripcion = descripcion_;
    cantidad = cantidad_;
    costo = costo_;
    categoria = categoria_;
    medida = medida_;
}

int almacenProducto::getIdProducto()
{
    return idProducto;
}
QString almacenProducto::getNombre()
{
    return nombre;
}

QString almacenProducto::getDescripcion()
{
    return descripcion;
}

int almacenProducto::getCantidad()
{
    return cantidad;
}
float almacenProducto::getCosto()
{
    return costo;
}
QString almacenProducto::getCategoria()
{
   return categoria;
}
QString almacenProducto::getMedida()
{
    return medida;
}

void almacenProducto::setCantidad(int nuevaCantidad)
{
    cantidad = nuevaCantidad;
}
