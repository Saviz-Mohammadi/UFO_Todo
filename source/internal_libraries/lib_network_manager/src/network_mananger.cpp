#include "network_mananger.hpp"

// Constructors and Destructor
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

NetworkManager *NetworkManager::m_Instance = nullptr;

NetworkManager::NetworkManager(QObject *parent)
    : QObject{parent}
    , m_UdpSocket(QUdpSocket())
    , m_TcpSocket(QTcpSocket())
    , m_Port(quint64(2024))
    , timer(new QTimer(this))
{
#ifdef QT_DEBUG
    qDebug() << "Call to constructor.";
#endif

    // Connecting to signal.
    connect(&m_UdpSocket, &QUdpSocket::readyRead, this, &NetworkManager::readyRead);
    connect(timer, &QTimer::timeout, this, &NetworkManager::notifyNetwork);

    // Connecting to port.
    if(!m_UdpSocket.bind(m_Port)) // QAbstractSocket::ShareAddress
    {
        qInfo() << m_UdpSocket.errorString();
        return;
    }

#ifdef QT_DEBUG
    qDebug() << "Started UDP on " << m_UdpSocket.localAddress() << ":" << m_UdpSocket.localPort();
#endif

    timer->start(3500);
}

NetworkManager::~NetworkManager()
{
#ifdef QT_DEBUG
    qDebug() << "Call to destructor.";
#endif


#ifdef QT_DEBUG
    qDebug() << "Closing sockets.";
#endif

    QByteArray byteArray;
    QDataStream stream(&byteArray, QIODevice::WriteOnly);

    // When you serialize two QString objects (or any other data types) to a QDataStream, they are not concatenated into a single string. Instead, they are serialized sequentially as separate pieces of data within the same QByteArray
    stream << "DISCONNECTED" << QSysInfo::machineHostName();

    QNetworkDatagram datagram(byteArray, QHostAddress::Broadcast, m_Port);
    m_UdpSocket.writeDatagram(datagram);

    //notifyNetwork();

    // Befor disconnecting udp, you may want to send another broadcast saying you are disconnected to refresh the list.
    m_UdpSocket.close();
    m_TcpSocket.close();
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




// Slots
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

void NetworkManager::readyRead()
{
    while(m_UdpSocket.hasPendingDatagrams())
    {
        QNetworkDatagram datagram = m_UdpSocket.receiveDatagram();

#ifdef QT_DEBUG
        qDebug() << "Data: " << QString::fromUtf8(datagram.data()) << " from " << datagram.senderAddress().toString() << ":" << datagram.senderPort();
#endif

        QByteArray data = datagram.data();

        // Deserialize the QByteArray back into QPair<QString, QByteArray>
        QDataStream in_stream(&data, QIODevice::ReadOnly);

        QString str;
        QByteArray byteArray;
        in_stream >> str >> byteArray;

#ifdef QT_DEBUG
        qDebug() << "Data: " << byteArray << " from " << datagram.senderAddress().toString() << ":" << datagram.senderPort();
#endif

        // See if recieved data is disconneccetd and remove it.
        if(str == "DISCONNECTED")
        {
            m_RecognizedDevices.remove(
                QString::fromUtf8(byteArray)
            );

            emit recognizedDevicesChanged();
            return;
        }

        // See if the recieved data alread is in here.
        if(m_RecognizedDevices.contains(QString::fromUtf8(byteArray)))
        {
            return;
        }

        // Use insert.
        setRecognizedDevices(byteArray, datagram.senderAddress());
    }
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]




// Methods
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

void NetworkManager::notifyNetwork()
{
    // it is good for the machine name to be the same as system name.
    QByteArray byteArray;
    QDataStream stream(&byteArray, QIODevice::WriteOnly);

    // When you serialize two QString objects (or any other data types) to a QDataStream, they are not concatenated into a single string. Instead, they are serialized sequentially as separate pieces of data within the same QByteArray
    stream << "CONNECTED" << QSysInfo::machineHostName();

    QNetworkDatagram datagram(byteArray, QHostAddress::Broadcast, m_Port);
    m_UdpSocket.writeDatagram(datagram);
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]




// Getters and Setters
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

QVariantMap NetworkManager::recognizedDevices() const
{
    return m_RecognizedDevices;
}

void NetworkManager::setRecognizedDevices(QByteArray data, QHostAddress ipAddress)
{
    m_RecognizedDevices.insert(QString::fromUtf8(data), ipAddress.toString());

    emit recognizedDevicesChanged();
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]
