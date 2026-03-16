import React, { forwardRef, useId } from 'react';

export interface PcInputProps extends Omit<React.InputHTMLAttributes<HTMLInputElement>, 'size'> {
    /** Visible label above the input */
    label?: string;
    /** Error message shown below the input */
    error?: string;
    /** Helper text shown below the input (hidden when error is present) */
    hint?: string;
    /** Visual size variant */
    size?: 'sm' | 'md' | 'lg';
    /** Full-width mode */
    block?: boolean;
    /** Cypress test attribute */
    'data-cy'?: string;
}

const SIZE_MAP = {
    sm: { padding: '6px 10px', fontSize: '13px' },
    md: { padding: '10px 14px', fontSize: '14px' },
    lg: { padding: '12px 16px', fontSize: '15px' },
};

export const PcInput = forwardRef<HTMLInputElement, PcInputProps>(
    ({ label, error, hint, size = 'md', block, style, className, id, ...rest }, ref) => {
        const autoId = useId();
        const inputId = id || autoId;
        const sizeStyle = SIZE_MAP[size];

        return (
            <div style={{ display: 'flex', flexDirection: 'column', gap: '4px', width: block ? '100%' : undefined }} className={className}>
                {label && (
                    <label
                        htmlFor={inputId}
                        style={{
                            fontSize: '13px',
                            fontWeight: 600,
                            color: 'var(--pc-text-primary)',
                            fontFamily: 'var(--pc-font-main)',
                        }}
                    >
                        {label}
                    </label>
                )}
                <input
                    ref={ref}
                    id={inputId}
                    style={{
                        ...sizeStyle,
                        fontFamily: 'var(--pc-font-main)',
                        borderRadius: 'var(--pc-radius-sm)',
                        border: `1px solid ${error ? 'var(--pc-error)' : 'var(--pc-border-primary)'}`,
                        backgroundColor: 'var(--pc-surface-input)',
                        color: 'var(--pc-text-primary)',
                        outline: 'none',
                        transition: 'var(--pc-transition)',
                        width: block ? '100%' : undefined,
                        boxSizing: 'border-box',
                        ...style,
                    }}
                    onFocus={(e) => {
                        e.currentTarget.style.borderColor = error ? 'var(--pc-error)' : 'var(--pc-border-focus)';
                        e.currentTarget.style.boxShadow = `0 0 0 2px ${error ? 'var(--pc-error-bg)' : 'rgba(59,130,246,0.15)'}`;
                        rest.onFocus?.(e);
                    }}
                    onBlur={(e) => {
                        e.currentTarget.style.borderColor = error ? 'var(--pc-error)' : 'var(--pc-border-primary)';
                        e.currentTarget.style.boxShadow = 'none';
                        rest.onBlur?.(e);
                    }}
                    {...rest}
                />
                {error && (
                    <span style={{ fontSize: '12px', color: 'var(--pc-error)', fontFamily: 'var(--pc-font-main)' }}>
                        {error}
                    </span>
                )}
                {!error && hint && (
                    <span style={{ fontSize: '12px', color: 'var(--pc-text-tertiary)', fontFamily: 'var(--pc-font-main)' }}>
                        {hint}
                    </span>
                )}
            </div>
        );
    }
);

PcInput.displayName = 'PcInput';
export default PcInput;
