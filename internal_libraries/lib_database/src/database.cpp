#include "database.hpp"

#ifdef QT_DEBUG
    #include "logger.hpp"
#endif


Database *Database::m_Instance = Q_NULLPTR;

// Constructors, Initializers, Destructor
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

Database::Database(QObject *parent, const QString& name)
    : QObject{parent}
    , m_QSqlDatabase(QSqlDatabase{})
    , connectionExists(false)
{
    this->setObjectName(name);


#ifdef QT_DEBUG
    QString message("Call to Constructor\n");

    QTextStream stream(&message);

    stream << "List of SQL drivers: " << QSqlDatabase::drivers().join(", ");

    logger::log(logger::LOG_LEVEL::DEBUG, this->objectName(), Q_FUNC_INFO, message);
#endif
}

Database::~Database()
{
#ifdef QT_DEBUG
    QString message("Call to Destructor");

    logger::log(logger::LOG_LEVEL::DEBUG, this->objectName(), Q_FUNC_INFO, message);
#endif


    // Shutdown.
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

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// PUBLIC Methods
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

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
        QString message("Connection failed!\n");

        QTextStream stream(&message);

        stream << "Error       : " << m_QSqlDatabase.lastError().text() << "\n"
               << "Path exists : " << QFileInfo::exists(path) << "\n"
               << "Path        : " << path;

        logger::log(logger::LOG_LEVEL::DEBUG, this->objectName(), Q_FUNC_INFO, message);
#endif

        return;
    }


    QSqlQuery query;

    bool query_success = query.exec(
        "CREATE TABLE IF NOT EXISTS tasks (task_id INTEGER PRIMARY KEY AUTOINCREMENT, task_description TEXT);"
    );

    if (!query_success)
    {
#ifdef QT_DEBUG
        QString message("Failed to run query!\n");

        QTextStream stream(&message);

        stream << "Reason: " << query.lastError().text();

        logger::log(logger::LOG_LEVEL::DEBUG, this->objectName(), Q_FUNC_INFO, message);
#endif

        return;
    }


    connectionExists = (true);
}

void Database::disconnect()
{
    m_QSqlDatabase.close();

    connectionExists = (false);


#ifdef QT_DEBUG
    QString message("Closing the database connection...\n");

    logger::log(logger::LOG_LEVEL::DEBUG, this->objectName(), Q_FUNC_INFO, message);
#endif
}

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
        QString message("Operation failed!\n");

        QTextStream stream(&message);

        stream << "Reason: " << query.lastError().text();

        logger::log(logger::LOG_LEVEL::DEBUG, this->objectName(), Q_FUNC_INFO, message);
#endif


        return (operation_success);
    }


    return (query.lastInsertId());
}

bool Database::removeTask(QVariant id)
{
    QString command("DELETE FROM tasks WHERE task_id = :id");

    QSqlQuery query;
    query.prepare(command);
    query.bindValue(":id", id.toULongLong());


    bool operation_success = (query.exec());

    if (!operation_success)
    {
#ifdef QT_DEBUG
        QString message("Operation failed!\n");

        QTextStream stream(&message);

        stream << "Reason: " << query.lastError().text();

        logger::log(logger::LOG_LEVEL::DEBUG, this->objectName(), Q_FUNC_INFO, message);
#endif


        return (operation_success);
    }


    return (operation_success);
}

QVariantList Database::obtainAllTasks()
{
    QString command("SELECT task_id, task_description FROM tasks WHERE task_description IS NOT NULL");

    QSqlQuery query;
    query.prepare(command);
    query.exec();


    QVariantList list;

    while (query.next())
    {
        QVariantMap recordMap;

        recordMap["id"] = query.value(0).toULongLong();
        recordMap["task"] = query.value(1).toString();

        list.append(recordMap);
    }


    return (list);
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]
