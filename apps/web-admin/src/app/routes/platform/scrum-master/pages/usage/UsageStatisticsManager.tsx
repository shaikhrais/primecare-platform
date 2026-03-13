import React, { useState, useEffect, useMemo } from 'react';
import { UsageTracker, type UsageSnapshot } from '@/shared/services/UsageTracker';
import { AdminRegistry } from 'prime-care-shared';

const { RouteRegistry } = AdminRegistry;

/* ─── Helpers ─── */
const formatTime = (ms: number) => {
    if (ms < 1000) return `${ms}ms`;
    if (ms < 60000) return `${(ms / 1000).toFixed(1)}s`;
    if (ms < 3600000) return `${(ms / 60000).toFixed(1)}m`;
    return `${(ms / 3600000).toFixed(1)}h`;
};

const timeAgo = (ts: number) => {
    if (!ts) return 'Never';
    const d = Date.now() - ts;
    if (d < 60000) return 'Just now';
    if (d < 3600000) return `${Math.floor(d / 60000)}m ago`;
    if (d < 86400000) return `${Math.floor(d / 3600000)}h ago`;
    return `${Math.floor(d / 86400000)}d ago`;
};

const getUsageLevel = (count: number, max: number) => {
    if (count === 0) return { label: 'Unused', color: '#ef4444', bg: '#fef2f2' };
    const ratio = count / (max || 1);
    if (ratio > 0.6) return { label: 'Hot', color: '#f97316', bg: '#fff7ed' };
    if (ratio > 0.3) return { label: 'Active', color: '#22c55e', bg: '#f0fdf4' };
    return { label: 'Low', color: '#eab308', bg: '#fefce8' };
};

/* ─── All known platform routes ─── */
const gatherRoutes = (): { path: string; label: string; section: string }[] => {
    const routes: { path: string; label: string; section: string }[] = [];
    const flat = (obj: any, section: string, prefix = '') => {
        for (const [key, val] of Object.entries(obj)) {
            if (typeof val === 'string') {
                routes.push({ path: val, label: `${prefix}${key}`.replace(/_/g, ' '), section });
            } else if (typeof val === 'object' && val !== null && typeof val !== 'function') {
                flat(val, section, `${key} > `);
            }
        }
    };
    if (RouteRegistry.ADMIN) flat(RouteRegistry.ADMIN, 'Admin');
    if (RouteRegistry.SCRUM_MASTER) flat(RouteRegistry.SCRUM_MASTER, 'Scrum Master');
    if ((RouteRegistry as any).PSW) flat((RouteRegistry as any).PSW, 'PSW');
    if ((RouteRegistry as any).CLIENT) flat((RouteRegistry as any).CLIENT, 'Client');
    if ((RouteRegistry as any).MANAGER) flat((RouteRegistry as any).MANAGER, 'Manager');
    if ((RouteRegistry as any).COORDINATOR) flat((RouteRegistry as any).COORDINATOR, 'Coordinator');
    if ((RouteRegistry as any).RN) flat((RouteRegistry as any).RN, 'RN');
    if ((RouteRegistry as any).STAFF) flat((RouteRegistry as any).STAFF, 'Staff');
    return routes;
};

