#include "database.hpp"

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



// Debugging
#ifdef QT_DEBUG
    qDebug() << "\n**************************************************\n"
             << "* Object Name :" << this->objectName()  << "\n"
             << "* Function    :" << __FUNCTION__        << "\n"
             << "* Message     : Call to Constructor"
             << "\n**************************************************\n\n";
#endif

#ifdef QT_DEBUG
    qDebug() << "\n**************************************************\n"
             << "* Object Name :" << this->objectName()  << "\n"
             << "* Function    :" << __FUNCTION__        << "\n"
             << "* Message     : List of SQL drivers: "  << QSqlDatabase::drivers()
             << "\n**************************************************\n\n";
#endif
}

Database::~Database()
{
// Debugging
#ifdef QT_DEBUG
    qDebug() << "\n**************************************************\n"
             << "* Object Name :" << this->objectName()  << "\n"
             << "* Function    :" << __FUNCTION__        << "\n"
             << "* Message     : Call to Destructor"
             << "\n**************************************************\n\n";
#endif



    // Closing the connection.
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
// Debugging
#ifdef QT_DEBUG
        qDebug() << "\n**************************************************\n"
                 << "* Object Name :" << this->objectName()  << "\n"
                 << "* Function    :" << __FUNCTION__        << "\n"
                 << "* Message     : Connection failed!"     << "\n"
                 << "* Error       : " << m_QSqlDatabase.lastError().text() << "\n"
                 << "* Path exists : " << QFileInfo::exists(path) << "\n"
                 << "* Path        : " << path
                 << "\n**************************************************\n\n";
#endif



        return;
    }



// Debugging
#ifdef QT_DEBUG
    qDebug() << "\n**************************************************\n"
             << "* Object Name :" << this->objectName()  << "\n"
             << "* Function    :" << __FUNCTION__        << "\n"
             << "* Message     : Connection established!"
             << "\n**************************************************\n\n";
#endif



    QSqlQuery query;

    bool query_success = query.exec(
        "CREATE TABLE IF NOT EXISTS tasks (task_id INTEGER PRIMARY KEY AUTOINCREMENT, task_description TEXT);"
    );

    if (!query_success)
    {
// Debugging
#ifdef QT_DEBUG
        qDebug() << "\n**************************************************\n"
                 << "* Object Name :" << this->objectName()  << "\n"
                 << "* Function    :" << __FUNCTION__        << "\n"
                 << "* Message     : Failed to run query. Reason: " << query.lastError().text()
                 << "\n**************************************************\n\n";
#endif



        return;
    }


// Debugging
#ifdef QT_DEBUG
    qDebug() << "\n**************************************************\n"
             << "* Object Name :" << this->objectName()  << "\n"
             << "* Function    :" << __FUNCTION__        << "\n"
             << "* Message     : Query executed successfully. Table is now created if not already existed."
             << "\n**************************************************\n\n";
#endif



    connectionExists = (true);
}

void Database::disconnect()
{
    m_QSqlDatabase.close();

    connectionExists = (false);



// Debugging
#ifdef QT_DEBUG
    qDebug() << "\n**************************************************\n"
             << "* Object Name :" << this->objectName()  << "\n"
             << "* Function    :" << __FUNCTION__        << "\n"
             << "* Message     : Closing the database connection..."
             << "\n**************************************************\n\n";
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
// Debugging
#ifdef QT_DEBUG
        qDebug() << "\n**************************************************\n"
                 << "* Object Name :" << this->objectName()  << "\n"
                 << "* Function    :" << __FUNCTION__        << "\n"
                 << "* Message     : Operation failed! Reason: " << query.lastError().text()
                 << "\n**************************************************\n\n";
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
// Debugging
#ifdef QT_DEBUG
        qDebug() << "\n**************************************************\n"
                 << "* Object Name :" << this->objectName()  << "\n"
                 << "* Function    :" << __FUNCTION__        << "\n"
                 << "* Message     : Operation failed! Reason: " << query.lastError().text()
                 << "\n**************************************************\n\n";
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



// Debugging
#ifdef QT_DEBUG
        qDebug() << "\n**************************************************\n"
                 << "* Object Name :" << this->objectName()  << "\n"
                 << "* Function    :" << __FUNCTION__        << "\n"
                 << "* Message     : Found record" << recordMap
                 << "\n**************************************************\n\n";
#endif
    }


    return (list);
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]
