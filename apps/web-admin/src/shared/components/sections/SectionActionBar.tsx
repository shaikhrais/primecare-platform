import React from 'react';

export interface ActionBarButton {
    id: string;
    label: string;
    icon?: string;
    variant?: 'primary' | 'secondary' | 'danger' | 'ghost';
    onClick?: () => void;
}

interface SectionActionBarProps {
    buttons: ActionBarButton[];
    align?: 'left' | 'right' | 'space-between';
}

const variantStyles: Record<string, React.CSSProperties> = {
    primary:   { background: 'var(--pc-primary, #3B82F6)', color: 'white', border: 'none' },
    secondary: { background: 'var(--pc-bg-secondary, #f1f5f9)', color: 'var(--pc-text-primary)', border: '1px solid var(--pc-border-primary, #e5e7eb)' },
    danger:    { background: '#FEE2E2', color: '#DC2626', border: '1px solid #FECACA' },
    ghost:     { background: 'transparent', color: 'var(--pc-text-secondary)', border: '1px solid transparent' },
};

/** Registry-driven action bar — horizontal row of buttons */
export function SectionActionBar({ buttons, align = 'right' }: SectionActionBarProps) {
    return (
        <div style={{
            display: 'flex', gap: '10px', marginBottom: '16px',
            justifyContent: align === 'space-between' ? 'space-between' : align === 'left' ? 'flex-start' : 'flex-end',
            flexWrap: 'wrap',
        }}>
            {buttons.map(btn => (
                <button key={btn.id} onClick={btn.onClick} data-cy={btn.id} style={{
                    padding: '8px 18px', borderRadius: '8px', fontWeight: 600,
                    fontSize: '0.8rem', cursor: 'pointer', display: 'flex',
                    alignItems: 'center', gap: '6px', transition: 'all 0.2s',
                    ...variantStyles[btn.variant || 'secondary'],
                }}>
                    {btn.icon && <span>{btn.icon}</span>}
                    {btn.label}
                </button>
            ))}
        </div>
    );
}