/* ─── Styles ─── */
const S: Record<string, React.CSSProperties> = {
    page: { padding: '0 0 60px', fontFamily: "'Inter', system-ui, -apple-system, sans-serif" },
    hero: { background: 'linear-gradient(135deg, #312e81 0%, #4338ca 50%, #818cf8 100%)', borderRadius: 16, padding: '36px 40px', marginBottom: 32, position: 'relative', overflow: 'hidden' },
    heroGlow: { position: 'absolute', top: -80, right: -40, width: 220, height: 220, background: 'radial-gradient(circle, rgba(165,180,252,0.3) 0%, transparent 70%)', borderRadius: '50%', pointerEvents: 'none' },
    heroTitle: { fontSize: 28, fontWeight: 800, color: '#fff', margin: 0, letterSpacing: -0.5, display: 'flex', alignItems: 'center', gap: 12 },
    heroSub: { fontSize: 14, color: 'rgba(255,255,255,0.7)', marginTop: 6 },
    heroIcon: { width: 36, height: 36, background: 'rgba(255,255,255,0.15)', borderRadius: 10, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 20 },

    topBar: { display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 24, flexWrap: 'wrap' as const, gap: 12 },
    statRow: { display: 'grid', gridTemplateColumns: 'repeat(5, 1fr)', gap: 16, marginBottom: 28 },
    stat: { background: '#fff', borderRadius: 14, padding: '20px 24px', boxShadow: '0 1px 3px rgba(0,0,0,0.06), 0 4px 12px rgba(0,0,0,0.04)' },
    statLabel: { fontSize: 11, fontWeight: 700, textTransform: 'uppercase' as const, letterSpacing: 0.8, color: '#94a3b8', marginBottom: 4 },
    statVal: { fontSize: 28, fontWeight: 800, color: '#0f172a' },
    statNote: { fontSize: 12, color: '#94a3b8', marginTop: 4 },

    card: { background: '#fff', borderRadius: 14, boxShadow: '0 1px 3px rgba(0,0,0,0.06), 0 4px 12px rgba(0,0,0,0.04)', overflow: 'hidden', marginBottom: 28 },
    cardH: { padding: '16px 20px', fontWeight: 700, fontSize: 14, textTransform: 'uppercase' as const, letterSpacing: 0.8, color: '#475569', borderBottom: '1px solid #f1f5f9', display: 'flex', alignItems: 'center', justifyContent: 'space-between' },

    table: { width: '100%', borderCollapse: 'collapse' as const },
    th: { padding: '10px 16px', textAlign: 'left' as const, fontSize: 11, fontWeight: 700, textTransform: 'uppercase' as const, letterSpacing: 0.8, color: '#94a3b8', borderBottom: '1px solid #f1f5f9' },
    td: { padding: '12px 16px', fontSize: 13, borderBottom: '1px solid #f8fafc', color: '#334155' },
    tdMono: { fontFamily: "'JetBrains Mono', 'Fira Code', monospace", fontSize: 12 },

    badge: { display: 'inline-flex', padding: '3px 10px', borderRadius: 16, fontSize: 11, fontWeight: 700, letterSpacing: 0.3 },
    heatBar: { height: 6, borderRadius: 3, background: '#e2e8f0', overflow: 'hidden', width: 80, display: 'inline-block', verticalAlign: 'middle', marginLeft: 8 },
    heatFill: { height: '100%', borderRadius: 3, transition: 'width 0.4s ease' },

    tabRow: { display: 'flex', gap: 4, flexWrap: 'wrap' as const },
    tab: { padding: '8px 16px', borderRadius: 10, border: '1px solid #e2e8f0', background: '#fff', cursor: 'pointer', fontSize: 13, fontWeight: 600, color: '#64748b', transition: 'all 0.2s' },
    tabActive: { background: '#4338ca', color: '#fff', borderColor: '#4338ca' },

    resetBtn: { padding: '8px 20px', borderRadius: 8, border: '1px solid #fee2e2', background: '#fff', color: '#ef4444', fontSize: 12, fontWeight: 600, cursor: 'pointer' },
    refreshBtn: { padding: '8px 20px', borderRadius: 8, border: '1px solid #e2e8f0', background: '#fff', color: '#475569', fontSize: 12, fontWeight: 600, cursor: 'pointer' },
    emptyState: { padding: 40, textAlign: 'center' as const, color: '#94a3b8' },

    scrollBar: { height: 6, borderRadius: 3, background: '#e2e8f0', overflow: 'hidden', width: 60 },
    scrollFill: { height: '100%', borderRadius: 3, background: 'linear-gradient(90deg, #818cf8, #4338ca)' },
};

type TabKey = 'routes' | 'clicks' | 'forms' | 'api' | 'unused';

