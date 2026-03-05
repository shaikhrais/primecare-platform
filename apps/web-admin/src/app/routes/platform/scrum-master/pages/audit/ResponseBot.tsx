import React, { useState, useEffect } from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { InteractionARegistry } = AdminRegistry;

export default function ResponseBot() {
    const [auditRunning, setAuditRunning] = useState(false);
    const [results, setResults] = useState<any[]>([]);

    const runSweep = () => {
        setAuditRunning(true);
        // Simulate sweep
        setTimeout(() => {
            setResults([
                { id: 1, type: 'BUTTON_REGISTRY', status: 'success', summary: 'All 42 primary buttons active.', issues: 0 },
                { id: 2, type: 'LINK_REGISTRY', status: 'warning', summary: 'Orphan link detected in Marketing.', issues: 1 },
                { id: 3, type: '404_HEARTBEAT', status: 'success', summary: 'Zero 404s detected on public URL.', issues: 0 },
                { id: 4, type: 'SCHEMA_PARITY', status: 'success', summary: 'Prisma model alignment verified.', issues: 0 },
            ]);
            setAuditRunning(false);
        }, 2000);
    };

    const auditAction = InteractionARegistry.find((ia: any) => ia.id === 'ia-sm-response-bot-audit');

    return (
        <div style={{ padding: '24px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div>
                    <h1 style={{ fontSize: '28px', fontWeight: '800', marginBottom: '8px' }}>Response Bot Diagnostic center</h1>
                    <p style={{ color: '#6B7280' }}>Autonomous platform-wide heartbeat and registry integrity verification.</p>
                </div>
                <button
                    onClick={runSweep}
                    disabled={auditRunning}
                    className={`btn ${auditRunning ? 'secondary' : 'primary'}`}
                    data-cy="btn-response-bot-sweep"
                >
                    {auditRunning ? 'Sweeping Platform...' : (auditAction?.label || 'Execute Full Sweep')}
                </button>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '24px', marginBottom: '32px' }}>
                <div className="pc-card" style={{ padding: '24px' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#6B7280' }}>Global Registry Health</div>
                    <div style={{ fontSize: '32px', fontWeight: '800', color: '#10B981', marginTop: '8px' }}>99.9%</div>
                    <p style={{ fontSize: '12px', color: '#6B7280', marginTop: '8px' }}>Measured across 124 active system touchpoints.</p>
                </div>
                <div className="pc-card" style={{ padding: '24px' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#6B7280' }}>Response Sensitivity</div>
                    <div style={{ fontSize: '32px', fontWeight: '800', color: '#111827', marginTop: '8px' }}>120ms</div>
                    <p style={{ fontSize: '12px', color: '#6B7280', marginTop: '8px' }}>Average latency for automated registry repair.</p>
                </div>
            </div>

            <div className="pc-card">
                <div className="pc-card-h">Audit History & Live Feed</div>
                <div className="pc-card-b" style={{ padding: '0' }}>
                    <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead style={{ background: '#F9FAFB', borderBottom: '1px solid #E5E7EB' }}>
                            <tr style={{ textAlign: 'left', color: '#6B7280', fontSize: '12px', textTransform: 'uppercase' }}>
                                <th style={{ padding: '16px' }}>Diagnostic Engine</th>
                                <th style={{ padding: '16px' }}>Status</th>
                                <th style={{ padding: '16px' }}>Summary</th>
                                <th style={{ padding: '16px' }}>Issues</th>
                            </tr>
                        </thead>
                        <tbody>
                            {results.length === 0 ? (
                                <tr>
                                    <td colSpan={4} style={{ padding: '40px', textAlign: 'center', color: '#9CA3AF' }}>
                                        No recent sweep data. Click "Execute Full Sweep" to begin.
                                    </td>
                                </tr>
                            ) : results.map(res => (
                                <tr key={res.id} style={{ borderBottom: '1px solid #F3F4F6' }}>
                                    <td style={{ padding: '16px' }}><strong>{res.type}</strong></td>
                                    <td style={{ padding: '16px' }}>
                                        <span className={`pc-badge ${res.status === 'success' ? 'primary' : 'secondary'}`}>
                                            {res.status.toUpperCase()}
                                        </span>
                                    </td>
                                    <td style={{ padding: '16px', color: '#4B5563' }}>{res.summary}</td>
                                    <td style={{ padding: '16px', fontWeight: 'bold', color: res.issues > 0 ? '#EF4444' : '#10B981' }}>
                                        {res.issues}
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    );
}
