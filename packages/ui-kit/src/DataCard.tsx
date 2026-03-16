/**
 * DataCard — Metric/stat card for dashboards
 *
 * Usage:
 *   <DataCard title="Active Visits" value={42} trend="+12%" icon="📊" />
 *   <DataCard title="Revenue" value="$12,450" subtitle="This month" color="green" />
 */
import React from 'react';

interface DataCardProps {
    title: string;
    value: string | number;
    subtitle?: string;
    trend?: string;
    trendDirection?: 'up' | 'down' | 'neutral';
    icon?: string;
    color?: 'blue' | 'green' | 'orange' | 'red' | 'purple' | 'gray';
    onClick?: () => void;
    className?: string;
}

const COLOR_MAP = {
    blue: { accent: '#3B82F6', bg: '#EFF6FF', border: '#BFDBFE' },
    green: { accent: '#10B981', bg: '#ECFDF5', border: '#A7F3D0' },
    orange: { accent: '#F59E0B', bg: '#FFFBEB', border: '#FDE68A' },
    red: { accent: '#EF4444', bg: '#FEF2F2', border: '#FECACA' },
    purple: { accent: '#8B5CF6', bg: '#F5F3FF', border: '#C4B5FD' },
    gray: { accent: '#6B7280', bg: '#F9FAFB', border: '#E5E7EB' },
};

const TREND_COLORS = {
    up: '#10B981',
    down: '#EF4444',
    neutral: '#6B7280',
};

export const DataCard: React.FC<DataCardProps> = ({
    title,
    value,
    subtitle,
    trend,
    trendDirection = 'neutral',
    icon,
    color = 'blue',
    onClick,
    className,
}) => {
    const palette = COLOR_MAP[color];
    const trendColor = TREND_COLORS[trendDirection];
    const trendArrow = trendDirection === 'up' ? '↑' : trendDirection === 'down' ? '↓' : '';

    return (
        <div
            className={className}
            data-cy={`data-card-${title.toLowerCase().replace(/\s+/g, '-')}`}
            onClick={onClick}
            style={{
                padding: '1.25rem',
                borderRadius: '0.75rem',
                border: `1px solid ${palette.border}`,
                backgroundColor: 'var(--card-bg, #fff)',
                cursor: onClick ? 'pointer' : 'default',
                transition: 'box-shadow 0.2s, transform 0.15s',
                position: 'relative',
                overflow: 'hidden',
            }}
            onMouseEnter={e => {
                if (onClick) {
                    (e.currentTarget as HTMLDivElement).style.boxShadow = '0 4px 12px rgba(0,0,0,0.08)';
                    (e.currentTarget as HTMLDivElement).style.transform = 'translateY(-2px)';
                }
            }}
            onMouseLeave={e => {
                (e.currentTarget as HTMLDivElement).style.boxShadow = 'none';
                (e.currentTarget as HTMLDivElement).style.transform = 'none';
            }}
        >
            {/* Accent bar */}
            <div style={{ position: 'absolute', top: 0, left: 0, right: 0, height: '3px', background: palette.accent }} />

            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                <div>
                    <div style={{ fontSize: '0.8125rem', fontWeight: 500, color: 'var(--text-secondary, #6B7280)', marginBottom: '0.375rem' }}>
                        {title}
                    </div>
                    <div style={{ fontSize: '1.75rem', fontWeight: 700, color: 'var(--text-primary, #111827)', lineHeight: 1.2 }}>
                        {value}
                    </div>
                    {subtitle && (
                        <div style={{ fontSize: '0.75rem', color: 'var(--text-tertiary, #9CA3AF)', marginTop: '0.25rem' }}>
                            {subtitle}
                        </div>
                    )}
                    {trend && (
                        <div style={{ fontSize: '0.75rem', fontWeight: 600, color: trendColor, marginTop: '0.375rem' }}>
                            {trendArrow} {trend}
                        </div>
                    )}
                </div>
                {icon && (
                    <div style={{
                        width: '2.5rem', height: '2.5rem', borderRadius: '0.625rem',
                        backgroundColor: palette.bg, display: 'flex', alignItems: 'center',
                        justifyContent: 'center', fontSize: '1.25rem', flexShrink: 0,
                    }}>
                        {icon}
                    </div>
                )}
            </div>
        </div>
    );
};

export default DataCard;
