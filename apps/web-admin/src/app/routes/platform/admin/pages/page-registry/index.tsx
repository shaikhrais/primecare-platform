import React, { useState, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { LayoutGrid, Search, Filter, ChevronRight, BarChart3, ClipboardList, Layers, Compass, FileText, Wand2, AlertTriangle, Wrench, Globe, BookOpen, List, Network, ArrowRight, ExternalLink, FolderOpen } from 'lucide-react';
import { AdminRegistry } from 'prime-care-shared';
import type { PageType, PageEntry, MasterEntry } from 'prime-care-shared';

const { PageRegistry, getPageTypeStats, PAGE_REGISTRY_COUNT, CATEGORY_PREFIXES, MASTER_REGISTRY, MASTER_REGISTRY_COUNT, getAssociates } = AdminRegistry;

const TYPE_META: Record<PageType, { color: string; bg: string; icon: React.ReactNode; label: string }> = {
    dashboard:  { color: '#1D4ED8', bg: '#DBEAFE', icon: <BarChart3 size={14} />, label: 'Dashboard' },
    form:       { color: '#065F46', bg: '#D1FAE5', icon: <ClipboardList size={14} />, label: 'Form' },
    list:       { color: '#92400E', bg: '#FEF3C7', icon: <Layers size={14} />, label: 'List' },
    hub:        { color: '#9D174D', bg: '#FCE7F3', icon: <Compass size={14} />, label: 'Hub' },
    wizard:     { color: '#5B21B6', bg: '#EDE9FE', icon: <Wand2 size={14} />, label: 'Wizard' },
    report:     { color: '#166534', bg: '#DCFCE7', icon: <FileText size={14} />, label: 'Report' },
    tool:       { color: '#0369A1', bg: '#E0F2FE', icon: <Wrench size={14} />, label: 'Tool' },
    portal:     { color: '#B45309', bg: '#FEF9C3', icon: <Globe size={14} />, label: 'Portal' },
    registry:   { color: '#7C3AED', bg: '#F3E8FF', icon: <BookOpen size={14} />, label: 'Registry' },
    settings:   { color: '#374151', bg: '#F3F4F6', icon: <Wrench size={14} />, label: 'Settings' },
    detail:     { color: '#4338CA', bg: '#E0E7FF', icon: <FileText size={14} />, label: 'Detail' },
    error:      { color: '#DC2626', bg: '#FEE2E2', icon: <AlertTriangle size={14} />, label: 'Error' },
};

const OWNER_META: Record<string, { icon: string; color: string; bg: string }> = {
    admin:         { icon: '⚙️', color: '#1E40AF', bg: '#DBEAFE' },
    superuser:     { icon: '👑', color: '#92400E', bg: '#FEF3C7' },
    manager:       { icon: '📊', color: '#7C3AED', bg: '#EDE9FE' },
    staff:         { icon: '👥', color: '#0369A1', bg: '#E0F2FE' },
    psw:           { icon: '🩺', color: '#065F46', bg: '#D1FAE5' },
    rn:            { icon: '💉', color: '#DC2626', bg: '#FEE2E2' },
    client:        { icon: '👤', color: '#B45309', bg: '#FEF9C3' },
    coordinator:   { icon: '📍', color: '#9D174D', bg: '#FCE7F3' },
    allied:        { icon: '🏥', color: '#166534', bg: '#DCFCE7' },
    'scrum-master':{ icon: '🔧', color: '#374151', bg: '#F3F4F6' },
    auth:          { icon: '🔐', color: '#4338CA', bg: '#E0E7FF' },
    shared:        { icon: '🔗', color: '#64748B', bg: '#F1F5F9' },
};

type ViewMode = 'identity' | 'grid' | 'table';

export default function PageRegistryPage() {
    const navigate = useNavigate();
    const [searchTerm, setSearchTerm] = useState('');
    const [filterType, setFilterType] = useState<string>('all');
    const [filterOwner, setFilterOwner] = useState<string>('all');
    const [viewMode, setViewMode] = useState<ViewMode>('identity');
    const [selectedCode, setSelectedCode] = useState<string | null>(null);

    const typeStats = useMemo(() => getPageTypeStats(), []);
    const pageTypes = useMemo(() => Object.keys(typeStats) as PageType[], [typeStats]);
    const owners = useMemo(() => {
        const s = new Set<string>();
        PageRegistry.forEach((p: PageEntry) => s.add(p.owner));
        return Array.from(s);
    }, []);

    // Master registry entries as array
    const masterEntries = useMemo(() => {
        return Object.entries(MASTER_REGISTRY as Record<string, MasterEntry>).map(([code, entry]) => ({ code, ...entry }));
    }, []);

    // Filtered master entries
    const filteredMaster = useMemo(() => {
        return masterEntries.filter(e => {
            const matchSearch = !searchTerm ||
                e.code.toLowerCase().includes(searchTerm.toLowerCase()) ||
                e.label.toLowerCase().includes(searchTerm.toLowerCase()) ||
                e.file.toLowerCase().includes(searchTerm.toLowerCase()) ||
                e.associates.some(a => a.toLowerCase().includes(searchTerm.toLowerCase()));
            const matchType = filterType === 'all' || e.type === filterType;
            const matchOwner = filterOwner === 'all' || e.owner === filterOwner;
            return matchSearch && matchType && matchOwner;
        });
    }, [masterEntries, searchTerm, filterType, filterOwner]);

    // Grouped by owner for identity view
    const groupedByOwner = useMemo(() => {
        const g: Record<string, typeof filteredMaster> = {};
        filteredMaster.forEach(e => {
            (g[e.owner] = g[e.owner] || []).push(e);
        });
        return g;
    }, [filteredMaster]);

    // Stats by type from master
    const masterTypeStats = useMemo(() => {
        const stats: Record<string, number> = {};
        masterEntries.forEach(e => { stats[e.type] = (stats[e.type] || 0) + 1; });
        return stats;
    }, [masterEntries]);

    // Stats by owner from master
    const masterOwnerStats = useMemo(() => {
        const stats: Record<string, number> = {};
        masterEntries.forEach(e => { stats[e.owner] = (stats[e.owner] || 0) + 1; });
        return stats;
    }, [masterEntries]);

    // Filtered pages for grid/table
    const filteredPages = useMemo(() => {
        return (PageRegistry as PageEntry[]).filter(p => {
            const matchSearch = p.label.toLowerCase().includes(searchTerm.toLowerCase()) ||
                                p.id.toLowerCase().includes(searchTerm.toLowerCase()) ||
                                p.route.toLowerCase().includes(searchTerm.toLowerCase()) ||
                                p.categoryCode.toLowerCase().includes(searchTerm.toLowerCase()) ||
                                String(p.srNo).includes(searchTerm);
            const matchType = filterType === 'all' || p.type === filterType;
            const matchOwner = filterOwner === 'all' || p.owner === filterOwner;
            return matchSearch && matchType && matchOwner;
        });
    }, [searchTerm, filterType, filterOwner]);

    const grouped = useMemo(() => {
        const g: Record<string, PageEntry[]> = {};
        filteredPages.forEach(p => { (g[p.type] = g[p.type] || []).push(p); });
        return g;
    }, [filteredPages]);

    const selectedEntry = selectedCode ? MASTER_REGISTRY?.[selectedCode] as MasterEntry | undefined : null;

    return (
        <div data-cy="page-registry-page" style={{ padding: '24px', maxWidth: '1400px', margin: '0 auto' }}>
            {/* Header */}
            <div style={{ display: 'flex', alignItems: 'center', gap: '16px', marginBottom: '28px' }}>
                <div style={{
                    background: 'linear-gradient(135deg, #1E40AF 0%, #7C3AED 100%)',
                    padding: '14px', borderRadius: '14px',
                    boxShadow: '0 4px 12px rgba(124,58,237,0.3)',
                }}>
                    <Network size={28} color="white" />
                </div>
                <div style={{ flex: 1 }}>
                    <h1 style={{ fontSize: '1.75rem', fontWeight: 800, margin: 0, color: '#0F172A' }}>
                        Identity Registry Dashboard
                    </h1>
                    <p style={{ margin: '4px 0 0 0', color: '#94A3B8', fontSize: '0.9rem' }}>
                        {MASTER_REGISTRY_COUNT || masterEntries.length} identity codes · {Object.keys(masterOwnerStats).length} owners · {Object.keys(masterTypeStats).length} types · Every page mapped with associates
                    </p>
                </div>
                {/* View toggle */}
                <div style={{ display: 'flex', gap: '4px', background: '#F1F5F9', borderRadius: '8px', padding: '3px' }}>
                    {[
                        { key: 'identity' as ViewMode, label: 'Identity Map', icon: <Network size={13} /> },
                        { key: 'grid' as ViewMode, label: 'Grid', icon: <LayoutGrid size={13} /> },
                        { key: 'table' as ViewMode, label: 'Table', icon: <List size={13} /> },
                    ].map(v => (
                        <button
                            key={v.key}
                            data-cy={`view-mode-${v.key}`}
                            onClick={() => setViewMode(v.key)}
                            style={{
                                display: 'flex', alignItems: 'center', gap: '4px',
                                padding: '6px 12px', borderRadius: '6px', border: 'none', cursor: 'pointer',
                                background: viewMode === v.key ? 'white' : 'transparent',
                                fontWeight: viewMode === v.key ? 700 : 500, fontSize: '0.78rem',
                                boxShadow: viewMode === v.key ? '0 1px 3px rgba(0,0,0,0.1)' : 'none',
                                color: viewMode === v.key ? '#1E40AF' : '#64748B',
                            }}
                        >
                            {v.icon} {v.label}
                        </button>
                    ))}
                </div>
            </div>

            {/* KPI Strip */}
            <div data-cy="identity-kpi-strip" style={{
                display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(120px, 1fr))',
                gap: '10px', marginBottom: '20px',
            }}>
                {Object.entries(masterTypeStats).sort((a, b) => b[1] - a[1]).map(([type, count]) => {
                    const meta = TYPE_META[type as PageType];
                    if (!meta) return null;
                    const isActive = filterType === type;
                    return (
                        <button
                            key={type}
                            data-cy={`kpi-${type}`}
                            onClick={() => setFilterType(isActive ? 'all' : type)}
                            style={{
                                display: 'flex', flexDirection: 'column', alignItems: 'center',
                                padding: '12px 8px', borderRadius: '12px',
                                border: isActive ? `2px solid ${meta.color}` : '1px solid #E2E8F0',
                                background: isActive ? meta.bg : 'white',
                                cursor: 'pointer', transition: 'all 0.15s',
                            }}
                        >
                            <span style={{ color: meta.color, marginBottom: '4px' }}>{meta.icon}</span>
                            <span style={{ fontWeight: 900, fontSize: '1.4rem', color: meta.color, lineHeight: 1 }}>{count}</span>
                            <span style={{ fontWeight: 700, fontSize: '0.6rem', color: isActive ? meta.color : '#94A3B8', textTransform: 'uppercase', marginTop: '2px' }}>{meta.label}s</span>
                        </button>
                    );
                })}
            </div>

            {/* Search + Owner Filter */}
            <div style={{ display: 'flex', gap: '12px', marginBottom: '24px' }}>
                <div style={{ flex: 1, position: 'relative' }}>
                    <Search size={16} color="#94A3B8" style={{ position: 'absolute', left: '12px', top: '11px' }} />
                    <input
                        data-cy="page-registry-search"
                        type="text"
                        placeholder="Search by code (D4), label, file path, or associate..."
                        value={searchTerm}
                        onChange={e => setSearchTerm(e.target.value)}
                        style={{
                            width: '100%', boxSizing: 'border-box',
                            padding: '10px 14px 10px 36px', borderRadius: '8px',
                            border: '1px solid #CBD5E1', fontSize: '0.85rem', outline: 'none',
                        }}
                    />
                </div>
                <div style={{ position: 'relative' }}>
                    <Filter size={14} color="#94A3B8" style={{ position: 'absolute', left: '10px', top: '12px' }} />
                    <select
                        data-cy="page-registry-owner-filter"
                        value={filterOwner}
                        onChange={e => setFilterOwner(e.target.value)}
                        style={{
                            padding: '10px 14px 10px 30px', borderRadius: '8px',
                            border: '1px solid #CBD5E1', fontSize: '0.85rem',
                            outline: 'none', cursor: 'pointer', minWidth: '160px',
                        }}
                    >
                        <option value="all">All Owners</option>
                        {Object.entries(masterOwnerStats).sort((a, b) => b[1] - a[1]).map(([owner, count]) => (
                            <option key={owner} value={owner}>{OWNER_META[owner]?.icon || '📄'} {owner} ({count})</option>
                        ))}
                    </select>
                </div>
            </div>

            {/* ── IDENTITY MAP VIEW ── */}
            {viewMode === 'identity' && (
                <div style={{ display: 'flex', gap: '24px' }}>
                    {/* Left: grouped entries */}
                    <div style={{ flex: 1 }}>
                        {Object.entries(groupedByOwner).sort((a, b) => b[1].length - a[1].length).map(([owner, entries]) => {
                            const ownerMeta = OWNER_META[owner] || { icon: '📄', color: '#64748B', bg: '#F1F5F9' };
                            return (
                                <div key={owner} style={{ marginBottom: '28px' }}>
                                    {/* Owner header */}
                                    <div style={{
                                        display: 'flex', alignItems: 'center', gap: '10px',
                                        marginBottom: '12px', padding: '8px 14px',
                                        background: ownerMeta.bg, borderRadius: '10px',
                                        borderLeft: `4px solid ${ownerMeta.color}`,
                                    }}>
                                        <span style={{ fontSize: '1.2rem' }}>{ownerMeta.icon}</span>
                                        <span style={{ fontWeight: 800, color: ownerMeta.color, fontSize: '0.9rem', textTransform: 'uppercase' }}>
                                            {owner}
                                        </span>
                                        <span style={{
                                            fontWeight: 800, fontSize: '0.75rem', color: 'white',
                                            background: ownerMeta.color, padding: '2px 8px', borderRadius: '10px',
                                        }}>
                                            {entries.length}
                                        </span>
                                    </div>

                                    {/* Entries */}
                                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(340px, 1fr))', gap: '8px' }}>
                                        {entries.map(entry => {
                                            const meta = TYPE_META[entry.type as PageType];
                                            const isSelected = selectedCode === entry.code;
                                            return (
                                                <div
                                                    key={entry.code}
                                                    data-cy={`identity-card-${entry.code}`}
                                                    onClick={() => setSelectedCode(isSelected ? null : entry.code)}
                                                    style={{
                                                        padding: '12px 14px', borderRadius: '10px',
                                                        border: isSelected ? `2px solid ${meta?.color || '#64748B'}` : '1px solid #E2E8F0',
                                                        background: isSelected ? (meta?.bg || '#F1F5F9') : 'white',
                                                        cursor: 'pointer', transition: 'all 0.15s',
                                                    }}
                                                    onMouseEnter={e => { if (!isSelected) e.currentTarget.style.borderColor = meta?.color || '#94A3B8'; }}
                                                    onMouseLeave={e => { if (!isSelected) e.currentTarget.style.borderColor = '#E2E8F0'; }}
                                                >
                                                    <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                                                        {/* Code badge */}
                                                        <span style={{
                                                            display: 'inline-flex', alignItems: 'center', justifyContent: 'center',
                                                            minWidth: '44px', padding: '4px 8px', borderRadius: '8px',
                                                            fontWeight: 900, fontSize: '0.8rem', fontFamily: 'monospace',
                                                            background: meta?.bg || '#F1F5F9', color: meta?.color || '#64748B',
                                                            border: `1px solid ${meta?.color || '#CBD5E1'}20`,
                                                        }}>
                                                            {entry.code}
                                                        </span>
                                                        <div style={{ flex: 1, minWidth: 0 }}>
                                                            <div style={{ fontWeight: 700, fontSize: '0.85rem', color: '#0F172A' }}>{entry.label}</div>
                                                            <div style={{
                                                                fontFamily: 'monospace', fontSize: '0.55rem', color: '#94A3B8',
                                                                overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap',
                                                            }}>
                                                                {entry.file.split('/').slice(-2).join('/')}
                                                            </div>
                                                        </div>
                                                        {/* Type pill */}
                                                        <span style={{
                                                            padding: '2px 7px', borderRadius: '4px',
                                                            fontSize: '0.55rem', fontWeight: 700, textTransform: 'uppercase',
                                                            background: meta?.bg || '#F1F5F9', color: meta?.color || '#64748B',
                                                        }}>{meta?.label || entry.type}</span>
                                                    </div>

                                                    {/* Associates */}
                                                    {entry.associates.length > 0 && (
                                                        <div style={{ display: 'flex', gap: '4px', marginTop: '8px', flexWrap: 'wrap', alignItems: 'center' }}>
                                                            <ArrowRight size={10} color="#94A3B8" />
                                                            {entry.associates.map(a => {
                                                                const assocEntry = (MASTER_REGISTRY as Record<string, MasterEntry>)?.[a];
                                                                const assocMeta = assocEntry ? TYPE_META[assocEntry.type as PageType] : null;
                                                                return (
                                                                    <span
                                                                        key={a}
                                                                        onClick={(e) => { e.stopPropagation(); setSelectedCode(a); }}
                                                                        style={{
                                                                            padding: '1px 6px', borderRadius: '4px',
                                                                            fontSize: '0.6rem', fontWeight: 700, fontFamily: 'monospace',
                                                                            background: assocMeta?.bg || '#F1F5F9',
                                                                            color: assocMeta?.color || '#64748B',
                                                                            cursor: 'pointer',
                                                                            border: `1px solid ${assocMeta?.color || '#CBD5E1'}30`,
                                                                        }}
                                                                        title={assocEntry?.label || a}
                                                                    >
                                                                        {a}
                                                                    </span>
                                                                );
                                                            })}
                                                        </div>
                                                    )}
                                                </div>
                                            );
                                        })}
                                    </div>
                                </div>
                            );
                        })}
                    </div>

                    {/* Right: Detail panel */}
                    {selectedCode && selectedEntry && (
                        <div style={{
                            width: '340px', flexShrink: 0,
                            position: 'sticky', top: '24px', alignSelf: 'flex-start',
                        }}>
                            <div style={{
                                padding: '20px', borderRadius: '14px',
                                border: `2px solid ${TYPE_META[selectedEntry.type as PageType]?.color || '#CBD5E1'}`,
                                background: 'white',
                                boxShadow: '0 8px 32px rgba(0,0,0,0.08)',
                            }}>
                                {/* Code + label */}
                                <div style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '16px' }}>
                                    <span style={{
                                        padding: '6px 12px', borderRadius: '10px',
                                        fontWeight: 900, fontSize: '1.1rem', fontFamily: 'monospace',
                                        background: TYPE_META[selectedEntry.type as PageType]?.bg || '#F1F5F9',
                                        color: TYPE_META[selectedEntry.type as PageType]?.color || '#64748B',
                                    }}>
                                        {selectedCode}
                                    </span>
                                    <div>
                                        <div style={{ fontWeight: 800, fontSize: '1rem', color: '#0F172A' }}>{selectedEntry.label}</div>
                                        <div style={{ display: 'flex', gap: '6px', marginTop: '4px' }}>
                                            <span style={{
                                                padding: '1px 6px', borderRadius: '4px', fontSize: '0.6rem', fontWeight: 700, textTransform: 'uppercase',
                                                background: TYPE_META[selectedEntry.type as PageType]?.bg || '#F1F5F9',
                                                color: TYPE_META[selectedEntry.type as PageType]?.color || '#64748B',
                                            }}>{selectedEntry.type}</span>
                                            <span style={{
                                                padding: '1px 6px', borderRadius: '4px', fontSize: '0.6rem', fontWeight: 700,
                                                background: OWNER_META[selectedEntry.owner]?.bg || '#F1F5F9',
                                                color: OWNER_META[selectedEntry.owner]?.color || '#64748B',
                                            }}>{OWNER_META[selectedEntry.owner]?.icon} {selectedEntry.owner}</span>
                                        </div>
                                    </div>
                                </div>

                                {/* File path */}
                                <div style={{ marginBottom: '16px' }}>
                                    <div style={{ fontSize: '0.65rem', fontWeight: 700, color: '#64748B', marginBottom: '4px', textTransform: 'uppercase' }}>
                                        <FolderOpen size={10} style={{ verticalAlign: 'middle', marginRight: '4px' }} /> Source File
                                    </div>
                                    <div style={{
                                        fontFamily: 'monospace', fontSize: '0.65rem', color: '#475569',
                                        padding: '8px 10px', borderRadius: '6px', background: '#F8FAFC',
                                        wordBreak: 'break-all', lineHeight: 1.5,
                                    }}>
                                        {selectedEntry.file}
                                    </div>
                                </div>

                                {/* Associates */}
                                <div>
                                    <div style={{ fontSize: '0.65rem', fontWeight: 700, color: '#64748B', marginBottom: '8px', textTransform: 'uppercase' }}>
                                        <Network size={10} style={{ verticalAlign: 'middle', marginRight: '4px' }} /> Associates ({selectedEntry.associates.length})
                                    </div>
                                    {selectedEntry.associates.length === 0 ? (
                                        <div style={{ color: '#CBD5E1', fontSize: '0.75rem', fontStyle: 'italic' }}>No associates</div>
                                    ) : (
                                        <div style={{ display: 'flex', flexDirection: 'column', gap: '6px' }}>
                                            {selectedEntry.associates.map(a => {
                                                const assoc = (MASTER_REGISTRY as Record<string, MasterEntry>)?.[a];
                                                const aMeta = assoc ? TYPE_META[assoc.type as PageType] : null;
                                                return (
                                                    <div
                                                        key={a}
                                                        onClick={() => setSelectedCode(a)}
                                                        style={{
                                                            display: 'flex', alignItems: 'center', gap: '8px',
                                                            padding: '8px 10px', borderRadius: '8px',
                                                            border: '1px solid #E2E8F0', cursor: 'pointer',
                                                            transition: 'all 0.15s',
                                                        }}
                                                        onMouseEnter={e => { e.currentTarget.style.borderColor = aMeta?.color || '#94A3B8'; e.currentTarget.style.background = aMeta?.bg || '#F8FAFC'; }}
                                                        onMouseLeave={e => { e.currentTarget.style.borderColor = '#E2E8F0'; e.currentTarget.style.background = 'transparent'; }}
                                                    >
                                                        <span style={{
                                                            padding: '2px 8px', borderRadius: '5px',
                                                            fontWeight: 800, fontSize: '0.7rem', fontFamily: 'monospace',
                                                            background: aMeta?.bg || '#F1F5F9', color: aMeta?.color || '#64748B',
                                                        }}>{a}</span>
                                                        <div style={{ flex: 1, minWidth: 0 }}>
                                                            <div style={{ fontWeight: 600, fontSize: '0.75rem', color: '#0F172A' }}>
                                                                {assoc?.label || a}
                                                            </div>
                                                        </div>
                                                        <span style={{
                                                            padding: '1px 5px', borderRadius: '3px',
                                                            fontSize: '0.5rem', fontWeight: 700, textTransform: 'uppercase',
                                                            background: aMeta?.bg || '#F1F5F9', color: aMeta?.color || '#94A3B8',
                                                        }}>{assoc?.type || '?'}</span>
                                                    </div>
                                                );
                                            })}
                                        </div>
                                    )}
                                </div>
                            </div>
                        </div>
                    )}
                </div>
            )}

            {/* ── TABLE VIEW ── */}
            {viewMode === 'table' && (
                <div className="pc-card" style={{ overflow: 'auto', marginBottom: '32px' }}>
                    <table data-cy="page-master-table" style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.8rem' }}>
                        <thead>
                            <tr style={{ background: '#F8FAFC', borderBottom: '2px solid #E2E8F0' }}>
                                <th style={{ padding: '10px 12px', textAlign: 'center', fontWeight: 800, color: '#64748B', width: '65px' }}>Code</th>
                                <th style={{ padding: '10px 12px', textAlign: 'left', fontWeight: 800, color: '#64748B' }}>Label</th>
                                <th style={{ padding: '10px 12px', textAlign: 'center', fontWeight: 800, color: '#64748B', width: '90px' }}>Type</th>
                                <th style={{ padding: '10px 12px', textAlign: 'center', fontWeight: 800, color: '#64748B', width: '100px' }}>Owner</th>
                                <th style={{ padding: '10px 12px', textAlign: 'left', fontWeight: 800, color: '#64748B' }}>File</th>
                                <th style={{ padding: '10px 12px', textAlign: 'left', fontWeight: 800, color: '#64748B', width: '200px' }}>Associates</th>
                            </tr>
                        </thead>
                        <tbody>
                            {filteredMaster.map(entry => {
                                const meta = TYPE_META[entry.type as PageType];
                                return (
                                    <tr
                                        key={entry.code}
                                        data-cy={`master-row-${entry.code}`}
                                        style={{ borderBottom: '1px solid #F1F5F9', transition: 'background 0.1s' }}
                                        onMouseEnter={e => e.currentTarget.style.background = '#F8FAFC'}
                                        onMouseLeave={e => e.currentTarget.style.background = 'transparent'}
                                    >
                                        <td style={{ padding: '8px 12px', textAlign: 'center' }}>
                                            <span style={{
                                                display: 'inline-block', padding: '2px 8px', borderRadius: '4px',
                                                fontWeight: 800, fontSize: '0.75rem', fontFamily: 'monospace',
                                                background: meta?.bg || '#F1F5F9', color: meta?.color || '#64748B',
                                            }}>
                                                {entry.code}
                                            </span>
                                        </td>
                                        <td style={{ padding: '8px 12px', fontWeight: 600, color: '#0F172A' }}>{entry.label}</td>
                                        <td style={{ padding: '8px 12px', textAlign: 'center' }}>
                                            <span style={{
                                                padding: '1px 8px', borderRadius: '4px', fontSize: '0.65rem',
                                                fontWeight: 700, textTransform: 'uppercase',
                                                background: meta?.bg || '#F1F5F9', color: meta?.color || '#64748B',
                                            }}>{meta?.label || entry.type}</span>
                                        </td>
                                        <td style={{ padding: '8px 12px', textAlign: 'center', fontSize: '0.75rem', color: '#475569' }}>
                                            {OWNER_META[entry.owner]?.icon || ''} {entry.owner}
                                        </td>
                                        <td style={{ padding: '8px 12px', fontFamily: 'monospace', fontSize: '0.6rem', color: '#94A3B8', maxWidth: '250px', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                                            {entry.file.split('/').slice(-2).join('/')}
                                        </td>
                                        <td style={{ padding: '8px 12px' }}>
                                            <div style={{ display: 'flex', gap: '3px', flexWrap: 'wrap' }}>
                                                {entry.associates.map(a => {
                                                    const aEntry = (MASTER_REGISTRY as Record<string, MasterEntry>)?.[a];
                                                    const aMeta = aEntry ? TYPE_META[aEntry.type as PageType] : null;
                                                    return (
                                                        <span key={a} style={{
                                                            padding: '1px 5px', borderRadius: '3px',
                                                            fontSize: '0.55rem', fontWeight: 700, fontFamily: 'monospace',
                                                            background: aMeta?.bg || '#F1F5F9', color: aMeta?.color || '#94A3B8',
                                                        }} title={aEntry?.label || a}>{a}</span>
                                                    );
                                                })}
                                            </div>
                                        </td>
                                    </tr>
                                );
                            })}
                        </tbody>
                    </table>
                </div>
            )}

            {/* ── GRID VIEW ── */}
            {viewMode === 'grid' && Object.entries(grouped).map(([type, pages]) => {
                const meta = TYPE_META[type as PageType]!;
                return (
                    <div key={type} style={{ marginBottom: '32px' }}>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '14px' }}>
                            <span style={{
                                display: 'inline-flex', alignItems: 'center', gap: '6px',
                                padding: '4px 12px', borderRadius: '6px',
                                background: meta.bg, color: meta.color,
                                fontWeight: 800, fontSize: '0.8rem', textTransform: 'uppercase',
                            }}>
                                {meta.icon} {meta.label}
                            </span>
                            <span style={{ color: '#94A3B8', fontSize: '0.8rem', fontWeight: 600 }}>{pages.length} pages</span>
                        </div>
                        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(320px, 1fr))', gap: '12px' }}>
                            {pages.map(page => (
                                <div
                                    key={page.id}
                                    data-cy={`page-card-${page.categoryCode}`}
                                    className="pc-card"
                                    onClick={() => navigate(page.route)}
                                    style={{
                                        padding: '16px', cursor: 'pointer',
                                        transition: 'all 0.15s',
                                        border: '1px solid #E2E8F0',
                                        borderLeft: `3px solid ${meta.color}`,
                                    }}
                                    onMouseEnter={e => { e.currentTarget.style.boxShadow = `0 4px 16px ${meta.bg}`; e.currentTarget.style.borderColor = meta.color; }}
                                    onMouseLeave={e => { e.currentTarget.style.boxShadow = 'none'; e.currentTarget.style.borderColor = '#E2E8F0'; }}
                                >
                                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                                        <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                                            <div style={{
                                                minWidth: '32px', height: '32px',
                                                display: 'flex', alignItems: 'center', justifyContent: 'center',
                                                borderRadius: '8px', background: '#0F172A', color: 'white',
                                                fontWeight: 800, fontSize: '0.75rem', fontFamily: 'monospace',
                                            }}>
                                                #{page.srNo}
                                            </div>
                                            <div>
                                                <div style={{ fontWeight: 700, color: '#0F172A', fontSize: '0.9rem' }}>{page.label}</div>
                                                <div style={{ fontFamily: 'monospace', fontSize: '0.65rem', color: '#94A3B8' }}>{page.route}</div>
                                            </div>
                                        </div>
                                        <ChevronRight size={16} color="#94A3B8" />
                                    </div>
                                    <div style={{ display: 'flex', gap: '6px', marginTop: '10px', flexWrap: 'wrap' }}>
                                        <span style={{
                                            padding: '2px 8px', borderRadius: '4px',
                                            fontSize: '0.7rem', fontWeight: 800, fontFamily: 'monospace',
                                            background: meta.bg, color: meta.color,
                                        }}>{page.categoryCode}</span>
                                        <span style={{
                                            padding: '1px 8px', borderRadius: '4px',
                                            fontSize: '0.6rem', fontWeight: 700, textTransform: 'uppercase',
                                            background: '#F1F5F9', color: '#475569',
                                        }}>{page.owner}</span>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </div>
                );
            })}

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
