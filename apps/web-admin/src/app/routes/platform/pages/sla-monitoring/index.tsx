import React from 'react';

export default function SLAMonitoring() {
    const stats = [
        { label: 'Platform Uptime', value: '99.98%', status: 'healthy' },
        { label: 'Avg latency', value: '142ms', status: 'healthy' },
        { label: 'Error Rate', value: '0.02%', status: 'healthy' },
        { label: 'Active Tenants', value: '1,240', status: 'increasing' },
    ];

    return (
        <div style={{ padding: '24px' }}>
            <div style={{ marginBottom: '32px' }}>
                <h1 style={{ fontSize: '24px', fontWeight: '800', marginBottom: '8px' }}>SLA Monitoring</h1>
                <p style={{ color: '#6B7280' }}>Real-time platform health and performance metrics.</p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))', gap: '20px', marginBottom: '40px' }}>
                {stats.map(s => (
                    <div key={s.label} className="pc-card" style={{ padding: '24px' }}>
                        <div style={{ fontSize: '14px', fontWeight: '600', color: '#6B7280', marginBottom: '12px' }}>{s.label}</div>
                        <div style={{ fontSize: '32px', fontWeight: '800', color: '#111827' }}>{s.value}</div>
                    </div>
                ))}
            </div>

            <div className="pc-card">
                <div className="pc-card-h">System Incidents (Last 30 Days)</div>
                <div className="pc-card-b">
                    <div style={{ textAlign: 'center', padding: '40px', color: '#6B7280' }}>
                        <span style={{ fontSize: '2rem' }}>🌐</span>
                        <p style={{ marginTop: '12px', fontWeight: '600' }}>No incidents reported in the last 30 days.</p>
                    </div>
                </div>
            </div>
        </div>
    );
}
