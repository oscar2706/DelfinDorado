#ifndef MESEROMODELO_H
#define MESEROMODELO_H

#include <QAbstractListModel>

class meseroLista;

class meseroModelo : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(meseroLista *list READ list WRITE setList)


public:
    explicit meseroModelo(QObject *parent = nullptr);

    enum{
        IdRole,
        NombreRole,
        SeleccionRole = Qt::UserRole
    };

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;
    Qt::ItemFlags flags(const QModelIndex& index) const override;
    QHash<int, QByteArray> roleNames() const override;

    meseroLista *list();
    void setList(meseroLista *list);

private:
    meseroLista *mList;
};

#endif // MESEROMODELO_H

