import React from 'react';

export interface KpiCardItem {
    label: string;
    value: string | number;
    icon?: string;
    color?: string;
}

interface SectionKpiCardsProps {
    items: KpiCardItem[];
}

/** Row of KPI stat cards — used for homes, hubs, and list page summaries */
export function SectionKpiCards({ items }: SectionKpiCardsProps) {
    return (
        <div style={{ display: 'flex', gap: '16px', flexWrap: 'wrap', marginBottom: '24px' }}>
            {items.map((s, i) => (
                <div key={i} style={{
                    flex: '1 1 160px', padding: '20px', borderRadius: '14px',
                    background: 'var(--pc-surface-card, var(--card-bg, #fff))',
                    border: '1px solid var(--pc-border-primary, var(--border, #e5e7eb))',
                }}>
                    <div style={{
                        fontSize: '0.7rem', fontWeight: 600,
                        color: 'var(--pc-text-tertiary)', textTransform: 'uppercase',
                        marginBottom: '6px',
                    }}>
                        {s.icon && <span style={{ marginRight: '4px' }}>{s.icon}</span>}
                        {s.label}
                    </div>
                    <div style={{
                        fontSize: '1.8rem', fontWeight: 800,
                        color: s.color || 'var(--pc-primary, #3b82f6)',
                    }}>
                        {typeof s.value === 'number' ? s.value.toLocaleString() : s.value}
                    </div>
                </div>
            ))}
        </div>
    );
}
