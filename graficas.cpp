#include "graficas.h"

Graficas::Graficas(QObject *parent) : QObject(parent)
{

}

Graficas::Graficas(const QString &_fechaInicial, const QString &_fechaFinal, QObject *parent):
    QObject (parent),m_fechaInicial(_fechaInicial),m_fechaFinal(_fechaFinal)
{

}

//grafica 1
QString Graficas::nombrePlatilloMasVendido(int numeroPlatillo)
{
    qDebug() << "ENTRO GRAFICA 1";
    QSqlQuery nombre;

    nombre.prepare("SELECT count(pc.idPlatillo) AS total, p.nombre FROM platillo AS p INNER JOIN "
                   "platilloscomanda AS pc ON p.idPlatillo = pc.idPlatillo INNER JOIN "
                   "comanda AS c ON c.idComanda = pc.idComanda WHERE "
                   "c.fecha BETWEEN :fechaInicial AND :fechaFinal "
                   "GROUP BY p.nombre ORDER BY total DESC");
    nombre.bindValue(":fechaInicial", m_fechaInicial);
    nombre.bindValue(":fechaFinal", m_fechaFinal);

    if(nombre.exec())
    {
        for(int i = 0; i<numeroPlatillo; i++)
            nombre.next();

        qDebug() << "Nombre: " << nombre.value(1).toString();
        return nombre.value(1).toString();
    }
    else {
        qDebug() << nombre.lastError().text();
        return "";
    }
}

int Graficas::cantidadPlatilloMasVendido(int numeroPlatillo)
{
    QSqlQuery nombre;

    nombre.prepare("SELECT count(pc.idPlatillo) AS total, p.nombre FROM platillo AS p INNER JOIN "
                   "platilloscomanda AS pc ON p.idPlatillo = pc.idPlatillo INNER JOIN "
                   "comanda AS c ON c.idComanda = pc.idComanda WHERE "
                   "c.fecha BETWEEN :fechaInicial AND :fechaFinal "
                   "GROUP BY p.nombre ORDER BY total DESC");
    nombre.bindValue(":fechaInicial", m_fechaInicial);
    nombre.bindValue(":fechaFinal", m_fechaFinal);

    if(nombre.exec())
    {
        for(int i = 0; i<numeroPlatillo; i++)
        {
            nombre.next();
            qDebug() << nombre.value(0).toInt();
        }
        qDebug() << "Cantidad: " << nombre.value(0).toInt();
        return nombre.value(0).toInt();
    }
    else {
        qDebug() << nombre.lastError().text();
        return 0;
    }
}

//grafica 2
QString Graficas::categoriaPlatilloMasVendidoCategoria(int numeroCategoria)
{
    qDebug() << "ENTRO GRAFICA 2";
    QSqlQuery consulta;

    consulta.prepare("SELECT ca.nombre, p.nombre, count(pc.idPlatillo) AS total "
                     "FROM platilloscomanda AS pc INNER JOIN platillo AS p ON p.idPlatillo = pc.idPlatillo "
                     "INNER JOIN categoriaplatillo AS ca ON ca.idCategoriaPlatillo = p.idCategoriaPlatillo "
                     "INNER JOIN comanda AS co ON co.idComanda = pc.idComanda "
                     "WHERE p.idCategoriaPlatillo = :numeroCategoria AND "
                     "co.fecha BETWEEN :fechaInicial AND :fechaFinal ORDER BY total DESC");
    consulta.bindValue(":numeroCategoria", numeroCategoria);
    consulta.bindValue(":fechaInicial", m_fechaInicial);
    consulta.bindValue(":fechaFinal", m_fechaFinal);

    if(consulta.exec())
    {
        consulta.next();

        qDebug() << "Categoria: " << consulta.value(0).toString();
        return consulta.value(0).toString();
    }
    else
    {
        qDebug() << consulta.lastError().text();
        return "";
    }
}

