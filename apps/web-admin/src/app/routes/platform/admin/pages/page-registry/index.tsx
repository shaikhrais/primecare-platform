import React, { useState, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { LayoutGrid, Search, Filter, ChevronRight, BarChart3, ClipboardList, Layers, Compass, FileText, Wand2, AlertTriangle, Wrench, Globe, BookOpen, List } from 'lucide-react';
import { AdminRegistry } from 'prime-care-shared';
import type { PageType, PageEntry } from 'prime-care-shared';

const { PageRegistry, getPageTypeStats, getMasterList, PAGE_REGISTRY_COUNT, DashboardRegistry, ListRegistry, HubRegistry, WizardRegistry, ReportRegistry, ToolRegistry, CATEGORY_PREFIXES } = AdminRegistry;

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

const OWNER_ICONS: Record<string, string> = {
    admin: '⚙️', superuser: '👑', manager: '📊', staff: '👥', psw: '🩺',
    rn: '💉', client: '👤', coordinator: '📍', allied: '🏥',
    'scrum-master': '🔧', auth: '🔐', shared: '🔗',
};

export default function PageRegistryPage() {
    const navigate = useNavigate();
    const [searchTerm, setSearchTerm] = useState('');
    const [filterType, setFilterType] = useState<string>('all');
    const [filterOwner, setFilterOwner] = useState<string>('all');
    const [viewMode, setViewMode] = useState<'grid' | 'table'>('grid');

    const typeStats = useMemo(() => getPageTypeStats(), []);
    const pageTypes = useMemo(() => Object.keys(typeStats) as PageType[], [typeStats]);
    const owners = useMemo(() => {
        const s = new Set<string>();
        PageRegistry.forEach((p: PageEntry) => s.add(p.owner));
        return Array.from(s);
    }, []);

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
        filteredPages.forEach(p => {
            (g[p.type] = g[p.type] || []).push(p);
        });
        return g;
    }, [filteredPages]);

    return (
        <div data-cy="page-registry-page" style={{ padding: '24px', maxWidth: '1400px', margin: '0 auto' }}>
            {/* Header */}
            <div style={{ display: 'flex', alignItems: 'center', gap: '16px', marginBottom: '28px' }}>
                <div style={{ backgroundColor: '#EFF6FF', padding: '14px', borderRadius: '12px', border: '1px solid #DBEAFE' }}>
                    <LayoutGrid size={28} color="#2563EB" />
                </div>
                <div style={{ flex: 1 }}>
                    <h1 style={{ fontSize: '1.75rem', fontWeight: 800, margin: 0, color: '#0F172A' }}>
                        Page Registry — Master List
                    </h1>
                    <p style={{ margin: '4px 0 0 0', color: '#94A3B8', fontSize: '0.9rem' }}>
                        {PAGE_REGISTRY_COUNT} pages · {pageTypes.length} types · {owners.length} owners · Each with SrNo + Category Code
                    </p>
                </div>
                {/* View toggle */}
                <div style={{ display: 'flex', gap: '4px', background: '#F1F5F9', borderRadius: '8px', padding: '3px' }}>
                    <button
                        data-cy="view-mode-grid"
                        onClick={() => setViewMode('grid')}
                        style={{
                            padding: '6px 12px', borderRadius: '6px', border: 'none', cursor: 'pointer',
                            background: viewMode === 'grid' ? 'white' : 'transparent',
                            fontWeight: viewMode === 'grid' ? 700 : 500, fontSize: '0.8rem',
                            boxShadow: viewMode === 'grid' ? '0 1px 3px rgba(0,0,0,0.1)' : 'none',
                        }}
                    >
                        Grid
                    </button>
                    <button
                        data-cy="view-mode-table"
                        onClick={() => setViewMode('table')}
                        style={{
                            padding: '6px 12px', borderRadius: '6px', border: 'none', cursor: 'pointer',
                            background: viewMode === 'table' ? 'white' : 'transparent',
                            fontWeight: viewMode === 'table' ? 700 : 500, fontSize: '0.8rem',
                            boxShadow: viewMode === 'table' ? '0 1px 3px rgba(0,0,0,0.1)' : 'none',
                        }}
                    >
                        <List size={14} style={{ verticalAlign: 'middle', marginRight: '4px' }} />
                        Table
                    </button>
                </div>
            </div>

            {/* Stats Strip */}
            <div data-cy="page-registry-stats" style={{ display: 'flex', gap: '10px', marginBottom: '20px', overflowX: 'auto', paddingBottom: '4px' }}>
                {pageTypes.map(type => {
                    const meta = TYPE_META[type]!;
                    const isActive = filterType === type;
                    const prefix = CATEGORY_PREFIXES?.[type] || '?';
                    return (
                        <button
                            key={type}
                            data-cy={`page-stat-${type}`}
                            onClick={() => setFilterType(isActive ? 'all' : type)}
                            style={{
                                display: 'flex', alignItems: 'center', gap: '6px',
                                padding: '8px 14px', borderRadius: '10px',
                                border: isActive ? `2px solid ${meta.color}` : '1px solid #E2E8F0',
                                background: isActive ? meta.bg : 'white',
                                cursor: 'pointer', whiteSpace: 'nowrap',
                                transition: 'all 0.15s',
                            }}
                        >
                            <span style={{ color: meta.color }}>{meta.icon}</span>
                            <span style={{ fontWeight: 800, color: meta.color, fontSize: '0.95rem' }}>{typeStats[type]}</span>
                            <span style={{ fontWeight: 600, color: isActive ? meta.color : '#64748B', fontSize: '0.7rem', textTransform: 'uppercase' }}>{meta.label}</span>
                            <span style={{
                                fontFamily: 'monospace', fontSize: '0.6rem', fontWeight: 700,
                                padding: '1px 5px', borderRadius: '3px',
                                background: isActive ? meta.color : '#E2E8F0',
                                color: isActive ? 'white' : '#64748B',
                            }}>{prefix}#</span>
                        </button>
                    );
                })}
            </div>

            {/* Search + Filters */}
            <div style={{ display: 'flex', gap: '12px', marginBottom: '24px' }}>
                <div style={{ flex: 1, position: 'relative' }}>
                    <Search size={16} color="#94A3B8" style={{ position: 'absolute', left: '12px', top: '11px' }} />
                    <input
                        data-cy="page-registry-search"
                        type="text"
                        placeholder="Search by name, SrNo, category code (D1, F2, T5...), ID, or route..."
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
                        {owners.map(o => (
                            <option key={o} value={o}>{OWNER_ICONS[o] || '📄'} {o.charAt(0).toUpperCase() + o.slice(1)}</option>
                        ))}
                    </select>
                </div>
            </div>

            {/* ── TABLE VIEW ───────────────────────────────────── */}
            {viewMode === 'table' && (
                <div className="pc-card" style={{ overflow: 'auto', marginBottom: '32px' }}>
                    <table data-cy="page-master-table" style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.8rem' }}>
                        <thead>
                            <tr style={{ background: '#F8FAFC', borderBottom: '2px solid #E2E8F0' }}>
                                <th style={{ padding: '10px 12px', textAlign: 'center', fontWeight: 800, color: '#64748B', width: '50px' }}>SrNo</th>
                                <th style={{ padding: '10px 12px', textAlign: 'center', fontWeight: 800, color: '#64748B', width: '65px' }}>Code</th>
                                <th style={{ padding: '10px 12px', textAlign: 'left', fontWeight: 800, color: '#64748B' }}>Label</th>
                                <th style={{ padding: '10px 12px', textAlign: 'center', fontWeight: 800, color: '#64748B', width: '90px' }}>Type</th>
                                <th style={{ padding: '10px 12px', textAlign: 'center', fontWeight: 800, color: '#64748B', width: '100px' }}>Owner</th>
                                <th style={{ padding: '10px 12px', textAlign: 'left', fontWeight: 800, color: '#64748B' }}>Route</th>
                                <th style={{ padding: '10px 12px', textAlign: 'left', fontWeight: 800, color: '#64748B' }}>ID</th>
                            </tr>
                        </thead>
                        <tbody>
                            {filteredPages.map(page => {
                                const meta = TYPE_META[page.type]!;
                                return (
                                    <tr
                                        key={page.id}
                                        data-cy={`master-row-${page.srNo}`}
                                        onClick={() => navigate(page.route)}
                                        style={{ cursor: 'pointer', borderBottom: '1px solid #F1F5F9', transition: 'background 0.1s' }}
                                        onMouseEnter={e => e.currentTarget.style.background = '#F8FAFC'}
                                        onMouseLeave={e => e.currentTarget.style.background = 'transparent'}
                                    >
                                        <td style={{ padding: '8px 12px', textAlign: 'center', fontWeight: 800, color: '#0F172A', fontFamily: 'monospace' }}>
                                            {page.srNo}
                                        </td>
                                        <td style={{ padding: '8px 12px', textAlign: 'center' }}>
                                            <span style={{
                                                display: 'inline-block', padding: '2px 8px', borderRadius: '4px',
                                                fontWeight: 800, fontSize: '0.75rem', fontFamily: 'monospace',
                                                background: meta.bg, color: meta.color,
                                            }}>
                                                {page.categoryCode}
                                            </span>
                                        </td>
                                        <td style={{ padding: '8px 12px', fontWeight: 600, color: '#0F172A' }}>
                                            {page.icon && <span style={{ marginRight: '6px' }}>{page.icon}</span>}
                                            {page.label}
                                        </td>
                                        <td style={{ padding: '8px 12px', textAlign: 'center' }}>
                                            <span style={{
                                                padding: '1px 8px', borderRadius: '4px', fontSize: '0.65rem',
                                                fontWeight: 700, textTransform: 'uppercase',
                                                background: meta.bg, color: meta.color,
                                            }}>{meta.label}</span>
                                        </td>
                                        <td style={{ padding: '8px 12px', textAlign: 'center', fontSize: '0.75rem', color: '#475569' }}>
                                            {OWNER_ICONS[page.owner] || ''} {page.owner}
                                        </td>
                                        <td style={{ padding: '8px 12px', fontFamily: 'monospace', fontSize: '0.7rem', color: '#94A3B8' }}>
                                            {page.route}
                                        </td>
                                        <td style={{ padding: '8px 12px', fontFamily: 'monospace', fontSize: '0.65rem', color: '#CBD5E1' }}>
                                            {page.id}
                                        </td>
                                    </tr>
                                );
                            })}
                        </tbody>
                    </table>
                </div>
            )}

            {/* ── GRID VIEW ───────────────────────────────────── */}
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
                            <span style={{ color: '#94A3B8', fontSize: '0.8rem', fontWeight: 600 }}>
                                {pages.length} page{pages.length !== 1 ? 's' : ''}
                            </span>
                            <span style={{
                                fontFamily: 'monospace', fontSize: '0.65rem', fontWeight: 700,
                                padding: '2px 6px', borderRadius: '4px',
                                background: '#F1F5F9', color: '#64748B',
                            }}>
                                {CATEGORY_PREFIXES?.[type as PageType] || '?'}1–{CATEGORY_PREFIXES?.[type as PageType] || '?'}{pages.length}
                            </span>
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
                                    onMouseEnter={e => {
                                        e.currentTarget.style.boxShadow = `0 4px 16px ${meta.bg}`;
                                        e.currentTarget.style.borderColor = meta.color;
                                    }}
                                    onMouseLeave={e => {
                                        e.currentTarget.style.boxShadow = 'none';
                                        e.currentTarget.style.borderColor = '#E2E8F0';
                                    }}
                                >
                                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                                        <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                                            {/* SrNo badge */}
                                            <div style={{
                                                minWidth: '32px', height: '32px',
                                                display: 'flex', alignItems: 'center', justifyContent: 'center',
                                                borderRadius: '8px', background: '#0F172A', color: 'white',
                                                fontWeight: 800, fontSize: '0.75rem', fontFamily: 'monospace',
                                            }}>
                                                #{page.srNo}
                                            </div>
                                            <div>
                                                <div style={{ fontWeight: 700, color: '#0F172A', fontSize: '0.9rem' }}>
                                                    {page.label}
                                                </div>
                                                <div style={{ fontFamily: 'monospace', fontSize: '0.65rem', color: '#94A3B8' }}>
                                                    {page.route}
                                                </div>
                                            </div>
                                        </div>
                                        <ChevronRight size={16} color="#94A3B8" />
                                    </div>

                                    {/* Tags row */}
                                    <div style={{ display: 'flex', gap: '6px', marginTop: '10px', flexWrap: 'wrap' }}>
                                        {/* Category Code badge */}
                                        <span style={{
                                            padding: '2px 8px', borderRadius: '4px',
                                            fontSize: '0.7rem', fontWeight: 800, fontFamily: 'monospace',
                                            background: meta.bg, color: meta.color,
                                        }}>
                                            {page.categoryCode}
                                        </span>
                                        <span style={{
                                            padding: '1px 8px', borderRadius: '4px',
                                            fontSize: '0.6rem', fontWeight: 700, textTransform: 'uppercase',
                                            background: '#F1F5F9', color: '#475569',
                                        }}>
                                            {page.owner}
                                        </span>
                                        {page.formRegistryId && (
                                            <span style={{
                                                padding: '1px 8px', borderRadius: '4px',
                                                fontSize: '0.6rem', fontWeight: 700,
                                                background: '#D1FAE5', color: '#065F46',
                                            }}>
                                                FormRegistry
                                            </span>
                                        )}
                                        {page.dashboardRegistryId && (
                                            <span style={{
                                                padding: '1px 8px', borderRadius: '4px',
                                                fontSize: '0.6rem', fontWeight: 700,
                                                background: '#DBEAFE', color: '#1D4ED8',
                                            }}>
                                                DashboardReg
                                            </span>
                                        )}
                                    </div>

                                    {page.description && (
                                        <div style={{ marginTop: '8px', fontSize: '0.75rem', color: '#64748B', lineHeight: 1.4 }}>
                                            {page.description}
                                        </div>
                                    )}
                                </div>
                            ))}
                        </div>
                    </div>
                );
            })}

            {filteredPages.length === 0 && (
                <div style={{ textAlign: 'center', padding: '48px', color: '#94A3B8' }}>
                    <LayoutGrid size={48} style={{ marginBottom: '12px', opacity: 0.5 }} />
                    <p style={{ fontWeight: 600, margin: '0 0 6px' }}>No pages match your filters</p>
                    <p style={{ fontSize: '0.85rem', margin: 0 }}>Try adjusting search, type, or owner filters.</p>
                </div>
            )}
        </div>
    );
}
