#ifndef Database_H
#define Database_H

#include <QDebug>
#include <QObject>
#include <QQmlEngine>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QVariant>
#include <QVariantList>

class Database : public QObject
{
    Q_OBJECT

    // This is neccessary for Singleton pattern.
    // Disables following:
    //
    // -- Copy constructor
    // -- Copy assignment operator
    // -- Move constructor
    // -- Move assignment operator
    Q_DISABLE_COPY_MOVE(Database)

public:
    explicit Database(QObject *parent = nullptr);
    ~Database();

    // Fields;
private:
    static Database *m_Instance;
    QSqlDatabase m_QSqlDatabase;
    bool connectionExists = false;

    // Methods;
public:
    static Database *qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine);
    static Database *cppInstance(QObject *parent = nullptr);

    // Methods;
public:
    Q_INVOKABLE void establishConnection(const QString &path);
    Q_INVOKABLE void disconnect();
    Q_INVOKABLE bool searchTask(const QString &text);
    Q_INVOKABLE QVariant addTask(const QString &text);
    Q_INVOKABLE bool removeTask(QVariant id);
    Q_INVOKABLE QVariantList obtainAllTasks();
};

#endif // Database_H
