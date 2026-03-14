import React, { useState, useMemo } from 'react';
import { FileText, Search, LayoutGrid, ChevronRight, ArrowLeft, Tag, Workflow, Plus, Database, Filter } from 'lucide-react';
import { AdminRegistry } from 'prime-care-shared';
import { DynamicFormRenderer } from '@/shared/components/forms/DynamicFormRenderer';
import type { FormEntry } from 'prime-care-shared';
import { CATEGORY_COLORS } from './formRegistryConfig';

const { FormRegistry, getFormsByCategory, getFormsWithDependencies, FORM_REGISTRY_COUNT } = AdminRegistry;


const FormRegistryPage: React.FC = () => {
    const [activeFormId, setActiveFormId] = useState<string | null>(null);
    const [searchTerm, setSearchTerm] = useState('');
    const [filterCategory, setFilterCategory] = useState<string>('all');

    const categories = useMemo(() => {
        const cats = new Set<string>();
        (FormRegistry as readonly FormEntry[]).forEach((f) => cats.add(f.category));
        return Array.from(cats);
    }, []);

    const filteredForms = useMemo(() => {
        return (FormRegistry as readonly FormEntry[]).filter(f => {
            const matchesSearch = f.label.toLowerCase().includes(searchTerm.toLowerCase()) ||
                                  f.id.toLowerCase().includes(searchTerm.toLowerCase()) ||
                                  f.apiEndpoint.toLowerCase().includes(searchTerm.toLowerCase());
            const matchesCategory = filterCategory === 'all' || f.category === filterCategory;
            return matchesSearch && matchesCategory;
        });
    }, [searchTerm, filterCategory]);

    const activeForm = useMemo(() =>
        (FormRegistry as readonly FormEntry[]).find(f => f.id === activeFormId) || null
    , [activeFormId]);

    const formsWithDeps = useMemo(() => getFormsWithDependencies(), []);

    // ── Active Form View ─────────────────────────────────────────────────
    if (activeForm) {
        return (
            <div data-cy="form-registry-detail" style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }}>
                <button
                    data-cy="btn-back-to-registry"
                    onClick={() => setActiveFormId(null)}
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
                    formEntry={activeForm as FormEntry}
                    onSuccess={(data) => {
                        console.log('Form submitted:', data);
                    }}
                    onCancel={() => setActiveFormId(null)}
                />

                {/* Form metadata panel */}
                <div
                    className="pc-card"
                    style={{ padding: '20px', maxWidth: '680px', margin: '24px auto 0', background: 'var(--bg-100, #F8FAFC)' }}
                >
                    <h4 style={{ margin: '0 0 12px 0', fontSize: '0.85rem', color: 'var(--text-300, #94A3B8)', fontWeight: 700, textTransform: 'uppercase', display: 'flex', alignItems: 'center', gap: '6px' }}>
                        <Database size={14} /> Form Metadata
                    </h4>
                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '12px', fontSize: '0.8rem' }}>
                        <div>
                            <span style={{ color: 'var(--text-300)', fontWeight: 600 }}>ID:</span>{' '}
                            <code style={{ background: '#E2E8F0', padding: '2px 6px', borderRadius: '4px' }}>{activeForm.id}</code>
                        </div>
                        <div>
                            <span style={{ color: 'var(--text-300)', fontWeight: 600 }}>Method:</span>{' '}
                            <code style={{ background: '#E2E8F0', padding: '2px 6px', borderRadius: '4px' }}>{activeForm.method}</code>
                        </div>
                        <div>
                            <span style={{ color: 'var(--text-300)', fontWeight: 600 }}>Route:</span>{' '}
                            <code style={{ background: '#E2E8F0', padding: '2px 6px', borderRadius: '4px', fontSize: '0.75rem' }}>{activeForm.route}</code>
                        </div>
                        <div>
                            <span style={{ color: 'var(--text-300)', fontWeight: 600 }}>API:</span>{' '}
                            <code style={{ background: '#E2E8F0', padding: '2px 6px', borderRadius: '4px', fontSize: '0.75rem' }}>{activeForm.apiEndpoint}</code>
                        </div>
                        <div>
                            <span style={{ color: 'var(--text-300)', fontWeight: 600 }}>Fields:</span>{' '}
                            <strong>{activeForm.fields.length}</strong>
                        </div>
                        <div>
                            <span style={{ color: 'var(--text-300)', fontWeight: 600 }}>Dependencies:</span>{' '}
                            <strong>{activeForm.dependencies?.length || 0}</strong>
                        </div>
                    </div>
                </div>
            </div>
        );
    }

    // ── Registry Listing View ────────────────────────────────────────────
    return (
        <div data-cy="form-registry-page" style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }}>
            {/* Header */}
            <div style={{ display: 'flex', alignItems: 'center', gap: '16px', marginBottom: '28px' }}>
                <div style={{
                    backgroundColor: 'var(--brand-50, #EFF6FF)',
                    padding: '14px', borderRadius: '12px',
                    border: '1px solid var(--brand-100, #DBEAFE)',
                }}>
                    <LayoutGrid size={28} color="var(--brand-500, #2563EB)" />
                </div>
                <div>
                    <h1 style={{ fontSize: '1.75rem', fontWeight: 800, margin: 0, color: 'var(--text-100, #0F172A)' }}>
                        Form Registry
                    </h1>
                    <p style={{ margin: '4px 0 0 0', color: 'var(--text-300, #94A3B8)', fontSize: '0.9rem' }}>
                        {FORM_REGISTRY_COUNT} forms · {formsWithDeps.length} with inline creators · {categories.length} categories
                    </p>
                </div>
            </div>

            {/* Summary Cards */}
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: '16px', marginBottom: '24px' }}>
                <div className="pc-card" style={{ padding: '16px', textAlign: 'center' }}>
                    <div style={{ fontSize: '1.75rem', fontWeight: 800, color: 'var(--brand-500)' }}>{FORM_REGISTRY_COUNT}</div>
                    <div style={{ fontSize: '0.75rem', fontWeight: 600, color: 'var(--text-300)', textTransform: 'uppercase' }}>Total Forms</div>
                </div>
                <div className="pc-card" style={{ padding: '16px', textAlign: 'center' }}>
                    <div style={{ fontSize: '1.75rem', fontWeight: 800, color: '#10B981' }}>{formsWithDeps.length}</div>
                    <div style={{ fontSize: '0.75rem', fontWeight: 600, color: 'var(--text-300)', textTransform: 'uppercase' }}>With Inline Creators</div>
                </div>
                <div className="pc-card" style={{ padding: '16px', textAlign: 'center' }}>
                    <div style={{ fontSize: '1.75rem', fontWeight: 800, color: '#8B5CF6' }}>{categories.length}</div>
                    <div style={{ fontSize: '0.75rem', fontWeight: 600, color: 'var(--text-300)', textTransform: 'uppercase' }}>Categories</div>
                </div>
                <div className="pc-card" style={{ padding: '16px', textAlign: 'center' }}>
                    <div style={{ fontSize: '1.75rem', fontWeight: 800, color: '#F59E0B' }}>
                        {(FormRegistry as readonly FormEntry[]).reduce((acc, f) => acc + f.fields.length, 0)}
                    </div>
                    <div style={{ fontSize: '0.75rem', fontWeight: 600, color: 'var(--text-300)', textTransform: 'uppercase' }}>Total Fields</div>
                </div>
            </div>

            {/* Search + Filter */}
            <div style={{ display: 'flex', gap: '12px', marginBottom: '24px' }}>
                <div style={{ flex: 1, position: 'relative' }}>
                    <Search size={16} color="#94A3B8" style={{ position: 'absolute', left: '12px', top: '11px' }} />
                    <input
                        data-cy="form-registry-search"
                        type="text"
                        placeholder="Search forms by name, ID, or endpoint..."
                        value={searchTerm}
                        onChange={e => setSearchTerm(e.target.value)}
                        style={{
                            width: '100%', boxSizing: 'border-box',
                            padding: '10px 14px 10px 36px', borderRadius: '8px',
                            border: '1px solid var(--border, #CBD5E1)',
                            fontSize: '0.85rem', outline: 'none',
                        }}
                    />
                </div>
                <div style={{ position: 'relative' }}>
                    <Filter size={14} color="#94A3B8" style={{ position: 'absolute', left: '10px', top: '12px' }} />
                    <select
                        data-cy="form-registry-filter"
                        value={filterCategory}
                        onChange={e => setFilterCategory(e.target.value)}
                        style={{
                            padding: '10px 14px 10px 30px', borderRadius: '8px',
                            border: '1px solid var(--border, #CBD5E1)',
                            fontSize: '0.85rem', outline: 'none', cursor: 'pointer',
                            appearance: 'auto', minWidth: '160px',
                        }}
                    >
                        <option value="all">All Categories</option>
                        {categories.map(cat => (
                            <option key={cat} value={cat}>
                                {CATEGORY_COLORS[cat]?.icon || '📄'} {cat.charAt(0).toUpperCase() + cat.slice(1)}
                            </option>
                        ))}
                    </select>
                </div>
            </div>

            {/* Form Cards Grid */}
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(340px, 1fr))', gap: '16px' }}>
                {filteredForms.map(form => {
                    const catStyle = CATEGORY_COLORS[form.category] || CATEGORY_COLORS.shared;
                    const hasDeps = form.dependencies && form.dependencies.length > 0;
                    return (
                        <div
                            key={form.id}
                            data-cy={`form-card-${form.id}`}
                            onClick={() => setActiveFormId(form.id)}
                            className="pc-card"
                            style={{
                                padding: '20px', cursor: 'pointer',
                                transition: 'all 0.15s',
                                border: '1px solid var(--border, #E2E8F0)',
                            }}
                            onMouseEnter={e => {
                                e.currentTarget.style.borderColor = 'var(--brand-300, #93C5FD)';
                                e.currentTarget.style.boxShadow = '0 4px 16px rgba(37, 99, 235, 0.1)';
                            }}
                            onMouseLeave={e => {
                                e.currentTarget.style.borderColor = 'var(--border, #E2E8F0)';
                                e.currentTarget.style.boxShadow = 'none';
                            }}
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
                                <span style={{
                                    background: catStyle.bg, color: catStyle.text,
                                    padding: '2px 8px', borderRadius: '4px',
                                    fontSize: '0.65rem', fontWeight: 700, textTransform: 'uppercase',
                                }}>
                                    {form.category}
                                </span>
                                <span style={{
                                    background: form.method === 'POST' ? '#D1FAE5' : '#FEF3C7',
                                    color: form.method === 'POST' ? '#065F46' : '#92400E',
                                    padding: '2px 8px', borderRadius: '4px',
                                    fontSize: '0.65rem', fontWeight: 700,
                                }}>
                                    {form.method}
                                </span>
                                {hasDeps && (
                                    <span style={{
                                        background: '#EDE9FE', color: '#5B21B6',
                                        padding: '2px 8px', borderRadius: '4px',
                                        fontSize: '0.65rem', fontWeight: 700,
                                        display: 'flex', alignItems: 'center', gap: '3px',
                                    }}>
                                        <Plus size={10} /> Inline
                                    </span>
                                )}
                            </div>

                            {/* Metadata */}
                            <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.75rem', color: 'var(--text-300)' }}>
                                <span style={{ display: 'flex', alignItems: 'center', gap: '4px' }}>
                                    <Tag size={12} /> {form.fields.length} fields
                                </span>
                                <span style={{ display: 'flex', alignItems: 'center', gap: '4px' }}>
                                    <Workflow size={12} /> {form.dependencies?.length || 0} deps
                                </span>
                                <span style={{ fontFamily: 'monospace', fontSize: '0.65rem' }}>
                                    {form.apiEndpoint.length > 30 ? '...' + form.apiEndpoint.slice(-28) : form.apiEndpoint}
                                </span>
                            </div>
                        </div>
                    );
                })}
            </div>

            {filteredForms.length === 0 && (
                <div style={{ textAlign: 'center', padding: '48px', color: 'var(--text-300)' }}>
                    <FileText size={48} color="var(--text-300)" style={{ marginBottom: '12px', opacity: 0.5 }} />
                    <p style={{ fontWeight: 600, margin: '0 0 6px 0' }}>No forms match your search</p>
                    <p style={{ fontSize: '0.85rem', margin: 0 }}>Try a different search term or category filter.</p>
                </div>
            )}
        </div>
    );
};

export default FormRegistryPage;
