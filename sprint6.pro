QT += quick
QT += quickcontrols2
QT += core gui sql
QT += charts
CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp \
    empleadolista.cpp \
    empleadomodelo.cpp \
    platillo.cpp \
    platillomodel.cpp \
    comanda.cpp \
    comandamodelo.cpp \
    platillocomanda.cpp \
    platillocomandamodel.cpp \
    meserolista.cpp \
    meseromodelo.cpp \
    platillococina.cpp \
    platillococinamodelo.cpp \
    almacenmodelo.cpp \
    almacenProducto.cpp \
    ticketprinter.cpp \
    pedido.cpp \
    pedidomodelo.cpp \
    pedidoproductos.cpp \
    pedidoproductosmodelo.cpp \
    mesa.cpp \
    mesamodelo.cpp \
    graficas.cpp

RESOURCES += qml.qrc \
    img.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    empleadolista.h \
    empleadomodelo.h \
    platillo.h \
    platillomodel.h \
    comanda.h \
    comandamodelo.h \
    platillocomanda.h \
    platillocomandamodel.h \
    meserolista.h \
    meseromodelo.h \
    platillococina.h \
    platillococinamodelo.h \
    almacenmodelo.h \
    almacenProducto.h \
    ticketprinter.h \
    pedido.h \
    pedidomodelo.h \
    pedidoproductos.h \
    pedidoproductosmodelo.h \
    mesa.h \
    mesamodelo.h \
    graficas.h

DISTFILES +=
