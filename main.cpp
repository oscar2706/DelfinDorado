#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>

#include "empleadolista.h"
#include "empleadomodelo.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<EmpleadoModelo>("Empleado", 1, 0, "EmpleadoModelo");
    qmlRegisterUncreatableType<EmpleadoLista>("Empleado", 1, 0, "EmpleadoLista", QStringLiteral("Empleado lista should not be created in UML"));

    EmpleadoLista empleadoLista;

    QQmlApplicationEngine engine;
    QQuickStyle::setStyle("Material");
    engine.rootContext()->setContextProperty(QStringLiteral("empleadoLista"), &empleadoLista);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
