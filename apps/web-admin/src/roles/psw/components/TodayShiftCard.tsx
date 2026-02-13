import React from 'react';

interface TodayShiftCardProps {
    clientName: string;
    startTime: string;
    address: string;
    status: string;
    onCheckIn: () => void;
    onCheckOut: () => void;
}

export const TodayShiftCard: React.FC<TodayShiftCardProps> = ({
    clientName,
    startTime,
    address,
    status,
    onCheckIn,
    onCheckOut
}) => {
    const isInProgress = status.toLowerCase() === 'in_progress';
    const isCompleted = status.toLowerCase() === 'completed';

    return (
        <div
            data-cy="today-shift-card"
            style={{
                padding: '24px',
                backgroundColor: '#FFFFFF',
                border: '1px solid #E5E7EB',
                borderRadius: '16px',
                transition: 'all 0.2s'
            }}
        >
            <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '1.5rem' }}>
                <div>
                    <h3 data-cy="shift-client-name" style={{ margin: 0, fontSize: '1.25rem', fontWeight: 800 }}>{clientName}</h3>
                    <p style={{ margin: '4px 0 0 0', color: '#6B7280', fontSize: '0.9rem' }}>📍 {address}</p>
                </div>
                <span data-cy="shift-status" style={{
                    color: '#00875A',
                    fontWeight: 800,
                    fontSize: '0.7rem',
                    textTransform: 'uppercase',
                    letterSpacing: '1px',
                    background: '#E6F4EF',
                    padding: '6px 12px',
                    borderRadius: '20px'
                }}>
                    {status}
                </span>
            </div>

            <div style={{ display: 'flex', gap: '2rem', marginBottom: '2rem' }}>
                <div>
                    <span style={{ display: 'block', fontSize: '0.7rem', fontWeight: 700, color: '#9CA3AF', textTransform: 'uppercase' }}>Scheduled Time</span>
                    <span style={{ fontSize: '1.1rem', fontWeight: 700 }}>🕒 {startTime}</span>
                </div>
            </div>

            {!isCompleted && (
                <button
                    data-cy={isInProgress ? 'btn-check-out' : 'btn-check-in'}
                    onClick={isInProgress ? onCheckOut : onCheckIn}
                    style={{
                        width: '100%',
                        padding: '14px',
                        backgroundColor: isInProgress ? '#EF4444' : '#00875A',
                        color: 'white',
                        border: 'none',
                        borderRadius: '12px',
                        fontWeight: '800',
                        fontSize: '1rem',
                        cursor: 'pointer',
                        transition: 'transform 0.1s active'
                    }}
                >
                    {isInProgress ? 'Finish Visit (Check-Out)' : 'Start Visit & Check-In'}
                </button>
            )}
        </div>
    );
};
