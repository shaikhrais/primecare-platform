// FormRegistry: FormDetailView sub-component extracted
import React from 'react';
import { ArrowLeft, Database } from 'lucide-react';
import { DynamicFormRenderer } from '@/shared/components/forms/DynamicFormRenderer';
import type { FormEntry } from 'prime-care-shared';

interface FormDetailViewProps {
    form: FormEntry;
    onBack: () => void;
}

export const FormDetailView: React.FC<FormDetailViewProps> = ({ form, onBack }) => (
    <div data-cy="form-registry-detail" style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }}>
        <button
            data-cy="btn-back-to-registry"
            onClick={onBack}
            style={{
                display: 'flex', alignItems: 'center', gap: '6px',
                background: 'transparent', border: 'none',
                color: 'var(--brand-500, #2563EB)', fontWeight: 700,
                fontSize: '0.85rem', cursor: 'pointer',
                marginBottom: '20px', padding: '0',
            }}
        >
            <ArrowLeft size={16} /> Back to Form Registry
        </button>

        <DynamicFormRenderer
            formEntry={form}
            onSuccess={(data) => { console.log('Form submitted:', data); }}
            onCancel={onBack}
        />

        {/* Form metadata panel */}
        <div className="pc-card" style={{ padding: '20px', maxWidth: '680px', margin: '24px auto 0', background: 'var(--bg-100, #F8FAFC)' }}>
            <h4 style={{ margin: '0 0 12px 0', fontSize: '0.85rem', color: 'var(--text-300, #94A3B8)', fontWeight: 700, textTransform: 'uppercase', display: 'flex', alignItems: 'center', gap: '6px' }}>
                <Database size={14} /> Form Metadata
            </h4>
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '12px', fontSize: '0.8rem' }}>
                <div><span style={{ color: 'var(--text-300)', fontWeight: 600 }}>ID:</span>{' '}<code style={{ background: '#E2E8F0', padding: '2px 6px', borderRadius: '4px' }}>{form.id}</code></div>
                <div><span style={{ color: 'var(--text-300)', fontWeight: 600 }}>Method:</span>{' '}<code style={{ background: '#E2E8F0', padding: '2px 6px', borderRadius: '4px' }}>{form.method}</code></div>
                <div><span style={{ color: 'var(--text-300)', fontWeight: 600 }}>Route:</span>{' '}<code style={{ background: '#E2E8F0', padding: '2px 6px', borderRadius: '4px', fontSize: '0.75rem' }}>{form.route}</code></div>
                <div><span style={{ color: 'var(--text-300)', fontWeight: 600 }}>API:</span>{' '}<code style={{ background: '#E2E8F0', padding: '2px 6px', borderRadius: '4px', fontSize: '0.75rem' }}>{form.apiEndpoint}</code></div>
                <div><span style={{ color: 'var(--text-300)', fontWeight: 600 }}>Fields:</span>{' '}<strong>{form.fields.length}</strong></div>
                <div><span style={{ color: 'var(--text-300)', fontWeight: 600 }}>Dependencies:</span>{' '}<strong>{form.dependencies?.length || 0}</strong></div>
            </div>
        </div>
    </div>
);
