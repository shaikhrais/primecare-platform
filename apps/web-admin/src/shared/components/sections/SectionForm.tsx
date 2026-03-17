import React from 'react';

export interface FormField {
    key: string;
    label: string;
    type?: 'text' | 'select' | 'textarea' | 'date' | 'number' | 'toggle';
    placeholder?: string;
    options?: string[];
    value?: string;
    disabled?: boolean;
}

interface SectionFormProps {
    title?: string;
    fields: FormField[];
    columns?: 1 | 2 | 3;
    submitLabel?: string;
    onSubmit?: () => void;
}

/** Registry-driven form section — renders a structured form layout */
export function SectionForm({ title, fields, columns = 2, submitLabel = 'Save', onSubmit }: SectionFormProps) {
    const inputStyle: React.CSSProperties = {
        width: '100%', padding: '10px 14px', borderRadius: '8px',
        border: '1px solid var(--pc-border-primary, #e5e7eb)',
        background: 'var(--pc-bg-primary, white)', fontSize: '0.85rem',
        color: 'var(--pc-text-primary)', outline: 'none', boxSizing: 'border-box',
    };
    const labelStyle: React.CSSProperties = {
        fontSize: '0.75rem', fontWeight: 700, textTransform: 'uppercase',
        letterSpacing: '0.5px', color: 'var(--pc-text-secondary)',
        marginBottom: '6px', display: 'block',
    };

    return (
        <div style={{ marginBottom: '24px', padding: '24px', borderRadius: '14px', border: '1px solid var(--pc-border-primary, #e5e7eb)', background: 'var(--pc-bg-primary, white)' }}>
            {title && <div style={{ fontWeight: 700, marginBottom: '20px', fontSize: '1rem' }}>{title}</div>}
            <div style={{ display: 'grid', gridTemplateColumns: `repeat(${columns}, 1fr)`, gap: '16px' }}>
                {fields.map(f => (
                    <div key={f.key} style={f.type === 'textarea' ? { gridColumn: `span ${columns}` } : {}}>
                        <label style={labelStyle}>{f.label}</label>
                        {f.type === 'textarea' ? (
                            <textarea style={{ ...inputStyle, minHeight: '80px', resize: 'vertical' }} placeholder={f.placeholder} defaultValue={f.value} disabled={f.disabled} />
                        ) : f.type === 'select' ? (
                            <select style={inputStyle} defaultValue={f.value} disabled={f.disabled}>
                                <option value="">{f.placeholder || 'Select...'}</option>
                                {f.options?.map(o => <option key={o} value={o}>{o}</option>)}
                            </select>
                        ) : f.type === 'toggle' ? (
                            <div style={{ display: 'flex', alignItems: 'center', gap: '8px', padding: '8px 0' }}>
                                <div style={{ width: '40px', height: '22px', borderRadius: '11px', background: f.value === 'true' ? '#10B981' : '#D1D5DB', cursor: 'pointer', position: 'relative', transition: 'background 0.2s' }}>
                                    <div style={{ position: 'absolute', top: '2px', left: f.value === 'true' ? '20px' : '2px', width: '18px', height: '18px', borderRadius: '50%', background: 'white', transition: 'left 0.2s', boxShadow: '0 1px 3px rgba(0,0,0,0.2)' }} />
                                </div>
                                <span style={{ fontSize: '0.8rem', color: 'var(--pc-text-secondary)' }}>{f.value === 'true' ? 'Enabled' : 'Disabled'}</span>
                            </div>
                        ) : (
                            <input type={f.type || 'text'} style={inputStyle} placeholder={f.placeholder} defaultValue={f.value} disabled={f.disabled} />
                        )}
                    </div>
                ))}
            </div>
            {onSubmit && (
                <div style={{ marginTop: '20px', display: 'flex', justifyContent: 'flex-end' }}>
                    <button onClick={onSubmit} style={{ padding: '10px 24px', borderRadius: '8px', background: 'var(--pc-primary, #3B82F6)', color: 'white', border: 'none', fontWeight: 700, cursor: 'pointer', fontSize: '0.85rem' }}>
                        {submitLabel}
                    </button>
                </div>
            )}
        </div>
    );
}
