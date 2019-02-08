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
//cargado de imagenes
#include <QQuickView>
#include <QFile>

struct ToDoItem
{
    QString idEmpleado;
    QString nombreEmpleado;
    QString apellidoPaterno;
    QString apellidoMaterno;
    QString rfc;
    QString seguroSocial;
    QString fechaNacimiento;
    QString sueldo;
    QString foto;
    QString telefono;
    QString puestoEmpleado;
    QString sexo;
    QString usuario;
    QString contrasegna;
    bool eleccionEmpleado;
};

class EmpleadoLista: public QObject
{
    Q_OBJECT
public:
    explicit EmpleadoLista(QObject *parent = nullptr);

    QVector<ToDoItem> items() const;

    bool setItemAt(int indice, const ToDoItem &item);

    //cargado de imagenes
    Q_INVOKABLE void insertarBD(QString, QString);
    Q_INVOKABLE QString visualizarImg(int);

signals:
    void preItemAppended();
    void postItemAppended();

    void preItemRemoved(int indice);
    void postItemRemoved();

public slots:
    void appendItem();
    void refresh();
    void removeCheckedItem();
    void removeItems();

    QString getDato(QString);

    QString getNombre(QString id);
    QString getApellidoPaterno(QString id);
    QString getApellidoMaterno(QString id);
    QString getFechaNacimiento(QString id);
    QString getSexo(QString id);
    int getPuesto(QString id);
    QString getTelefono(QString id);
    QString getSalario(QString id);
    QString getRFC(QString id);
    QString getSeguroSocial(QString id);
    QString getUsuario(QString id);
    QString getContrasegna(QString id);

    void altaUsuario(QString, QString, QString, QString, QString, QString, QString, QString, QString, int, QString, QString, QString);
    void modificaUsuario(QString, QString, QString, QString, QString, QString,
                         QString, QString, QString, int, QString, QString, QString, QString);
    void bajaUsuario(QString);

    int getUltimoId();
    int buscarCategoria(QString, QString);
private:
    QVector<ToDoItem> mItems;
};

#endif // EMPLEADOLISTA_H
