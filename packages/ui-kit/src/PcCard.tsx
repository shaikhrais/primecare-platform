import React from 'react';

export interface PcCardProps {
    /** Card title in the header */
    title?: string;
    /** Action element rendered in the header's right side (e.g. button, badge) */
    headerAction?: React.ReactNode;
    /** Card body content */
    children: React.ReactNode;
    /** Visual variant: 'default' or 'strip' (tinted header) */
    variant?: 'default' | 'strip';
    /** Cypress test attribute */
    'data-cy'?: string;
    /** Additional inline styles */
    style?: React.CSSProperties;
    /** Additional class name */
    className?: string;
    /** Whether to add hover elevation effect */
    hoverable?: boolean;
    /** onClick handler for clickable cards */
    onClick?: (e: React.MouseEvent) => void;
}

export const PcCard: React.FC<PcCardProps> = ({
    title,
    headerAction,
    children,
    variant = 'default',
    hoverable = false,
    onClick,
    style,
    className,
    ...rest
}) => {
    return (
        <div
            data-cy={rest['data-cy']}
            className={className}
            onClick={onClick}
            style={{
                borderRadius: 'var(--pc-radius-md)',
                border: '1px solid var(--pc-border-primary)',
                backgroundColor: 'var(--pc-surface-card)',
                boxShadow: 'var(--pc-shadow-md)',
                overflow: 'hidden',
                transition: 'var(--pc-transition)',
                cursor: onClick ? 'pointer' : undefined,
                ...style,
            }}
            onMouseEnter={(e) => {
                if (hoverable || onClick) {
                    e.currentTarget.style.borderColor = 'var(--pc-border-secondary)';
                    e.currentTarget.style.boxShadow = 'var(--pc-shadow-lg)';
                }
            }}
            onMouseLeave={(e) => {
                if (hoverable || onClick) {
                    e.currentTarget.style.borderColor = 'var(--pc-border-primary)';
                    e.currentTarget.style.boxShadow = 'var(--pc-shadow-md)';
                }
            }}
        >
            {/* Header */}
            {title && (
                <div
                    style={{
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'space-between',
                        padding: '16px 20px',
                        fontWeight: 700,
                        fontSize: '16px',
                        fontFamily: 'var(--pc-font-main)',
                        borderBottom: '1px solid var(--pc-border-primary)',
                        color: variant === 'strip' ? 'var(--pc-primary)' : 'var(--pc-text-primary)',
                        backgroundColor: variant === 'strip' ? 'var(--pc-bg-secondary)' : undefined,
                    }}
                >
                    <span>{title}</span>
                    {headerAction}
                </div>
            )}

            {/* Body */}
            <div
                style={{
                    padding: '20px',
                    color: 'var(--pc-text-primary)',
                    fontFamily: 'var(--pc-font-main)',
                    lineHeight: 1.5,
                }}
            >
                {children}
            </div>
        </div>
    );
};

export default PcCard;
