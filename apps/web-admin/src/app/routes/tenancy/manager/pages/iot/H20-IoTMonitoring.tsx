// ================================================================
// PAGE IDENTITY: H20 · IoT & Wearable Monitoring — Smart Care
// Type: Hub | Owner: manager
// Models: IoTEvent
// ================================================================
import React, { useState } from 'react';

const devices = [
    { id: 'iot-001', clientName: 'Margaret Chen', device: 'Fall Sensor', battery: 87, status: 'active', lastPing: '2 min ago', signal: 'strong', alerts: 0 },
    { id: 'iot-002', clientName: 'Robert Davies', device: 'BP Monitor', battery: 62, status: 'active', lastPing: '8 min ago', signal: 'good', alerts: 1 },
    { id: 'iot-003', clientName: 'Helen Kowalski', device: 'Glucose Monitor', battery: 45, status: 'warning', lastPing: '23 min ago', signal: 'weak', alerts: 2 },
    { id: 'iot-004', clientName: 'James Morrison', device: 'Motion Sensor', battery: 92, status: 'active', lastPing: '1 min ago', signal: 'strong', alerts: 0 },
    { id: 'iot-005', clientName: 'Yuki Tanaka', device: 'Medication Dispenser', battery: 15, status: 'critical', lastPing: '45 min ago', signal: 'weak', alerts: 3 },
    { id: 'iot-006', clientName: 'Sarah O\'Malley', device: 'Smart Bed Sensor', battery: 78, status: 'active', lastPing: '5 min ago', signal: 'good', alerts: 0 },
];

const recentEvents = [
    { time: '10:42 AM', device: 'Fall Sensor', client: 'Margaret Chen', event: 'Motion detected — normal activity', severity: 'info' },
    { time: '10:38 AM', device: 'BP Monitor', client: 'Robert Davies', event: 'BP reading: 142/88 — elevated', severity: 'warning' },
    { time: '10:25 AM', device: 'Glucose Monitor', client: 'Helen Kowalski', event: 'Glucose: 210 mg/dL — high alert', severity: 'error' },
    { time: '10:15 AM', device: 'Medication Dispenser', client: 'Yuki Tanaka', event: 'Dose missed — 10:00 AM Metformin', severity: 'error' },
    { time: '10:10 AM', device: 'Smart Bed Sensor', client: 'Sarah O\'Malley', event: 'Sleep quality: 7.2/10 — good', severity: 'info' },
    { time: '9:55 AM', device: 'Motion Sensor', client: 'James Morrison', event: 'Morning routine detected — normal', severity: 'info' },
    { time: '9:30 AM', device: 'BP Monitor', client: 'Robert Davies', event: 'BP reading: 138/85 — borderline', severity: 'warning' },
];

