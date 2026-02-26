import React from 'react';

interface Stat {
    label: string;
    value: string;
    trend: string;
    color: string;
}

interface EarningStatsProps {
    stats: Stat[];
}

export const EarningStats: React.FC<EarningStatsProps> = ({ stats }) => {
    return (
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))', gap: '1.5rem' }}>
            {stats.map(stat => (
                <div key={stat.label} style={{
                    padding: '24px',
                    backgroundColor: '#FFFFFF',
                    borderRadius: '24px',
                    border: '1px solid #F3F4F6',
                    boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.05)',
                    transition: 'transform 0.2s ease'
                }}>
                    <div style={{ fontSize: '0.85rem', fontWeight: 800, color: '#6B7280', textTransform: 'uppercase', letterSpacing: '0.5px', marginBottom: '12px' }}>{stat.label}</div>
                    <div style={{ fontSize: '2rem', fontWeight: 900, color: '#111827', marginBottom: '8px' }}>{stat.value}</div>
                    <div style={{ fontSize: '0.85rem', fontWeight: 700, color: stat.trend.startsWith('+') ? '#00875A' : '#EF4444' }}>
                        {stat.trend} <span style={{ color: '#9CA3AF', fontWeight: 500 }}>vs last month</span>
                    </div>
                </div>
            ))}
        </div>
    );
};
