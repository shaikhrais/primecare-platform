// ================================================================
// PAGE IDENTITY: D6 · Platform Health & Observability
// Type: Dashboard | Owner: admin
// ================================================================
import React, { useState } from 'react';
import { useRegistryQuery } from '@/shared/hooks/useRegistryQuery';

const vitals = [
    { key: 'lcp', label: 'Largest Contentful Paint', target: '≤ 2.5s', icon: '🖼️' },
    { key: 'fid', label: 'First Input Delay', target: '≤ 100ms', icon: '👆' },
    { key: 'cls', label: 'Cumulative Layout Shift', target: '≤ 0.1', icon: '📐' },
    { key: 'ttfb', label: 'Time to First Byte', target: '≤ 800ms', icon: '⏱️' },
    { key: 'fcp', label: 'First Contentful Paint', target: '≤ 1.8s', icon: '🎨' },
    { key: 'inp', label: 'Interaction to Next Paint', target: '≤ 200ms', icon: '🖱️' },
];

const apiMetrics = [
    { endpoint: '/v1/auth/login', avgMs: 142, p99Ms: 380, rpm: 45, status: 'healthy' },
    { endpoint: '/v1/manager/schedule', avgMs: 89, p99Ms: 210, rpm: 128, status: 'healthy' },
    { endpoint: '/v1/staff/visits', avgMs: 76, p99Ms: 195, rpm: 230, status: 'healthy' },
    { endpoint: '/v1/billing/invoices', avgMs: 234, p99Ms: 820, rpm: 67, status: 'warning' },
    { endpoint: '/v1/admin/analytics', avgMs: 412, p99Ms: 1200, rpm: 23, status: 'degraded' },
    { endpoint: '/v1/client/family', avgMs: 65, p99Ms: 150, rpm: 34, status: 'healthy' },
    { endpoint: '/v1/system/realtime', avgMs: 12, p99Ms: 35, rpm: 890, status: 'healthy' },
    { endpoint: '/v1/ai/recommendations', avgMs: 567, p99Ms: 2100, rpm: 12, status: 'warning' },
];

const systemHealth = [
    { name: 'Cloudflare Workers', status: 'operational', uptime: '99.97%', icon: '⚡' },
    { name: 'D1 Database', status: 'operational', uptime: '99.95%', icon: '🗄️' },
    { name: 'Durable Objects', status: 'operational', uptime: '99.99%', icon: '🔗' },
    { name: 'R2 Storage', status: 'operational', uptime: '99.99%', icon: '📦' },
    { name: 'Prisma Accelerate', status: 'degraded', uptime: '99.82%', icon: '🚀' },
    { name: 'Firebase Cloud Messaging', status: 'operational', uptime: '99.98%', icon: '🔔' },
];

