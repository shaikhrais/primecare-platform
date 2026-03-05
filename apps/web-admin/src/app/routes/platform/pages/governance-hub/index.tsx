import React from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ButtonRegistry } = AdminRegistry;

export default function GovernanceHub() {
    const healthBtn = ButtonRegistry.find((b: any) => b.id === 'btn-sup-health-refresh');
    const policyBtn = ButtonRegistry.find((b: any) => b.id === 'btn-sup-policy-push');

    return (
        <div style={{ padding: '24px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div>
                    <h1 style={{ fontSize: '28px', fontWeight: '800', marginBottom: '8px' }}>Global Governance Hub</h1>
                    <p style={{ color: '#6B7280' }}>Platform-wide policy enforcement and multi-tenant oversight.</p>
                </div>
                <div style={{ display: 'flex', gap: '12px' }}>
                    <button className="btn secondary" data-cy="btn-sup-health-refresh">
                        {healthBtn?.label || 'Refresh Health'}
                    </button>
                    <button className="btn primary" data-cy="btn-sup-policy-push">
                        {policyBtn?.label || 'Push Policies'}
                    </button>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '24px', marginBottom: '32px' }}>
                <div className="pc-card" style={{ padding: '24px' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#6B7280' }}>Global Compliance Score</div>
                    <div style={{ fontSize: '32px', fontWeight: '800', color: '#10B981', marginTop: '8px' }}>98.4%</div>
                    <p style={{ fontSize: '12px', color: '#6B7280', marginTop: '8px' }}>Across 1,240 active tenants and 42 regions.</p>
                </div>
                <div className="pc-card" style={{ padding: '24px' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#6B7280' }}>Active Policy Blocks</div>
                    <div style={{ fontSize: '32px', fontWeight: '800', color: '#111827', marginTop: '8px' }}>12</div>
                    <p style={{ fontSize: '12px', color: '#6B7280', marginTop: '8px' }}>Core clinical and billing protocols currently enforced.</p>
                </div>
            </div>

            <div className="pc-card">
                <div className="pc-card-h">Infrastructure & Tenant Health</div>
                <div className="pc-card-b">
                    <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead>
                            <tr style={{ textAlign: 'left', color: '#6B7280', fontSize: '12px', textTransform: 'uppercase' }}>
                                <th style={{ padding: '12px' }}>Regime / Cluster</th>
                                <th style={{ padding: '12px' }}>Tenants</th>
                                <th style={{ padding: '12px' }}>SLA Status</th>
                                <th style={{ padding: '12px' }}>Latency</th>
                                <th style={{ padding: '12px' }}>Governance Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td style={{ padding: '12px' }}><strong>US-EAST-01</strong></td>
                                <td style={{ padding: '12px' }}>412</td>
                                <td style={{ padding: '12px' }}><span style={{ color: '#10B981' }}>99.99%</span></td>
                                <td style={{ padding: '12px' }}>42ms</td>
                                <td style={{ padding: '12px' }}><span className="badge primary">Protected</span></td>
                            </tr>
                            <tr>
                                <td style={{ padding: '12px' }}><strong>CA-CENTRAL-01</strong></td>
                                <td style={{ padding: '12px' }}>328</td>
                                <td style={{ padding: '12px' }}><span style={{ color: '#10B981' }}>99.98%</span></td>
                                <td style={{ padding: '12px' }}>38ms</td>
                                <td style={{ padding: '12px' }}><span className="badge primary">Protected</span></td>
                            </tr>
                            <tr style={{ background: '#FFF7ED' }}>
                                <td style={{ padding: '12px' }}><strong>EU-WEST-01</strong></td>
                                <td style={{ padding: '12px' }}>500</td>
                                <td style={{ padding: '12px' }}><span style={{ color: '#F59E0B' }}>99.92%</span></td>
                                <td style={{ padding: '12px' }}>112ms</td>
                                <td style={{ padding: '12px' }}><span className="badge secondary">Policy Warning</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    );
}
