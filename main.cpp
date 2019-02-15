#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>


#include "empleadolista.h"
#include "empleadomodelo.h"
#include "platillomodel.h"
#include "comandamodelo.h"
#include "platillocomandamodel.h"

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

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