export default function ObservabilityDashboard() {
    const [activeTab, setActiveTab] = useState<'vitals' | 'api' | 'infra' | 'errors'>('vitals');

    const tabs = [
        { id: 'vitals' as const, label: '📊 Web Vitals' },
        { id: 'api' as const, label: '🌐 API Performance' },
        { id: 'infra' as const, label: '🏗️ Infrastructure' },
        { id: 'errors' as const, label: '🐛 Error Tracking' },
    ];

    const statusColor = (s: string) => {
        if (s === 'healthy' || s === 'operational') return 'var(--pc-success)';
        if (s === 'warning' || s === 'degraded') return 'var(--pc-warning)';
        return 'var(--pc-error)';
    };

    return (
        <div data-cy="page.container" role="main" aria-label="Observability" style={{ padding: '24px', maxWidth: '1400px', margin: '0 auto' }}>
            {/* Header */}
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div>
                    <h1 data-cy="page.title" style={{ fontSize: '1.75rem', fontWeight: 800, color: 'var(--pc-text-primary)', margin: 0 }}>
                        🔭 Platform Observability
                    </h1>
                    <p style={{ color: 'var(--pc-text-tertiary)', fontSize: '0.85rem', margin: '4px 0 0' }}>
                        Real-time health monitoring, performance metrics & error tracking
                    </p>
                </div>
                <div style={{
                    padding: '8px 16px', borderRadius: '20px',
                    background: 'rgba(5,150,105,0.1)', color: 'var(--pc-success)',
                    fontWeight: 700, fontSize: '0.85rem', display: 'flex', alignItems: 'center', gap: '6px',
                }}>
                    <span style={{ width: '8px', height: '8px', borderRadius: '50%', background: 'var(--pc-success)', display: 'inline-block', animation: 'pulse 2s infinite' }} />
                    All Systems Operational
                </div>
            </div>

            {/* Quick stats */}
            <div style={{ display: 'flex', gap: '16px', flexWrap: 'wrap', marginBottom: '24px' }}>
                {[
                    { label: 'Avg Response Time', value: '127ms', trend: '↘ -8%', color: 'var(--pc-success)' },
                    { label: 'Requests/min', value: '1,429', trend: '↗ +12%', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Error Rate', value: '0.03%', trend: '↘ -0.01%', color: 'var(--pc-success)' },
                    { label: 'Active Users', value: '342', trend: '↗ +24', color: 'var(--pc-primary)' },
                    { label: 'Cache Hit Rate', value: '94.7%', trend: '↗ +1.2%', color: 'var(--pc-success)' },
                ].map((stat, i) => (
                    <div key={i} style={{
                        flex: '1 1 180px', padding: '20px', borderRadius: '14px',
                        background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)',
                    }}>
                        <div style={{ fontSize: '0.7rem', fontWeight: 600, color: 'var(--pc-text-tertiary)', textTransform: 'uppercase', marginBottom: '8px' }}>
                            {stat.label}
                        </div>
                        <div style={{ fontSize: '1.8rem', fontWeight: 800, color: 'var(--pc-text-primary)' }}>{stat.value}</div>
                        <div style={{ fontSize: '0.7rem', fontWeight: 700, color: stat.color, marginTop: '4px' }}>{stat.trend}</div>
                    </div>
                ))}
            </div>

            {/* Tab Nav */}
            <div style={{ display: 'flex', gap: '4px', marginBottom: '24px' }}>
                {tabs.map(tab => (
                    <button key={tab.id} onClick={() => setActiveTab(tab.id)} data-cy={`tab-obs-${tab.id}`}
                        style={{
                            padding: '10px 20px', borderRadius: '10px', border: 'none',
                            backgroundColor: activeTab === tab.id ? 'var(--pc-primary)' : 'var(--pc-bg-secondary)',
                            color: activeTab === tab.id ? 'white' : 'var(--pc-text-secondary)',
                            fontWeight: 700, fontSize: '0.85rem', cursor: 'pointer', transition: 'all 0.2s',
                        }}
                    >{tab.label}</button>
                ))}
            </div>

            {/* Web Vitals */}
            {activeTab === 'vitals' && (
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(200px, 1fr))', gap: '16px' }}>
                    {vitals.map((v, i) => {
                        const values = [1.2, 45, 0.05, 320, 0.9, 120];
                        const value = values[i] || 0;
                        const thresholds = [2.5, 100, 0.1, 800, 1.8, 200];
                        const threshold = thresholds[i] || 100;
                        const pct = Math.min(100, (value / threshold) * 100);
                        const isGood = pct <= 75;
                        const isOk = pct <= 100;
                        return (
                            <div key={v.key} style={{
                                padding: '20px', borderRadius: '14px',
                                background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)',
                            }}>
                                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '12px' }}>
                                    <span style={{ fontSize: '1.5rem' }}>{v.icon}</span>
                                    <span style={{
                                        padding: '2px 8px', borderRadius: '10px', fontSize: '0.65rem', fontWeight: 700,
                                        background: isGood ? 'rgba(5,150,105,0.1)' : isOk ? 'rgba(245,158,11,0.1)' : 'rgba(239,68,68,0.1)',
                                        color: isGood ? 'var(--pc-success)' : isOk ? 'var(--pc-warning)' : 'var(--pc-error)',
                                    }}>
                                        {isGood ? 'GOOD' : isOk ? 'NEEDS WORK' : 'POOR'}
                                    </span>
                                </div>
                                <div style={{ fontSize: '0.75rem', fontWeight: 600, color: 'var(--pc-text-secondary)', marginBottom: '4px' }}>{v.label}</div>
                                <div style={{ fontSize: '1.5rem', fontWeight: 800, color: 'var(--pc-text-primary)' }}>
                                    {v.key === 'cls' ? value.toFixed(2) : `${value}${v.key === 'fid' || v.key === 'ttfb' || v.key === 'inp' ? 'ms' : 's'}`}
                                </div>
                                <div style={{ height: '4px', background: 'var(--pc-bg-secondary)', borderRadius: '2px', marginTop: '10px', overflow: 'hidden' }}>
                                    <div style={{
                                        height: '100%', borderRadius: '2px', width: `${pct}%`,
                                        background: isGood ? 'var(--pc-success)' : isOk ? 'var(--pc-warning)' : 'var(--pc-error)',
                                        transition: 'width 1s cubic-bezier(0.2, 0.8, 0.2, 1)',
                                    }} />
                                </div>
                                <div style={{ fontSize: '0.65rem', color: 'var(--pc-text-tertiary)', marginTop: '6px' }}>Target: {v.target}</div>
                            </div>
                        );
                    })}
                </div>
            )}

            {/* API Performance */}
            {activeTab === 'api' && (
                <div style={{ borderRadius: '14px', border: '1px solid var(--pc-border-primary)', overflow: 'hidden' }}>
                    <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead>
                            <tr>
                                {['Endpoint', 'Avg (ms)', 'P99 (ms)', 'RPM', 'Status'].map(h => (
                                    <th key={h} style={{
                                        padding: '12px 16px', textAlign: 'left',
                                        background: 'var(--pc-bg-secondary)', color: 'var(--pc-text-tertiary)',
                                        fontSize: '0.7rem', fontWeight: 700, textTransform: 'uppercase',
                                        borderBottom: '2px solid var(--pc-border-primary)',
                                    }}>{h}</th>
                                ))}
                            </tr>
                        </thead>
                        <tbody>
                            {apiMetrics.map((m, i) => (
                                <tr key={i} style={{ background: 'var(--pc-surface-card)' }}
                                    onMouseEnter={e => e.currentTarget.style.background = 'var(--pc-bg-secondary)'}
                                    onMouseLeave={e => e.currentTarget.style.background = 'var(--pc-surface-card)'}
                                >
                                    <td style={{ padding: '12px 16px', fontWeight: 600, fontSize: '0.85rem', color: 'var(--pc-text-primary)', borderBottom: '1px solid var(--pc-border-primary)', fontFamily: 'monospace' }}>
                                        {m.endpoint}
                                    </td>
                                    <td style={{ padding: '12px 16px', fontSize: '0.85rem', color: m.avgMs > 300 ? 'var(--pc-warning)' : 'var(--pc-text-primary)', fontWeight: 700, borderBottom: '1px solid var(--pc-border-primary)' }}>
                                        {m.avgMs}
                                    </td>
                                    <td style={{ padding: '12px 16px', fontSize: '0.85rem', color: m.p99Ms > 1000 ? 'var(--pc-error)' : 'var(--pc-text-secondary)', borderBottom: '1px solid var(--pc-border-primary)' }}>
                                        {m.p99Ms}
                                    </td>
                                    <td style={{ padding: '12px 16px', fontSize: '0.85rem', color: 'var(--pc-text-secondary)', borderBottom: '1px solid var(--pc-border-primary)' }}>
                                        {m.rpm}
                                    </td>
                                    <td style={{ padding: '12px 16px', borderBottom: '1px solid var(--pc-border-primary)' }}>
                                        <span style={{
                                            padding: '3px 10px', borderRadius: '10px', fontSize: '0.65rem', fontWeight: 700,
                                            color: statusColor(m.status),
                                            background: m.status === 'healthy' ? 'rgba(5,150,105,0.1)' : m.status === 'warning' ? 'rgba(245,158,11,0.1)' : 'rgba(239,68,68,0.1)',
                                        }}>
                                            {m.status.toUpperCase()}
                                        </span>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            )}

            {/* Infrastructure */}
            {activeTab === 'infra' && (
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(250px, 1fr))', gap: '16px' }}>
                    {systemHealth.map((sys, i) => (
                        <div key={i} style={{
                            padding: '24px', borderRadius: '14px',
                            background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)',
                            display: 'flex', alignItems: 'center', gap: '16px',
                        }}>
                            <div style={{ fontSize: '2rem' }}>{sys.icon}</div>
                            <div style={{ flex: 1 }}>
                                <div style={{ fontWeight: 700, fontSize: '0.9rem', color: 'var(--pc-text-primary)' }}>{sys.name}</div>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginTop: '4px' }}>
                                    <span style={{
                                        width: '8px', height: '8px', borderRadius: '50%',
                                        background: statusColor(sys.status), display: 'inline-block',
                                    }} />
                                    <span style={{ fontSize: '0.75rem', fontWeight: 600, color: statusColor(sys.status) }}>
                                        {sys.status.charAt(0).toUpperCase() + sys.status.slice(1)}
                                    </span>
                                </div>
                                <div style={{ fontSize: '0.7rem', color: 'var(--pc-text-tertiary)', marginTop: '4px' }}>
                                    Uptime: {sys.uptime}
                                </div>
                            </div>
                        </div>
                    ))}
                </div>
            )}

            {/* Error Tracking */}
            {activeTab === 'errors' && (
                <div style={{ padding: '24px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)' }}>
                    <h3 style={{ margin: '0 0 16px', fontWeight: 700, color: 'var(--pc-text-primary)' }}>🐛 Recent Errors</h3>
                    {[
                        { time: '2 min ago', msg: 'TypeError: Cannot read "undefined" (billing/InvoiceList)', count: 3, severity: 'warning' },
                        { time: '15 min ago', msg: 'NetworkError: WebSocket disconnected (realtime)', count: 1, severity: 'info' },
                        { time: '1 hr ago', msg: '429 Too Many Requests: /v1/ai/recommendations', count: 12, severity: 'warning' },
                        { time: '3 hrs ago', msg: 'RBAC: Unauthorized access attempt to /admin/users', count: 2, severity: 'error' },
                        { time: '6 hrs ago', msg: 'Prisma: Connection pool exhausted (peak hours)', count: 5, severity: 'error' },
                    ].map((err, i) => (
                        <div key={i} style={{
                            display: 'flex', alignItems: 'center', gap: '12px', padding: '14px',
                            borderBottom: i < 4 ? '1px solid var(--pc-border-primary)' : 'none',
                        }}>
                            <span style={{
                                width: '8px', height: '8px', borderRadius: '50%', flexShrink: 0,
                                background: err.severity === 'error' ? 'var(--pc-error)' : err.severity === 'warning' ? 'var(--pc-warning)' : 'var(--pc-info, #2563EB)',
                            }} />
                            <div style={{ flex: 1 }}>
                                <div style={{ fontSize: '0.85rem', fontWeight: 600, color: 'var(--pc-text-primary)', fontFamily: 'monospace' }}>{err.msg}</div>
                                <div style={{ fontSize: '0.7rem', color: 'var(--pc-text-tertiary)' }}>{err.time} • {err.count} occurrence{err.count > 1 ? 's' : ''}</div>
                            </div>
                        </div>
                    ))}
                </div>
            )}
        </div>
    );
}
