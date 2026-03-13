import React from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry, ButtonRegistry } = AdminRegistry;

export default function SecurityDashboard() {
    const flushBtn = getButtonById('btn-sec-session-flush');

    return (
        <div data-cy="page.container" style={{ padding: '24px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div>
                    <h1 data-cy="page.title" style={{ fontSize: '28px', fontWeight: '800', marginBottom: '8px' }}>Security & Sovereignty</h1>
                    <p style={{ color: '#6B7280' }}>Platform-wide threat intelligence and session governance.</p>
                </div>
                <button
                    className="btn secondary"
                    data-cy="btn-sec-session-flush"
                >
                    {flushBtn?.label || 'Flush Sessions'}
                </button>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))', gap: '20px', marginBottom: '32px' }}>
                <div className="pc-card" style={{ borderLeft: '4px solid #EF4444', padding: '24px' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#6B7280' }}>Active Threats</div>
                    <div style={{ fontSize: '32px', fontWeight: '800', color: '#B91C1C' }}>0</div>
                    <p style={{ fontSize: '12px', color: '#6B7280', marginTop: '8px' }}>No critical vulnerabilities detected in the last 24h.</p>
                </div>
                <div className="pc-card" style={{ borderLeft: '4px solid #3B82F6', padding: '24px' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#6B7280' }}>Global Sessions</div>
                    <div style={{ fontSize: '32px', fontWeight: '800', color: '#111827' }}>142</div>
                    <p style={{ fontSize: '12px', color: '#6B7280', marginTop: '8px' }}>Total authenticated users across all tenants.</p>
                </div>
                <div className="pc-card" style={{ borderLeft: '4px solid #10B981', padding: '24px' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#6B7280' }}>Crypto Health</div>
                    <div style={{ fontSize: '32px', fontWeight: '800', color: '#059669' }}>99.9%</div>
                    <p style={{ fontSize: '12px', color: '#6B7280', marginTop: '8px' }}>Integrity coverage for encrypted PHI storage.</p>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '24px' }}>
                <div className="pc-card">
                    <div className="pc-card-h">Geographical Access Map</div>
                    <div className="pc-card-b" style={{ height: '300px', background: '#F9FAFB', display: 'flex', alignItems: 'center', justifyContent: 'center', borderRadius: '12px' }}>
                        <span style={{ color: '#9CA3AF', fontSize: '14px' }}>[Interactive Map: Login Origins]</span>
                    </div>
                </div>
                <div className="pc-card">
                    <div className="pc-card-h">Security Audit Stream</div>
                    <div className="pc-card-b">
                        <div style={{ display: 'grid', gap: '12px' }}>
                            <div style={{ padding: '12px', background: '#F3F4F6', borderRadius: '8px', borderLeft: '4px solid #3B82F6' }}>
                                <div style={{ fontSize: '13px', fontWeight: 'bold' }}>Root Password Change</div>
                                <p style={{ fontSize: '12px', color: '#6B7280' }}>Admin @ HQ • 10 minutes ago</p>
                            </div>
                            <div style={{ padding: '12px', background: '#F3F4F6', borderRadius: '8px', borderLeft: '4px solid #3B82F6' }}>
                                <div style={{ fontSize: '13px', fontWeight: 'bold' }}>New API Key Provisioned</div>
                                <p style={{ fontSize: '12px', color: '#6B7280' }}>System • 2 hours ago</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}
