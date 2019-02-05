#ifndef EMPLEADOMODELO_H
#define EMPLEADOMODELO_H

#include <QAbstractListModel>

class EmpleadoLista;

class EmpleadoModelo : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(EmpleadoLista *list READ list WRITE setList)

public:
    explicit EmpleadoModelo(QObject *parent = nullptr);

    enum
    {
        idRole,
        nombreRole,
        puestoRole,
        eleccionRole = Qt::UserRole
    };

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    virtual QHash<int, QByteArray> roleNames() const override;

    EmpleadoLista *list() const;
    void setList(EmpleadoLista *list);

private:
    EmpleadoLista *mList;
};

#endif // EMPLEADOMODELO_H
