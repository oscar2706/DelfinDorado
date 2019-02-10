#ifndef PLATILLO_H
#define PLATILLO_H

#include <QObject>
#include <QDebug>

class Platillo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString image READ image WRITE setImage NOTIFY imageChanged)
    Q_PROPERTY(QString price READ price WRITE setPrice NOTIFY priceChanged)
    Q_PROPERTY(QString description READ description WRITE setDescription NOTIFY descriptionChanged)
    Q_PROPERTY(QString category READ category WRITE setCategory NOTIFY categoryChanged)
    Q_PROPERTY(QString status READ status WRITE setStatus NOTIFY statusChanged)

public:
    explicit Platillo(QObject *parent = nullptr);
    Platillo(int _id, const QString &_name, const QString &_image, const float &_price, const QString &_description,
             const QString &_category, const QString &_status, QObject * parent = nullptr);
    QString name() const;
    float price() const;
    QString description() const;
    QString category() const;
    int id() const;
    QString image() const;
    QString status() const;

signals:
    void nameChanged(QString name);
    void priceChanged(float price);
    void descriptionChanged(QString description);
    void categoryChanged(QString category);
    void idChanged(int id);
    void imageChanged(QString image);
    void statusChanged(QString status);

public slots:
    void setName(QString name);
    void setPrice(float price);
    void setDescription(QString description);
    void setCategory(QString category);
    void setId(int id);
    void setImage(QString image);
    void setStatus(QString status);

private:
    int m_id;
    QString m_name;
    float m_price;
    QString m_description;
    QString m_category;
    QString m_image;
    QString m_status;
};

#endif // PLATILLO_H
