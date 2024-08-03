#ifndef StopTimer_H
#define StopTimer_H

#include <QDebug>
#include <QObject>
#include <QTimer>

class StopTimer : public QObject
{
    Q_OBJECT

public:
    explicit StopTimer(QObject *parent = nullptr);
    ~StopTimer();

    // Q_PROPERTY;
private:
    Q_PROPERTY(QString Time READ time NOTIFY timeChanged);
    Q_PROPERTY(qint64 RemaningTime READ remainingTime NOTIFY remainingTimeChanged);
    Q_PROPERTY(qint64 Hours READ hours NOTIFY hoursChanged);
    Q_PROPERTY(qint64 Minutes READ minutes NOTIFY minutesChanged);
    Q_PROPERTY(qint64 Seconds READ seconds NOTIFY secondsChanged);

    // Fields;
private:
    QTimer *timer;
    QString m_Time;
    qint64 m_RemainingTime;
    qint64 m_Hours;
    qint64 m_Minutes;
    qint64 m_Seconds;

    // Methods;
public:
    Q_INVOKABLE void startTimer(qint64 time, qint64 interval);
    Q_INVOKABLE void resumeTimer();
    Q_INVOKABLE void stopTimer();

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

    // Getters
public:
    QString time() const;
    qint64 remainingTime() const;
    qint64 hours() const;
    qint64 minutes() const;
    qint64 seconds() const;

    // Setters
private:
    void setTime(const QString &newTime);
    void setRemainingTime(const qint64 &newTime);
    void setHours(const qint64 &newTime);
    void setMinutes(const qint64 &newTime);
    void setSeconds(const qint64 &newTime);
};

#endif // StopTimer_H
