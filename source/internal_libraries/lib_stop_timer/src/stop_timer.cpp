#include "stop_timer.hpp"

// Constructors, Initializers, Destructor
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

StopTimer::StopTimer(QObject *parent, const QString& name)
    : QObject{parent}
    , timer(new QTimer(this))
    , m_Time(QString())
    , m_RemainingTime(quint64(0))
    , m_Hours(quint64(0))
    , m_Minutes(quint64(0))
    , m_Seconds(quint64(0))
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



    connect(this->timer, &QTimer::timeout, this, &StopTimer::calculateTime);
}

StopTimer::~StopTimer()
{
// Debugging
#ifdef QT_DEBUG
    qDebug() << "\n**************************************************\n"
             << "* Object Name :" << this->objectName()  << "\n"
             << "* Function    :" << __FUNCTION__        << "\n"
             << "* Message     : Call to Destructor"
             << "\n**************************************************\n\n";
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

    quint64 milliseconds = m_RemainingTime;

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





// PUBLIC Methods
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

void StopTimer::startTimer(quint64 time, quint64 interval)
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

QString StopTimer::getTime() const
{
    return m_Time;
}

quint64 StopTimer::getRemainingTime() const
{
    return m_RemainingTime;
}

quint64 StopTimer::getHours() const
{
    return m_Hours;
}

quint64 StopTimer::getMinutes() const
{
    return m_Minutes;
}

quint64 StopTimer::getSeconds() const
{
    return m_Seconds;
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// PRIVATE Setters
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

void StopTimer::setTime(const QString &newTime)
{
    if (m_Time == newTime)
    {
        return;
    }

    m_Time = newTime;
    emit timeChanged();
}

void StopTimer::setRemainingTime(const quint64 &newTime)
{
    if (m_RemainingTime == newTime)
    {
        return;
    }

    m_RemainingTime = newTime;
    emit remainingTimeChanged();
}

void StopTimer::setHours(const quint64 &newTime)
{
    if (m_Hours == newTime)
    {
        return;
    }

    m_Hours = newTime;
    emit hoursChanged();
}

void StopTimer::setMinutes(const quint64 &newTime)
{
    if (m_Minutes == newTime)
    {
        return;
    }

    m_Minutes = newTime;
    emit minutesChanged();
}

void StopTimer::setSeconds(const quint64 &newTime)
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