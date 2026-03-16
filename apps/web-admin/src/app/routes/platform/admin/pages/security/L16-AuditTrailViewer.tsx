// ================================================================
// PAGE IDENTITY: L16 · Audit Trail Viewer
// Type: List | Owner: admin
// Models: AuditLog
// ================================================================
import React, { useState } from 'react';

const auditEntries = [
    { id: 'aud-001', timestamp: '2026-03-16 16:42:18', actor: 'admin@primecare.ca', action: 'UPDATE', resource: 'User/PSW-045', details: 'Role changed from psw to rn', ip: '198.51.100.23', severity: 'high' },
    { id: 'aud-002', timestamp: '2026-03-16 16:38:05', actor: 'sarah.mgr@primecare.ca', action: 'CREATE', resource: 'Visit/V-2847', details: 'New visit assigned: Priya Sharma → Margaret Chen', ip: '203.0.113.42', severity: 'info' },
    { id: 'aud-003', timestamp: '2026-03-16 16:35:22', actor: 'system', action: 'DELETE', resource: 'Session/S-expired-batch', details: 'Purged 23 expired sessions (cron job)', ip: '10.0.0.1', severity: 'info' },
    { id: 'aud-004', timestamp: '2026-03-16 16:30:48', actor: 'kevin.psw@primecare.ca', action: 'AUTH_FAIL', resource: 'Auth/Login', details: 'Failed login attempt (wrong password)', ip: '72.134.215.90', severity: 'warning' },
    { id: 'aud-005', timestamp: '2026-03-16 16:25:11', actor: 'admin@primecare.ca', action: 'UPDATE', resource: 'Tenant/T-001', details: 'Feature flag "telehealth" enabled', ip: '198.51.100.23', severity: 'high' },
    { id: 'aud-006', timestamp: '2026-03-16 16:20:03', actor: 'finance@primecare.ca', action: 'EXPORT', resource: 'Invoice/batch-march', details: 'Exported 47 invoices to CSV', ip: '198.51.100.25', severity: 'info' },
    { id: 'aud-007', timestamp: '2026-03-16 16:15:55', actor: 'admin@primecare.ca', action: 'DELETE', resource: 'User/PSW-012', details: 'Deactivated user account (termination)', ip: '198.51.100.23', severity: 'critical' },
    { id: 'aud-008', timestamp: '2026-03-16 16:10:30', actor: 'system', action: 'BACKUP', resource: 'Database/D1-primary', details: 'Automated daily backup completed (245MB)', ip: '10.0.0.1', severity: 'info' },
    { id: 'aud-009', timestamp: '2026-03-16 16:05:18', actor: 'unknown', action: 'AUTH_FAIL', resource: 'Auth/Login', details: 'Brute force detected: 15 attempts in 60s. IP blocked.', ip: '185.220.101.42', severity: 'critical' },
    { id: 'aud-010', timestamp: '2026-03-16 16:00:00', actor: 'sarah.mgr@primecare.ca', action: 'UPDATE', resource: 'Schedule/W-2026-12', details: 'Modified 8 shifts for next week', ip: '203.0.113.42', severity: 'info' },
];

const actionColors: Record<string, string> = {
    CREATE: 'var(--pc-success)', UPDATE: 'var(--pc-info, #2563EB)', DELETE: 'var(--pc-error)',
    AUTH_FAIL: 'var(--pc-warning)', EXPORT: '#7C3AED', BACKUP: 'var(--pc-text-tertiary)',
};

const severityDot = (s: string) => s === 'critical' ? 'var(--pc-error)' : s === 'high' ? 'var(--pc-warning)' : s === 'warning' ? '#F59E0B' : 'var(--pc-text-tertiary)';

