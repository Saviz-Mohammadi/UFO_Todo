#ifndef DATABASE_H
#define DATABASE_H

#include <QDebug>
#include <QObject>
#include <QQmlEngine>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QVariant>
#include <QVariantList>
#include <QFileInfo>
#include <QTextStream>

class Database : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY_MOVE(Database) // Needed for Singleton

public:
    explicit Database(QObject *parent = Q_NULLPTR, const QString& name = "No name");
    ~Database();

    static Database *qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine);
    static Database *cppInstance(QObject *parent = Q_NULLPTR);

    // Fields;
private:
    static Database *m_Instance;
    QSqlDatabase m_QSqlDatabase;
    bool connectionExists;

    // PUBLIC Methods;
public:
    Q_INVOKABLE void establishConnection(const QString &path);
    Q_INVOKABLE void disconnect();
    Q_INVOKABLE QVariant addTask(const QString &text);
    Q_INVOKABLE bool removeTask(QVariant id);
    Q_INVOKABLE QVariantList obtainAllTasks();
};

#endif // DATABASE_H
