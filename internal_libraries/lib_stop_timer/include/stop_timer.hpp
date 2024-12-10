#ifndef StopTimer_H
#define StopTimer_H

#include <QDebug>
#include <QObject>
#include <QTimer>

class StopTimer : public QObject
{
    Q_OBJECT

    // Q_PROPERTY;
    Q_PROPERTY(QString time READ getTime NOTIFY timeChanged);
    Q_PROPERTY(quint64 remaningTime READ getRemainingTime NOTIFY remainingTimeChanged);
    Q_PROPERTY(quint64 hours READ getHours NOTIFY hoursChanged);
    Q_PROPERTY(quint64 minutes READ getMinutes NOTIFY minutesChanged);
    Q_PROPERTY(quint64 seconds READ getSeconds NOTIFY secondsChanged);

    // Constructors, Initializers, Destructor
public:
    explicit StopTimer(QObject *parent = nullptr, const QString& name = "No name");
    ~StopTimer();

    // Fields;
private:
    QTimer *timer;
    QString m_Time;
    quint64 m_RemainingTime;
    quint64 m_Hours;
    quint64 m_Minutes;
    quint64 m_Seconds;

    // Signals;
signals:
    void timeChanged();
    void remainingTimeChanged();
    void hoursChanged();
    void minutesChanged();
    void secondsChanged();
    void timerStarted();
    void timerStopped();
    void timerResumed();

    // Slots;
private slots:
    void calculateTime();

    // PUBLIC Methods;
public:
    Q_INVOKABLE void startTimer(quint64 time, quint64 interval);
    Q_INVOKABLE void resumeTimer();
    Q_INVOKABLE void stopTimer();

    // PUBLIC Getters
public:
    QString getTime() const;
    quint64 getRemainingTime() const;
    quint64 getHours() const;
    quint64 getMinutes() const;
    quint64 getSeconds() const;

    // PRIVATE Setters
private:
    void setTime(const QString &newTime);
    void setRemainingTime(const quint64 &newTime);
    void setHours(const quint64 &newTime);
    void setMinutes(const quint64 &newTime);
    void setSeconds(const quint64 &newTime);
};

#endif // StopTimer_H
