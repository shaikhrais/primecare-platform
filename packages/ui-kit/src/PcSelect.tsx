import React, { forwardRef, useId } from 'react';

export interface PcSelectOption {
    label: string;
    value: string;
    disabled?: boolean;
}

export interface PcSelectProps extends Omit<React.SelectHTMLAttributes<HTMLSelectElement>, 'size'> {
    /** Visible label above the select */
    label?: string;
    /** Error message shown below the select */
    error?: string;
    /** Dropdown options */
    options: PcSelectOption[];
    /** Placeholder option (disabled first option) */
    placeholder?: string;
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

export const PcSelect = forwardRef<HTMLSelectElement, PcSelectProps>(
    ({ label, error, options, placeholder, size = 'md', block, style, className, id, ...rest }, ref) => {
        const autoId = useId();
        const selectId = id || autoId;
        const sizeStyle = SIZE_MAP[size];

        return (
            <div style={{ display: 'flex', flexDirection: 'column', gap: '4px', width: block ? '100%' : undefined }} className={className}>
                {label && (
                    <label
                        htmlFor={selectId}
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
                <select
                    ref={ref}
                    id={selectId}
                    style={{
                        ...sizeStyle,
                        fontFamily: 'var(--pc-font-main)',
                        borderRadius: 'var(--pc-radius-sm)',
                        border: `1px solid ${error ? 'var(--pc-error)' : 'var(--pc-border-primary)'}`,
                        backgroundColor: 'var(--pc-surface-input)',
                        color: 'var(--pc-text-primary)',
                        outline: 'none',
                        transition: 'var(--pc-transition)',
                        cursor: 'pointer',
                        width: block ? '100%' : undefined,
                        boxSizing: 'border-box',
                        appearance: 'none',
                        backgroundImage: `url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236B7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e")`,
                        backgroundPosition: 'right 8px center',
                        backgroundRepeat: 'no-repeat',
                        backgroundSize: '20px',
                        paddingRight: '32px',
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
                >
                    {placeholder && (
                        <option value="" disabled>
                            {placeholder}
                        </option>
                    )}
                    {options.map((opt) => (
                        <option key={opt.value} value={opt.value} disabled={opt.disabled}>
                            {opt.label}
                        </option>
                    ))}
                </select>
                {error && (
                    <span style={{ fontSize: '12px', color: 'var(--pc-error)', fontFamily: 'var(--pc-font-main)' }}>
                        {error}
                    </span>
                )}
            </div>
        );
    }
);

PcSelect.displayName = 'PcSelect';
export default PcSelect;
