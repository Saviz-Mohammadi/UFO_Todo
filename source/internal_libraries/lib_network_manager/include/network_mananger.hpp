#ifndef NetworkManager_H
#define NetworkManager_H

#include <QDebug>
#include <QObject>
#include <QQmlEngine>
#include <QVariantMap>
#include <QTcpSocket>
#include <QUdpSocket>
#include <QNetworkDatagram>
#include <QTimer>

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

    // Q_PROPERTY;
private:
    Q_PROPERTY(QVariantMap RecognizedDevices READ recognizedDevices NOTIFY recognizedDevicesChanged)

    // Fields;
private:
    static NetworkManager *m_Instance;
    QUdpSocket m_UdpSocket;
    QTcpSocket m_TcpSocket;
    quint64 m_Port;
    QVariantMap m_RecognizedDevices;
    QTimer *timer;
    QHostAddress address;

    // Methods;
public:
    // Make this have status as well like CONNECTED, DISCONNECTED and read hostname by default instead.
    Q_INVOKABLE void notifyNetwork();

    // Signals;
signals:
    void recognizedDevicesChanged();

    // Public Slots;
public slots:

    // Private Slots;
private slots:
    void readyRead();


    // Getters
public:
    QVariantMap recognizedDevices() const;

    // Setters
private:
    void setRecognizedDevices(QByteArray data, QHostAddress ipAddress);
};

#endif // NetworkManager_H
