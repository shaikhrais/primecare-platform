import React, { useState, useMemo } from 'react';
import { FileText, Search, LayoutGrid, Filter } from 'lucide-react';
import { AdminRegistry } from 'prime-care-shared';
import type { FormEntry } from 'prime-care-shared';
import { CATEGORY_COLORS } from './formRegistryConfig';
import { FormDetailView } from './FormDetailView';
import { FormCard } from './FormCard';

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

    if (activeForm) {
        return <FormDetailView form={activeForm as FormEntry} onBack={() => setActiveFormId(null)} />;
    }

    // ── Registry Listing View ────────────────────────────────────────────
    return (
        <div role="main" aria-label="Form Registry" data-cy="form-registry-page" style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }}>
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

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(340px, 1fr))', gap: '16px' }}>
                {filteredForms.map(form => (
                    <FormCard key={form.id} form={form} onClick={() => setActiveFormId(form.id)} />
                ))}
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
