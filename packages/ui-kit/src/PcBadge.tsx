import React from 'react';

export interface PcBadgeProps {
    /** Semantic color variant */
    variant?: 'success' | 'warning' | 'error' | 'info' | 'neutral';
    /** Content of the badge */
    children: React.ReactNode;
    /** Size variant */
    size?: 'sm' | 'md';
    /** Cypress test attribute */
    'data-cy'?: string;
    /** Additional inline styles */
    style?: React.CSSProperties;
}

const VARIANT_STYLES: Record<NonNullable<PcBadgeProps['variant']>, { color: string; background: string }> = {
    success: { color: 'var(--pc-success)', background: 'var(--pc-success-bg)' },
    warning: { color: 'var(--pc-warning)', background: 'var(--pc-warning-bg)' },
    error:   { color: 'var(--pc-error)', background: 'var(--pc-error-bg)' },
    info:    { color: 'var(--pc-info)', background: 'var(--pc-info-bg)' },
    neutral: { color: 'var(--pc-text-secondary)', background: 'var(--pc-bg-tertiary)' },
};

const SIZE_MAP = {
    sm: { padding: '2px 8px', fontSize: '11px' },
    md: { padding: '4px 10px', fontSize: '12px' },
};

export const PcBadge: React.FC<PcBadgeProps> = ({
    variant = 'neutral',
    size = 'md',
    children,
    style,
    ...rest
}) => {
    const variantStyle = VARIANT_STYLES[variant];
    const sizeStyle = SIZE_MAP[size];

    return (
        <span
            data-cy={rest['data-cy']}
            style={{
                display: 'inline-flex',
                alignItems: 'center',
                gap: '4px',
                fontFamily: 'var(--pc-font-main)',
                fontWeight: 600,
                borderRadius: 'var(--pc-radius-full)',
                whiteSpace: 'nowrap',
                lineHeight: 1.4,
                ...sizeStyle,
                ...variantStyle,
                ...style,
            }}
        >
            {children}
        </span>
    );
};

export default PcBadge;