/* ─── Component ─── */
const UsageStatisticsManager: React.FC = () => {
    const [snapshot, setSnapshot] = useState<UsageSnapshot>(UsageTracker.getSnapshot());
    const [tab, setTab] = useState<TabKey>('routes');

    const refresh = () => setSnapshot(UsageTracker.getSnapshot());

    useEffect(() => {
        const interval = setInterval(refresh, 5000);
        return () => clearInterval(interval);
    }, []);

    const allKnownRoutes = useMemo(() => gatherRoutes(), []);

    const routeEntries = Object.values(snapshot.routes);
    const formEntries = Object.values(snapshot.forms);
    const apiEntries = Object.values(snapshot.apiCalls);
    const clickEntries = Object.values(snapshot.clicks || {});
    const totalRouteVisits = routeEntries.reduce((s, r) => s + r.count, 0);
    const totalFormEntries = formEntries.reduce((s, f) => s + f.count, 0);
    const totalApiCalls = apiEntries.reduce((s, a) => s + a.count, 0);
    const totalClicks = snapshot.totalClicks || clickEntries.reduce((s, c) => s + c.count, 0);
    const maxRouteCount = Math.max(...routeEntries.map(r => r.count), 1);
    const maxClickCount = Math.max(...clickEntries.map(c => c.count), 1);

    const visitedPaths = new Set(Object.keys(snapshot.routes));
    const unusedRoutes = allKnownRoutes.filter(r => !visitedPaths.has(r.path));

    const sortedRoutes = [...routeEntries].sort((a, b) => b.count - a.count);
    const sortedForms = [...formEntries].sort((a, b) => b.count - a.count);
    const sortedApi = [...apiEntries].sort((a, b) => b.count - a.count);
    const sortedClicks = [...clickEntries].sort((a, b) => b.count - a.count);

    const handleReset = () => {
        if (confirm('Reset all usage statistics? This cannot be undone.')) {
            UsageTracker.reset();
            refresh();
        }
    };

    const TABS: { key: TabKey; label: string; count: number }[] = [
        { key: 'routes', label: '🛤️ Routes', count: routeEntries.length },
        { key: 'clicks', label: '👆 Clicks', count: clickEntries.length },
        { key: 'forms', label: '📝 Forms', count: formEntries.length },
        { key: 'api', label: '🔌 API', count: apiEntries.length },
        { key: 'unused', label: '⚠️ Unused', count: unusedRoutes.length },
    ];

    return (
        <div data-cy="page.container" style={S.page} className="main-content">
            {/* ─── Hero ─── */}
            <div style={S.hero}>
                <div style={S.heroGlow as any} />
                <h1 data-cy="page.title" style={S.heroTitle}><span style={S.heroIcon}>📊</span> Usage Statistics Manager</h1>
                <p style={S.heroSub}>Routes · Clicks · Forms · API calls · Scroll depth · Unused components</p>
            </div>

            {/* ─── Summary Stats ─── */}
            <div style={S.statRow}>
                <div style={S.stat}>
                    <div style={S.statLabel}>Route Visits</div>
                    <div style={S.statVal}>{totalRouteVisits.toLocaleString()}</div>
                    <div style={S.statNote}>{routeEntries.length} unique routes</div>
                </div>
                <div style={S.stat}>
                    <div style={S.statLabel}>Clicks</div>
                    <div style={S.statVal}>{totalClicks.toLocaleString()}</div>
                    <div style={S.statNote}>{clickEntries.length} unique targets</div>
                </div>
                <div style={S.stat}>
                    <div style={S.statLabel}>Form Entries</div>
                    <div style={S.statVal}>{totalFormEntries.toLocaleString()}</div>
                    <div style={S.statNote}>{formEntries.length} unique forms</div>
                </div>
                <div style={S.stat}>
                    <div style={S.statLabel}>API Calls</div>
                    <div style={S.statVal}>{totalApiCalls.toLocaleString()}</div>
                    <div style={S.statNote}>{apiEntries.filter(a => a.errors > 0).length} with errors</div>
                </div>
                <div style={S.stat}>
                    <div style={S.statLabel}>Unused Routes</div>
                    <div style={{ ...S.statVal, color: unusedRoutes.length > 0 ? '#ef4444' : '#22c55e' }}>{unusedRoutes.length}</div>
                    <div style={S.statNote}>of {allKnownRoutes.length} registered</div>
                </div>
            </div>

            {/* ─── Tabs ─── */}
            <div style={S.topBar}>
                <div style={S.tabRow}>
                    {TABS.map(t => (
                        <button data-cy="btn-usage-statistics-manager-0" key={t.key} onClick={() => setTab(t.key)} style={{ ...S.tab, ...(tab === t.key ? S.tabActive : {}) }}>
                            {t.label} ({t.count})
                        </button>
                    ))}
                </div>
                <div style={{ display: 'flex', gap: 8 }}>
                    <button data-cy="btn-usage-statistics-manager-1" style={S.refreshBtn} onClick={refresh}>↻ Refresh</button>
                    <button data-cy="btn-usage-statistics-manager-2" style={S.resetBtn} onClick={handleReset}>🗑 Reset All</button>
                </div>
            </div>

            {/* ─── Routes Tab ─── */}
            {tab === 'routes' && (
                <div style={S.card}>
                    <div style={S.cardH}>
                        <span>🛤️ Route Visit Heatmap</span>
                        <span style={{ fontSize: 11, color: '#94a3b8', fontWeight: 500 }}>Sorted by frequency</span>
                    </div>
                    {sortedRoutes.length === 0 ? (
                        <div style={S.emptyState}>No routes tracked yet. Navigate around to start.</div>
                    ) : (
                        <table data-cy="table-usage-statistics-manager" style={S.table}>
                            <thead><tr>
                                <th style={S.th}>Route</th>
                                <th style={S.th}>Visits</th>
                                <th style={S.th}>Heat</th>
                                <th style={S.th}>Time Spent</th>
                                <th style={S.th}>Scroll</th>
                                <th style={S.th}>Last Visit</th>
                                <th style={S.th}>Status</th>
                            </tr></thead>
                            <tbody>
                                {sortedRoutes.map(r => {
                                    const level = getUsageLevel(r.count, maxRouteCount);
                                    const heatPct = Math.round((r.count / maxRouteCount) * 100);
                                    const scrollPct = r.maxScrollDepth || 0;
                                    return (
                                        <tr key={r.path}>
                                            <td style={S.td}>
                                                <div style={{ fontWeight: 600 }}>{r.label || r.path.split('/').pop()}</div>
                                                <div style={{ ...S.tdMono, color: '#94a3b8', fontSize: 11 }}>{r.path}</div>
                                            </td>
                                            <td style={{ ...S.td, fontWeight: 700, fontSize: 16 }}>{r.count}</td>
                                            <td style={S.td}>
                                                <div style={S.heatBar}><div style={{ ...S.heatFill, width: `${heatPct}%`, background: `linear-gradient(90deg, #818cf8, ${level.color})` }} /></div>
                                            </td>
                                            <td style={{ ...S.td, ...S.tdMono }}>{formatTime(r.totalTimeMs)}</td>
                                            <td style={S.td}>
                                                <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
                                                    <div style={S.scrollBar}><div style={{ ...S.scrollFill, width: `${scrollPct}%` }} /></div>
                                                    <span style={{ fontSize: 11, color: '#94a3b8' }}>{scrollPct}%</span>
                                                </div>
                                            </td>
                                            <td style={{ ...S.td, color: '#94a3b8' }}>{timeAgo(r.lastVisit)}</td>
                                            <td style={S.td}><span style={{ ...S.badge, background: level.bg, color: level.color }}>{level.label}</span></td>
                                        </tr>
                                    );
                                })}
                            </tbody>
                        </table>
                    )}
                </div>
            )}

            {/* ─── Clicks Tab ─── */}
            {tab === 'clicks' && (
                <div style={S.card}>
                    <div style={S.cardH}>
                        <span>👆 Click Interaction Tracker</span>
                        <span style={{ fontSize: 11, color: '#94a3b8', fontWeight: 500 }}>Top clicked elements</span>
                    </div>
                    {sortedClicks.length === 0 ? (
                        <div style={S.emptyState}>No clicks tracked yet. Interact with buttons and links to start.</div>
                    ) : (
                        <table data-cy="table-usage-statistics-manager" style={S.table}>
                            <thead><tr>
                                <th style={S.th}>Element</th>
                                <th style={S.th}>Type</th>
                                <th style={S.th}>Clicks</th>
                                <th style={S.th}>Heat</th>
                                <th style={S.th}>Last Click</th>
                                <th style={S.th}>Load</th>
                            </tr></thead>
                            <tbody>
                                {sortedClicks.slice(0, 50).map(c => {
                                    const level = getUsageLevel(c.count, maxClickCount);
                                    const heatPct = Math.round((c.count / maxClickCount) * 100);
                                    return (
                                        <tr key={`${c.elementType}:${c.target}`}>
                                            <td style={S.td}><div style={{ fontWeight: 600, maxWidth: 300, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>{c.target}</div></td>
                                            <td style={S.td}>
                                                <span style={{ ...S.badge, background: c.elementType === 'button' ? '#eff6ff' : c.elementType === 'a' ? '#ecfdf5' : '#f5f3ff', color: c.elementType === 'button' ? '#3b82f6' : c.elementType === 'a' ? '#059669' : '#7c3aed' }}>
                                                    {c.elementType}
                                                </span>
                                            </td>
                                            <td style={{ ...S.td, fontWeight: 700, fontSize: 16 }}>{c.count}</td>
                                            <td style={S.td}><div style={S.heatBar}><div style={{ ...S.heatFill, width: `${heatPct}%`, background: `linear-gradient(90deg, #c084fc, ${level.color})` }} /></div></td>
                                            <td style={{ ...S.td, color: '#94a3b8' }}>{timeAgo(c.lastClick)}</td>
                                            <td style={S.td}><span style={{ ...S.badge, background: level.bg, color: level.color }}>{level.label}</span></td>
                                        </tr>
                                    );
                                })}
                            </tbody>
                        </table>
                    )}
                </div>
            )}

            {/* ─── Forms Tab ─── */}
            {tab === 'forms' && (
                <div style={S.card}>
                    <div style={S.cardH}><span>📝 Data Entry Tracking</span></div>
                    {sortedForms.length === 0 ? (
                        <div style={S.emptyState}>No form submissions tracked yet. Submit any form to start.</div>
                    ) : (
                        <table data-cy="table-usage-statistics-manager" style={S.table}>
                            <thead><tr><th style={S.th}>Form</th><th style={S.th}>Submissions</th><th style={S.th}>Last Entry</th></tr></thead>
                            <tbody>{sortedForms.map(f => (
                                <tr key={f.formId}><td style={S.td}><div style={{ fontWeight: 600 }}>{f.label || f.formId}</div></td><td style={{ ...S.td, fontWeight: 700, fontSize: 16 }}>{f.count}</td><td style={{ ...S.td, color: '#94a3b8' }}>{timeAgo(f.lastEntry)}</td></tr>
                            ))}</tbody>
                        </table>
                    )}
                </div>
            )}

            {/* ─── API Tab ─── */}
            {tab === 'api' && (
                <div style={S.card}>
                    <div style={S.cardH}><span>🔌 API Call Analytics</span></div>
                    {sortedApi.length === 0 ? (
                        <div style={S.emptyState}>No API calls tracked yet.</div>
                    ) : (
                        <table data-cy="table-usage-statistics-manager" style={S.table}>
                            <thead><tr><th style={S.th}>Endpoint</th><th style={S.th}>Method</th><th style={S.th}>Calls</th><th style={S.th}>Errors</th><th style={S.th}>Last Call</th></tr></thead>
                            <tbody>{sortedApi.map(a => (
                                <tr key={`${a.method}:${a.endpoint}`}>
                                    <td style={{ ...S.td, ...S.tdMono }}>{a.endpoint}</td>
                                    <td style={S.td}><span style={{ ...S.badge, background: a.method === 'GET' ? '#ecfdf5' : a.method === 'POST' ? '#eff6ff' : '#fef3c7', color: a.method === 'GET' ? '#059669' : a.method === 'POST' ? '#3b82f6' : '#d97706' }}>{a.method}</span></td>
                                    <td style={{ ...S.td, fontWeight: 700 }}>{a.count}</td>
                                    <td style={{ ...S.td, color: a.errors > 0 ? '#ef4444' : '#94a3b8', fontWeight: a.errors > 0 ? 700 : 400 }}>{a.errors > 0 ? `${a.errors} ✗` : '—'}</td>
                                    <td style={{ ...S.td, color: '#94a3b8' }}>{timeAgo(a.lastCall)}</td>
                                </tr>
                            ))}</tbody>
                        </table>
                    )}
                </div>
            )}

            {/* ─── Unused Tab ─── */}
            {tab === 'unused' && (
                <div style={S.card}>
                    <div style={S.cardH}>
                        <span>⚠️ Unused Routes — Never Visited</span>
                        <span style={{ fontSize: 11, color: '#94a3b8', fontWeight: 500 }}>From RouteRegistry ({unusedRoutes.length} unused)</span>
                    </div>
                    {unusedRoutes.length === 0 ? (
                        <div style={S.emptyState}>🎉 All registered routes have been visited!</div>
                    ) : (
                        <table data-cy="table-usage-statistics-manager" style={S.table}>
                            <thead><tr><th style={S.th}>Route</th><th style={S.th}>Section</th><th style={S.th}>Path</th><th style={S.th}>Status</th></tr></thead>
                            <tbody>{unusedRoutes.map(r => (
                                <tr key={r.path}>
                                    <td style={{ ...S.td, fontWeight: 600 }}>{r.label}</td>
                                    <td style={S.td}><span style={{ ...S.badge, background: '#f1f5f9', color: '#475569' }}>{r.section}</span></td>
                                    <td style={{ ...S.td, ...S.tdMono, color: '#94a3b8' }}>{r.path}</td>
                                    <td style={S.td}><span style={{ ...S.badge, background: '#fef2f2', color: '#ef4444' }}>Unused</span></td>
                                </tr>
                            ))}</tbody>
                        </table>
                    )}
                </div>
            )}

            {/* ─── Session ─── */}
            <div style={{ ...S.card, padding: 20 }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <div style={{ fontSize: 12, fontWeight: 600, color: '#94a3b8' }}>Sessions: {snapshot.totalSessions} · Last activity: {timeAgo(snapshot.lastActivity)}</div>
                    <div style={{ fontSize: 11, color: '#cbd5e1' }}>Tracking: routes, clicks, forms, API, scroll · Auto-refreshes 5s · localStorage</div>
                </div>
            </div>
        </div>
    );
};

export default UsageStatisticsManager;
