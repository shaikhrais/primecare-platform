import React, { useState, useMemo, useEffect } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { UsageTracker, type UsageSnapshot } from '@/shared/services/UsageTracker';

const { RouteRegistry, ApiRegistry, ButtonRegistry, ContentRegistry, ThemeRegistry } = AdminRegistry;

/* ─── Types ─── */
interface DigitalAsset {
    name: string;
    type: 'route' | 'api' | 'button' | 'content' | 'theme' | 'click';
    section: string;
    path?: string;
    method?: string;
    detail?: string;
    visits?: number;
    lastUsed?: number;
    status: 'active' | 'unused' | 'hot';
}

/* ─── Flatten helpers ─── */
const flattenObj = (obj: any, section: string, type: DigitalAsset['type'], prefix = ''): DigitalAsset[] => {
    const items: DigitalAsset[] = [];
    for (const [key, val] of Object.entries(obj)) {
        if (typeof val === 'string') {
            items.push({ name: `${prefix}${key}`.replace(/_/g, ' '), type, section, path: val, status: 'unused' });
        } else if (typeof val === 'function') {
            items.push({ name: `${prefix}${key}(...)`, type, section, path: `[dynamic]`, detail: 'parameterized', status: 'unused' });
        } else if (typeof val === 'object' && val !== null) {
            items.push(...flattenObj(val, section, type, `${key} › `));
        }
    }
    return items;
};

const gatherRoutes = (): DigitalAsset[] => {
    const a: DigitalAsset[] = [];
    const sections: [string, any][] = [
        ['Admin', RouteRegistry.ADMIN], ['Scrum Master', RouteRegistry.SCRUM_MASTER],
        ['Superuser', RouteRegistry.SUPERUSER], ['Manager', RouteRegistry.MANAGER],
        ['Staff', RouteRegistry.STAFF], ['PSW', RouteRegistry.PSW],
        ['RN', RouteRegistry.RN], ['Client', RouteRegistry.CLIENT],
        ['Coordinator', RouteRegistry.COORDINATOR], ['Allied', RouteRegistry.ALLIED],
    ];
    for (const [sec, obj] of sections) {
        if (obj && typeof obj === 'object') a.push(...flattenObj(obj, sec, 'route'));
        else if (typeof obj === 'string') a.push({ name: sec, type: 'route', section: sec, path: obj, status: 'unused' });
    }
    // Auth + shared
    for (const key of ['LOGIN', 'REGISTER', 'FORGOT_PASSWORD', 'RESET_PASSWORD', 'PROFILE', 'SUPPORT', 'LEARN', 'KNOWLEDGE_BASE'] as const) {
        if ((RouteRegistry as any)[key]) a.push({ name: key.replace(/_/g, ' '), type: 'route', section: 'Shared', path: (RouteRegistry as any)[key], status: 'unused' });
    }
    return a;
};

const gatherApis = (): DigitalAsset[] => {
    const a: DigitalAsset[] = [];
    const sections: [string, any][] = [];
    // ApiRegistry has nested sections
    for (const [key, val] of Object.entries(ApiRegistry)) {
        if (typeof val === 'object' && val !== null) sections.push([key, val]);
        else if (typeof val === 'string') a.push({ name: key, type: 'api', section: 'Root', path: val, status: 'unused' });
    }
    for (const [sec, obj] of sections) a.push(...flattenObj(obj, sec, 'api'));
    return a;
};

const gatherButtons = (): DigitalAsset[] => {
    const a: DigitalAsset[] = [];
    try {
        const allButtons = (ButtonRegistry as any).ALL || [];
        if (Array.isArray(allButtons)) {
            for (const btn of allButtons) {
                a.push({
                    name: btn.label || btn.id, type: 'button', section: btn.role || btn.module || 'General',
                    path: btn.apiPath, detail: `${btn.type || ''} · ${btn.action || ''}`, status: 'unused',
                });
            }
        }
        // Also flatten any nested objects
        for (const [key, val] of Object.entries(ButtonRegistry)) {
            if (key === 'ALL') continue;
            if (typeof val === 'object' && val !== null && !Array.isArray(val)) {
                a.push(...flattenObj(val, key, 'button'));
            }
        }
    } catch { }
    return a;
};

