import React from 'react';

interface EmptyStateProps {
    title: string;
    description: string;
    icon?: React.ReactNode;
    actionLabel?: string;
    onAction?: () => void;
}

export default function EmptyState({ title, description, icon, actionLabel, onAction }: EmptyStateProps) {
    return (
        <div style={{
            display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center',
            padding: '3rem', textAlign: 'center', backgroundColor: '#FAFAFA', border: '1px dashed var(--line)',
            borderRadius: '1.5rem', margin: '2rem 0', minHeight: '300px'
        }}>
            <div style={{ fontSize: '3rem', marginBottom: '1rem', opacity: '0.6', filter: 'grayscale(100%)' }}>
                {icon || '📁'}
            </div>
            <h3 style={{ fontSize: '1.25rem', fontWeight: '800', color: 'var(--text-100)', marginBottom: '0.5rem', letterSpacing: '-0.02em' }}>
                {title}
            </h3>
            <p style={{ fontSize: '0.875rem', color: 'var(--text-300)', maxWidth: '400px', lineHeight: '1.6', marginBottom: actionLabel ? '1.5rem' : '0' }}>
                {description}
            </p>
            {actionLabel && onAction && (
                <button
                    onClick={onAction}
                    data-cy="bg-action"
                    style={{
                        padding: '0.75rem 1.5rem', backgroundColor: 'var(--brand-500)', color: 'white',
                        border: 'none', borderRadius: '0.75rem', fontWeight: '800', cursor: 'pointer',
                        fontSize: '0.875rem', transition: 'background-color 0.2s', boxShadow: 'var(--shadow-sm)'
                    }}
                    onMouseEnter={(e) => e.currentTarget.style.backgroundColor = 'var(--brand-600)'}
                    onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'var(--brand-500)'}
                >
                    {actionLabel}
                </button>
            )}
        </div>
    );
}
