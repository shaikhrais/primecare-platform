import React from 'react';

export interface AlertItem {
    level: 'info' | 'warning' | 'danger';
    message: string;
    time?: string;
}

interface SectionAlertPanelProps {
    alerts: AlertItem[];
}

/** Alert/notification panel — used for SOS, health monitors, IoT alerts */
export function SectionAlertPanel({ alerts }: SectionAlertPanelProps) {
    const colors = { info: '#3b82f6', warning: '#f59e0b', danger: '#ef4444' };
    const icons = { info: 'ℹ️', warning: '⚠️', danger: '🚨' };
    return (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '8px', marginBottom: '24px' }}>
            {alerts.map((a, i) => (
                <div key={i} style={{
                    padding: '12px 16px', borderRadius: '10px',
                    borderLeft: `4px solid ${colors[a.level]}`,
                    background: `${colors[a.level]}08`,
                    display: 'flex', justifyContent: 'space-between', alignItems: 'center',
                }}>
                    <span style={{ fontSize: '0.85rem' }}>{icons[a.level]} {a.message}</span>
                    {a.time && <span style={{ fontSize: '0.7rem', color: 'var(--pc-text-tertiary)' }}>{a.time}</span>}
                </div>
            ))}
        </div>
    );
}