const gatherContent = (): DigitalAsset[] => {
    const a: DigitalAsset[] = [];
    try {
        for (const [key, val] of Object.entries(ContentRegistry)) {
            if (typeof val === 'string') {
                a.push({ name: key.replace(/_/g, ' '), type: 'content', section: 'Content', path: undefined, detail: String(val).slice(0, 60), status: 'active' });
            } else if (typeof val === 'object' && val !== null) {
                const items = flattenObj(val, key, 'content');
                a.push(...items);
            }
        }
    } catch { }
    return a;
};

const gatherTheme = (): DigitalAsset[] => {
    const a: DigitalAsset[] = [];
    try {
        for (const [key, val] of Object.entries(ThemeRegistry.COLORS)) {
            if (typeof val === 'string') {
                a.push({ name: key.replace(/_/g, ' '), type: 'theme', section: 'CSS Variables', path: val, status: 'active' });
            } else if (typeof val === 'object') {
                for (const [k2, v2] of Object.entries(val)) {
                    a.push({ name: `${key} › ${k2}`.replace(/_/g, ' '), type: 'theme', section: 'CSS Variables', path: v2 as string, status: 'active' });
                }
            }
        }
        for (const key of Object.keys(ThemeRegistry.PRESETS)) {
            a.push({ name: key.replace(/_/g, ' '), type: 'theme', section: 'Presets', status: 'active' });
        }
    } catch { }
    return a;
};

/* ─── Styles ─── */
const S: Record<string, React.CSSProperties> = {
    page: { padding: '0 0 60px', fontFamily: "'Inter', system-ui, -apple-system, sans-serif" },
    hero: { background: 'linear-gradient(135deg, #0c4a6e 0%, #0284c7 40%, #38bdf8 100%)', borderRadius: 16, padding: '36px 40px', marginBottom: 28, position: 'relative', overflow: 'hidden' },
    heroGlow: { position: 'absolute', top: -80, right: -40, width: 240, height: 240, background: 'radial-gradient(circle, rgba(56,189,248,0.25) 0%, transparent 70%)', borderRadius: '50%', pointerEvents: 'none' },
    heroTitle: { fontSize: 28, fontWeight: 800, color: '#fff', margin: 0, letterSpacing: -0.5, display: 'flex', alignItems: 'center', gap: 12 },
    heroSub: { fontSize: 14, color: 'rgba(255,255,255,0.7)', marginTop: 6 },
    heroIcon: { width: 40, height: 40, background: 'rgba(255,255,255,0.15)', borderRadius: 10, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 22 },

    statsRow: { display: 'grid', gridTemplateColumns: 'repeat(6, 1fr)', gap: 14, marginBottom: 24 },
    stat: { background: '#fff', borderRadius: 12, padding: '16px 20px', boxShadow: '0 1px 3px rgba(0,0,0,0.06)', cursor: 'pointer', transition: 'all 0.2s', border: '2px solid transparent' },
    statActive: { borderColor: '#0284c7', boxShadow: '0 0 0 3px rgba(2,132,199,0.15)' },
    statIcon: { fontSize: 20, marginBottom: 4 },
    statVal: { fontSize: 22, fontWeight: 800, color: '#0f172a' },
    statLabel: { fontSize: 11, fontWeight: 600, textTransform: 'uppercase' as const, letterSpacing: 0.8, color: '#94a3b8', marginTop: 2 },

    filterBar: { display: 'flex', gap: 12, marginBottom: 20, flexWrap: 'wrap' as const, alignItems: 'center' },
    search: { flex: 1, minWidth: 200, padding: '10px 16px 10px 40px', borderRadius: 10, border: '1px solid #e2e8f0', fontSize: 14, fontFamily: 'inherit', outline: 'none', background: '#fff url("data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' fill=\'none\' viewBox=\'0 0 24 24\' stroke=\'%2394a3b8\' stroke-width=\'2\'%3E%3Cpath stroke-linecap=\'round\' stroke-linejoin=\'round\' d=\'M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z\'/%3E%3C/svg%3E") 12px center/18px no-repeat' },
    select: { padding: '10px 16px', borderRadius: 10, border: '1px solid #e2e8f0', fontSize: 13, fontFamily: 'inherit', background: '#fff', color: '#475569', cursor: 'pointer' },
    chip: { padding: '6px 14px', borderRadius: 20, fontSize: 12, fontWeight: 600, cursor: 'pointer', transition: 'all 0.2s', border: '1px solid #e2e8f0', background: '#fff', color: '#64748b' },
    chipActive: { background: '#0284c7', color: '#fff', borderColor: '#0284c7' },

    card: { background: '#fff', borderRadius: 14, boxShadow: '0 1px 3px rgba(0,0,0,0.06), 0 4px 12px rgba(0,0,0,0.04)', overflow: 'hidden' },
    table: { width: '100%', borderCollapse: 'collapse' as const },
    th: { padding: '10px 16px', textAlign: 'left' as const, fontSize: 11, fontWeight: 700, textTransform: 'uppercase' as const, letterSpacing: 0.8, color: '#94a3b8', borderBottom: '1px solid #f1f5f9', position: 'sticky' as const, top: 0, background: '#fff', zIndex: 1 },
    td: { padding: '10px 16px', fontSize: 13, borderBottom: '1px solid #f8fafc', color: '#334155' },
    tdMono: { fontFamily: "'JetBrains Mono', 'Fira Code', monospace", fontSize: 12, color: '#64748b' },

    badge: { display: 'inline-flex', padding: '3px 10px', borderRadius: 16, fontSize: 11, fontWeight: 700, letterSpacing: 0.3 },
    typeBadge: { route: { bg: '#eff6ff', color: '#2563eb' }, api: { bg: '#ecfdf5', color: '#059669' }, button: { bg: '#fef3c7', color: '#d97706' }, content: { bg: '#f5f3ff', color: '#7c3aed' }, theme: { bg: '#fdf2f8', color: '#db2777' }, click: { bg: '#fff7ed', color: '#ea580c' } } as Record<string, { bg: string; color: string }>,
    statusBadge: { active: { bg: '#dcfce7', color: '#166534' }, unused: { bg: '#fef2f2', color: '#dc2626' }, hot: { bg: '#fff7ed', color: '#ea580c' } } as Record<string, { bg: string; color: string }>,

    footer: { display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '12px 20px', borderTop: '1px solid #f1f5f9', fontSize: 12, color: '#94a3b8' },
    pagination: { display: 'flex', gap: 4 },
    pageBtn: { padding: '6px 12px', borderRadius: 6, border: '1px solid #e2e8f0', background: '#fff', fontSize: 12, cursor: 'pointer', color: '#475569' },
    pageBtnActive: { background: '#0284c7', color: '#fff', borderColor: '#0284c7' },
};

