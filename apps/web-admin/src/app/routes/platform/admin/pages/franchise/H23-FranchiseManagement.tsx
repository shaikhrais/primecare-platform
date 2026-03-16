// ================================================================
// PAGE IDENTITY: H23 · Franchise Management — Multi-Location Operations
// Type: Hub | Owner: admin
// Tier: Enterprise
// ================================================================
import React, { useState } from 'react';

const locations = [
    { id: 'loc-001', name: 'PrimeCare Toronto — Downtown', city: 'Toronto', province: 'ON', manager: 'Sarah Chen', psws: 24, clients: 67, revenue: '$142K', growth: '+12%', status: 'active' },
    { id: 'loc-002', name: 'PrimeCare Toronto — North York', city: 'North York', province: 'ON', manager: 'James Wilson', psws: 18, clients: 45, revenue: '$98K', growth: '+8%', status: 'active' },
    { id: 'loc-003', name: 'PrimeCare Mississauga', city: 'Mississauga', province: 'ON', manager: 'Maria Santos', psws: 15, clients: 38, revenue: '$82K', growth: '+15%', status: 'active' },
    { id: 'loc-004', name: 'PrimeCare Ottawa', city: 'Ottawa', province: 'ON', manager: 'Kevin O\'Brien', psws: 12, clients: 28, revenue: '$64K', growth: '+5%', status: 'active' },
    { id: 'loc-005', name: 'PrimeCare Vancouver', city: 'Vancouver', province: 'BC', manager: 'Yuki Tanaka', psws: 8, clients: 15, revenue: '$32K', growth: '+22%', status: 'launching' },
    { id: 'loc-006', name: 'PrimeCare Calgary', city: 'Calgary', province: 'AB', manager: 'TBD', psws: 0, clients: 0, revenue: '—', growth: '—', status: 'planned' },
];

const performanceMetrics = [
    { metric: 'Client Satisfaction', toronto: 4.7, northYork: 4.5, mississauga: 4.8, ottawa: 4.3, icon: '⭐' },
    { metric: 'PSW Retention', toronto: '92%', northYork: '88%', mississauga: '95%', ottawa: '85%', icon: '💎' },
    { metric: 'Visit Completion', toronto: '97%', northYork: '95%', mississauga: '98%', ottawa: '94%', icon: '✅' },
    { metric: 'Avg Response Time', toronto: '2.1hr', northYork: '3.4hr', mississauga: '1.8hr', ottawa: '4.2hr', icon: '⏱️' },
];

