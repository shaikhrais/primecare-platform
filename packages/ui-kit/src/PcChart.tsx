import React from 'react';

interface DataPoint {
    label: string;
    value: number;
    color?: string;
}

interface PcChartProps {
    data: DataPoint[];
    type: 'bar' | 'progress' | 'donut';
    height?: number;
    title?: string;
    showValues?: boolean;
    animated?: boolean;
}

/**
 * PcChart — Lightweight, theme-aware chart component
 * No external dependencies — pure CSS + SVG
 */
export const PcChart: React.FC<PcChartProps> = ({
    data, type, height = 200, title, showValues = true, animated = true,
}) => {
    const maxValue = Math.max(...data.map(d => d.value), 1);
    const defaultColors = [
        'var(--pc-primary)', 'var(--pc-success)', 'var(--pc-warning)',
        'var(--pc-info, #2563EB)', '#7C3AED', '#EC4899', '#F97316', '#06B6D4',
    ];

    if (type === 'bar') {
        return (
            <div style={{ padding: '16px' }}>
                {title && <h4 style={{ margin: '0 0 16px', fontWeight: 700, fontSize: '0.9rem', color: 'var(--pc-text-primary)' }}>{title}</h4>}
                <div style={{ display: 'flex', flexDirection: 'column', gap: '10px' }}>
                    {data.map((d, i) => (
                        <div key={i} style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                            <div style={{ width: '90px', fontSize: '0.75rem', fontWeight: 600, color: 'var(--pc-text-secondary)', textAlign: 'right', flexShrink: 0 }}>
                                {d.label}
                            </div>
                            <div style={{ flex: 1, height: '24px', background: 'var(--pc-bg-secondary)', borderRadius: '6px', overflow: 'hidden' }}>
                                <div style={{
                                    height: '100%', borderRadius: '6px',
                                    background: d.color || defaultColors[i % defaultColors.length],
                                    width: `${(d.value / maxValue) * 100}%`,
                                    transition: animated ? 'width 0.8s cubic-bezier(0.2, 0.8, 0.2, 1)' : 'none',
                                    display: 'flex', alignItems: 'center', justifyContent: 'flex-end', paddingRight: '8px',
                                }}>
                                    {showValues && (d.value / maxValue) > 0.15 && (
                                        <span style={{ fontSize: '0.65rem', fontWeight: 800, color: 'white' }}>{d.value.toLocaleString()}</span>
                                    )}
                                </div>
                            </div>
                            {showValues && (d.value / maxValue) <= 0.15 && (
                                <span style={{ fontSize: '0.7rem', fontWeight: 700, color: 'var(--pc-text-secondary)', minWidth: '30px' }}>{d.value.toLocaleString()}</span>
                            )}
                        </div>
                    ))}
                </div>
            </div>
        );
    }

    if (type === 'progress') {
        return (
            <div style={{ padding: '16px' }}>
                {title && <h4 style={{ margin: '0 0 16px', fontWeight: 700, fontSize: '0.9rem', color: 'var(--pc-text-primary)' }}>{title}</h4>}
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(140px, 1fr))', gap: '12px' }}>
                    {data.map((d, i) => {
                        const pct = Math.min(100, d.value);
                        const color = d.color || defaultColors[i % defaultColors.length];
                        return (
                            <div key={i} style={{ textAlign: 'center' }}>
                                <svg width="80" height="80" viewBox="0 0 80 80">
                                    <circle cx="40" cy="40" r="32" fill="none" stroke="var(--pc-bg-secondary)" strokeWidth="6" />
                                    <circle cx="40" cy="40" r="32" fill="none" stroke={color} strokeWidth="6"
                                        strokeDasharray={`${(pct / 100) * 201} 201`}
                                        strokeLinecap="round" transform="rotate(-90 40 40)"
                                        style={{ transition: animated ? 'stroke-dasharray 1s cubic-bezier(0.2, 0.8, 0.2, 1)' : 'none' }}
                                    />
                                    <text x="40" y="40" textAnchor="middle" dominantBaseline="central"
                                        style={{ fontSize: '14px', fontWeight: 800, fill: 'var(--pc-text-primary)' }}>
                                        {pct}%
                                    </text>
                                </svg>
                                <div style={{ fontSize: '0.7rem', fontWeight: 600, color: 'var(--pc-text-secondary)', marginTop: '4px' }}>{d.label}</div>
                            </div>
                        );
                    })}
                </div>
            </div>
        );
    }

    // Donut chart
    const total = data.reduce((acc, d) => acc + d.value, 0) || 1;
    let cumulativePercent = 0;

    return (
        <div style={{ padding: '16px', display: 'flex', alignItems: 'center', gap: '24px', flexWrap: 'wrap' }}>
            <div>
                {title && <h4 style={{ margin: '0 0 16px', fontWeight: 700, fontSize: '0.9rem', color: 'var(--pc-text-primary)' }}>{title}</h4>}
                <svg width={height} height={height} viewBox="0 0 200 200">
                    {data.map((d, i) => {
                        const pct = (d.value / total) * 100;
                        const startAngle = (cumulativePercent / 100) * 360;
                        cumulativePercent += pct;
                        const endAngle = (cumulativePercent / 100) * 360;
                        const startRad = ((startAngle - 90) * Math.PI) / 180;
                        const endRad = ((endAngle - 90) * Math.PI) / 180;
                        const largeArc = pct > 50 ? 1 : 0;
                        const x1 = 100 + 70 * Math.cos(startRad);
                        const y1 = 100 + 70 * Math.sin(startRad);
                        const x2 = 100 + 70 * Math.cos(endRad);
                        const y2 = 100 + 70 * Math.sin(endRad);
                        return (
                            <path key={i}
                                d={`M 100 100 L ${x1} ${y1} A 70 70 0 ${largeArc} 1 ${x2} ${y2} Z`}
                                fill={d.color || defaultColors[i % defaultColors.length]}
                                style={{ transition: animated ? 'opacity 0.5s' : 'none' }}
                            />
                        );
                    })}
                    <circle cx="100" cy="100" r="45" fill="var(--pc-surface-card)" />
                    <text x="100" y="95" textAnchor="middle" style={{ fontSize: '22px', fontWeight: 900, fill: 'var(--pc-text-primary)' }}>
                        {total.toLocaleString()}
                    </text>
                    <text x="100" y="115" textAnchor="middle" style={{ fontSize: '10px', fontWeight: 600, fill: 'var(--pc-text-tertiary)' }}>
                        TOTAL
                    </text>
                </svg>
            </div>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
                {data.map((d, i) => (
                    <div key={i} style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                        <div style={{ width: '10px', height: '10px', borderRadius: '3px', backgroundColor: d.color || defaultColors[i % defaultColors.length] }} />
                        <span style={{ fontSize: '0.8rem', color: 'var(--pc-text-secondary)' }}>{d.label}</span>
                        <span style={{ fontSize: '0.8rem', fontWeight: 700, color: 'var(--pc-text-primary)' }}>{d.value.toLocaleString()}</span>
                    </div>
                ))}
            </div>
        </div>
    );
};
