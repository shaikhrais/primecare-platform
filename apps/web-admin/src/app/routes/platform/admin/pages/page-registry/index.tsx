import React, { useState, useMemo } from 'react';
import { LayoutGrid, Search, Filter, Network, List } from 'lucide-react';
import { AdminRegistry } from 'prime-care-shared';
import type { PageType, PageEntry, MasterEntry } from 'prime-care-shared';
import { TYPE_META, OWNER_META } from './registryMeta';
import { IdentityMapView } from './IdentityMapView';
import { TableView } from './TableView';
import { GridView } from './GridView';

const { PageRegistry, getPageTypeStats, PAGE_REGISTRY_COUNT, MASTER_REGISTRY, MASTER_REGISTRY_COUNT } = AdminRegistry;

type ViewMode = 'identity' | 'grid' | 'table';

export default function PageRegistryPage() {
    const [searchTerm, setSearchTerm] = useState('');
    const [filterType, setFilterType] = useState<string>('all');
    const [filterOwner, setFilterOwner] = useState<string>('all');
    const [viewMode, setViewMode] = useState<ViewMode>('identity');
    const [selectedCode, setSelectedCode] = useState<string | null>(null);

    const masterEntries = useMemo(() => Object.entries(MASTER_REGISTRY as Record<string, MasterEntry>).map(([code, entry]) => ({ code, ...entry })), []);

    const filteredMaster = useMemo(() => masterEntries.filter(e => {
        const matchSearch = !searchTerm || e.code.toLowerCase().includes(searchTerm.toLowerCase()) || e.label.toLowerCase().includes(searchTerm.toLowerCase()) || e.file.toLowerCase().includes(searchTerm.toLowerCase()) || e.associates.some(a => a.toLowerCase().includes(searchTerm.toLowerCase()));
        return matchSearch && (filterType === 'all' || e.type === filterType) && (filterOwner === 'all' || e.owner === filterOwner);
    }), [masterEntries, searchTerm, filterType, filterOwner]);

    const groupedByOwner = useMemo(() => { const g: Record<string, typeof filteredMaster> = {}; filteredMaster.forEach(e => { (g[e.owner] = g[e.owner] || []).push(e); }); return g; }, [filteredMaster]);
    const masterTypeStats = useMemo(() => { const s: Record<string, number> = {}; masterEntries.forEach(e => { s[e.type] = (s[e.type] || 0) + 1; }); return s; }, [masterEntries]);
    const masterOwnerStats = useMemo(() => { const s: Record<string, number> = {}; masterEntries.forEach(e => { s[e.owner] = (s[e.owner] || 0) + 1; }); return s; }, [masterEntries]);

    const filteredPages = useMemo(() => (PageRegistry as PageEntry[]).filter(p => {
        const matchSearch = p.label.toLowerCase().includes(searchTerm.toLowerCase()) || p.id.toLowerCase().includes(searchTerm.toLowerCase()) || p.route.toLowerCase().includes(searchTerm.toLowerCase()) || p.categoryCode.toLowerCase().includes(searchTerm.toLowerCase()) || String(p.srNo).includes(searchTerm);
        return matchSearch && (filterType === 'all' || p.type === filterType) && (filterOwner === 'all' || p.owner === filterOwner);
    }), [searchTerm, filterType, filterOwner]);

    const grouped = useMemo(() => { const g: Record<string, PageEntry[]> = {}; filteredPages.forEach(p => { (g[p.type] = g[p.type] || []).push(p); }); return g; }, [filteredPages]);

    const selectedEntry = selectedCode ? MASTER_REGISTRY?.[selectedCode] as MasterEntry | undefined : null;

    return (
        <div data-cy="page.container" role="main" aria-label="Page Registry" data-cy="page-registry-page" style={{ padding: '24px', maxWidth: '1400px', margin: '0 auto' }}>
            {/* Header */}
            <div style={{ display: 'flex', alignItems: 'center', gap: '16px', marginBottom: '28px' }}>
                <div style={{ background: 'linear-gradient(135deg, #1E40AF 0%, #7C3AED 100%)', padding: '14px', borderRadius: '14px', boxShadow: '0 4px 12px rgba(124,58,237,0.3)' }}><Network size={28} color="white" /></div>
                <div style={{ flex: 1 }}>
                    <h1 style={{ fontSize: '1.75rem', fontWeight: 800, margin: 0, color: '#0F172A' }}>Identity Registry Dashboard</h1>
                    <p style={{ margin: '4px 0 0 0', color: '#94A3B8', fontSize: '0.9rem' }}>{MASTER_REGISTRY_COUNT || masterEntries.length} identity codes · {Object.keys(masterOwnerStats).length} owners · {Object.keys(masterTypeStats).length} types · Every page mapped with associates</p>
                </div>
                <div style={{ display: 'flex', gap: '4px', background: '#F1F5F9', borderRadius: '8px', padding: '3px' }}>
                    {[{ key: 'identity' as ViewMode, label: 'Identity Map', icon: <Network size={13} /> }, { key: 'grid' as ViewMode, label: 'Grid', icon: <LayoutGrid size={13} /> }, { key: 'table' as ViewMode, label: 'Table', icon: <List size={13} /> }].map(v => (
                        <button key={v.key} data-cy={`view-mode-${v.key}`} onClick={() => setViewMode(v.key)}
                            style={{ display: 'flex', alignItems: 'center', gap: '4px', padding: '6px 12px', borderRadius: '6px', border: 'none', cursor: 'pointer', background: viewMode === v.key ? 'white' : 'transparent', fontWeight: viewMode === v.key ? 700 : 500, fontSize: '0.78rem', boxShadow: viewMode === v.key ? '0 1px 3px rgba(0,0,0,0.1)' : 'none', color: viewMode === v.key ? '#1E40AF' : '#64748B' }}>
                            {v.icon} {v.label}
                        </button>
                    ))}
                </div>
            </div>

            {/* KPI Strip */}
            <div data-cy="identity-kpi-strip" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(120px, 1fr))', gap: '10px', marginBottom: '20px' }}>
                {Object.entries(masterTypeStats).sort((a, b) => b[1] - a[1]).map(([type, count]) => {
                    const meta = TYPE_META[type as PageType]; if (!meta) return null;
                    const isActive = filterType === type;
                    return (<button key={type} data-cy={`kpi-${type}`} onClick={() => setFilterType(isActive ? 'all' : type)}
                        style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', padding: '12px 8px', borderRadius: '12px', border: isActive ? `2px solid ${meta.color}` : '1px solid #E2E8F0', background: isActive ? meta.bg : 'white', cursor: 'pointer', transition: 'all 0.15s' }}>
                        <span style={{ color: meta.color, marginBottom: '4px' }}>{meta.icon}</span>
                        <span style={{ fontWeight: 900, fontSize: '1.4rem', color: meta.color, lineHeight: 1 }}>{count}</span>
                        <span style={{ fontWeight: 700, fontSize: '0.6rem', color: isActive ? meta.color : '#94A3B8', textTransform: 'uppercase', marginTop: '2px' }}>{meta.label}s</span>
                    </button>);
                })}
            </div>

            {/* Search + Owner Filter */}
            <div style={{ display: 'flex', gap: '12px', marginBottom: '24px' }}>
                <div style={{ flex: 1, position: 'relative' }}>
                    <Search size={16} color="#94A3B8" style={{ position: 'absolute', left: '12px', top: '11px' }} />
                    <input data-cy="page-registry-search" type="text" placeholder="Search by code (D4), label, file path, or associate..." value={searchTerm} onChange={e => setSearchTerm(e.target.value)}
                        style={{ width: '100%', boxSizing: 'border-box', padding: '10px 14px 10px 36px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem', outline: 'none' }} />
                </div>
                <div style={{ position: 'relative' }}>
                    <Filter size={14} color="#94A3B8" style={{ position: 'absolute', left: '10px', top: '12px' }} />
                    <select data-cy="page-registry-owner-filter" value={filterOwner} onChange={e => setFilterOwner(e.target.value)}
                        style={{ padding: '10px 14px 10px 30px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem', outline: 'none', cursor: 'pointer', minWidth: '160px' }}>
                        <option value="all">All Owners</option>
                        {Object.entries(masterOwnerStats).sort((a, b) => b[1] - a[1]).map(([owner, count]) => (
                            <option key={owner} value={owner}>{OWNER_META[owner]?.icon || '📄'} {owner} ({count})</option>
                        ))}
                    </select>
                </div>
            </div>

            {viewMode === 'identity' && <IdentityMapView groupedByOwner={groupedByOwner} selectedCode={selectedCode} setSelectedCode={setSelectedCode} selectedEntry={selectedEntry || null} />}
            {viewMode === 'table' && <TableView filteredMaster={filteredMaster} />}
            {viewMode === 'grid' && <GridView grouped={grouped} />}

            {filteredMaster.length === 0 && viewMode === 'identity' && (
                <div style={{ textAlign: 'center', padding: '48px', color: '#94A3B8' }}>
                    <Network size={48} style={{ marginBottom: '12px', opacity: 0.5 }} />
                    <p style={{ fontWeight: 600, margin: '0 0 6px' }}>No pages match your filters</p>
                    <p style={{ fontSize: '0.85rem', margin: 0 }}>Try adjusting search, type, or owner filters.</p>
                </div>
            )}
        </div>
    );
}
