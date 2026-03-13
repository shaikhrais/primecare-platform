import React, { useState, useEffect } from 'react';
import { Play, Pause, Square } from 'lucide-react';

interface InAppTimerProps {
    onSave: (durationSeconds: number) => void;
}

export const InAppTimer: React.FC<InAppTimerProps> = ({ onSave }) => {
    const [seconds, setSeconds] = useState(0);
    const [isRunning, setIsRunning] = useState(false);

    useEffect(() => {
        let interval: ReturnType<typeof setInterval>;
        if (isRunning) {
            interval = setInterval(() => {
                setSeconds(s => s + 1);
            }, 1000);
        }
        return () => clearInterval(interval);
    }, [isRunning]);

    const formatTime = (totalSeconds: number) => {
        const m = Math.floor(totalSeconds / 60).toString().padStart(2, '0');
        const s = (totalSeconds % 60).toString().padStart(2, '0');
        return `${m}:${s}`;
    };

    return (
        <div style={{
            display: 'flex',
            alignItems: 'center',
            gap: '12px',
            backgroundColor: '#F1F5F9',
            padding: '8px 16px',
            borderRadius: '12px',
            border: '1px solid #E2E8F0'
        }}>
            <span style={{ fontSize: '1.25rem', fontWeight: 700, fontFamily: 'monospace', color: isRunning ? '#EF4444' : '#0F172A', transition: 'color 0.2s' }}>
                {formatTime(seconds)}
            </span>
            <div style={{ display: 'flex', gap: '8px' }}>
                <button data-cy="btn-psw.in-app-timer-0"
                    onClick={() => setIsRunning(!isRunning)}
                    style={{
                        padding: '8px',
                        borderRadius: '50%',
                        border: 'none',
                        backgroundColor: isRunning ? '#FEF2F2' : '#E0E7FF',
                        color: isRunning ? '#EF4444' : '#4F46E5',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        cursor: 'pointer'
                    }}
                >
                    {isRunning ? <Pause size={18} /> : <Play size={18} />}
                </button>
                {seconds > 0 && !isRunning && (
                    <button data-cy="btn-psw.in-app-timer-1"
                        onClick={() => {
                            onSave(seconds);
                            setSeconds(0);
                        }}
                        style={{
                            padding: '8px',
                            borderRadius: '50%',
                            border: 'none',
                            backgroundColor: '#DCFCE7',
                            color: '#16A34A',
                            display: 'flex',
                            alignItems: 'center',
                            justifyContent: 'center',
                            cursor: 'pointer'
                        }}
                    >
                        <Square size={18} />
                    </button>
                )}
            </div>
        </div>
    );
};
