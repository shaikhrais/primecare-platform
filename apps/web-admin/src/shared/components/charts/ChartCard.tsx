import React, { ReactNode } from 'react';
import { ResponsiveContainer } from 'recharts';

interface ChartCardProps {
    title: string;
    children: ReactNode;
    subtitle?: string;
    height?: number | string;
    action?: ReactNode;
    onClick?: () => void;
}

export const ChartCard = ({
    title,
    children,
    subtitle,
    height = 300,
    action,
    onClick
}: ChartCardProps) => {
    return (
        <div
            className="pc-card"
            style={{
                padding: '1.5rem',
                height: 'auto',
                minHeight: typeof height === 'number' ? height + 60 : height, // account for header
                display: 'flex',
                flexDirection: 'column',
                cursor: onClick ? 'pointer' : 'default'
            }}
            onClick={onClick}
        >
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
                <div>
                    <h3 style={{ margin: 0, fontSize: '1.125rem', fontWeight: 700, color: 'var(--text-900)' }}>{title}</h3>
                    {subtitle && <p style={{ margin: '4px 0 0 0', fontSize: '0.875rem', color: 'var(--text-500)' }}>{subtitle}</p>}
                </div>
                {action && <div>{action}</div>}
            </div>

            <div style={{ flex: 1, minHeight: typeof height === 'number' ? height : 250, width: '100%' }}>
                <ResponsiveContainer width="100%" height="100%">
                    {children as any}
                </ResponsiveContainer>
            </div>
        </div>
    );
};
