import React, { useState, useEffect } from 'react';

interface CountdownTimerProps {
    targetDate: Date;
}

export function CountdownTimer({ targetDate }: CountdownTimerProps) {
    const [timeLeft, setTimeLeft] = useState(calculateTimeLeft());

    function calculateTimeLeft() {
        const difference = targetDate.getTime() - new Date().getTime();
        if (difference <= 0) return { days: 0, hours: 0, minutes: 0, seconds: 0 };

        return {
            days: Math.floor(difference / (1000 * 60 * 60 * 24)),
            hours: Math.floor((difference / (1000 * 60 * 60)) % 24),
            minutes: Math.floor((difference / 1000 / 60) % 60),
            seconds: Math.floor((difference / 1000) % 60),
        };
    }

    useEffect(() => {
        const timer = setInterval(() => setTimeLeft(calculateTimeLeft()), 1000);
        return () => clearInterval(timer);
    }, []);

    const timeBoxStyle: React.CSSProperties = {
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        padding: '1rem 1.5rem',
        backgroundColor: 'rgba(255,255,255,0.95)',
        borderRadius: '12px',
        minWidth: '80px',
        boxShadow: '0 4px 15px rgba(0,0,0,0.1)',
    };

    return (
        <div style={{ display: 'flex', gap: '1rem', justifyContent: 'center', flexWrap: 'wrap' }}>
            {Object.entries(timeLeft).map(([unit, value]) => (
                <div key={unit} style={timeBoxStyle}>
                    <span style={{ fontSize: '2.5rem', fontWeight: 'bold', color: '#00897b' }}>
                        {String(value).padStart(2, '0')}
                    </span>
                    <span style={{ fontSize: '0.75rem', textTransform: 'uppercase', color: '#666', letterSpacing: '1px' }}>
                        {unit}
                    </span>
                </div>
            ))}
        </div>
    );
}

export default CountdownTimer;