export default function IoTMonitoring() {
    const [activeTab, setActiveTab] = useState<'overview' | 'devices' | 'events' | 'alerts'>('overview');
    const statusColor = (s: string) => s === 'active' ? 'var(--pc-success)' : s === 'warning' ? 'var(--pc-warning)' : 'var(--pc-error)';
    const sevColor = (s: string) => s === 'info' ? 'var(--pc-info, #2563EB)' : s === 'warning' ? 'var(--pc-warning)' : 'var(--pc-error)';

    return (
        <div data-cy="page.container" role="main" aria-label="IoT Monitoring" style={{ padding: '24px', maxWidth: '1400px', margin: '0 auto' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px', flexWrap: 'wrap', gap: '16px' }}>
                <div>
                    <h1 data-cy="page.title" style={{ fontSize: '1.75rem', fontWeight: 800, color: 'var(--pc-text-primary)', margin: 0 }}>
                        📡 IoT & Wearable Monitoring
                    </h1>
                    <p style={{ color: 'var(--pc-text-tertiary)', fontSize: '0.85rem', margin: '4px 0 0' }}>
                        Real-time health device monitoring, alerts & predictive insights
                    </p>
                </div>
                <div style={{ display: 'flex', gap: '8px' }}>
                    <span style={{ padding: '6px 14px', borderRadius: '10px', background: 'rgba(5,150,105,0.1)', color: 'var(--pc-success)', fontWeight: 700, fontSize: '0.8rem' }}>
                        ● 4 Active
                    </span>
                    <span style={{ padding: '6px 14px', borderRadius: '10px', background: 'rgba(239,68,68,0.1)', color: 'var(--pc-error)', fontWeight: 700, fontSize: '0.8rem' }}>
                        ⚠ 6 Alerts
                    </span>
                </div>
            </div>

            {/* Stats */}
            <div style={{ display: 'flex', gap: '16px', flexWrap: 'wrap', marginBottom: '24px' }}>
                {[
                    { label: 'Connected Devices', value: '6', icon: '📱', color: 'var(--pc-primary)' },
                    { label: 'Events Today', value: '142', icon: '📊', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Active Alerts', value: '6', icon: '🔔', color: 'var(--pc-error)' },
                    { label: 'Avg Battery', value: '63%', icon: '🔋', color: 'var(--pc-warning)' },
                    { label: 'Uptime', value: '99.2%', icon: '✅', color: 'var(--pc-success)' },
                ].map((s, i) => (
                    <div key={i} style={{
                        flex: '1 1 160px', padding: '20px', borderRadius: '14px',
                        background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)',
                    }}>
                        <div style={{ fontSize: '0.7rem', fontWeight: 600, color: 'var(--pc-text-tertiary)', textTransform: 'uppercase', marginBottom: '6px' }}>
                            {s.icon} {s.label}
                        </div>
                        <div style={{ fontSize: '1.8rem', fontWeight: 800, color: s.color }}>{s.value}</div>
                    </div>
                ))}
            </div>

            {/* Tabs */}
            <div style={{ display: 'flex', gap: '4px', marginBottom: '24px' }}>
                {[
                    { id: 'overview' as const, label: '📊 Overview' },
                    { id: 'devices' as const, label: '📱 Devices' },
                    { id: 'events' as const, label: '📋 Events' },
                    { id: 'alerts' as const, label: '🔔 Alerts' },
                ].map(tab => (
                    <button key={tab.id} onClick={() => setActiveTab(tab.id)} data-cy={`tab-iot-${tab.id}`}
                        style={{
                            padding: '10px 20px', borderRadius: '10px', border: 'none',
                            background: activeTab === tab.id ? 'var(--pc-primary)' : 'var(--pc-bg-secondary)',
                            color: activeTab === tab.id ? 'white' : 'var(--pc-text-secondary)',
                            fontWeight: 700, fontSize: '0.85rem', cursor: 'pointer',
                        }}>{tab.label}</button>
                ))}
            </div>

            {/* Devices Grid */}
            {(activeTab === 'overview' || activeTab === 'devices') && (
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(280px, 1fr))', gap: '16px', marginBottom: '24px' }}>
                    {devices.map(d => (
                        <div key={d.id} style={{
                            padding: '20px', borderRadius: '14px',
                            background: 'var(--pc-surface-card)', border: `1px solid ${d.status === 'critical' ? 'var(--pc-error)' : 'var(--pc-border-primary)'}`,
                            transition: 'transform 0.2s', cursor: 'pointer',
                        }}
                            onMouseEnter={e => e.currentTarget.style.transform = 'translateY(-2px)'}
                            onMouseLeave={e => e.currentTarget.style.transform = 'translateY(0)'}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '12px' }}>
                                <span style={{
                                    padding: '3px 10px', borderRadius: '10px', fontSize: '0.65rem', fontWeight: 700,
                                    color: statusColor(d.status), background: `${statusColor(d.status)}15`,
                                }}>{d.status.toUpperCase()}</span>
                                {d.alerts > 0 && (
                                    <span style={{
                                        padding: '2px 8px', borderRadius: '10px', fontSize: '0.65rem', fontWeight: 700,
                                        background: 'rgba(239,68,68,0.1)', color: 'var(--pc-error)',
                                    }}>⚠ {d.alerts}</span>
                                )}
                            </div>
                            <div style={{ fontWeight: 700, fontSize: '0.95rem', color: 'var(--pc-text-primary)', marginBottom: '4px' }}>{d.device}</div>
                            <div style={{ fontSize: '0.8rem', color: 'var(--pc-text-secondary)', marginBottom: '12px' }}>👤 {d.clientName}</div>
                            <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.7rem', color: 'var(--pc-text-tertiary)' }}>
                                <span>🔋 {d.battery}%</span>
                                <span>📶 {d.signal}</span>
                                <span>🕐 {d.lastPing}</span>
                            </div>
                            {/* Battery bar */}
                            <div style={{ height: '4px', background: 'var(--pc-bg-secondary)', borderRadius: '2px', marginTop: '8px', overflow: 'hidden' }}>
                                <div style={{
                                    width: `${d.battery}%`, height: '100%', borderRadius: '2px',
                                    background: d.battery > 50 ? 'var(--pc-success)' : d.battery > 20 ? 'var(--pc-warning)' : 'var(--pc-error)',
                                }} />
                            </div>
                        </div>
                    ))}
                </div>
            )}

            {/* Events Feed */}
            {(activeTab === 'overview' || activeTab === 'events' || activeTab === 'alerts') && (
                <div style={{ borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)', overflow: 'hidden' }}>
                    <div style={{ padding: '16px 20px', borderBottom: '1px solid var(--pc-border-primary)' }}>
                        <h3 style={{ margin: 0, fontWeight: 700, fontSize: '0.95rem', color: 'var(--pc-text-primary)' }}>
                            {activeTab === 'alerts' ? '🔔 Active Alerts' : '📋 Recent Events'}
                        </h3>
                    </div>
                    {(activeTab === 'alerts' ? recentEvents.filter(e => e.severity !== 'info') : recentEvents).map((e, i) => (
                        <div key={i} style={{
                            display: 'flex', alignItems: 'center', gap: '12px', padding: '14px 20px',
                            borderBottom: '1px solid var(--pc-border-primary)',
                        }}
                            onMouseEnter={ev => ev.currentTarget.style.background = 'var(--pc-bg-secondary)'}
                            onMouseLeave={ev => ev.currentTarget.style.background = 'transparent'}>
                            <span style={{
                                width: '8px', height: '8px', borderRadius: '50%', flexShrink: 0,
                                background: sevColor(e.severity),
                            }} />
                            <div style={{ width: '70px', fontSize: '0.75rem', fontWeight: 600, color: 'var(--pc-text-tertiary)', flexShrink: 0 }}>{e.time}</div>
                            <div style={{ flex: 1 }}>
                                <div style={{ fontSize: '0.85rem', fontWeight: 600, color: 'var(--pc-text-primary)' }}>{e.event}</div>
                                <div style={{ fontSize: '0.7rem', color: 'var(--pc-text-tertiary)' }}>{e.device} • {e.client}</div>
                            </div>
                        </div>
                    ))}
                </div>
            )}
        </div>
    );
}
