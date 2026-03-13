import React, { useState, useEffect, useCallback } from 'react';
import { Save, Loader2, AlertCircle, CheckCircle2, FileText } from 'lucide-react';
import { apiClient } from '@/shared/utils/apiClient';
import { useNotification } from '@/shared/context/NotificationContext';
import { InlineCreatorPopover } from './InlineCreatorPopover';
import type { FormEntry, FormField, FormDependency } from 'prime-care-shared';

interface DynamicFormRendererProps {
    /** The FormRegistry entry to render */
    formEntry: FormEntry;
    /** Optional pre-fill values (for edit mode) */
    initialValues?: Record<string, any>;
    /** Callback after successful submission */
    onSuccess?: (data: any) => void;
    /** Callback on cancel */
    onCancel?: () => void;
    /** Compact mode (no card wrapper) */
    compact?: boolean;
}

interface SelectOption {
    value: string;
    label: string;
}

/**
 * DynamicFormRenderer — consumes a FormRegistry entry and renders a fully
 * functional form with:
 *   - All fields rendered dynamically by type
 *   - Select dropdowns populated via API (fetchOptionsFrom)
 *   - Inline creator popovers for dependency fields
 *   - data-cy tags on every interactive element
 *   - Automatic POST/PUT to the form's apiEndpoint
 */
