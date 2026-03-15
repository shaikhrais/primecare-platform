// ================================================================
// PAGE IDENTITY: D4 · EVV Dashboard
// Type: Dashboard | Owner: admin
// ================================================================
import React, { useState } from 'react';

export default function EvvDashboard() {
    const [period, setPeriod] = useState('This Month');
    return (
        <div data-cy="page.container" role="main" aria-label="EVV Dashboard" style={{ padding: '24px', maxWidth: '1400px', margin: '0 auto' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div>
                    <h1 data-cy="page.title" style={{ fontSize: '1.75rem', fontWeight: 800, color: '#0F172A', margin: 0 }}>📍 EVV Dashboard</h1>
                    <p style={{ color: '#94A3B8', fontSize: '0.85rem', margin: '4px 0 0' }}>Real-time overview and key performance indicators</p>
                </div>
                <select data-cy="select-admin.evv-dashboard-0" value={period} onChange={e => setPeriod(e.target.value)} style={{ padding: '8px 16px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '0.85rem' }}>
                    <option>Today</option><option>This Week</option><option>This Month</option><option>This Quarter</option>
                </select>
            </div>
            <div style={{ display: 'flex', gap: '16px', flexWrap: 'wrap', marginBottom: '24px' }}>
                    <div style={{ background: 'white', borderRadius: '12px', padding: '20px', border: '1px solid #E2E8F0', flex: '1 1 200px' }}>
                        <div style={{ fontSize: '0.75rem', fontWeight: 600, color: '#64748B', textTransform: 'uppercase', marginBottom: '8px' }}>Total Visits</div>
                        <div style={{ fontSize: '1.8rem', fontWeight: 800, color: '#0F172A' }}>1,247</div>
                        <div style={{ fontSize: '0.7rem', color: '#059669', fontWeight: 600, marginTop: '4px' }}>↗ +12.5% vs last period</div>
                    </div>
                    <div style={{ background: 'white', borderRadius: '12px', padding: '20px', border: '1px solid #E2E8F0', flex: '1 1 200px' }}>
                        <div style={{ fontSize: '0.75rem', fontWeight: 600, color: '#64748B', textTransform: 'uppercase', marginBottom: '8px' }}>Compliant Visits</div>
                        <div style={{ fontSize: '1.8rem', fontWeight: 800, color: '#0F172A' }}>3,829</div>
                        <div style={{ fontSize: '0.7rem', color: '#059669', fontWeight: 600, marginTop: '4px' }}>↗ +12.5% vs last period</div>
                    </div>
                    <div style={{ background: 'white', borderRadius: '12px', padding: '20px', border: '1px solid #E2E8F0', flex: '1 1 200px' }}>
                        <div style={{ fontSize: '0.75rem', fontWeight: 600, color: '#64748B', textTransform: 'uppercase', marginBottom: '8px' }}>Exceptions</div>
                        <div style={{ fontSize: '1.8rem', fontWeight: 800, color: '#0F172A' }}>94.2%</div>
                        <div style={{ fontSize: '0.7rem', color: '#059669', fontWeight: 600, marginTop: '4px' }}>↗ +12.5% vs last period</div>
                    </div>
                    <div style={{ background: 'white', borderRadius: '12px', padding: '20px', border: '1px solid #E2E8F0', flex: '1 1 200px' }}>
                        <div style={{ fontSize: '0.75rem', fontWeight: 600, color: '#64748B', textTransform: 'uppercase', marginBottom: '8px' }}>Compliance Rate</div>
                        <div style={{ fontSize: '1.8rem', fontWeight: 800, color: '#0F172A' }}>856</div>
                        <div style={{ fontSize: '0.7rem', color: '#059669', fontWeight: 600, marginTop: '4px' }}>↗ +12.5% vs last period</div>
                    </div>
            </div>
            <div style={{ display: 'grid', gridTemplateColumns: '2fr 1fr', gap: '16px' }}>
                <div style={{ background: 'white', borderRadius: '12px', padding: '24px', border: '1px solid #E2E8F0' }}>
                    <h3 data-cy="h3-admin.evv-dashboard-0" style={{ fontSize: '1rem', fontWeight: 700, color: '#0F172A', marginTop: 0 }}>Trend Overview</h3>
                    <div style={{ height: '240px', background: 'linear-gradient(135deg, #05966908 0%, #05966915 100%)', borderRadius: '8px', display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#059669', fontWeight: 600 }}>
                        Chart Area
                    </div>
                </div>
                <div style={{ background: 'white', borderRadius: '12px', padding: '24px', border: '1px solid #E2E8F0' }}>
                    <h3 data-cy="h3-admin.evv-dashboard-1" style={{ fontSize: '1rem', fontWeight: 700, color: '#0F172A', marginTop: 0 }}>Recent Activity</h3>
                    {['2 min ago — New entry recorded', '15 min ago — Status updated', '1 hr ago — Report generated', '3 hrs ago — Alert resolved'].map((a, i) => (
                        <div key={i} style={{ padding: '10px 0', borderBottom: i < 3 ? '1px solid #F1F5F9' : 'none', fontSize: '0.8rem', color: '#475569' }}>{a}</div>
                    ))}
                </div>
            </div>
        </div>
    );
}
