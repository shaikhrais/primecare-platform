import React, { ReactNode } from 'react';

interface ChartCardProps {
    title: string;
    children: ReactNode;
    subtitle?: string;
    height?: number | string;
    action?: ReactNode;
    onClick?: () => void;
    isDemo?: boolean;
}

export const ChartCard = ({
    title,
    children,
    subtitle,
    height = 300,
    action,
    onClick,
    isDemo
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
                cursor: onClick ? 'pointer' : 'default',
                position: 'relative'
            }}
            onClick={onClick}
        >
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '1.5rem' }}>
                <div>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                        <h3 style={{ margin: 0, fontSize: '1.125rem', fontWeight: 700, color: 'var(--text-900)' }}>{title}</h3>
                        {isDemo && (
                            <span style={{
                                backgroundColor: '#FEF3C7',
                                color: '#D97706',
                                fontSize: '0.65rem',
                                fontWeight: 800,
                                padding: '2px 6px',
                                borderRadius: '4px',
                                textTransform: 'uppercase',
                                letterSpacing: '0.5px'
                            }}>
                                Demo Data
                            </span>
                        )}
                    </div>
                    {subtitle && <p style={{ margin: '4px 0 0 0', fontSize: '0.875rem', color: 'var(--text-500)' }}>{subtitle}</p>}
                </div>
                {action && <div>{action}</div>}
            </div>

            <div style={{ flex: 1, minHeight: typeof height === 'number' ? height : 250, width: '100%' }}>
                {children}
            </div>
        </div>
    );
};