export default function FranchiseManagement() {
    const [tab, setTab] = useState<'locations' | 'comparison' | 'expansion'>('locations');
    const statusColor = (s: string) => s === 'active' ? 'var(--pc-success)' : s === 'launching' ? 'var(--pc-warning)' : 'var(--pc-text-tertiary)';

    return (
        <div data-cy="page.container" role="main" aria-label="Franchise Management" style={{ padding: '24px', maxWidth: '1400px', margin: '0 auto' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px', flexWrap: 'wrap', gap: '16px' }}>
                <div>
                    <h1 data-cy="page.title" style={{ fontSize: '1.75rem', fontWeight: 800, color: 'var(--pc-text-primary)', margin: 0 }}>🏢 Franchise Management</h1>
                    <p style={{ color: 'var(--pc-text-tertiary)', fontSize: '0.85rem', margin: '4px 0 0' }}>Multi-location operations, performance benchmarking & expansion planning</p>
                </div>
                <div style={{ padding: '6px 14px', borderRadius: '10px', background: 'rgba(124,58,237,0.1)', color: '#7C3AED', fontWeight: 700, fontSize: '0.75rem' }}>🏢 Enterprise</div>
            </div>

            {/* KPIs */}
            <div style={{ display: 'flex', gap: '16px', flexWrap: 'wrap', marginBottom: '24px' }}>
                {[
                    { label: 'Total Locations', value: '6', color: 'var(--pc-primary)' },
                    { label: 'Active', value: '4', color: 'var(--pc-success)' },
                    { label: 'Total PSWs', value: '77', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Total Clients', value: '193', color: '#7C3AED' },
                    { label: 'Combined Revenue', value: '$418K', color: 'var(--pc-success)' },
                ].map((s, i) => (
                    <div key={i} style={{ flex: '1 1 140px', padding: '18px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)' }}>
                        <div style={{ fontSize: '0.65rem', fontWeight: 600, color: 'var(--pc-text-tertiary)', textTransform: 'uppercase', marginBottom: '4px' }}>{s.label}</div>
                        <div style={{ fontSize: '1.6rem', fontWeight: 800, color: s.color }}>{s.value}</div>
                    </div>
                ))}
            </div>

            {/* Tabs */}
            <div style={{ display: 'flex', gap: '4px', marginBottom: '24px' }}>
                {[{ id: 'locations' as const, l: '📍 Locations' }, { id: 'comparison' as const, l: '📊 Comparison' }, { id: 'expansion' as const, l: '🗺️ Expansion' }].map(t => (
                    <button key={t.id} onClick={() => setTab(t.id)} style={{
                        padding: '10px 20px', borderRadius: '10px', border: 'none',
                        background: tab === t.id ? 'var(--pc-primary)' : 'var(--pc-bg-secondary)',
                        color: tab === t.id ? 'white' : 'var(--pc-text-secondary)', fontWeight: 700, fontSize: '0.85rem', cursor: 'pointer',
                    }}>{t.l}</button>
                ))}
            </div>

            {/* Location Cards */}
            {tab === 'locations' && (
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(320px, 1fr))', gap: '16px' }}>
                    {locations.map(loc => (
                        <div key={loc.id} style={{
                            padding: '24px', borderRadius: '14px',
                            background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)',
                            cursor: 'pointer', transition: 'transform 0.2s',
                        }}
                            onMouseEnter={e => e.currentTarget.style.transform = 'translateY(-3px)'}
                            onMouseLeave={e => e.currentTarget.style.transform = 'translateY(0)'}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '12px' }}>
                                <span style={{ padding: '3px 10px', borderRadius: '10px', fontSize: '0.65rem', fontWeight: 700, color: statusColor(loc.status), background: `${statusColor(loc.status)}15` }}>{loc.status.toUpperCase()}</span>
                                {loc.growth !== '—' && <span style={{ fontSize: '0.8rem', fontWeight: 700, color: 'var(--pc-success)' }}>{loc.growth}</span>}
                            </div>
                            <div style={{ fontWeight: 700, fontSize: '1rem', color: 'var(--pc-text-primary)', marginBottom: '4px' }}>📍 {loc.name}</div>
                            <div style={{ fontSize: '0.75rem', color: 'var(--pc-text-tertiary)', marginBottom: '12px' }}>{loc.city}, {loc.province} • Manager: {loc.manager}</div>
                            <div style={{ display: 'flex', justifyContent: 'space-between', padding: '12px 0', borderTop: '1px solid var(--pc-border-primary)' }}>
                                <div style={{ textAlign: 'center' }}>
                                    <div style={{ fontSize: '1.3rem', fontWeight: 800, color: 'var(--pc-primary)' }}>{loc.psws}</div>
                                    <div style={{ fontSize: '0.6rem', color: 'var(--pc-text-tertiary)', textTransform: 'uppercase' }}>PSWs</div>
                                </div>
                                <div style={{ textAlign: 'center' }}>
                                    <div style={{ fontSize: '1.3rem', fontWeight: 800, color: '#7C3AED' }}>{loc.clients}</div>
                                    <div style={{ fontSize: '0.6rem', color: 'var(--pc-text-tertiary)', textTransform: 'uppercase' }}>Clients</div>
                                </div>
                                <div style={{ textAlign: 'center' }}>
                                    <div style={{ fontSize: '1.3rem', fontWeight: 800, color: 'var(--pc-success)' }}>{loc.revenue}</div>
                                    <div style={{ fontSize: '0.6rem', color: 'var(--pc-text-tertiary)', textTransform: 'uppercase' }}>Revenue</div>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>
            )}

            {/* Comparison */}
            {tab === 'comparison' && (
                <div style={{ borderRadius: '14px', border: '1px solid var(--pc-border-primary)', overflow: 'auto' }}>
                    <table style={{ width: '100%', borderCollapse: 'collapse', minWidth: '600px' }}>
                        <thead><tr>
                            <th style={{ padding: '12px 16px', textAlign: 'left', background: 'var(--pc-bg-secondary)', color: 'var(--pc-text-tertiary)', fontSize: '0.7rem', fontWeight: 700, borderBottom: '2px solid var(--pc-border-primary)' }}>Metric</th>
                            {['Toronto', 'North York', 'Mississauga', 'Ottawa'].map(h => (
                                <th key={h} style={{ padding: '12px 16px', textAlign: 'center', background: 'var(--pc-bg-secondary)', color: 'var(--pc-text-tertiary)', fontSize: '0.7rem', fontWeight: 700, borderBottom: '2px solid var(--pc-border-primary)' }}>{h}</th>
                            ))}
                        </tr></thead>
                        <tbody>{performanceMetrics.map((m, i) => (
                            <tr key={i} style={{ background: 'var(--pc-surface-card)' }}>
                                <td style={{ padding: '12px 16px', fontWeight: 700, color: 'var(--pc-text-primary)', borderBottom: '1px solid var(--pc-border-primary)' }}>{m.icon} {m.metric}</td>
                                <td style={{ padding: '12px 16px', textAlign: 'center', fontWeight: 700, color: 'var(--pc-success)', borderBottom: '1px solid var(--pc-border-primary)' }}>{m.toronto}</td>
                                <td style={{ padding: '12px 16px', textAlign: 'center', fontWeight: 700, color: 'var(--pc-text-primary)', borderBottom: '1px solid var(--pc-border-primary)' }}>{m.northYork}</td>
                                <td style={{ padding: '12px 16px', textAlign: 'center', fontWeight: 700, color: 'var(--pc-success)', borderBottom: '1px solid var(--pc-border-primary)' }}>{m.mississauga}</td>
                                <td style={{ padding: '12px 16px', textAlign: 'center', fontWeight: 700, color: 'var(--pc-text-secondary)', borderBottom: '1px solid var(--pc-border-primary)' }}>{m.ottawa}</td>
                            </tr>
                        ))}</tbody>
                    </table>
                </div>
            )}

            {/* Expansion */}
            {tab === 'expansion' && (
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(280px, 1fr))', gap: '16px' }}>
                    {[
                        { city: 'Calgary, AB', pop: '1.4M', demand: 'High', readiness: 65, timeline: 'Q3 2026' },
                        { city: 'Edmonton, AB', pop: '1.0M', demand: 'Medium', readiness: 30, timeline: 'Q4 2026' },
                        { city: 'Winnipeg, MB', pop: '750K', demand: 'Medium', readiness: 15, timeline: 'Q1 2027' },
                        { city: 'Montreal, QC', pop: '1.8M', demand: 'Very High', readiness: 10, timeline: 'Q2 2027' },
                    ].map((city, i) => (
                        <div key={i} style={{ padding: '24px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)' }}>
                            <div style={{ fontWeight: 700, fontSize: '1rem', color: 'var(--pc-text-primary)', marginBottom: '4px' }}>📍 {city.city}</div>
                            <div style={{ fontSize: '0.75rem', color: 'var(--pc-text-tertiary)', marginBottom: '12px' }}>Pop: {city.pop} • Demand: {city.demand}</div>
                            <div style={{ marginBottom: '8px' }}>
                                <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.7rem', marginBottom: '4px' }}>
                                    <span style={{ color: 'var(--pc-text-secondary)' }}>Readiness</span>
                                    <span style={{ fontWeight: 700, color: 'var(--pc-primary)' }}>{city.readiness}%</span>
                                </div>
                                <div style={{ height: '6px', background: 'var(--pc-bg-secondary)', borderRadius: '3px', overflow: 'hidden' }}>
                                    <div style={{ width: `${city.readiness}%`, height: '100%', borderRadius: '3px', background: 'var(--pc-primary)', transition: 'width 0.5s ease' }} />
                                </div>
                            </div>
                            <div style={{ fontSize: '0.7rem', color: 'var(--pc-text-tertiary)' }}>Target: {city.timeline}</div>
                        </div>
                    ))}
                </div>
            )}
        </div>
    );
}
