#include "mesa.h"

mesa::mesa()
{

}
mesa::mesa(int _id,int _estado,int _height,int _width,int _capacidad,QString _img)
{
    idMesa = _id;
    estado = _estado;
    height = _height;
    width = _width;
    capacidad=_capacidad;
    imgMesa = _img;
}
int mesa::getIdMesa(){ return idMesa; }
int mesa::getEstado(){ return estado;}
int mesa::getWidth() { return width; }
int mesa::getHeight(){ return height;}
int mesa::getCapacidad(){ return capacidad;}
QString mesa::getImg(){ return imgMesa; }
void mesa::setIdMesa(int _id)    { idMesa =_id; }
void mesa::setEstado(int _estado){ estado = _estado; }
void mesa::setWidth(int _height) { height = _height; }
void mesa::setHeight(int _width) { width = _width;  }
void mesa::setCapacidad(int _capacidad){ capacidad=_capacidad; }
void mesa::setImg(QString _img){ imgMesa = _img; }