export const DynamicFormRenderer: React.FC<DynamicFormRendererProps> = ({
    formEntry,
    initialValues = {},
    onSuccess,
    onCancel,
    compact = false,
}) => {
    const { showToast } = useNotification();
    const [formData, setFormData] = useState<Record<string, any>>({});
    const [isSubmitting, setIsSubmitting] = useState(false);
    const [isSuccess, setIsSuccess] = useState(false);
    const [selectOptions, setSelectOptions] = useState<Record<string, SelectOption[]>>({});
    const [loadingFields, setLoadingFields] = useState<Set<string>>(new Set());

    // ── Initialize form data ─────────────────────────────────────────────
    useEffect(() => {
        const defaults: Record<string, any> = {};
        formEntry.fields.forEach(field => {
            defaults[field.name] = initialValues[field.name] ?? field.defaultValue ?? (field.type === 'checkbox' ? false : '');
        });
        setFormData(defaults);
    }, [formEntry.id, initialValues]);

    // ── Fetch select options for dynamic dropdowns ───────────────────────
    const fetchOptionsForField = useCallback(async (field: FormField) => {
        if (!field.fetchOptionsFrom) return;
        setLoadingFields(prev => new Set(prev).add(field.name));
        try {
            const res = await apiClient.get(field.fetchOptionsFrom) as any;
            const items = Array.isArray(res) ? res : (res?.data || res?.items || []);
            const options: SelectOption[] = items.map((item: any) => ({
                value: item.id || item._id || item.value || '',
                label: item.name || item.label || item.firstName
                    ? `${item.firstName || ''} ${item.lastName || ''}`.trim()
                    : item.email || String(item.id),
            }));
            setSelectOptions(prev => ({ ...prev, [field.name]: options }));
        } catch {
            // Graceful fallback — empty options
            setSelectOptions(prev => ({ ...prev, [field.name]: [] }));
        } finally {
            setLoadingFields(prev => {
                const next = new Set(prev);
                next.delete(field.name);
                return next;
            });
        }
    }, []);

    useEffect(() => {
        // Fetch options for all select fields that have fetchOptionsFrom
        formEntry.fields
            .filter(f => f.type === 'select' && f.fetchOptionsFrom)
            .forEach(f => fetchOptionsForField(f));
    }, [formEntry.id, fetchOptionsForField]);

    // ── Inline creator callback — re-fetch dropdown after creation ───────
    const handleInlineCreated = (dep: FormDependency) => {
        const field = formEntry.fields.find(f => f.name === dep.field);
        if (field) fetchOptionsForField(field);
    };

    // ── Form handlers ────────────────────────────────────────────────────
    const handleChange = (name: string, value: any) => {
        setFormData(prev => ({ ...prev, [name]: value }));
    };

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setIsSubmitting(true);
        setIsSuccess(false);

        try {
            const endpoint = formEntry.apiEndpoint;
            let res: any;

            if (formEntry.method === 'POST') {
                res = await apiClient.post(endpoint, formData);
            } else if (formEntry.method === 'PUT') {
                res = await apiClient.put(endpoint, formData);
            } else {
                res = await apiClient.patch(endpoint, formData);
            }

            setIsSuccess(true);
            showToast(`${formEntry.label} submitted successfully!`, 'success');
            onSuccess?.(res);

            // Brief success state
            setTimeout(() => setIsSuccess(false), 2000);
        } catch (error: any) {
            showToast(error.message || `Failed to submit ${formEntry.label}`, 'error');
        } finally {
            setIsSubmitting(false);
        }
    };

    // ── Field renderer ───────────────────────────────────────────────────
    const renderField = (field: FormField) => {
        const dep = formEntry.dependencies?.find(d => d.field === field.name);
        const dataCy = `${formEntry.dataCyPrefix}.inp-${field.name}`;

        const labelEl = (
            <label
                style={{
                    display: 'block', fontSize: '0.8rem', fontWeight: 700,
                    color: 'var(--text-200, #334155)', marginBottom: '6px',
                }}
            >
                {field.label}
                {field.required && <span style={{ color: '#EF4444', marginLeft: '3px' }}>*</span>}
            </label>
        );

        const commonInputStyle: React.CSSProperties = {
            width: '100%', boxSizing: 'border-box' as const,
            padding: '10px 14px', borderRadius: '8px',
            border: '1px solid var(--border, #CBD5E1)',
            fontSize: '0.9rem', outline: 'none',
            backgroundColor: 'var(--bg-100, white)',
            color: 'var(--text-100, #0F172A)',
            transition: 'border-color 0.15s',
        };

        let inputEl: React.ReactNode;

        switch (field.type) {
            case 'textarea':
                inputEl = (
                    <textarea
                        data-cy={dataCy}
                        value={formData[field.name] || ''}
                        onChange={e => handleChange(field.name, e.target.value)}
                        required={field.required}
                        placeholder={field.placeholder}
                        rows={3}
                        style={{ ...commonInputStyle, resize: 'vertical', minHeight: '80px' }}
                    />
                );
                break;

            case 'select':
                inputEl = (
                    <>
                        <div style={{ position: 'relative' }}>
                            <select
                                data-cy={dataCy}
                                value={formData[field.name] || ''}
                                onChange={e => handleChange(field.name, e.target.value)}
                                required={field.required}
                                style={{ ...commonInputStyle, cursor: 'pointer', appearance: 'auto' }}
                            >
                                <option value="">
                                    {loadingFields.has(field.name) ? 'Loading...' : `Select ${field.label}`}
                                </option>
                                {(selectOptions[field.name] || []).map(opt => (
                                    <option key={opt.value} value={opt.value}>{opt.label}</option>
                                ))}
                            </select>
                        </div>
                        {/* Inline creator popover for dependencies */}
                        {dep && (
                            <InlineCreatorPopover
                                dependency={dep}
                                onCreated={() => handleInlineCreated(dep)}
                            />
                        )}
                    </>
                );
                break;

            case 'checkbox':
                inputEl = (
                    <label style={{ display: 'flex', alignItems: 'center', gap: '8px', cursor: 'pointer' }}>
                        <input
                            data-cy={dataCy}
                            type="checkbox"
                            checked={!!formData[field.name]}
                            onChange={e => handleChange(field.name, e.target.checked)}
                            style={{ width: '18px', height: '18px', accentColor: 'var(--brand-500, #2563EB)' }}
                        />
                        <span style={{ fontSize: '0.85rem', color: 'var(--text-200, #334155)' }}>{field.label}</span>
                    </label>
                );
                return (
                    <div key={field.name} style={{ marginBottom: '16px' }}>
                        {inputEl}
                    </div>
                );

            case 'file':
                inputEl = (
                    <input
                        data-cy={dataCy}
                        type="file"
                        onChange={e => handleChange(field.name, e.target.files?.[0] || null)}
                        required={field.required}
                        style={{ ...commonInputStyle, padding: '8px', cursor: 'pointer' }}
                    />
                );
                break;

            case 'hidden':
                return (
                    <input
                        key={field.name}
                        type="hidden"
                        value={formData[field.name] || ''}
                    />
                );

            default:
                inputEl = (
                    <input
                        data-cy={dataCy}
                        type={field.type}
                        value={formData[field.name] || ''}
                        onChange={e => handleChange(field.name, e.target.value)}
                        required={field.required}
                        placeholder={field.placeholder}
                        style={commonInputStyle}
                    />
                );
        }

        return (
            <div key={field.name} style={{ marginBottom: '16px' }}>
                {labelEl}
                {inputEl}
            </div>
        );
    };

    // ── Render ────────────────────────────────────────────────────────────
    const formContent = (
        <form
            data-cy={`${formEntry.dataCyPrefix}.form`}
            onSubmit={handleSubmit}
            style={{ display: 'flex', flexDirection: 'column', gap: '0px' }}
        >
            {formEntry.fields.map(field => renderField(field))}

            {/* Action buttons */}
            <div style={{ display: 'flex', gap: '12px', marginTop: '8px', justifyContent: 'flex-end' }}>
                {onCancel && (
                    <button
                        type="button"
                        data-cy={`${formEntry.dataCyPrefix}.btn-cancel`}
                        onClick={onCancel}
                        style={{
                            padding: '10px 20px', borderRadius: '8px',
                            border: '1px solid var(--border, #CBD5E1)',
                            background: 'transparent',
                            color: 'var(--text-200, #475569)',
                            fontWeight: 600, fontSize: '0.85rem', cursor: 'pointer',
                        }}
                    >
                        Cancel
                    </button>
                )}
                <button
                    type="submit"
                    data-cy={`${formEntry.dataCyPrefix}.btn-submit`}
                    disabled={isSubmitting}
                    style={{
                        display: 'flex', alignItems: 'center', gap: '8px',
                        padding: '10px 24px', borderRadius: '8px', border: 'none',
                        background: isSuccess
                            ? '#10B981'
                            : 'var(--brand-500, #2563EB)',
                        color: 'white', fontWeight: 700, fontSize: '0.85rem',
                        cursor: isSubmitting ? 'wait' : 'pointer',
                        transition: 'all 0.2s',
                        boxShadow: '0 2px 8px rgba(37, 99, 235, 0.2)',
                    }}
                >
                    {isSubmitting ? (
                        <><Loader2 size={16} className="animate-spin" /> Submitting...</>
                    ) : isSuccess ? (
                        <><CheckCircle2 size={16} /> Submitted!</>
                    ) : (
                        <><Save size={16} /> Submit {formEntry.label}</>
                    )}
                </button>
            </div>
        </form>
    );

    if (compact) return formContent;

    return (
        <div
            data-cy={`${formEntry.dataCyPrefix}.card`}
            className="pc-card"
            style={{ padding: '28px', maxWidth: '680px', margin: '0 auto' }}
        >
            <div style={{ display: 'flex', alignItems: 'center', gap: '12px', marginBottom: '24px' }}>
                <div style={{
                    backgroundColor: 'var(--brand-50, #EFF6FF)',
                    padding: '10px', borderRadius: '10px',
                    border: '1px solid var(--brand-100, #DBEAFE)',
                }}>
                    <FileText size={22} color="var(--brand-500, #2563EB)" />
                </div>
                <div>
                    <h2 style={{ margin: 0, fontSize: '1.25rem', fontWeight: 800, color: 'var(--text-100, #0F172A)' }}>
                        {formEntry.label}
                    </h2>
                    <p style={{ margin: '2px 0 0 0', fontSize: '0.8rem', color: 'var(--text-300, #94A3B8)' }}>
                        <span style={{ fontFamily: 'monospace', fontSize: '0.75rem' }}>{formEntry.method}</span>
                        {' → '}
                        <span style={{ fontFamily: 'monospace', fontSize: '0.75rem' }}>{formEntry.apiEndpoint}</span>
                    </p>
                </div>
            </div>

            {formContent}
        </div>
    );
};
