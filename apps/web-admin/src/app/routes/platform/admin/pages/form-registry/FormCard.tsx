// FormRegistry: FormCard sub-component extracted
import React from 'react';
import { ChevronRight, Tag, Workflow, Plus } from 'lucide-react';
import type { FormEntry } from 'prime-care-shared';
import { CATEGORY_COLORS } from './formRegistryConfig';

interface FormCardProps {
    form: FormEntry;
    onClick: () => void;
}

export const FormCard: React.FC<FormCardProps> = ({ form, onClick }) => {
    const catStyle = CATEGORY_COLORS[form.category] || CATEGORY_COLORS.shared;
    const hasDeps = form.dependencies && form.dependencies.length > 0;
    return (
        <div
            key={form.id}
            data-cy={`form-card-${form.id}`}
            onClick={onClick}
            className="pc-card"
            style={{ padding: '20px', cursor: 'pointer', transition: 'all 0.15s', border: '1px solid var(--border, #E2E8F0)' }}
            onMouseEnter={e => { e.currentTarget.style.borderColor = 'var(--brand-300, #93C5FD)'; e.currentTarget.style.boxShadow = '0 4px 16px rgba(37, 99, 235, 0.1)'; }}
            onMouseLeave={e => { e.currentTarget.style.borderColor = 'var(--border, #E2E8F0)'; e.currentTarget.style.boxShadow = 'none'; }}
        >
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '12px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                    <span style={{ fontSize: '1.3rem' }}>{catStyle.icon}</span>
                    <div>
                        <div style={{ fontWeight: 800, color: 'var(--text-100)', fontSize: '0.95rem' }}>{form.label}</div>
                        <div style={{ fontFamily: 'monospace', fontSize: '0.7rem', color: 'var(--text-300)' }}>{form.id}</div>
                    </div>
                </div>
                <ChevronRight size={18} color="var(--text-300, #94A3B8)" />
            </div>
            {/* Tags */}
            <div style={{ display: 'flex', flexWrap: 'wrap', gap: '6px', marginBottom: '12px' }}>
                <span style={{ background: catStyle.bg, color: catStyle.text, padding: '2px 8px', borderRadius: '4px', fontSize: '0.65rem', fontWeight: 700, textTransform: 'uppercase' }}>{form.category}</span>
                <span style={{ background: form.method === 'POST' ? '#D1FAE5' : '#FEF3C7', color: form.method === 'POST' ? '#065F46' : '#92400E', padding: '2px 8px', borderRadius: '4px', fontSize: '0.65rem', fontWeight: 700 }}>{form.method}</span>
                {hasDeps && (<span style={{ background: '#EDE9FE', color: '#5B21B6', padding: '2px 8px', borderRadius: '4px', fontSize: '0.65rem', fontWeight: 700, display: 'flex', alignItems: 'center', gap: '3px' }}><Plus size={10} /> Inline</span>)}
            </div>
            {/* Metadata */}
            <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.75rem', color: 'var(--text-300)' }}>
                <span style={{ display: 'flex', alignItems: 'center', gap: '4px' }}><Tag size={12} /> {form.fields.length} fields</span>
                <span style={{ display: 'flex', alignItems: 'center', gap: '4px' }}><Workflow size={12} /> {form.dependencies?.length || 0} deps</span>
                <span style={{ fontFamily: 'monospace', fontSize: '0.65rem' }}>{form.apiEndpoint.length > 30 ? '...' + form.apiEndpoint.slice(-28) : form.apiEndpoint}</span>
            </div>
        </div>
    );
};
