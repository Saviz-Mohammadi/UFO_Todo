#ifndef NetworkManager_H
#define NetworkManager_H

#include <QDebug>
#include <QObject>
#include <QQmlEngine>
#include <QVariantMap>
#include <QTcpSocket>
#include <QFile>
#include <QDataStream>
#include <QNetworkInterface>

class NetworkManager : public QObject
{
    Q_OBJECT

    // This is neccessary for Singleton pattern.
    // Disables following:
    //
    // -- Copy constructor
    // -- Copy assignment operator
    // -- Move constructor
    // -- Move assignment operator
    Q_DISABLE_COPY_MOVE(NetworkManager)

public:
    explicit NetworkManager(QObject *parent = nullptr);
    ~NetworkManager();

    static NetworkManager *qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine);
    static NetworkManager *cppInstance(QObject *parent = nullptr);

    // Properties;
public:
    Q_PROPERTY(bool isConnected READ getIsConnected NOTIFY isConnectedChanged)

    // Fields;
private:
    static NetworkManager *m_Instance;
    QTcpSocket m_TcpSocket;
    quint64 m_Port;
    bool m_IsConnected;

    // Signals;
signals:
    void isConnectedChanged();
    void synchronizeRequestReceived(const QByteArray& fileData);

    // Public Slots;
public slots:
    void connectToDevice(const QString &deviceIP);
    void sendSynchronizeRequest();
    void disconnect();
    QVariantList getIP();

    // Private Slots;
private slots:
    void connected();
    void disconnected();
    void error(QAbstractSocket::SocketError socketError);
    void stateChanged(QAbstractSocket::SocketState socketState);
    void readyRead();

    // Getters
public:
    bool getIsConnected() const;

    // Setters
public:
    void setIsConnected(bool newState);
};

#endif // NetworkManager_H