const TYPE_ICONS: Record<string, string> = { route: '🛤️', api: '🔌', button: '🔘', content: '📄', theme: '🎨', click: '👆' };
const PAGE_SIZE = 30;

/* ─── Component ─── */
const DigitalPropertyManager: React.FC = () => {
    const [search, setSearch] = useState('');
    const [typeFilter, setTypeFilter] = useState<string>('all');
    const [sectionFilter, setSectionFilter] = useState('all');
    const [statusFilter, setStatusFilter] = useState<string>('all');
    const [page, setPage] = useState(0);
    const [snapshot, setSnapshot] = useState<UsageSnapshot | null>(null);

    useEffect(() => {
        try { setSnapshot(UsageTracker.getSnapshot()); } catch { }
    }, []);

    // Gather all digital assets
    const allAssets = useMemo(() => {
        const assets = [
            ...gatherRoutes(),
            ...gatherApis(),
            ...gatherButtons(),
            ...gatherContent(),
            ...gatherTheme(),
        ];

        // Enrich with usage data from tracker
        if (snapshot) {
            const visitedPaths = new Set(Object.keys(snapshot.routes));
            const maxVisits = Math.max(...Object.values(snapshot.routes).map(r => r.count), 1);

            for (const asset of assets) {
                if (asset.type === 'route' && asset.path) {
                    const rv = snapshot.routes[asset.path];
                    if (rv) {
                        asset.visits = rv.count;
                        asset.lastUsed = rv.lastVisit;
                        asset.status = rv.count / maxVisits > 0.5 ? 'hot' : 'active';
                    }
                }
            }

            // Add tracked clicks as assets
            for (const [key, ce] of Object.entries(snapshot.clicks || {})) {
                assets.push({
                    name: ce.target, type: 'click', section: ce.elementType,
                    detail: `${ce.count} clicks`, visits: ce.count, lastUsed: ce.lastClick,
                    status: 'active',
                });
            }
        }

        return assets;
    }, [snapshot]);

    // Get unique sections
    const allSections = useMemo(() => {
        const s = new Set(allAssets.map(a => a.section));
        return ['all', ...Array.from(s).sort()];
    }, [allAssets]);

    // Type counts
    const typeCounts = useMemo(() => {
        const c: Record<string, number> = { all: allAssets.length };
        for (const a of allAssets) c[a.type] = (c[a.type] || 0) + 1;
        return c;
    }, [allAssets]);

    // Filter
    const filtered = useMemo(() => {
        let items = allAssets;
        if (typeFilter !== 'all') items = items.filter(a => a.type === typeFilter);
        if (sectionFilter !== 'all') items = items.filter(a => a.section === sectionFilter);
        if (statusFilter !== 'all') items = items.filter(a => a.status === statusFilter);
        if (search) {
            const q = search.toLowerCase();
            items = items.filter(a =>
                a.name.toLowerCase().includes(q) || a.path?.toLowerCase().includes(q) || a.section.toLowerCase().includes(q) || a.detail?.toLowerCase().includes(q)
            );
        }
        return items;
    }, [allAssets, typeFilter, sectionFilter, statusFilter, search]);

    const totalPages = Math.ceil(filtered.length / PAGE_SIZE);
    const pageItems = filtered.slice(page * PAGE_SIZE, (page + 1) * PAGE_SIZE);

    useEffect(() => { setPage(0); }, [typeFilter, sectionFilter, statusFilter, search]);

    const timeAgo = (ts?: number) => {
        if (!ts) return '—';
        const d = Date.now() - ts;
        if (d < 60000) return 'Just now';
        if (d < 3600000) return `${Math.floor(d / 60000)}m ago`;
        if (d < 86400000) return `${Math.floor(d / 3600000)}h ago`;
        return `${Math.floor(d / 86400000)}d ago`;
    };

    return (
        <div data-cy="page.container" style={S.page} className="main-content">
            {/* Hero */}
            <div style={S.hero}>
                <div style={S.heroGlow as any} />
                <h1 data-cy="page.title" style={S.heroTitle}><span style={S.heroIcon}>🏛️</span> Digital Property Manager</h1>
                <p style={S.heroSub}>Complete inventory of all platform digital assets — routes, APIs, buttons, content, theme tokens, and interactions</p>
            </div>

            {/* Type stat cards */}
            <div style={S.statsRow}>
                {[
                    { key: 'all', icon: '🏗️', label: 'Total Assets' },
                    { key: 'route', icon: '🛤️', label: 'Routes' },
                    { key: 'api', icon: '🔌', label: 'API Endpoints' },
                    { key: 'button', icon: '🔘', label: 'Buttons' },
                    { key: 'content', icon: '📄', label: 'Content Keys' },
                    { key: 'theme', icon: '🎨', label: 'Theme Tokens' },
                ].map(t => (
                    <div
                        key={t.key}
                        style={{ ...S.stat, ...(typeFilter === t.key ? S.statActive : {}) }}
                        onClick={() => setTypeFilter(typeFilter === t.key ? 'all' : t.key)}
                    >
                        <div style={S.statIcon}>{t.icon}</div>
                        <div style={S.statVal}>{typeCounts[t.key] || 0}</div>
                        <div style={S.statLabel}>{t.label}</div>
                    </div>
                ))}
            </div>

            {/* Filter bar */}
            <div style={S.filterBar}>
                <input type="text" placeholder="Search assets by name, path, or section..." value={search} onChange={e => setSearch(e.target.value)} style={S.search} />
                <select value={sectionFilter} onChange={e => setSectionFilter(e.target.value)} style={S.select}>
                    {allSections.map(s => <option key={s} value={s}>{s === 'all' ? '📁 All Sections' : s}</option>)}
                </select>
                <select value={statusFilter} onChange={e => setStatusFilter(e.target.value)} style={S.select}>
                    <option value="all">🔵 All Status</option>
                    <option value="active">🟢 Active</option>
                    <option value="unused">🔴 Unused</option>
                    <option value="hot">🟠 Hot</option>
                </select>
            </div>

            {/* Status chips */}
            <div style={{ display: 'flex', gap: 8, marginBottom: 20 }}>
                {['all', 'active', 'unused', 'hot'].map(s => {
                    const count = s === 'all' ? filtered.length : allAssets.filter(a => a.status === s).length;
                    return (
                        <span key={s} onClick={() => setStatusFilter(statusFilter === s ? 'all' : s)} style={{ ...S.chip, ...(statusFilter === s ? S.chipActive : {}) }}>
                            {s === 'all' ? '●' : s === 'active' ? '🟢' : s === 'unused' ? '🔴' : '🟠'} {s.charAt(0).toUpperCase() + s.slice(1)} ({count})
                        </span>
                    );
                })}
            </div>

            {/* Main table */}
            <div style={S.card}>
                <div style={{ overflowX: 'auto', maxHeight: '70vh', overflowY: 'auto' }}>
                    <table style={S.table}>
                        <thead>
                            <tr>
                                <th style={S.th}>Asset</th>
                                <th style={S.th}>Type</th>
                                <th style={S.th}>Section</th>
                                <th style={S.th}>Path / Value</th>
                                <th style={S.th}>Visits</th>
                                <th style={S.th}>Last Used</th>
                                <th style={S.th}>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            {pageItems.map((a, i) => {
                                const tBadge = (S.typeBadge as any)[a.type] || { bg: '#f1f5f9', color: '#475569' };
                                const sBadge = (S.statusBadge as any)[a.status] || { bg: '#f1f5f9', color: '#475569' };
                                return (
                                    <tr key={`${a.type}-${a.name}-${i}`} style={{ background: i % 2 === 0 ? '#fff' : '#fafbfc' }}>
                                        <td style={S.td}>
                                            <div style={{ fontWeight: 600, fontSize: 13 }}>{a.name}</div>
                                            {a.detail && <div style={{ fontSize: 11, color: '#94a3b8', marginTop: 2 }}>{a.detail}</div>}
                                        </td>
                                        <td style={S.td}>
                                            <span style={{ ...S.badge, background: tBadge.bg, color: tBadge.color }}>
                                                {TYPE_ICONS[a.type]} {a.type}
                                            </span>
                                        </td>
                                        <td style={S.td}><span style={{ fontSize: 12, color: '#64748b' }}>{a.section}</span></td>
                                        <td style={{ ...S.td, ...S.tdMono, maxWidth: 300, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                                            {a.path || '—'}
                                        </td>
                                        <td style={{ ...S.td, fontWeight: a.visits ? 700 : 400, color: a.visits ? '#0f172a' : '#cbd5e1' }}>
                                            {a.visits || '—'}
                                        </td>
                                        <td style={{ ...S.td, color: '#94a3b8', fontSize: 12 }}>{timeAgo(a.lastUsed)}</td>
                                        <td style={S.td}>
                                            <span style={{ ...S.badge, background: sBadge.bg, color: sBadge.color }}>{a.status}</span>
                                        </td>
                                    </tr>
                                );
                            })}
                        </tbody>
                    </table>
                </div>
                <div style={S.footer}>
                    <span>Showing {page * PAGE_SIZE + 1}–{Math.min((page + 1) * PAGE_SIZE, filtered.length)} of {filtered.length} assets</span>
                    <div style={S.pagination}>
                        <button style={S.pageBtn} onClick={() => setPage(Math.max(0, page - 1))} disabled={page === 0}>‹ Prev</button>
                        {Array.from({ length: Math.min(totalPages, 7) }, (_, i) => {
                            const p = totalPages <= 7 ? i : page < 3 ? i : page > totalPages - 4 ? totalPages - 7 + i : page - 3 + i;
                            return (
                                <button key={p} onClick={() => setPage(p)} style={{ ...S.pageBtn, ...(p === page ? S.pageBtnActive : {}) }}>
                                    {p + 1}
                                </button>
                            );
                        })}
                        <button style={S.pageBtn} onClick={() => setPage(Math.min(totalPages - 1, page + 1))} disabled={page >= totalPages - 1}>Next ›</button>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default DigitalPropertyManager;
