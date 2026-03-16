import React from 'react';

export interface CardGridItem {
    icon?: string;
    title: string;
    subtitle?: string;
    badge?: string;
}

interface SectionCardGridProps {
    items: CardGridItem[];
    columns?: number;
}

/** Hoverable card grid — used for badges, rewards, navigation tiles */
export function SectionCardGrid({ items, columns = 4 }: SectionCardGridProps) {
    const minWidth = Math.round(800 / columns);
    return (
        <div style={{
            display: 'grid',
            gridTemplateColumns: `repeat(auto-fill, minmax(${minWidth}px, 1fr))`,
            gap: '16px', marginBottom: '24px',
        }}>
            {items.map((item, i) => (
                <div key={i} style={{
                    padding: '24px', borderRadius: '14px', textAlign: 'center',
                    background: 'var(--pc-surface-card, #fff)',
                    border: '1px solid var(--pc-border-primary, #e5e7eb)',
                    transition: 'transform 0.2s, box-shadow 0.2s', cursor: 'pointer',
                }}
                    onMouseEnter={e => {
                        e.currentTarget.style.transform = 'translateY(-4px)';
                        e.currentTarget.style.boxShadow = '0 8px 30px rgba(0,0,0,0.12)';
                    }}
                    onMouseLeave={e => {
                        e.currentTarget.style.transform = 'translateY(0)';
                        e.currentTarget.style.boxShadow = 'none';
                    }}>
                    {item.icon && <div style={{ fontSize: '2.5rem', marginBottom: '12px' }}>{item.icon}</div>}
                    <div style={{ fontWeight: 700, fontSize: '0.95rem', color: 'var(--pc-text-primary)', marginBottom: '4px' }}>
                        {item.title}
                    </div>
                    {item.subtitle && (
                        <div style={{ fontSize: '0.75rem', color: 'var(--pc-text-tertiary)' }}>
                            {item.subtitle}
                        </div>
                    )}
                    {item.badge && (
                        <div style={{
                            marginTop: '8px', display: 'inline-block',
                            padding: '3px 10px', borderRadius: '10px',
                            fontSize: '0.7rem', fontWeight: 700,
                            color: 'var(--pc-success, #10b981)',
                            background: 'rgba(16,185,129,0.1)',
                        }}>
                            {item.badge}
                        </div>
                    )}
                </div>
            ))}
        </div>
    );
}
