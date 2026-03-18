// UsageStatisticsManager: helpers, styles, and route gatherer
import React from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { RouteRegistry } = AdminRegistry;

/* ─── Helpers ─── */
export const formatTime = (ms: number) => {
    if (ms < 1000) return `${ms}ms`;
    if (ms < 60000) return `${(ms / 1000).toFixed(1)}s`;
    if (ms < 3600000) return `${(ms / 60000).toFixed(1)}m`;
    return `${(ms / 3600000).toFixed(1)}h`;
};

export const timeAgo = (ts: number) => {
    if (!ts) return 'Never';
    const d = Date.now() - ts;
    if (d < 60000) return 'Just now';
    if (d < 3600000) return `${Math.floor(d / 60000)}m ago`;
    if (d < 86400000) return `${Math.floor(d / 3600000)}h ago`;
    return `${Math.floor(d / 86400000)}d ago`;
};

export const getUsageLevel = (count: number, max: number) => {
    if (count === 0) return { label: 'Unused', color: '#ef4444', bg: '#fef2f2' };
    const ratio = count / (max || 1);
    if (ratio > 0.6) return { label: 'Hot', color: '#f97316', bg: '#fff7ed' };
    if (ratio > 0.3) return { label: 'Active', color: '#22c55e', bg: '#f0fdf4' };
    return { label: 'Low', color: '#eab308', bg: '#fefce8' };
};

/* ─── All known platform routes ─── */
export const gatherRoutes = (): { path: string; label: string; section: string }[] => {
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
export const S: Record<string, React.CSSProperties> = {
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

export type TabKey = 'routes' | 'clicks' | 'forms' | 'api' | 'unused';
