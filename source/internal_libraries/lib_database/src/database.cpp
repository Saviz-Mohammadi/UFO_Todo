#include <QFileInfo>
#include "database.hpp"

Database *Database::m_Instance = nullptr;

Database::Database(QObject *parent)
    : QObject{parent}
{
    // Just for insurance.
#ifdef QT_DEBUG
    qDebug() << "List of SQL drivers:";
    qDebug() << QSqlDatabase::drivers();
#endif
}

Database::~Database()
{
#ifdef QT_DEBUG
    qDebug() << "Closing the database connection.";
#endif

    // Close the connection to database.
    this->disconnect();
}

Database *Database::qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    if (!m_Instance)
    {
        m_Instance = new Database();
    }

    return (m_Instance);
}

Database *Database::cppInstance(QObject *parent)
{
    if (m_Instance)
    {
        return (qobject_cast<Database *>(Database::m_Instance));
    }

    auto instance = new Database(parent);
    m_Instance = instance;
    return (instance);
}

void Database::establishConnection(const QString &path)
{
    // Connection already exists, abort operation.
    if (connectionExists)
    {
        return;
    }

    m_QSqlDatabase = QSqlDatabase::addDatabase("QSQLITE");

    m_QSqlDatabase.setDatabaseName(path);

    bool connectionFailed = !m_QSqlDatabase.open();

    if (connectionFailed)
    {
#ifdef QT_DEBUG
        qDebug() << "Connection failed!" << m_QSqlDatabase.lastError().text();
        qDebug() << "Path given to the database file: " << path
                 << " Does path exist: " << QFileInfo::exists(path);
#endif

        return;
    }

#ifdef QT_DEBUG
    qDebug() << "Connection established!";
#endif

    QSqlQuery query;

    bool query_success = query.exec(
        "CREATE TABLE IF NOT EXISTS tasks (task_id INTEGER PRIMARY KEY AUTOINCREMENT, task_description TEXT);");

    if (!query_success)
    {
#ifdef QT_DEBUG
        qDebug() << "Failed to run query. Reason: " << query.lastError().text();
#endif

        return;
    }

#ifdef QT_DEBUG
    qDebug() << "Query executed successfully. Table is now created if not already existed.";
#endif

    connectionExists = (true);
}

void Database::disconnect()
{
    m_QSqlDatabase.close();

    connectionExists = (false);
}

bool Database::searchTask(const QString &text)
{
    QString command("SELECT COUNT(*) FROM tasks WHERE task = :text");

    QSqlQuery query;
    query.prepare(command);
    query.bindValue(":text", text);

    bool operation_success = (query.exec());

    if (!operation_success) {
#ifdef QT_DEBUG
        qDebug() << "Operation \"search\" failed. Reason: " << query.lastError().text();
#endif

        return (operation_success);
    }

#ifdef QT_DEBUG
    qDebug() << "Operation \"search\" successful.";
#endif

    if (query.next()) { // Move to the first (and only) record
        int count = query.value(0).toInt();
        return count > 0;
    }

    return false;
}

// Please note the use of QVariant is not neccessary. The internal QtQuick interface attempts to find the closest matching type between javaScript and C++ depending on the argument types.
// However, some argument types are unknown to the QML typesystem, and for those wrapping in QVariants may be necessary. I just want to be safe here.
QVariant Database::addTask(const QString &text)
{
    QString command("INSERT INTO tasks(task_description) VALUES(:text)");

    QSqlQuery query;
    query.prepare(command);
    query.bindValue(":text", text);

    bool operation_success = (query.exec());

    if (!operation_success)
    {
#ifdef QT_DEBUG
        qDebug() << "Operation \"addTask\" failed. Reason: " << query.lastError().text();
#endif
        return (operation_success);
    }

#ifdef QT_DEBUG
    qDebug() << "Operation \"addTask\" successful.";
#endif

    return (query.lastInsertId());
}

bool Database::removeTask(QVariant id)
{
    QString command("DELETE FROM tasks WHERE task_id = :id");

    QSqlQuery query;
    query.prepare(command);
    query.bindValue(":id", id.toInt());

    bool operation_success = (query.exec());

    if (!operation_success) {
#ifdef QT_DEBUG
        qDebug() << "Operation \"removeTask\" failed. Reason: " << query.lastError().text();
#endif

        return (operation_success);
    }

#ifdef QT_DEBUG
    qDebug() << "Operation \"removeTask\" successful.";
#endif

    return (operation_success);
}

QVariantList Database::obtainAllTasks()
{
    QString command("SELECT task_id, task_description FROM tasks WHERE task_description IS NOT NULL");

    QSqlQuery query;
    query.prepare(command);
    query.exec();

    QVariantList list;

    // Iterate using a cursor.
    while (query.next())
    {
        // Create a QVariantMap to hold the id and task
        QVariantMap recordMap;
        recordMap["id"] = query.value(0).toInt(); // Assuming id is an integer
        recordMap["task"] = query.value(1).toString(); // Assuming task is a string

        // Append the map to the list
        list.append(recordMap);

#ifdef QT_DEBUG
        qDebug() << "Found record" << recordMap;
#endif
    }

    return (list);
}
