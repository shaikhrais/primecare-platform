import React from 'react';

export interface ProgressItem {
    name: string;
    description?: string;
    progress: number;
    badge?: string;
    meta?: string;
}

interface SectionProgressListProps {
    items: ProgressItem[];
}

/** Progress bar list — used for challenges, goals, training modules */
export function SectionProgressList({ items }: SectionProgressListProps) {
    return (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '16px', marginBottom: '24px' }}>
            {items.map((c, i) => (
                <div key={i} style={{
                    padding: '24px', borderRadius: '14px',
                    background: 'var(--pc-surface-card, #fff)',
                    border: '1px solid var(--pc-border-primary, #e5e7eb)',
                }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '12px' }}>
                        <div>
                            <div style={{ fontWeight: 700, fontSize: '1rem', color: 'var(--pc-text-primary)' }}>{c.name}</div>
                            {c.description && <div style={{ fontSize: '0.8rem', color: 'var(--pc-text-tertiary)', marginTop: '2px' }}>{c.description}</div>}
                        </div>
                        <div style={{ textAlign: 'right' }}>
                            {c.badge && <div style={{ fontSize: '0.75rem', fontWeight: 700, color: 'var(--pc-success, #10b981)' }}>{c.badge}</div>}
                            {c.meta && <div style={{ fontSize: '0.7rem', color: 'var(--pc-warning, #f59e0b)' }}>{c.meta}</div>}
                        </div>
                    </div>
                    <div style={{ height: '8px', background: 'var(--pc-bg-secondary, #f3f4f6)', borderRadius: '4px', overflow: 'hidden' }}>
                        <div style={{
                            width: `${c.progress}%`, height: '100%', borderRadius: '4px',
                            background: c.progress >= 75 ? 'var(--pc-success, #10b981)' : 'var(--pc-primary, #3b82f6)',
                            transition: 'width 1s ease',
                        }} />
                    </div>
                    <div style={{ fontSize: '0.7rem', color: 'var(--pc-text-tertiary)', marginTop: '6px' }}>
                        {c.progress}% complete
                    </div>
                </div>
            ))}
        </div>
    );
}