QString Graficas::nombrePlatilloMasVendidoCategoria(int numeroCategoria)
{
    QSqlQuery consulta;

    consulta.prepare("SELECT ca.nombre, p.nombre, count(pc.idPlatillo) AS total "
                     "FROM platilloscomanda AS pc INNER JOIN platillo AS p ON p.idPlatillo = pc.idPlatillo "
                     "INNER JOIN categoriaplatillo AS ca ON ca.idCategoriaPlatillo = p.idCategoriaPlatillo "
                     "INNER JOIN comanda AS co ON co.idComanda = pc.idComanda "
                     "WHERE p.idCategoriaPlatillo = :numeroCategoria AND "
                     "co.fecha BETWEEN :fechaInicial AND :fechaFinal ORDER BY total DESC");
    consulta.bindValue(":numeroCategoria", numeroCategoria);
    consulta.bindValue(":fechaInicial", m_fechaInicial);
    consulta.bindValue(":fechaFinal", m_fechaFinal);

    if(consulta.exec())
    {
        consulta.next();

        qDebug() << "Nombre: " << consulta.value(1).toString();
        return consulta.value(1).toString();
    }
    else
    {
        qDebug() << consulta.lastError().text();
        return "";
    }
}

int Graficas::cantidadPlatilloMasVendidoCategoria(int numeroCategoria)
{
    QSqlQuery consulta;

    consulta.prepare("SELECT ca.nombre, p.nombre, count(pc.idPlatillo) AS total "
                     "FROM platilloscomanda AS pc INNER JOIN platillo AS p ON p.idPlatillo = pc.idPlatillo "
                     "INNER JOIN categoriaplatillo AS ca ON ca.idCategoriaPlatillo = p.idCategoriaPlatillo "
                     "INNER JOIN comanda AS co ON co.idComanda = pc.idComanda "
                     "WHERE p.idCategoriaPlatillo = :numeroCategoria AND "
                     "co.fecha BETWEEN :fechaInicial AND :fechaFinal ORDER BY total DESC");
    consulta.bindValue(":numeroCategoria", numeroCategoria);
    consulta.bindValue(":fechaInicial", m_fechaInicial);
    consulta.bindValue(":fechaFinal", m_fechaFinal);

    if(consulta.exec())
    {
        consulta.next();

        qDebug() << "Cantidad: " << consulta.value(2).toString();
        return consulta.value(2).toInt();
    }
    else
    {
        qDebug() << consulta.lastError().text();
        return 0;
    }
}

//grafica 3
QString Graficas::categoriaPlatilloMenosVendidoCategoria(int numeroCategoria)
{
    qDebug() << "ENTRO GRAFICA 3";
    QSqlQuery consulta;

    consulta.prepare("SELECT ca.nombre, p.nombre, count(pc.idPlatillo) AS total "
                     "FROM platilloscomanda AS pc INNER JOIN platillo AS p ON p.idPlatillo = pc.idPlatillo "
                     "INNER JOIN categoriaplatillo AS ca ON ca.idCategoriaPlatillo = p.idCategoriaPlatillo "
                     "INNER JOIN comanda AS co ON co.idComanda = pc.idComanda "
                     "WHERE p.idCategoriaPlatillo = :numeroCategoria AND "
                     "co.fecha BETWEEN :fechaInicial AND :fechaFinal ORDER BY total ASC");
    consulta.bindValue(":numeroCategoria", numeroCategoria);
    consulta.bindValue(":fechaInicial", m_fechaInicial);
    consulta.bindValue(":fechaFinal", m_fechaFinal);

    if(consulta.exec())
    {
        consulta.next();

        qDebug() << "Categoria: " << consulta.value(0).toString();
        return consulta.value(0).toString();
    }
    else
    {
        qDebug() << consulta.lastError().text();
        return "";
    }
}

QString Graficas::nombrePlatilloMenosVendidoCategoria(int numeroCategoria)
{
    QSqlQuery consulta;

    consulta.prepare("SELECT ca.nombre, p.nombre, count(pc.idPlatillo) AS total "
                     "FROM platilloscomanda AS pc INNER JOIN platillo AS p ON p.idPlatillo = pc.idPlatillo "
                     "INNER JOIN categoriaplatillo AS ca ON ca.idCategoriaPlatillo = p.idCategoriaPlatillo "
                     "INNER JOIN comanda AS co ON co.idComanda = pc.idComanda "
                     "WHERE p.idCategoriaPlatillo = :numeroCategoria AND "
                     "co.fecha BETWEEN :fechaInicial AND :fechaFinal ORDER BY total DESC");
    consulta.bindValue(":numeroCategoria", numeroCategoria);
    consulta.bindValue(":fechaInicial", m_fechaInicial);
    consulta.bindValue(":fechaFinal", m_fechaFinal);

    if(consulta.exec())
    {
        consulta.next();

        qDebug() << "Nombre: " << consulta.value(1).toString();
        return consulta.value(1).toString();
    }
    else
    {
        qDebug() << consulta.lastError().text();
        return "";
    }
}

