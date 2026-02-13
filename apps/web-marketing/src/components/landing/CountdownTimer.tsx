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
        padding: '0.75rem 1.25rem',
        backgroundColor: '#F9FAFB',
        borderRadius: '6px',
        minWidth: '70px',
        border: '1px solid var(--line)'
    };

    return (
        <div style={{ display: 'flex', gap: '1rem', justifyContent: 'center', flexWrap: 'wrap' }}>
            {Object.entries(timeLeft).map(([unit, value]) => (
                <div key={unit} style={timeBoxStyle}>
                    <span style={{ fontSize: '2rem', fontWeight: 800, color: 'var(--brand-500)' }}>
                        {String(value).padStart(2, '0')}
                    </span>
                    <span style={{ fontSize: '0.65rem', textTransform: 'uppercase', color: 'var(--text-300)', fontWeight: 700 }}>
                        {unit}
                    </span>
                </div>
            ))}
        </div>
    );
}

export default CountdownTimer;
