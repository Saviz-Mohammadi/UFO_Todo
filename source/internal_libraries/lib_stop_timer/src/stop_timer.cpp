#include "stop_timer.hpp"

// Constructors and Destructor
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

StopTimer::StopTimer(QObject *parent)
    : QObject{parent}
    , timer(new QTimer(this))
    , m_Time(QString())
    , m_RemainingTime(qint64(0))
    , m_Hours(qint64(0))
    , m_Minutes(qint64(0))
    , m_Seconds(qint64(0))
{
#ifdef QT_DEBUG
    qDebug() << "Call to constructor.";
#endif

    connect(this->timer, &QTimer::timeout, this, &StopTimer::calculateTime);
}

StopTimer::~StopTimer()
{
#ifdef QT_DEBUG
    qDebug() << "call to destructor.";
#endif
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]




// Slots
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

void StopTimer::calculateTime()
{
    // m_RemainingTime is the last known meillisecond.
    setRemainingTime(
        m_RemainingTime - 1000
    );

    qint64 milliseconds = m_RemainingTime;

    // Hours
    setHours(
        milliseconds / (1000 * 60 * 60)
    );

    milliseconds %= (1000 * 60 * 60);

    // Minutes
    setMinutes(
        milliseconds / (1000 * 60)
    );

    milliseconds %= (1000 * 60);

    // Seconds
    setSeconds(
        milliseconds / 1000
    );

    // String output is padded with leading zeroes if need be...
    setTime(
        QString("%1:%2:%3")
        .arg(m_Hours, 2, 10, QChar('0'))
        .arg(m_Minutes, 2, 10, QChar('0'))
        .arg(m_Seconds, 2, 10, QChar('0'))
    );

    if(m_RemainingTime <= 0)
    {
        stopTimer();
    }
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]




// Methods
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

void StopTimer::startTimer(qint64 time, qint64 interval)
{
    setRemainingTime(time);
    timer->start(interval);
    emit timerStarted();
}

void StopTimer::resumeTimer()
{
    timer->start();
    emit timerResumed();
}

void StopTimer::stopTimer()
{
    timer->stop();
    emit timerStopped();
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]




// Getters and Setters
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

QString StopTimer::time() const
{
    return m_Time;
}

void StopTimer::setTime(const QString &newTime)
{
    if (m_Time == newTime)
    {
        return;
    }

    m_Time = newTime;
    emit timeChanged();
}

qint64 StopTimer::remainingTime() const
{
    return m_RemainingTime;
}

void StopTimer::setRemainingTime(const qint64 &newTime)
{
    if (m_RemainingTime == newTime)
    {
        return;
    }

    m_RemainingTime = newTime;
    emit remainingTimeChanged();
}

qint64 StopTimer::hours() const
{
    return m_Hours;
}

void StopTimer::setHours(const qint64 &newTime)
{
    if (m_Hours == newTime)
    {
        return;
    }

    m_Hours = newTime;
    emit hoursChanged();
}

qint64 StopTimer::minutes() const
{
    return m_Minutes;
}

void StopTimer::setMinutes(const qint64 &newTime)
{
    if (m_Minutes == newTime)
    {
        return;
    }

    m_Minutes = newTime;
    emit minutesChanged();
}

qint64 StopTimer::seconds() const
{
    return m_Seconds;
}

void StopTimer::setSeconds(const qint64 &newTime)
{
    if (m_Seconds == newTime)
    {
        return;
    }

    m_Seconds = newTime;
    emit secondsChanged();
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]
