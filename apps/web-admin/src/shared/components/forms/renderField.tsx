// DynamicFormRenderer: field rendering logic extracted
import React from 'react';
import type { FormField, FormDependency } from 'prime-care-shared';
import { InlineCreatorPopover } from './InlineCreatorPopover';

interface SelectOption { value: string; label: string; }

const commonInputStyle: React.CSSProperties = {
    width: '100%', boxSizing: 'border-box' as const,
    padding: '10px 14px', borderRadius: '8px',
    border: '1px solid var(--border, #CBD5E1)',
    fontSize: '0.9rem', outline: 'none',
    backgroundColor: 'var(--bg-100, white)',
    color: 'var(--text-100, #0F172A)',
    transition: 'border-color 0.15s',
};

export function renderField(
    field: FormField,
    formData: Record<string, any>,
    handleChange: (name: string, value: any) => void,
    dataCyPrefix: string,
    dependencies?: FormDependency[],
    selectOptions?: Record<string, SelectOption[]>,
    loadingFields?: Set<string>,
    handleInlineCreated?: (dep: FormDependency) => void,
) {
    const dep = dependencies?.find(d => d.field === field.name);
    const dataCy = `${dataCyPrefix}.inp-${field.name}`;

    const labelEl = (
        <label style={{ display: 'block', fontSize: '0.8rem', fontWeight: 700, color: 'var(--text-200, #334155)', marginBottom: '6px' }}>
            {field.label}
            {field.required && <span style={{ color: '#EF4444', marginLeft: '3px' }}>*</span>}
        </label>
    );

    let inputEl: React.ReactNode;

    switch (field.type) {
        case 'textarea':
            inputEl = (<textarea data-cy={dataCy} value={formData[field.name] || ''} onChange={e => handleChange(field.name, e.target.value)} required={field.required} placeholder={field.placeholder} rows={3} style={{ ...commonInputStyle, resize: 'vertical', minHeight: '80px' }} />);
            break;
        case 'select':
            inputEl = (<>
                <div style={{ position: 'relative' }}>
                    <select data-cy={dataCy} value={formData[field.name] || ''} onChange={e => handleChange(field.name, e.target.value)} required={field.required} style={{ ...commonInputStyle, cursor: 'pointer', appearance: 'auto' }}>
                        <option value="">{loadingFields?.has(field.name) ? 'Loading...' : `Select ${field.label}`}</option>
                        {(selectOptions?.[field.name] || []).map(opt => (<option key={opt.value} value={opt.value}>{opt.label}</option>))}
                    </select>
                </div>
                {dep && handleInlineCreated && (<InlineCreatorPopover dependency={dep} onCreated={() => handleInlineCreated(dep)} />)}
            </>);
            break;
        case 'checkbox':
            inputEl = (<label style={{ display: 'flex', alignItems: 'center', gap: '8px', cursor: 'pointer' }}><input data-cy={dataCy} type="checkbox" checked={!!formData[field.name]} onChange={e => handleChange(field.name, e.target.checked)} style={{ width: '18px', height: '18px', accentColor: 'var(--brand-500, #2563EB)' }} /><span style={{ fontSize: '0.85rem', color: 'var(--text-200, #334155)' }}>{field.label}</span></label>);
            return (<div key={field.name} style={{ marginBottom: '16px' }}>{inputEl}</div>);
        case 'file':
            inputEl = (<input data-cy={dataCy} type="file" onChange={e => handleChange(field.name, e.target.files?.[0] || null)} required={field.required} style={{ ...commonInputStyle, padding: '8px', cursor: 'pointer' }} />);
            break;
        case 'hidden':
            return (<input data-cy="input-shared.dynamic-form-renderer-0" key={field.name} type="hidden" value={formData[field.name] || ''} />);
        default:
            inputEl = (<input data-cy={dataCy} type={field.type} value={formData[field.name] || ''} onChange={e => handleChange(field.name, e.target.value)} required={field.required} placeholder={field.placeholder} style={commonInputStyle} />);
    }

    return (<div key={field.name} style={{ marginBottom: '16px' }}>{labelEl}{inputEl}</div>);
}
