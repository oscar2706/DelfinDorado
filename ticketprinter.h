#ifndef TICKETPRINTER_H
#define TICKETPRINTER_H

#include <QObject>
#include <QImage>
#include <QPainter>
#include <QQuickPaintedItem>
#include <QStringList>
class TicketPrinter : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(QString fecha READ fecha WRITE setFecha NOTIFY fechaChanged)
    Q_PROPERTY(QStringList platillosList READ platillosList WRITE setPlatillosList NOTIFY platillosListChanged)
    Q_PROPERTY(float total READ total WRITE setTotal NOTIFY totalChanged)

    QString m_fecha;
    QStringList m_platillosList;
    float m_total;

public:
    explicit TicketPrinter(QQuickItem *parent = nullptr);
    void paint(QPainter *painter);
    QString fecha() const;
    QStringList platillosList() const;
    float total() const;

signals:
    void fechaChanged(QString fecha);
    void platillosListChanged(QStringList platillosList);
    void totalChanged(float total);

public slots:
    void setFecha(QString fecha);
    void setPlatillosList(QStringList platillosList);
    void setTotal(float total);
};

#endif // TICKETPRINTER_H
