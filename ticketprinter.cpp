#include "ticketprinter.h"

TicketPrinter::TicketPrinter(QQuickItem*parent) : QQuickPaintedItem(parent),
    m_fecha("01/01/1998"), m_total(0.0)
{
    setWidth(400);
    setHeight(600);
}

void TicketPrinter::paint(QPainter *painter)
{
    QString imagePath = ":/img/tiket.jpg";
    QImage ticketImage(imagePath);
    QRect mRect = (ticketImage.rect());
    painter->drawImage(mRect,ticketImage);
    painter->drawText(140,130, "Fecha: "+fecha());

    int y_Pos = 200;
    for (int i = 0; i != platillosList().size(); i++) {
        QStringList elementos = platillosList().at(i).split(',');
        painter->drawText(40,y_Pos, elementos.at(0));
        painter->drawText(80,y_Pos, elementos.at(1));
        painter->drawText(235,y_Pos, elementos.at(2));
        painter->drawText(335,y_Pos, elementos.at(3));
        y_Pos += 25;
    }
    QString totalString;
    totalString.setNum(total());
    painter->setFont(QFont("Verdana",14,QFont::Bold));
    painter->drawText(270,y_Pos, "Total = $"+totalString);
}

QString TicketPrinter::fecha() const
{
    return m_fecha;
}

QStringList TicketPrinter::platillosList() const
{
    return m_platillosList;
}

float TicketPrinter::total() const
{
    return m_total;
}

void TicketPrinter::setFecha(QString fecha)
{
    if (m_fecha == fecha)
        return;

    m_fecha = fecha;
    emit fechaChanged(m_fecha);
}

void TicketPrinter::setPlatillosList(QStringList platillosList)
{
    if (m_platillosList == platillosList)
        return;

    m_platillosList = platillosList;
    emit platillosListChanged(m_platillosList);
}

void TicketPrinter::setTotal(float total)
{
    qWarning("Floating point comparison needs context sanity check");
    if (qFuzzyCompare(m_total, total))
        return;

    m_total = total;
    emit totalChanged(m_total);
}
