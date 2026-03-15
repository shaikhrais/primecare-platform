// ═══════════════════════════════════════════════════════════════
// PAGE IDENTITY: D2 · Registry Summary
// Registry ID:   page.admin.summary
// Type:          Dashboard
// Owner:         admin
// Route:         /platform/admin/summary-dashboard
// ═══════════════════════════════════════════════════════════════
import React, { useState, useEffect } from 'react';
import { type StatsData, KPI_CARDS, ALERT_CARDS, getValue, getAlertValue, fetchDashboardStats } from './dashboardConfig';

export const RegistrySummaryDashboard: React.FC = () => {
    const [stats, setStats] = useState<StatsData | null>(null);
    const [registryCount, setRegistryCount] = useState(0);
    const [registrySections, setRegistrySections] = useState<Record<string, number>>({});
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);
    const [lastSynced, setLastSynced] = useState<string | null>(null);

    const fetchAll = async () => {
        setLoading(true); setError(null);
        const result = await fetchDashboardStats();
        setStats(result.stats); setRegistryCount(result.registryCount);
        setRegistrySections(result.registrySections); setError(result.error);
        setLastSynced(result.lastSynced); setLoading(false);
    };

    useEffect(() => { fetchAll(); }, []);

    return (
        <div data-cy="page.container" role="main" aria-label="Registry Summary" style={{ padding: '2rem', maxWidth: '1400px', margin: '0 auto', fontFamily: "'Inter', 'Segoe UI', sans-serif" }}>
            <header style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem', flexWrap: 'wrap', gap: '1rem' }}>
                <div><h1 data-cy="page.title" style={{ fontSize: '1.75rem', fontWeight: 800, color: '#0f172a', margin: 0 }}>📊 Platform Summary Dashboard</h1><p style={{ color: '#64748b', marginTop: '0.25rem', fontSize: '0.9rem' }}>Real-time intelligence powered by DB{lastSynced && <span style={{ marginLeft: '1rem', fontSize: '0.8rem', padding: '2px 8px', borderRadius: '4px', background: '#f0fdf4', color: '#16a34a' }}>✅ Synced: {lastSynced}</span>}</p></div>
                <button data-cy="btn-admin.registry-summary-0" onClick={fetchAll} disabled={loading} style={{ padding: '0.7rem 1.5rem', borderRadius: '0.75rem', background: loading ? '#94a3b8' : 'linear-gradient(135deg, #0d9488, #0f766e)', border: 'none', color: 'white', fontWeight: 700, cursor: loading ? 'not-allowed' : 'pointer', fontSize: '0.9rem', transition: 'all 0.2s' }}>{loading ? '⏳ Syncing...' : '🔄 Sync Now'}</button>
            </header>
            {error && <div style={{ padding: '1rem 1.5rem', borderRadius: '0.75rem', marginBottom: '1.5rem', background: '#fef2f2', border: '1px solid #fecaca', color: '#991b1b', display: 'flex', alignItems: 'center', gap: '0.5rem', fontSize: '0.85rem' }}>⚠️ <strong>Error:</strong> {error}</div>}

            <section style={{ marginBottom: '2rem' }}>
                <h2 data-cy="h2-admin.registry-summary-0" style={{ fontSize: '0.9rem', fontWeight: 700, color: '#64748b', marginBottom: '0.75rem', textTransform: 'uppercase', letterSpacing: '0.08em' }}>Core Metrics</h2>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(190px, 1fr))', gap: '0.75rem' }}>
                    {KPI_CARDS.map(kpi => { const val = getValue(stats, kpi.key); return (
                        <div key={kpi.key} style={{ padding: '1.25rem', borderRadius: '1rem', background: 'white', border: '1px solid #e2e8f0', boxShadow: '0 1px 3px rgba(0,0,0,0.04)', cursor: kpi.route ? 'pointer' : 'default', transition: 'transform 0.15s, box-shadow 0.15s' }} onClick={() => kpi.route && (window.location.pathname = kpi.route)} onMouseEnter={e => { e.currentTarget.style.transform = 'translateY(-2px)'; e.currentTarget.style.boxShadow = '0 4px 12px rgba(0,0,0,0.08)'; }} onMouseLeave={e => { e.currentTarget.style.transform = ''; e.currentTarget.style.boxShadow = '0 1px 3px rgba(0,0,0,0.04)'; }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '0.5rem' }}><span style={{ fontSize: '0.75rem', fontWeight: 600, color: '#64748b', textTransform: 'uppercase', letterSpacing: '0.04em' }}>{kpi.label}</span><span style={{ fontSize: '1.3rem' }}>{kpi.icon}</span></div>
                            <div style={{ fontSize: '1.6rem', fontWeight: 800, color: kpi.color }}>{loading ? <span style={{ color: '#cbd5e1' }}>...</span> : <>{kpi.prefix}{val}{kpi.suffix}</>}</div>
                            {kpi.route && <div style={{ fontSize: '0.65rem', color: '#94a3b8', marginTop: '0.4rem' }}>Click to view →</div>}
                        </div>); })}
                </div>
            </section>

            <section style={{ marginBottom: '2rem' }}>
                <h2 data-cy="h2-admin.registry-summary-1" style={{ fontSize: '0.9rem', fontWeight: 700, color: '#64748b', marginBottom: '0.75rem', textTransform: 'uppercase', letterSpacing: '0.08em' }}>Health Alerts</h2>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '0.75rem' }}>
                    {ALERT_CARDS.map(alert => { const val = getAlertValue(stats, alert.key); const isActive = val > 0; return (
                        <div key={alert.key} style={{ padding: '1.25rem', borderRadius: '1rem', background: isActive ? '#fef2f2' : '#f0fdf4', border: `1px solid ${isActive ? '#fecaca' : '#bbf7d0'}` }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '0.5rem' }}><span style={{ fontSize: '0.75rem', fontWeight: 600, color: '#64748b', textTransform: 'uppercase' }}>{alert.label}</span><span style={{ fontSize: '1.3rem' }}>{alert.icon}</span></div>
                            <div style={{ fontSize: '1.6rem', fontWeight: 800, color: isActive ? alert.color : '#16a34a' }}>{loading ? <span style={{ color: '#cbd5e1' }}>...</span> : val}</div>
                            <div style={{ fontSize: '0.7rem', fontWeight: 600, color: isActive ? alert.color : '#16a34a', marginTop: '0.2rem' }}>{isActive ? '⚠️ Needs Attention' : '✅ All Clear'}</div>
                        </div>); })}
                </div>
            </section>

            <section>
                <h2 data-cy="h2-admin.registry-summary-2" style={{ fontSize: '0.9rem', fontWeight: 700, color: '#64748b', marginBottom: '0.75rem', textTransform: 'uppercase', letterSpacing: '0.08em' }}>🗄️ Registry Database</h2>
                <div style={{ padding: '1.25rem', borderRadius: '1rem', background: 'white', border: '1px solid #e2e8f0', boxShadow: '0 1px 3px rgba(0,0,0,0.04)' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '1rem', marginBottom: '1rem' }}><div style={{ fontSize: '1.6rem', fontWeight: 800, color: '#2563eb' }}>{loading ? '...' : registryCount.toLocaleString()}</div><div><div style={{ fontWeight: 700, color: '#0f172a', fontSize: '0.95rem' }}>Registry Entries in DB</div><div style={{ fontSize: '0.75rem', color: '#64748b' }}>Synced from ContentRegistry • Editable via API</div></div></div>
                    {Object.keys(registrySections).length > 0 && <div style={{ display: 'flex', flexWrap: 'wrap', gap: '0.5rem' }}>{Object.entries(registrySections).sort((a, b) => b[1] - a[1]).map(([sec, count]) => <span key={sec} style={{ padding: '3px 10px', borderRadius: '999px', fontSize: '0.7rem', background: '#f1f5f9', color: '#475569', fontWeight: 600, border: '1px solid #e2e8f0' }}>{sec}: {count}</span>)}</div>}
                </div>
            </section>
        </div>
    );
};

export default RegistrySummaryDashboard;
