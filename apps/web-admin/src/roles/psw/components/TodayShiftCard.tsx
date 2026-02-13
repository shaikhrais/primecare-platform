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
                padding: '40px',
                backgroundColor: '#FFFFFF',
                border: isInProgress ? '2px solid #00875A' : '1px solid #E5E7EB',
                borderRadius: '32px',
                boxShadow: isInProgress
                    ? '0 30px 60px -12px rgba(0, 135, 90, 0.2), 0 18px 36px -18px rgba(0, 0, 0, 0.3)'
                    : '0 10px 15px -3px rgba(0, 0, 0, 0.05), 0 4px 6px -2px rgba(0, 0, 0, 0.02)',
                transition: 'all 0.4s cubic-bezier(0.16, 1, 0.3, 1)',
                position: 'relative',
                display: 'flex',
                flexDirection: 'column',
                gap: '24px'
            }}
        >
            {isInProgress && (
                <div style={{
                    position: 'absolute',
                    top: '24px',
                    right: '24px',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '8px',
                    background: '#00875A',
                    color: 'white',
                    padding: '6px 14px',
                    borderRadius: '20px',
                    fontSize: '0.75rem',
                    fontWeight: 900,
                    textTransform: 'uppercase',
                    letterSpacing: '1px',
                    boxShadow: '0 4px 12px rgba(0, 135, 90, 0.3)',
                    animation: 'pulse 2.5s infinite'
                }}>
                    <span style={{ width: '8px', height: '8px', backgroundColor: '#FFFFFF', borderRadius: '50%', boxShadow: '0 0 8px #FFFFFF' }}></span>
                    Live Visit
                </div>
            )}

            <div>
                <span style={{
                    fontSize: '0.75rem',
                    fontWeight: 800,
                    color: isInProgress ? '#00875A' : '#6B7280',
                    textTransform: 'uppercase',
                    letterSpacing: '2px',
                    marginBottom: '8px',
                    display: 'block'
                }}>
                    {isInProgress ? 'Current Assignment' : 'Next Assignment'}
                </span>
                <h3 data-cy="shift-client-name" style={{ margin: 0, fontSize: '2.25rem', fontWeight: 900, color: '#111827', letterSpacing: '-1px' }}>
                    {clientName}
                </h3>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '20px' }}>
                <div style={{
                    padding: '20px',
                    backgroundColor: '#F9FAFB',
                    borderRadius: '20px',
                    border: '1px solid #F3F4F6'
                }}>
                    <span style={{ display: 'block', fontSize: '0.7rem', fontWeight: 800, color: '#9CA3AF', textTransform: 'uppercase', letterSpacing: '1px', marginBottom: '4px' }}>Scheduled Start</span>
                    <span style={{ fontSize: '1.25rem', fontWeight: 900, color: '#111827' }}>🕒 {startTime}</span>
                </div>
                <div style={{
                    padding: '20px',
                    backgroundColor: '#E6F4EF',
                    borderRadius: '20px',
                    border: '1px solid rgba(0, 135, 90, 0.1)'
                }}>
                    <span style={{ display: 'block', fontSize: '0.7rem', fontWeight: 800, color: '#00875A', textTransform: 'uppercase', letterSpacing: '1px', marginBottom: '4px' }}>Care Level</span>
                    <span style={{ fontSize: '1.25rem', fontWeight: 900, color: '#065F46' }}>🛡️ Enterprise</span>
                </div>
            </div>

            <div style={{
                display: 'flex',
                alignItems: 'center',
                gap: '12px',
                padding: '20px',
                backgroundColor: '#F9FAFB',
                borderRadius: '20px',
                border: '1px solid #F3F4F6'
            }}>
                <span style={{ fontSize: '1.5rem' }}>📍</span>
                <div style={{ flex: 1 }}>
                    <span style={{ display: 'block', fontSize: '0.7rem', fontWeight: 800, color: '#9CA3AF', textTransform: 'uppercase' }}>Location</span>
                    <span style={{ fontSize: '1rem', fontWeight: 700, color: '#374151' }}>{address}</span>
                </div>
            </div>

            {!isCompleted && (
                <button
                    data-cy={isInProgress ? 'btn-check-out' : 'btn-check-in'}
                    onClick={isInProgress ? onCheckOut : onCheckIn}
                    style={{
                        width: '100%',
                        padding: '24px',
                        backgroundColor: isInProgress ? '#000000' : '#00875A',
                        color: 'white',
                        border: 'none',
                        borderRadius: '24px',
                        fontWeight: '900',
                        fontSize: '1.25rem',
                        cursor: 'pointer',
                        transition: 'all 0.3s cubic-bezier(0.16, 1, 0.3, 1)',
                        boxShadow: isInProgress ? '0 10px 20px rgba(0,0,0,0.2)' : '0 10px 20px rgba(0, 135, 90, 0.3)',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        gap: '12px',
                        marginTop: '8px'
                    }}
                    onMouseEnter={(e) => {
                        e.currentTarget.style.transform = 'translateY(-2px)';
                        if (!isInProgress) e.currentTarget.style.backgroundColor = '#006D48';
                    }}
                    onMouseLeave={(e) => {
                        e.currentTarget.style.transform = 'translateY(0)';
                        if (!isInProgress) e.currentTarget.style.backgroundColor = '#00875A';
                    }}
                >
                    {isInProgress ? (
                        <><span>✓</span> Complete & Submit Visit</>
                    ) : (
                        <><span>▶</span> Start Shift & Log Entry</>
                    )}
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