export default function AuditTrailViewer() {
    const [filterAction, setFilterAction] = useState<string>('all');
    const [filterSeverity, setFilterSeverity] = useState<string>('all');

    const filtered = auditEntries.filter(e =>
        (filterAction === 'all' || e.action === filterAction) &&
        (filterSeverity === 'all' || e.severity === filterSeverity)
    );

    return (
        <div data-cy="page.container" role="main" aria-label="Audit Trail" style={{ padding: '24px', maxWidth: '1400px', margin: '0 auto' }}>
            <div style={{ marginBottom: '24px' }}>
                <h1 data-cy="page.title" style={{ fontSize: '1.75rem', fontWeight: 800, color: 'var(--pc-text-primary)', margin: 0 }}>🔍 Audit Trail</h1>
                <p style={{ color: 'var(--pc-text-tertiary)', fontSize: '0.85rem', margin: '4px 0 0' }}>
                    Complete system activity log — who did what, when, and from where
                </p>
            </div>

            {/* Stats */}
            <div style={{ display: 'flex', gap: '16px', flexWrap: 'wrap', marginBottom: '24px' }}>
                {[
                    { label: 'Total Events', value: '10', color: 'var(--pc-primary)' },
                    { label: 'Critical', value: '2', color: 'var(--pc-error)' },
                    { label: 'Auth Failures', value: '2', color: 'var(--pc-warning)' },
                    { label: 'Unique Actors', value: '5', color: 'var(--pc-info, #2563EB)' },
                ].map((s, i) => (
                    <div key={i} style={{ flex: '1 1 140px', padding: '18px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)' }}>
                        <div style={{ fontSize: '0.65rem', fontWeight: 600, color: 'var(--pc-text-tertiary)', textTransform: 'uppercase', marginBottom: '4px' }}>{s.label}</div>
                        <div style={{ fontSize: '1.6rem', fontWeight: 800, color: s.color }}>{s.value}</div>
                    </div>
                ))}
            </div>

            {/* Filters */}
            <div style={{ display: 'flex', gap: '12px', marginBottom: '20px', flexWrap: 'wrap' }}>
                <select value={filterAction} onChange={e => setFilterAction(e.target.value)} style={{
                    padding: '8px 14px', borderRadius: '10px', border: '1px solid var(--pc-border-primary)',
                    background: 'var(--pc-bg-secondary)', color: 'var(--pc-text-primary)', fontWeight: 700, fontSize: '0.8rem',
                }}>
                    <option value="all">All Actions</option>
                    {['CREATE', 'UPDATE', 'DELETE', 'AUTH_FAIL', 'EXPORT', 'BACKUP'].map(a => <option key={a} value={a}>{a}</option>)}
                </select>
                <select value={filterSeverity} onChange={e => setFilterSeverity(e.target.value)} style={{
                    padding: '8px 14px', borderRadius: '10px', border: '1px solid var(--pc-border-primary)',
                    background: 'var(--pc-bg-secondary)', color: 'var(--pc-text-primary)', fontWeight: 700, fontSize: '0.8rem',
                }}>
                    <option value="all">All Severity</option>
                    {['critical', 'high', 'warning', 'info'].map(s => <option key={s} value={s}>{s}</option>)}
                </select>
                <span style={{ fontSize: '0.8rem', color: 'var(--pc-text-tertiary)', alignSelf: 'center' }}>
                    Showing {filtered.length} of {auditEntries.length}
                </span>
            </div>

            {/* Audit Log */}
            <div style={{ borderRadius: '14px', border: '1px solid var(--pc-border-primary)', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                    <thead><tr>{['', 'Timestamp', 'Actor', 'Action', 'Resource', 'Details', 'IP'].map(h => (
                        <th key={h} style={{ padding: '10px 12px', textAlign: 'left', background: 'var(--pc-bg-secondary)', color: 'var(--pc-text-tertiary)', fontSize: '0.65rem', fontWeight: 700, textTransform: 'uppercase', borderBottom: '2px solid var(--pc-border-primary)', whiteSpace: 'nowrap' }}>{h}</th>
                    ))}</tr></thead>
                    <tbody>{filtered.map(e => (
                        <tr key={e.id} style={{ background: e.severity === 'critical' ? 'rgba(239,68,68,0.03)' : 'var(--pc-surface-card)' }}
                            onMouseEnter={ev => ev.currentTarget.style.background = 'var(--pc-bg-secondary)'}
                            onMouseLeave={ev => ev.currentTarget.style.background = e.severity === 'critical' ? 'rgba(239,68,68,0.03)' : 'var(--pc-surface-card)'}>
                            <td style={{ padding: '10px 12px', borderBottom: '1px solid var(--pc-border-primary)', textAlign: 'center' }}>
                                <span style={{ display: 'inline-block', width: '8px', height: '8px', borderRadius: '50%', background: severityDot(e.severity) }} />
                            </td>
                            <td style={{ padding: '10px 12px', fontFamily: 'monospace', fontSize: '0.75rem', color: 'var(--pc-text-secondary)', borderBottom: '1px solid var(--pc-border-primary)', whiteSpace: 'nowrap' }}>{e.timestamp}</td>
                            <td style={{ padding: '10px 12px', fontWeight: 600, fontSize: '0.8rem', color: e.actor === 'system' || e.actor === 'unknown' ? 'var(--pc-text-tertiary)' : 'var(--pc-text-primary)', borderBottom: '1px solid var(--pc-border-primary)' }}>{e.actor}</td>
                            <td style={{ padding: '10px 12px', borderBottom: '1px solid var(--pc-border-primary)' }}>
                                <span style={{ padding: '2px 8px', borderRadius: '8px', fontSize: '0.6rem', fontWeight: 800, color: actionColors[e.action] || 'var(--pc-text-secondary)', background: `${actionColors[e.action] || 'var(--pc-text-secondary)'}15` }}>{e.action}</span>
                            </td>
                            <td style={{ padding: '10px 12px', fontFamily: 'monospace', fontSize: '0.75rem', color: 'var(--pc-primary)', fontWeight: 600, borderBottom: '1px solid var(--pc-border-primary)' }}>{e.resource}</td>
                            <td style={{ padding: '10px 12px', fontSize: '0.8rem', color: 'var(--pc-text-secondary)', borderBottom: '1px solid var(--pc-border-primary)', maxWidth: '300px' }}>{e.details}</td>
                            <td style={{ padding: '10px 12px', fontFamily: 'monospace', fontSize: '0.7rem', color: 'var(--pc-text-tertiary)', borderBottom: '1px solid var(--pc-border-primary)' }}>{e.ip}</td>
                        </tr>
                    ))}</tbody>
                </table>
            </div>
        </div>
    );
}
