import React from 'react';

interface SectionEmptyStateProps {
    icon?: string;
    title: string;
    description?: string;
    actionLabel?: string;
    onAction?: () => void;
}

/** Registry-driven empty state section — shown when no data is available */
export function SectionEmptyState({ icon = '📭', title, description, actionLabel, onAction }: SectionEmptyStateProps) {
    return (
        <div style={{
            padding: '60px 24px', textAlign: 'center', borderRadius: '14px',
            border: '2px dashed var(--pc-border-primary, #e5e7eb)',
            background: 'var(--pc-bg-secondary, #f9fafb)', marginBottom: '24px',
        }}>
            <div style={{ fontSize: '3rem', marginBottom: '12px' }}>{icon}</div>
            <div style={{ fontWeight: 800, fontSize: '1.1rem', color: 'var(--pc-text-primary)', marginBottom: '6px' }}>{title}</div>
            {description && <div style={{ fontSize: '0.85rem', color: 'var(--pc-text-secondary)', maxWidth: '400px', margin: '0 auto' }}>{description}</div>}
            {actionLabel && onAction && (
                <button onClick={onAction} style={{
                    marginTop: '20px', padding: '10px 24px', borderRadius: '8px',
                    background: 'var(--pc-primary, #3B82F6)', color: 'white',
                    border: 'none', fontWeight: 700, cursor: 'pointer', fontSize: '0.85rem',
                }}>
                    {actionLabel}
                </button>
            )}
        </div>
    );
}
