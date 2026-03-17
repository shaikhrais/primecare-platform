import React from 'react';

export interface ChartDataPoint {
    label: string;
    value: number;
    color?: string;
}

interface SectionChartProps {
    title?: string;
    data: ChartDataPoint[];
    type?: 'bar' | 'horizontal-bar' | 'donut';
    height?: number;
}

/** Registry-driven chart section — renders bar charts, horizontal bars, or donut charts */
export function SectionChart({ title, data, type = 'bar', height = 240 }: SectionChartProps) {
    const max = Math.max(...data.map(d => d.value), 1);
    const colors = ['#3B82F6', '#10B981', '#F59E0B', '#EF4444', '#8B5CF6', '#EC4899', '#06B6D4', '#F97316'];

    if (type === 'donut') {
        const total = data.reduce((s, d) => s + d.value, 0);
        let cumulative = 0;
        const segments = data.map((d, i) => {
            const pct = (d.value / total) * 100;
            const start = cumulative;
            cumulative += pct;
            return { ...d, pct, start, color: d.color || colors[i % colors.length] };
        });
        const gradient = segments.map(s => `${s.color} ${s.start}% ${s.start + s.pct}%`).join(', ');

        return (
            <div style={{ marginBottom: '24px' }}>
                {title && <div style={{ fontWeight: 700, marginBottom: '16px', color: 'var(--pc-text-primary)' }}>{title}</div>}
                <div style={{ display: 'flex', alignItems: 'center', gap: '32px', justifyContent: 'center' }}>
                    <div style={{
                        width: `${height}px`, height: `${height}px`, borderRadius: '50%',
                        background: `conic-gradient(${gradient})`,
                        display: 'flex', alignItems: 'center', justifyContent: 'center',
                    }}>
                        <div style={{ width: '60%', height: '60%', borderRadius: '50%', background: 'var(--pc-bg-primary, white)', display: 'flex', alignItems: 'center', justifyContent: 'center', fontWeight: 800, fontSize: '1.25rem' }}>
                            {total}
                        </div>
                    </div>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '6px' }}>
                        {segments.map(s => (
                            <div key={s.label} style={{ display: 'flex', alignItems: 'center', gap: '8px', fontSize: '0.8rem' }}>
                                <span style={{ width: '12px', height: '12px', borderRadius: '3px', background: s.color, flexShrink: 0 }} />
                                <span style={{ color: 'var(--pc-text-secondary)' }}>{s.label}</span>
                                <span style={{ fontWeight: 700 }}>{s.value}</span>
                            </div>
                        ))}
                    </div>
                </div>
            </div>
        );
    }

    if (type === 'horizontal-bar') {
        return (
            <div style={{ marginBottom: '24px' }}>
                {title && <div style={{ fontWeight: 700, marginBottom: '16px', color: 'var(--pc-text-primary)' }}>{title}</div>}
                <div style={{ display: 'flex', flexDirection: 'column', gap: '10px' }}>
                    {data.map((d, i) => (
                        <div key={d.label} style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                            <span style={{ width: '100px', fontSize: '0.8rem', color: 'var(--pc-text-secondary)', textAlign: 'right', flexShrink: 0 }}>{d.label}</span>
                            <div style={{ flex: 1, height: '24px', background: 'var(--pc-bg-secondary, #f1f5f9)', borderRadius: '6px', overflow: 'hidden' }}>
                                <div style={{ width: `${(d.value / max) * 100}%`, height: '100%', background: d.color || colors[i % colors.length], borderRadius: '6px', transition: 'width 0.6s ease' }} />
                            </div>
                            <span style={{ width: '48px', fontSize: '0.8rem', fontWeight: 700, textAlign: 'right' }}>{d.value}</span>
                        </div>
                    ))}
                </div>
            </div>
        );
    }

    // Default: vertical bar chart
    return (
        <div style={{ marginBottom: '24px' }}>
            {title && <div style={{ fontWeight: 700, marginBottom: '16px', color: 'var(--pc-text-primary)' }}>{title}</div>}
            <div style={{ display: 'flex', alignItems: 'flex-end', gap: '8px', height: `${height}px`, padding: '0 8px' }}>
                {data.map((d, i) => (
                    <div key={d.label} style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '6px', height: '100%', justifyContent: 'flex-end' }}>
                        <span style={{ fontSize: '0.7rem', fontWeight: 700 }}>{d.value}</span>
                        <div style={{
                            width: '100%', maxWidth: '48px',
                            height: `${(d.value / max) * 80}%`, minHeight: '4px',
                            background: d.color || colors[i % colors.length],
                            borderRadius: '6px 6px 0 0', transition: 'height 0.6s ease',
                        }} />
                        <span style={{ fontSize: '0.65rem', color: 'var(--pc-text-secondary)', textAlign: 'center', lineHeight: 1.2 }}>{d.label}</span>
                    </div>
                ))}
            </div>
        </div>
    );
}
