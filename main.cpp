#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>

#include "empleadolista.h"
#include "empleadomodelo.h"
#include "platillomodel.h"
#include "comandamodelo.h"
#include "platillocomandamodel.h"
#include "pedidomodelo.h"
#include "pedidoproductosmodelo.h"
#include "meseromodelo.h"
#include "meserolista.h"
#include "platillococinamodelo.h"
#include <almacenmodelo.h>
#include "ticketprinter.h"
#include "mesamodelo.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QQuickStyle::setStyle("Material");

    qmlRegisterType<EmpleadoModelo>("Empleado", 1, 0, "EmpleadoModelo");
    qmlRegisterUncreatableType<EmpleadoLista>("Empleado", 1, 0, "EmpleadoLista", QStringLiteral("Empleado lista should not be created in UML"));
    EmpleadoLista empleadoLista;
    engine.rootContext()->setContextProperty(QStringLiteral("empleadoLista"), &empleadoLista);

    PlatilloModel modeloPlatillos;
    engine.rootContext()->setContextProperty("modeloPlatillos",&modeloPlatillos);

    ComandaModelo modeloComandas;
    engine.rootContext()->setContextProperty("modeloComandas",&modeloComandas);

    PlatilloComandaModel modeloPlatillosComanda;
    engine.rootContext()->setContextProperty("modeloPlatillosComandas", &modeloPlatillosComanda);

    PedidoModelo modeloPedidos;
    engine.rootContext()->setContextProperty("modeloPedidos", &modeloPedidos);

    PedidoProductosModelo modeloPedidoProductos;
    engine.rootContext()->setContextProperty("modeloPedidoProductos", &modeloPedidoProductos);

    PlatilloCocinaModelo modeloPlatillosNuevos;
    engine.rootContext()->setContextProperty("modeloPlatillosNuevos", &modeloPlatillosNuevos);

    PlatilloCocinaModelo modeloPlatillosPreparados;
    engine.rootContext()->setContextProperty("modeloPlatillosPreparados", &modeloPlatillosPreparados);

    PlatilloCocinaModelo modeloPlatillosMesero;
    engine.rootContext()->setContextProperty("modeloPlatillosMesero", &modeloPlatillosMesero);

    qmlRegisterType<meseroModelo>("ModeloMesero",1,0,"MeseroModelo");
    qmlRegisterUncreatableType<meseroLista>("ModeloMesero",1,0,"MeseroLista",QStringLiteral("mesero lista"));

    meseroLista meseroListaObj;
    engine.rootContext()->setContextProperty(QStringLiteral("meseroLista"),&meseroListaObj);

    almacenModelo *almacen = new almacenModelo;
     engine.rootContext()->setContextProperty("almacen",almacen);

    mesaModelo * mesaObjt= new mesaModelo;
    engine.rootContext()->setContextProperty("mesaObjModel",mesaObjt);

    qmlRegisterType<TicketPrinter>("Ticket",1,0,"TicketPrinter");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
