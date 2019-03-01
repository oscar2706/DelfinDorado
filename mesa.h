#ifndef MESA_H
#define MESA_H

#include <QObject>

class mesa : public QObject
{
    Q_OBJECT
private:
    int idMesa;
    int estado;
    int width;
    int height;
    int capacidad;
    QString imgMesa;

public:
    mesa();
    mesa(int,int,int,int,int,QString);
    int getIdMesa();
    int getEstado();
    int getWidth();
    int getHeight();
    int getCapacidad();
    QString getImg();
    void setIdMesa(int);
    void setEstado(int);
    void setWidth(int);
    void setHeight(int);
    void setCapacidad(int);
    void setImg(QString);

};

#endif // MESA_H
