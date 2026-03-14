import React, { useState, useMemo, useEffect } from 'react';
import { UsageTracker, type UsageSnapshot } from '@/shared/services/UsageTracker';
import { type DigitalAsset, gatherRoutes, gatherApis, gatherButtons, gatherContent, gatherTheme } from './assetGatherers';
import { S, TYPE_ICONS, PAGE_SIZE } from './propertyStyles';

const DigitalPropertyManager: React.FC = () => {
    const [search, setSearch] = useState('');
    const [typeFilter, setTypeFilter] = useState<string>('all');
    const [sectionFilter, setSectionFilter] = useState('all');
    const [statusFilter, setStatusFilter] = useState<string>('all');
    const [page, setPage] = useState(0);
    const [snapshot, setSnapshot] = useState<UsageSnapshot | null>(null);

    useEffect(() => { try { setSnapshot(UsageTracker.getSnapshot()); } catch { } }, []);

    const allAssets = useMemo(() => {
        const assets = [...gatherRoutes(), ...gatherApis(), ...gatherButtons(), ...gatherContent(), ...gatherTheme()];
        if (snapshot) {
            const maxVisits = Math.max(...Object.values(snapshot.routes).map(r => r.count), 1);
            for (const asset of assets) {
                if (asset.type === 'route' && asset.path) {
                    const rv = snapshot.routes[asset.path];
                    if (rv) { asset.visits = rv.count; asset.lastUsed = rv.lastVisit; asset.status = rv.count / maxVisits > 0.5 ? 'hot' : 'active'; }
                }
            }
            for (const [, ce] of Object.entries(snapshot.clicks || {})) {
                assets.push({ name: ce.target, type: 'click', section: ce.elementType, detail: `${ce.count} clicks`, visits: ce.count, lastUsed: ce.lastClick, status: 'active' });
            }
        }
        return assets;
    }, [snapshot]);

    const allSections = useMemo(() => ['all', ...Array.from(new Set(allAssets.map(a => a.section))).sort()], [allAssets]);
    const typeCounts = useMemo(() => { const c: Record<string, number> = { all: allAssets.length }; for (const a of allAssets) c[a.type] = (c[a.type] || 0) + 1; return c; }, [allAssets]);

    const filtered = useMemo(() => {
        let items = allAssets;
        if (typeFilter !== 'all') items = items.filter(a => a.type === typeFilter);
        if (sectionFilter !== 'all') items = items.filter(a => a.section === sectionFilter);
        if (statusFilter !== 'all') items = items.filter(a => a.status === statusFilter);
        if (search) { const q = search.toLowerCase(); items = items.filter(a => a.name.toLowerCase().includes(q) || a.path?.toLowerCase().includes(q) || a.section.toLowerCase().includes(q) || a.detail?.toLowerCase().includes(q)); }
        return items;
    }, [allAssets, typeFilter, sectionFilter, statusFilter, search]);

    const totalPages = Math.ceil(filtered.length / PAGE_SIZE);
    const pageItems = filtered.slice(page * PAGE_SIZE, (page + 1) * PAGE_SIZE);
    useEffect(() => { setPage(0); }, [typeFilter, sectionFilter, statusFilter, search]);

    const timeAgo = (ts?: number) => { if (!ts) return '—'; const d = Date.now() - ts; if (d < 60000) return 'Just now'; if (d < 3600000) return `${Math.floor(d / 60000)}m ago`; if (d < 86400000) return `${Math.floor(d / 3600000)}h ago`; return `${Math.floor(d / 86400000)}d ago`; };

    return (
        <div data-cy="page.container" style={S.page} className="main-content">
            <div style={S.hero}><div style={S.heroGlow as any} /><h1 data-cy="page.title" style={S.heroTitle}><span style={S.heroIcon}>🏛️</span> Digital Property Manager</h1><p style={S.heroSub}>Complete inventory of all platform digital assets — routes, APIs, buttons, content, theme tokens, and interactions</p></div>

            <div style={S.statsRow}>
                {[{ key: 'all', icon: '🏗️', label: 'Total Assets' }, { key: 'route', icon: '🛤️', label: 'Routes' }, { key: 'api', icon: '🔌', label: 'API Endpoints' }, { key: 'button', icon: '🔘', label: 'Buttons' }, { key: 'content', icon: '📄', label: 'Content Keys' }, { key: 'theme', icon: '🎨', label: 'Theme Tokens' }].map(t => (
                    <div key={t.key} style={{ ...S.stat, ...(typeFilter === t.key ? S.statActive : {}) }} onClick={() => setTypeFilter(typeFilter === t.key ? 'all' : t.key)}>
                        <div style={S.statIcon}>{t.icon}</div><div style={S.statVal}>{typeCounts[t.key] || 0}</div><div style={S.statLabel}>{t.label}</div>
                    </div>
                ))}
            </div>

            <div style={S.filterBar}>
                <input data-cy="input-digital-property-manager-0" type="text" placeholder="Search assets by name, path, or section..." value={search} onChange={e => setSearch(e.target.value)} style={S.search} />
                <select data-cy="select-digital-property-manager-0" value={sectionFilter} onChange={e => setSectionFilter(e.target.value)} style={S.select}>{allSections.map(s => <option key={s} value={s}>{s === 'all' ? '📁 All Sections' : s}</option>)}</select>
                <select data-cy="select-digital-property-manager-1" value={statusFilter} onChange={e => setStatusFilter(e.target.value)} style={S.select}><option value="all">🔵 All Status</option><option value="active">🟢 Active</option><option value="unused">🔴 Unused</option><option value="hot">🟠 Hot</option></select>
            </div>

            <div style={{ display: 'flex', gap: 8, marginBottom: 20 }}>
                {['all', 'active', 'unused', 'hot'].map(s => {
                    const count = s === 'all' ? filtered.length : allAssets.filter(a => a.status === s).length;
                    return (<span key={s} onClick={() => setStatusFilter(statusFilter === s ? 'all' : s)} style={{ ...S.chip, ...(statusFilter === s ? S.chipActive : {}) }}>{s === 'all' ? '●' : s === 'active' ? '🟢' : s === 'unused' ? '🔴' : '🟠'} {s.charAt(0).toUpperCase() + s.slice(1)} ({count})</span>);
                })}
            </div>

            <div style={S.card}>
                <div style={{ overflowX: 'auto', maxHeight: '70vh', overflowY: 'auto' }}>
                    <table data-cy="table-digital-property-manager" style={S.table}>
                        <thead><tr><th style={S.th}>Asset</th><th style={S.th}>Type</th><th style={S.th}>Section</th><th style={S.th}>Path / Value</th><th style={S.th}>Visits</th><th style={S.th}>Last Used</th><th style={S.th}>Status</th></tr></thead>
                        <tbody>
                            {pageItems.map((a, i) => {
                                const tBadge = (S.typeBadge as any)[a.type] || { bg: '#f1f5f9', color: '#475569' };
                                const sBadge = (S.statusBadge as any)[a.status] || { bg: '#f1f5f9', color: '#475569' };
                                return (
                                    <tr key={`${a.type}-${a.name}-${i}`} style={{ background: i % 2 === 0 ? '#fff' : '#fafbfc' }}>
                                        <td style={S.td}><div style={{ fontWeight: 600, fontSize: 13 }}>{a.name}</div>{a.detail && <div style={{ fontSize: 11, color: '#94a3b8', marginTop: 2 }}>{a.detail}</div>}</td>
                                        <td style={S.td}><span style={{ ...S.badge, background: tBadge.bg, color: tBadge.color }}>{TYPE_ICONS[a.type]} {a.type}</span></td>
                                        <td style={S.td}><span style={{ fontSize: 12, color: '#64748b' }}>{a.section}</span></td>
                                        <td style={{ ...S.td, ...S.tdMono, maxWidth: 300, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>{a.path || '—'}</td>
                                        <td style={{ ...S.td, fontWeight: a.visits ? 700 : 400, color: a.visits ? '#0f172a' : '#cbd5e1' }}>{a.visits || '—'}</td>
                                        <td style={{ ...S.td, color: '#94a3b8', fontSize: 12 }}>{timeAgo(a.lastUsed)}</td>
                                        <td style={S.td}><span style={{ ...S.badge, background: sBadge.bg, color: sBadge.color }}>{a.status}</span></td>
                                    </tr>
                                );
                            })}
                        </tbody>
                    </table>
                </div>
                <div style={S.footer}>
                    <span>Showing {page * PAGE_SIZE + 1}–{Math.min((page + 1) * PAGE_SIZE, filtered.length)} of {filtered.length} assets</span>
                    <div style={S.pagination}>
                        <button data-cy="btn-digital-property-manager-0" style={S.pageBtn} onClick={() => setPage(Math.max(0, page - 1))} disabled={page === 0}>‹ Prev</button>
                        {Array.from({ length: Math.min(totalPages, 7) }, (_, i) => { const p = totalPages <= 7 ? i : page < 3 ? i : page > totalPages - 4 ? totalPages - 7 + i : page - 3 + i; return (<button data-cy="btn-digital-property-manager-1" key={p} onClick={() => setPage(p)} style={{ ...S.pageBtn, ...(p === page ? S.pageBtnActive : {}) }}>{p + 1}</button>); })}
                        <button data-cy="btn-digital-property-manager-2" style={S.pageBtn} onClick={() => setPage(Math.min(totalPages - 1, page + 1))} disabled={page >= totalPages - 1}>Next ›</button>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default DigitalPropertyManager;
