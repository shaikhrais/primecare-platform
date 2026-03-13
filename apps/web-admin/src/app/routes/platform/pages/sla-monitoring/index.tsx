import React from 'react';

export default function SLAMonitoring() {
    const stats = [
        { label: 'Platform Uptime', value: '99.98%', status: 'healthy', icon: '⚡' },
        { label: 'Avg Latency', value: '142ms', status: 'healthy', icon: '⏱️' },
        { label: 'Compliance Rate', value: '94%', status: 'healthy', icon: '🛡️' },
        { label: 'Breach Forecast', value: 'Low', status: 'increasing', icon: '⚠️' },
    ];

    return (
        <div style={{ padding: '24px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div>
                    <h1 style={{ fontSize: '28px', fontWeight: '800', marginBottom: '8px' }}>SLA Monitoring</h1>
                    <p style={{ color: '#6B7280' }}>Tenant-level performance targets and compliance tracking.</p>
                </div>
                <button data-cy="btn-index-0" className="btn primary">Run Compliance Sweep</button>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))', gap: '20px', marginBottom: '40px' }}>
                {stats.map(s => (
                    <div key={s.label} className="pc-card" style={{ padding: '24px', position: 'relative', overflow: 'hidden' }}>
                        <div style={{ fontSize: '14px', fontWeight: '600', color: '#6B7280', marginBottom: '12px' }}>{s.label}</div>
                        <div style={{ fontSize: '32px', fontWeight: '800', color: '#111827' }}>{s.value}</div>
                        <div style={{ position: 'absolute', right: '-10px', bottom: '-10px', fontSize: '64px', opacity: 0.1 }}>{s.icon}</div>
                    </div>
                ))}
            </div>

            <div className="pc-card">
                <div className="pc-card-h">Tenant SLA Compliance Breakdown</div>
                <div className="pc-card-b">
                    <table data-cy="table-index" style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead>
                            <tr style={{ textAlign: 'left', color: '#6B7280', fontSize: '12px', textTransform: 'uppercase' }}>
                                <th style={{ padding: '12px' }}>Tenant</th>
                                <th style={{ padding: '12px' }}>Tier</th>
                                <th style={{ padding: '12px' }}>Uptime</th>
                                <th style={{ padding: '12px' }}>Response Goal</th>
                                <th style={{ padding: '12px' }}>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td style={{ padding: '12px' }}>PrimeCare Global</td>
                                <td style={{ padding: '12px' }}><span className="badge primary">PLATINUM</span></td>
                                <td style={{ padding: '12px' }}>99.99%</td>
                                <td style={{ padding: '12px' }}>200ms</td>
                                <td style={{ padding: '12px' }}><span style={{ color: '#10B981' }}>Compliant</span></td>
                            </tr>
                            <tr>
                                <td style={{ padding: '12px' }}>North Branch</td>
                                <td style={{ padding: '12px' }}><span className="badge secondary">GOLD</span></td>
                                <td style={{ padding: '12px' }}>99.95%</td>
                                <td style={{ padding: '12px' }}>500ms</td>
                                <td style={{ padding: '12px' }}><span style={{ color: '#10B981' }}>Compliant</span></td>
                            </tr>
                            <tr style={{ background: '#FEF2F2' }}>
                                <td style={{ padding: '12px' }}>Small Clinic Alpha</td>
                                <td style={{ padding: '12px' }}><span className="badge secondary">BRONZE</span></td>
                                <td style={{ padding: '12px' }}>98.2%</td>
                                <td style={{ padding: '12px' }}>2000ms</td>
                                <td style={{ padding: '12px' }}><span style={{ color: '#EF4444' }}>Breached</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    );
}
