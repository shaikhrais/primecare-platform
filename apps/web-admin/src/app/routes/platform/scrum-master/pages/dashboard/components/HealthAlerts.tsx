import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

interface Alert {
    id: string;
    type: 'critical' | 'warning' | 'info';
    message: string;
    timestamp: string;
}

export const HealthAlerts: React.FC = () => {
    const { t } = useTranslation();
    const [alerts, setAlerts] = useState<Alert[]>([
        { id: '1', type: 'critical', message: t(ContentRegistry.SCRUM_MASTER.ALERTS.CRITICAL), timestamp: '2 mins ago' },
        { id: '2', type: 'warning', message: t(ContentRegistry.SCRUM_MASTER.ALERTS.WARNING), timestamp: '15 mins ago' },
        { id: '3', type: 'info', message: t(ContentRegistry.SCRUM_MASTER.ALERTS.INFO), timestamp: '1 hour ago' },
    ]);

    const removeAlert = (id: string) => {
        setAlerts(prev => prev.filter(a => a.id !== id));
    };

    const getTypeStyles = (type: string) => {
        switch (type) {
            case 'critical': return { bg: '#FEF2F2', border: '#FCA5A5', color: '#991B1B', icon: '🚨' };
            case 'warning': return { bg: '#FFFBEB', border: '#FCD34D', color: '#92400E', icon: '⚠️' };
            default: return { bg: '#EFF6FF', border: '#93C5FD', color: '#1E40AF', icon: 'ℹ️' };
        }
    };

    return (
        <div className="sm-card" style={{ padding: '2rem', background: '#ffffff', marginBottom: '3rem' }}>
            <h3 style={{ margin: '0 0 1.5rem 0', display: 'flex', alignItems: 'center', gap: '10px', fontSize: '1.25rem', fontWeight: 800 }}>
                {t(ContentRegistry.SCRUM_MASTER.ALERTS.TITLE)}
            </h3>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                {alerts.length === 0 && (
                    <div style={{ textAlign: 'center', padding: '2rem', color: '#6b7280', fontSize: '0.9rem' }}>
                        ✅ All systems operational. No active alerts.
                    </div>
                )}
                {alerts.map(alert => {
                    const style = getTypeStyles(alert.type);
                    return (
                        <div
                            key={alert.id}
                            style={{
                                display: 'flex',
                                alignItems: 'center',
                                justifyContent: 'space-between',
                                padding: '1.25rem',
                                background: style.bg,
                                borderLeft: `4px solid ${style.border}`,
                                borderRadius: '12px',
                                animation: 'slideRight 0.3s ease-out'
                            }}
                        >
                            <div style={{ display: 'flex', alignItems: 'center', gap: '15px' }}>
                                <span style={{ fontSize: '1.5rem' }}>{style.icon}</span>
                                <div>
                                    <div style={{ fontWeight: 800, color: style.color, fontSize: '0.95rem' }}>{alert.message}</div>
                                    <div style={{ fontSize: '0.75rem', color: style.color, opacity: 0.7 }}>{alert.timestamp}</div>
                                </div>
                            </div>
                            <button
                                onClick={() => removeAlert(alert.id)}
                                style={{
                                    padding: '6px 12px',
                                    background: 'white',
                                    border: `1px solid ${style.border}`,
                                    color: style.color,
                                    borderRadius: '8px',
                                    fontSize: '0.75rem',
                                    fontWeight: 700,
                                    cursor: 'pointer',
                                    transition: '0.2s'
                                }}
                            >
                                {t(ContentRegistry.SCRUM_MASTER.ALERTS.RESOLVE)}
                            </button>
                        </div>
                    );
                })}
            </div>
            <style>{`
                @keyframes slideRight {
                    from { opacity: 0; transform: translateX(-10px); }
                    to { opacity: 1; transform: translateX(0); }
                }
            `}</style>
        </div>
    );
};
