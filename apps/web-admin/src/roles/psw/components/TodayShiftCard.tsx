import React from 'react';

interface TodayShiftCardProps {
    clientName: string;
    startTime: string;
    address: string;
    status: string;
    onCheckIn: (e: any) => void;
    onCheckOut: (e: any) => void;
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
                padding: '32px',
                backgroundColor: '#FFFFFF',
                border: isInProgress ? '2px solid #00875A' : '1px solid #E5E7EB',
                borderRadius: '24px',
                boxShadow: isInProgress
                    ? '0 0 20px rgba(0, 135, 90, 0.15), 0 10px 15px -3px rgba(0, 0, 0, 0.1)'
                    : '0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03)',
                transition: 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
                position: 'relative'
            }}
        >
            {isInProgress && (
                <div style={{
                    position: 'absolute',
                    top: '12px',
                    right: '12px',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '6px',
                    background: '#00875A',
                    color: 'white',
                    padding: '4px 10px',
                    borderRadius: '12px',
                    fontSize: '0.65rem',
                    fontWeight: 800,
                    textTransform: 'uppercase',
                    animation: 'pulse 2s infinite'
                }}>
                    <span style={{ width: '6px', height: '6px', backgroundColor: 'white', borderRadius: '50%' }}></span>
                    Active Now
                </div>
            )}

            <div style={{ marginBottom: '2rem' }}>
                <h3 data-cy="shift-client-name" style={{ margin: 0, fontSize: '1.5rem', fontWeight: 900, color: '#111827' }}>{clientName}</h3>
                <p style={{ margin: '8px 0 0 0', color: '#6B7280', fontSize: '1rem', display: 'flex', alignItems: 'center', gap: '6px' }}>
                    <span style={{ fontSize: '1.2rem' }}>📍</span> {address}
                </p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem', marginBottom: '2.5rem', padding: '20px', backgroundColor: '#F9FAFB', borderRadius: '16px' }}>
                <div>
                    <span style={{ display: 'block', fontSize: '0.75rem', fontWeight: 800, color: '#9CA3AF', textTransform: 'uppercase', letterSpacing: '0.5px' }}>Start Time</span>
                    <span style={{ fontSize: '1.25rem', fontWeight: 800, color: '#111827' }}>🕒 {startTime}</span>
                </div>
                <div>
                    <span style={{ display: 'block', fontSize: '0.75rem', fontWeight: 800, color: '#9CA3AF', textTransform: 'uppercase', letterSpacing: '0.5px' }}>Service</span>
                    <span style={{ fontSize: '1.25rem', fontWeight: 800, color: '#00875A' }}>🛡️ Standard</span>
                </div>
            </div>

            {!isCompleted && (
                <button
                    data-cy={isInProgress ? 'btn-check-out' : 'btn-check-in'}
                    onClick={isInProgress ? onCheckOut : onCheckIn}
                    style={{
                        width: '100%',
                        padding: '18px',
                        backgroundColor: isInProgress ? '#000000' : '#00875A',
                        color: 'white',
                        border: 'none',
                        borderRadius: '16px',
                        fontWeight: '900',
                        fontSize: '1.1rem',
                        cursor: 'pointer',
                        transition: 'all 0.2s ease',
                        boxShadow: isInProgress ? 'none' : '0 4px 14px 0 rgba(0, 135, 90, 0.39)'
                    }}
                >
                    {isInProgress ? 'Complete Visit' : 'Start Visit & Check-In'}
                </button>
            )}

            <style>{`
                @keyframes pulse {
                    0% { opacity: 1; }
                    50% { opacity: 0.6; }
                    100% { opacity: 1; }
                }
            `}</style>
        </div>
    );
};
