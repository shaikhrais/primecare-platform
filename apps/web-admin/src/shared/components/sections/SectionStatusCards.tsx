// ================================================================
// SectionStatusCards — Colored alert/status cards with icons,
// values, descriptions & optional action buttons.
// Replaces old HealthAlerts sub-component.
// ================================================================
import React from 'react';

export interface StatusCardItem {
    icon: string;
    label: string;
    value: number | string;
    description?: string;
    color: 'red' | 'yellow' | 'green' | 'blue' | 'purple';
    actionLabel?: string;
}

export interface SectionStatusCardsProps {
    items: StatusCardItem[];
}

const colorMap: Record<string, { bg: string; border: string; text: string; accent: string }> = {
    red:    { bg: '#FFF5F5', border: '#FEB2B2', text: '#C53030', accent: '#9B2C2C' },
    yellow: { bg: '#FFFBEB', border: '#FDE68A', text: '#92400E', accent: '#92400E' },
    green:  { bg: '#F0FFF4', border: '#9AE6B4', text: '#276749', accent: '#276749' },
    blue:   { bg: '#EFF6FF', border: '#93C5FD', text: '#1E40AF', accent: '#1E40AF' },
    purple: { bg: '#F5F3FF', border: '#C4B5FD', text: '#5B21B6', accent: '#5B21B6' },
};

export const SectionStatusCards: React.FC<SectionStatusCardsProps> = ({ items }) => {
    return (
        <div style={{ display: 'grid', gridTemplateColumns: `repeat(auto-fit, minmax(280px, 1fr))`, gap: '1.5rem' }}>
            {items.map((item, i) => {
                const c = colorMap[item.color] || colorMap.blue;
                return (
                    <div key={i} style={{
                        background: c.bg, border: `1px solid ${c.border}`, borderRadius: '1rem',
                        padding: '1.5rem', display: 'flex', alignItems: 'center', gap: '1rem',
                    }}>
                        <div style={{ fontSize: '2rem' }}>{item.icon}</div>
                        <div style={{ flex: 1 }}>
                            <div style={{ fontWeight: 800, color: c.text }}>{item.label}</div>
                            <div style={{ fontSize: '1.5rem', fontWeight: 900, color: c.accent }}>{item.value}</div>
                            {item.description && <div style={{ fontSize: '0.75rem', color: c.text }}>{item.description}</div>}
                        </div>
                        {item.actionLabel && (
                            <button className="btn" style={{
                                background: c.text, color: 'white', border: 'none',
                                padding: '0.5rem 1rem', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer',
                            }}>{item.actionLabel}</button>
                        )}
                    </div>
                );
            })}
        </div>
    );
};