int Graficas::cantidadPlatilloMenosVendidoCategoria(int numeroCategoria)
{
    QSqlQuery consulta;

    consulta.prepare("SELECT ca.nombre, p.nombre, count(pc.idPlatillo) AS total "
                     "FROM platilloscomanda AS pc INNER JOIN platillo AS p ON p.idPlatillo = pc.idPlatillo "
                     "INNER JOIN categoriaplatillo AS ca ON ca.idCategoriaPlatillo = p.idCategoriaPlatillo "
                     "INNER JOIN comanda AS co ON co.idComanda = pc.idComanda "
                     "WHERE p.idCategoriaPlatillo = :numeroCategoria AND "
                     "co.fecha BETWEEN :fechaInicial AND :fechaFinal ORDER BY total DESC");
    consulta.bindValue(":numeroCategoria", numeroCategoria);
    consulta.bindValue(":fechaInicial", m_fechaInicial);
    consulta.bindValue(":fechaFinal", m_fechaFinal);

    if(consulta.exec())
    {
        consulta.next();

        qDebug() << "Cantidad: " << consulta.value(2).toString();
        return consulta.value(2).toInt();
    }
    else
    {
        qDebug() << consulta.lastError().text();
        return 0;
    }
}

//grafica 4
QString Graficas::nombreProductosMasPedidos(int numeroProducto)
{
    qDebug() << "ENTRO GRAFICA 4";
    QSqlQuery consulta;

    consulta.prepare("SELECT sum(pp.cantidad) AS totalPedidos, p.nombre FROM producto AS p INNER JOIN "
                   "pedidoproductos AS pp ON p.idProducto = pp.idProducto INNER JOIN "
                   "pedido AS pe ON pe.idPedido = pp.idPedido WHERE "
                   "pe.fecha BETWEEN :fechaInicial AND :fechaFinal "
                   "GROUP BY p.nombre ORDER BY totalPedidos DESC");
    consulta.bindValue(":fechaInicial", m_fechaInicial);
    consulta.bindValue(":fechaFinal", m_fechaFinal);

    if(consulta.exec())
    {
        for(int i = 0; i<numeroProducto; i++)
            consulta.next();

        qDebug() << "Nombre: " << consulta.value(1).toString();
        return consulta.value(1).toString();
    }
    else {
        qDebug() << consulta.lastError().text();
        return "";
    }
}

int Graficas::cantidadProductosMasPedidos(int numeroProducto)
{
    QSqlQuery consulta;

    consulta.prepare("SELECT sum(pp.cantidad) AS totalPedidos, p.nombre FROM producto AS p INNER JOIN "
                   "pedidoproductos AS pp ON p.idProducto = pp.idProducto INNER JOIN "
                   "pedido AS pe ON pe.idPedido = pp.idPedido WHERE "
                   "pe.fecha BETWEEN :fechaInicial AND :fechaFinal "
                   "GROUP BY p.nombre ORDER BY totalPedidos DESC");
    consulta.bindValue(":fechaInicial", m_fechaInicial);
    consulta.bindValue(":fechaFinal", m_fechaFinal);

    if(consulta.exec())
    {
        for(int i = 0; i<numeroProducto; i++)
            consulta.next();

        qDebug() << "Cantidad: " << consulta.value(1).toString();
        return consulta.value(0).toInt();
    }
    else {
        qDebug() << consulta.lastError().text();
        return 0;
    }
}

//grafica 5

