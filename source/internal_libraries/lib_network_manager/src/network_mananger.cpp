#include "network_mananger.hpp"

// Constructors and Destructor
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

NetworkManager *NetworkManager::m_Instance = nullptr;

NetworkManager::NetworkManager(QObject *parent)
    : QObject{parent}
    , m_TcpSocket(QTcpSocket())
    , m_Port(quint64(2024))
    , m_IsConnected(false)
{
#ifdef QT_DEBUG
    qDebug() << "Call to NetworkManager constructor.";
#endif

    connect(
        &m_TcpSocket,
        &QTcpSocket::connected,
        this,
        &NetworkManager::connected
    );

    connect(
        &m_TcpSocket,
        &QTcpSocket::disconnected,
        this,
        &NetworkManager::disconnected
    );

    connect(
        &m_TcpSocket,
        &QTcpSocket::stateChanged,
        this,
        &NetworkManager::stateChanged
    );

    connect(
        &m_TcpSocket,
        &QTcpSocket::readyRead,
        this,
        &NetworkManager::readyRead
    );

    connect(
        &m_TcpSocket,
        &QTcpSocket::errorOccurred,
        this,
        &NetworkManager::error
    );
}

NetworkManager::~NetworkManager()
{
#ifdef QT_DEBUG
    qDebug() << "Call to NetworkManager destructor.";
#endif


#ifdef QT_DEBUG
    qDebug() << "Closing sockets.";
#endif

    if(m_TcpSocket.isOpen())
    {
        this->disconnect();
    }
}

NetworkManager *NetworkManager::qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    if (!m_Instance)
    {
        m_Instance = new NetworkManager();
    }

    return (m_Instance);
}

NetworkManager *NetworkManager::cppInstance(QObject *parent)
{
    if (m_Instance)
    {
        return (qobject_cast<NetworkManager *>(NetworkManager::m_Instance));
    }

    auto instance = new NetworkManager(parent);
    m_Instance = instance;
    return (instance);
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]




// Public Slots
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

void NetworkManager::connectToDevice(const QString &deviceIP)
{
#ifdef QT_DEBUG
    qDebug() << "Connecting to: " << deviceIP << " on port " << m_Port;
#endif

    m_TcpSocket.connectToHost(deviceIP, m_Port);
}

void NetworkManager::sendSynchronizeRequest()
{
    QFile file("tasks.db");

    if (!file.open(QIODevice::ReadOnly))
    {
#ifdef QT_DEBUG
        qDebug() << "Failed to open file:" << file.errorString();
#endif

        return;
    }

    // Read the file into a QByteArray
    QByteArray fileData = file.readAll();

    // Create a QDataStream to write the data
    QByteArray byteArray;
    QDataStream out_stream(&byteArray, QIODevice::WriteOnly);

    // Write the file size
    out_stream << static_cast<quint64>(fileData.size());

    // Write the file data
    out_stream << fileData;

    // Send the data
    m_TcpSocket.write(byteArray);
    m_TcpSocket.waitForBytesWritten();
}

void NetworkManager::disconnect()
{
#ifdef QT_DEBUG
    qDebug() << "Disconnecting.";
#endif

    m_TcpSocket.close();


    m_TcpSocket.waitForDisconnected();

#ifdef QT_DEBUG
    qDebug() << "Disconnected.";
#endif
}

QVariantList NetworkManager::getIP()
{
    // You can choose here what address type you want to get back.
    // You can potentially make this an enum.
    bool addressIsIPv4 = true;
    bool addressIsIPv6 = true;

    QList<QHostAddress> searchResult;
    QVariantList result;

    for(const QHostAddress & address : QNetworkInterface::allAddresses())
    {
        if(address != QHostAddress(QHostAddress::LocalHost) && address.isGlobal())
        {
            searchResult.append(address);
        }
    }

    for(const QHostAddress & address : searchResult)
    {
        if(address.protocol() == QAbstractSocket::IPv4Protocol)
        {
            result.append(address.toString());
        }

        if(address.protocol() == QAbstractSocket::IPv6Protocol)
        {
            result.append(address.toString());
        }
    }

    return (result);
}

void NetworkManager::connected()
{
#ifdef QT_DEBUG
    qDebug() << "Connected.";
#endif

    setIsConnected(true);
}

void NetworkManager::disconnected()
{
#ifdef QT_DEBUG
    qDebug() << "Disconnected.";
#endif

    setIsConnected(false);
}

void NetworkManager::error(QAbstractSocket::SocketError socketError)
{
#ifdef QT_DEBUG
    qDebug() << "Error:" << socketError << " " << m_TcpSocket.errorString();
#endif

    setIsConnected(false);
}

void NetworkManager::stateChanged(QAbstractSocket::SocketState socketState)
{
#ifdef QT_DEBUG
    QMetaEnum metaEnum = QMetaEnum::fromType<QAbstractSocket::SocketState>();

    qDebug() << "State:" << metaEnum.valueToKey(socketState);
#endif
}

void NetworkManager::readyRead()
{
    // Ensure we have enough data to read
    if (m_TcpSocket.bytesAvailable() < sizeof(quint64))
        return;

    // Read the request type
    QDataStream in_stream(&m_TcpSocket);

    // Read the file size
    quint64 fileSize;
    in_stream >> fileSize;

    if (m_TcpSocket.bytesAvailable() < fileSize)
        return; // Handle incomplete data

    // Read the file data
    QByteArray fileData;
    in_stream >> fileData;

    emit synchronizeRequestReceived(fileData);
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]




// Getters and Setters
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

bool NetworkManager::getIsConnected() const
{
    return m_IsConnected;
}

void NetworkManager::setIsConnected(bool newState)
{
    if (m_IsConnected == newState)
    {
        return;
    }

    m_IsConnected = newState;
    emit isConnectedChanged();
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]
