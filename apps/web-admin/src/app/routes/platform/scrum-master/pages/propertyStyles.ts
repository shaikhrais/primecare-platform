import React from 'react';

export const S: Record<string, React.CSSProperties> = {
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

export const TYPE_ICONS: Record<string, string> = { route: '🛤️', api: '🔌', button: '🔘', content: '📄', theme: '🎨', click: '👆' };
export const PAGE_SIZE = 30;