QString Graficas::nombreComandasAtendidas(int numeroComandas)
{
    qDebug() << "ENTRO GRAFICA 5";
    QSqlQuery consulta;

    consulta.prepare("SELECT count(co.idEmpleado) AS totalEmpleados, e.nombre FROM empleado AS e INNER JOIN "
                   "comanda AS co ON e.idEmpleado = co.idEmpleado WHERE "
                   "co.IdEstadoComanda = 3 AND co.fecha BETWEEN :fechaInicial AND :fechaFinal "
                   "ORDER BY totalEmpleados DESC");
    consulta.bindValue(":fechaInicial", m_fechaInicial);
    consulta.bindValue(":fechaFinal", m_fechaFinal);

    if(consulta.exec())
    {
        for(int i = 0; i<numeroComandas; i++)
            consulta.next();

        qDebug() << "Nombre: " << consulta.value(1).toString();
        return consulta.value(1).toString();
    }
    else {
        qDebug() << "Cadena 5 error: " << consulta.lastError().text();
        return "";
    }
}

int Graficas::cantidadComandasAtendidas(int numeroComandas)
{
    QSqlQuery consulta;

    consulta.prepare("SELECT count(co.idEmpleado) AS totalEmpleados, e.nombre FROM empleado AS e INNER JOIN "
                   "comanda AS co ON e.idEmpleado = co.idEmpleado WHERE "
                   "co.IdEstadoComanda = 3 AND co.fecha BETWEEN :fechaInicial AND :fechaFinal "
                   "ORDER BY totalEmpleados DESC");
    consulta.bindValue(":fechaInicial", m_fechaInicial);
    consulta.bindValue(":fechaFinal", m_fechaFinal);

    if(consulta.exec())
    {
        for(int i = 0; i<numeroComandas; i++)
            consulta.next();

        qDebug() << "Cantidad: " << consulta.value(0).toInt();
        return consulta.value(0).toInt();
    }
    else {
        qDebug() << "Entero 5 error: " << consulta.lastError().text();
        return 0;
    }
}

//terminan graficas

int Graficas::cantidadComandasGeneradas()
{
    QSqlQuery consulta;

    consulta.prepare("SELECT count(idComanda) AS totalComanda FROM comanda WHERE "
                   "idEstadoComanda = 3 AND fecha BETWEEN :fechaInicial AND :fechaFinal");
    consulta.bindValue(":fechaInicial", m_fechaInicial);
    consulta.bindValue(":fechaFinal", m_fechaFinal);
    if(consulta.exec())
    {
        consulta.next();

        qDebug() << "TotalComandas: " << consulta.value(1).toInt();
        return consulta.value(0).toInt();
    }
    else {
        qDebug() << consulta.lastError().text();
        return 0;
    }
}

float Graficas::promedioVentas()
{
    int cantidadComandas;
    float ganancias;
    QSqlQuery consulta;

    consulta.prepare("SELECT SUM(cu.totalCuenta) AS total FROM cuenta AS cu "
                     "INNER JOIN comanda AS co ON co.idComanda = cu.idComanda "
                     "WHERE co.fecha BETWEEN :fechaInicial AND :fechaFinal");
    consulta.bindValue(":fechaInicial", m_fechaInicial);
    consulta.bindValue(":fechaFinal", m_fechaFinal);

    if(consulta.exec())
    {
        consulta.next();
        ganancias = consulta.value(0).toFloat();
        cantidadComandas = cantidadComandasGeneradas();

        return ganancias/cantidadComandas;
    }
    else {
        qDebug() << consulta.lastError().text();
        return 0;
    }
}

//terminas datos directos

QString Graficas::fechaInicial() const
{
    return m_fechaInicial;
}

QString Graficas::fechaFinal() const
{
    return m_fechaFinal;
}

void Graficas::setFechaInicial(QString fechaInicial)
{
    if(m_fechaInicial == fechaInicial)
        return;
    else {
        m_fechaInicial = fechaInicial;
        emit fechaInicialChanged(m_fechaInicial);
    }
}

void Graficas::setFechaFinal(QString fechaFinal)
{
    if(m_fechaFinal == fechaFinal)
        return;
    else {
        m_fechaFinal = fechaFinal;
        emit fechaFinalChanged(m_fechaFinal);
    }
}
