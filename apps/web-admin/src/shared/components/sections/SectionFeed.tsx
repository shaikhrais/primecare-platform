import React from 'react';

export interface FeedItem {
    icon?: string;
    title: string;
    description?: string;
    time: string;
    level?: 'info' | 'warning' | 'danger' | 'success';
}

interface SectionFeedProps {
    items: FeedItem[];
    title?: string;
    maxItems?: number;
}

const levelColors: Record<string, { bg: string; border: string; dot: string }> = {
    info:    { bg: 'rgba(59,130,246,0.05)', border: '#3B82F6', dot: '#3B82F6' },
    warning: { bg: 'rgba(245,158,11,0.05)', border: '#F59E0B', dot: '#F59E0B' },
    danger:  { bg: 'rgba(239,68,68,0.05)',  border: '#EF4444', dot: '#EF4444' },
    success: { bg: 'rgba(16,185,129,0.05)', border: '#10B981', dot: '#10B981' },
};

/** Registry-driven feed section — vertical timeline of events */
export function SectionFeed({ items, title, maxItems = 20 }: SectionFeedProps) {
    const visibleItems = items.slice(0, maxItems);

    return (
        <div style={{ marginBottom: '24px' }}>
            {title && <div style={{ fontWeight: 700, marginBottom: '16px', color: 'var(--pc-text-primary)' }}>{title}</div>}
            <div style={{ display: 'flex', flexDirection: 'column', gap: '2px' }}>
                {visibleItems.map((item, i) => {
                    const lc = levelColors[item.level || 'info'];
                    return (
                        <div key={i} style={{
                            display: 'flex', alignItems: 'flex-start', gap: '12px',
                            padding: '12px 16px', borderRadius: '10px',
                            background: lc.bg, borderLeft: `3px solid ${lc.border}`,
                            transition: 'background 0.2s',
                        }}>
                            <span style={{ fontSize: '1rem', flexShrink: 0, marginTop: '2px' }}>{item.icon || '●'}</span>
                            <div style={{ flex: 1, minWidth: 0 }}>
                                <div style={{ fontWeight: 600, fontSize: '0.85rem', color: 'var(--pc-text-primary)' }}>{item.title}</div>
                                {item.description && <div style={{ fontSize: '0.75rem', color: 'var(--pc-text-secondary)', marginTop: '2px' }}>{item.description}</div>}
                            </div>
                            <span style={{ fontSize: '0.7rem', color: 'var(--pc-text-tertiary)', flexShrink: 0, whiteSpace: 'nowrap' }}>{item.time}</span>
                        </div>
                    );
                })}
            </div>
        </div>
    );
}
