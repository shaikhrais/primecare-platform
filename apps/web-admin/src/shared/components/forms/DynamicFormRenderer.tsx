import React, { useState, useEffect, useCallback } from 'react';
import { Save, Loader2, CheckCircle2, FileText } from 'lucide-react';
import { apiClient } from '@/shared/utils/apiClient';
import { useMutation } from '@tanstack/react-query';
import { useNotification } from '@/shared/context/NotificationContext';
import type { FormEntry, FormField, FormDependency } from 'prime-care-shared';
import { renderField } from './renderField';

interface DynamicFormRendererProps {
    formEntry: FormEntry;
    initialValues?: Record<string, any>;
    onSuccess?: (data: any) => void;
    onCancel?: () => void;
    compact?: boolean;
}

interface SelectOption { value: string; label: string; }

export const DynamicFormRenderer: React.FC<DynamicFormRendererProps> = ({ formEntry, initialValues = {}, onSuccess, onCancel, compact = false }) => {
    const { showToast } = useNotification();
    const [formData, setFormData] = useState<Record<string, any>>({});
    const [isSuccess, setIsSuccess] = useState(false);
    const [selectOptions, setSelectOptions] = useState<Record<string, SelectOption[]>>({});
    const [loadingFields, setLoadingFields] = useState<Set<string>>(new Set());

    useEffect(() => {
        const defaults: Record<string, any> = {};
        formEntry.fields.forEach(field => { defaults[field.name] = initialValues[field.name] ?? field.defaultValue ?? (field.type === 'checkbox' ? false : ''); });
        setFormData(defaults);
    }, [formEntry.id, initialValues]);

    const fetchOptionsForField = useCallback(async (field: FormField) => {
        if (!field.fetchOptionsFrom) return;
        setLoadingFields(prev => new Set(prev).add(field.name));
        try {
            const res = await apiClient.get(field.fetchOptionsFrom) as any;
            const items = Array.isArray(res) ? res : (res?.data || res?.items || []);
            const options: SelectOption[] = items.map((item: any) => ({ value: item.id || item._id || item.value || '', label: item.name || item.label || item.firstName ? `${item.firstName || ''} ${item.lastName || ''}`.trim() : item.email || String(item.id) }));
            setSelectOptions(prev => ({ ...prev, [field.name]: options }));
        } catch { setSelectOptions(prev => ({ ...prev, [field.name]: [] })); }
        finally { setLoadingFields(prev => { const next = new Set(prev); next.delete(field.name); return next; }); }
    }, []);

    useEffect(() => { formEntry.fields.filter(f => f.type === 'select' && f.fetchOptionsFrom).forEach(f => fetchOptionsForField(f)); }, [formEntry.id, fetchOptionsForField]);

    const handleInlineCreated = (dep: FormDependency) => { const field = formEntry.fields.find(f => f.name === dep.field); if (field) fetchOptionsForField(field); };
    const handleChange = (name: string, value: any) => { setFormData(prev => ({ ...prev, [name]: value })); };

    const submitMutation = useMutation({
        mutationFn: async (data: Record<string, any>) => {
            const endpoint = formEntry.apiEndpoint; let res: Response;
            if (formEntry.method === 'POST') { res = await apiClient.post(endpoint, data); } else if (formEntry.method === 'PUT') { res = await apiClient.put(endpoint, data); } else { res = await apiClient.patch(endpoint, data); }
            if (!res.ok) { const err = await res.json().catch(() => ({ error: 'Request failed' })); throw new Error(err.error || 'Request failed'); }
            return res.json();
        },
        onSuccess: (res) => {
            setIsSuccess(true); showToast(`${formEntry.label} submitted successfully!`, 'success'); onSuccess?.(res);
            setTimeout(() => setIsSuccess(false), 2000);
        },
        onError: (error: any) => { showToast(error.message || `Failed to submit ${formEntry.label}`, 'error'); },
    });

    const isSubmitting = submitMutation.isPending;

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        submitMutation.mutate(formData);
    };

    const formContent = (
        <form data-cy={`${formEntry.dataCyPrefix}.form`} onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '0px' }}>
            {formEntry.fields.map(field => renderField(field, formData, handleChange, formEntry.dataCyPrefix, formEntry.dependencies, selectOptions, loadingFields, handleInlineCreated))}
            <div style={{ display: 'flex', gap: '12px', marginTop: '8px', justifyContent: 'flex-end' }}>
                {onCancel && (<button type="button" data-cy={`${formEntry.dataCyPrefix}.btn-cancel`} onClick={onCancel} style={{ padding: '10px 20px', borderRadius: '8px', border: '1px solid var(--border, #CBD5E1)', background: 'transparent', color: 'var(--text-200, #475569)', fontWeight: 600, fontSize: '0.85rem', cursor: 'pointer' }}>Cancel</button>)}
                <button type="submit" data-cy={`${formEntry.dataCyPrefix}.btn-submit`} disabled={isSubmitting} style={{ display: 'flex', alignItems: 'center', gap: '8px', padding: '10px 24px', borderRadius: '8px', border: 'none', background: isSuccess ? '#10B981' : 'var(--brand-500, #2563EB)', color: 'white', fontWeight: 700, fontSize: '0.85rem', cursor: isSubmitting ? 'wait' : 'pointer', transition: 'all 0.2s', boxShadow: '0 2px 8px rgba(37, 99, 235, 0.2)' }}>
                    {isSubmitting ? (<><Loader2 size={16} className="animate-spin" /> Submitting...</>) : isSuccess ? (<><CheckCircle2 size={16} /> Submitted!</>) : (<><Save size={16} /> Submit {formEntry.label}</>)}
                </button>
            </div>
        </form>
    );

    if (compact) return formContent;

    return (
        <div data-cy={`${formEntry.dataCyPrefix}.card`} className="pc-card" style={{ padding: '28px', maxWidth: '680px', margin: '0 auto' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '12px', marginBottom: '24px' }}>
                <div style={{ backgroundColor: 'var(--brand-50, #EFF6FF)', padding: '10px', borderRadius: '10px', border: '1px solid var(--brand-100, #DBEAFE)' }}><FileText size={22} color="var(--brand-500, #2563EB)" /></div>
                <div><h2 data-cy="h2-shared.dynamic-form-renderer-0" style={{ margin: 0, fontSize: '1.25rem', fontWeight: 800, color: 'var(--text-100, #0F172A)' }}>{formEntry.label}</h2><p style={{ margin: '2px 0 0 0', fontSize: '0.8rem', color: 'var(--text-300, #94A3B8)' }}><span style={{ fontFamily: 'monospace', fontSize: '0.75rem' }}>{formEntry.method}</span>{' → '}<span style={{ fontFamily: 'monospace', fontSize: '0.75rem' }}>{formEntry.apiEndpoint}</span></p></div>
            </div>
            {formContent}
        </div>
    );
};
