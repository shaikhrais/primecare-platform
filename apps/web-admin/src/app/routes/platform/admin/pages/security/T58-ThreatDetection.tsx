// ================================================================
// PAGE IDENTITY: T58 · Threat Detection
// Type: Tool | Owner: admin
// ================================================================
import React from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ButtonRegistry } = AdminRegistry;

export default function ThreatDetection() {
    const scanBtn = ButtonRegistry.find((b: any) => b.id === 'btn-sec-threat-scan');

    return (
        <div style={{ padding: '24px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div>
                    <h1 style={{ fontSize: '28px', fontWeight: '800', marginBottom: '8px' }}>Threat Detection & Response</h1>
                    <p style={{ color: '#6B7280' }}>Real-time anomalous behavior analysis and mitigation.</p>
                </div>
                <button
                    className="btn danger"
                    data-cy="btn-sec-threat-scan"
                >
                    {scanBtn?.label || 'Run Threat Scan'}
                </button>
            </div>

            <div className="pc-card" style={{ marginBottom: '32px' }}>
                <div className="pc-card-h">Live Threat Feed</div>
                <div className="pc-card-b">
                    <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead>
                            <tr style={{ textAlign: 'left', color: '#6B7280', fontSize: '12px', textTransform: 'uppercase' }}>
                                <th style={{ padding: '12px' }}>Severity</th>
                                <th style={{ padding: '12px' }}>Type</th>
                                <th style={{ padding: '12px' }}>Source</th>
                                <th style={{ padding: '12px' }}>Timestamp</th>
                                <th style={{ padding: '12px' }}>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td style={{ padding: '12px' }}><span style={{ color: '#EF4444', fontWeight: 'bold' }}>LOW</span></td>
                                <td style={{ padding: '12px' }}>Invalid Login Attempt</td>
                                <td style={{ padding: '12px' }}>192.168.1.45</td>
                                <td style={{ padding: '12px' }}>2026-03-04 18:42</td>
                                <td style={{ padding: '12px' }}><span className="badge secondary">Blocked</span></td>
                            </tr>
                            <tr>
                                <td style={{ padding: '12px' }}><span style={{ color: '#EF4444', fontWeight: 'bold' }}>LOW</span></td>
                                <td style={{ padding: '12px' }}>CSRF Mismatch</td>
                                <td style={{ padding: '12px' }}>Session-ID: 882x</td>
                                <td style={{ padding: '12px' }}>2026-03-04 15:10</td>
                                <td style={{ padding: '12px' }}><span className="badge secondary">Neutralized</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '24px' }}>
                <div className="pc-card">
                    <div className="pc-card-h">Anomalous Activity Analytics</div>
                    <div className="pc-card-b" style={{ height: '200px', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                        <span style={{ color: '#9CA3AF' }}>[Trend Chart: Blocked Requests]</span>
                    </div>
                </div>
                <div className="pc-card">
                    <div className="pc-card-h">Automatic Mitigation Rules</div>
                    <div className="pc-card-b">
                        <ul style={{ listStyle: 'none', padding: 0, margin: 0, fontSize: '14px', color: '#4B5563' }}>
                            <li style={{ paddingBottom: '12px', borderBottom: '1px solid #F3F4F6', marginBottom: '12px' }}>
                                <strong>Rate Limiting:</strong> Enabled (100 req/min/IP)
                            </li>
                            <li style={{ paddingBottom: '12px', borderBottom: '1px solid #F3F4F6', marginBottom: '12px' }}>
                                <strong>GEO-Blocking:</strong> Active (China, Russia)
                            </li>
                            <li>
                                <strong>WAF Ruleset:</strong> Advanced OWASP Top 10
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    );
}
