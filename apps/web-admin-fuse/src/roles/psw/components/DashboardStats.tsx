import React from 'react';

interface StatItemProps {
    label: string;
    value: string | number;
    icon: string;
    trend?: string;
    trendPositive?: boolean;
}

const StatItem: React.FC<StatItemProps> = ({ label, value, icon, trend, trendPositive }) => (
    <div style={{
        padding: '24px',
        backgroundColor: '#FFFFFF',
        borderRadius: '20px',
        border: '1px solid #E5E7EB',
        display: 'flex',
        flexDirection: 'column',
        gap: '8px',
        flex: 1,
        minWidth: '160px',
        boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.05)'
    }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
            <span style={{ fontSize: '1.5rem' }}>{icon}</span>
            {trend && (
                <span style={{
                    fontSize: '0.75rem',
                    fontWeight: 700,
                    color: trendPositive ? '#00875A' : '#EF4444',
                    backgroundColor: trendPositive ? '#E6F4EF' : '#FEE2E2',
                    padding: '2px 8px',
                    borderRadius: '12px'
                }}>
                    {trend}
                </span>
            )}
        </div>
        <div style={{ fontSize: '1.75rem', fontWeight: 900, color: '#111827' }}>{value}</div>
        <div style={{ fontSize: '0.8rem', fontWeight: 600, color: '#6B7280', textTransform: 'uppercase', letterSpacing: '0.5px' }}>{label}</div>
    </div>
);

export const DashboardStats: React.FC = () => {
    return (
        <div style={{ display: 'flex', gap: '1.5rem', flexWrap: 'wrap' }}>
            <StatItem label="Earnings" value="$1,240" icon="💰" trend="+12%" trendPositive={true} />
            <StatItem label="Visits" value="42" icon="🏥" trend="+5" trendPositive={true} />
            <StatItem label="Hours" value="128.5" icon="⏰" trend="-2%" trendPositive={false} />
            <StatItem label="Rating" value="4.9" icon="⭐" />
        </div>
    );
};
