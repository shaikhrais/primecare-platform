// ================================================================
// PAGE IDENTITY: T57 � Session Monitor
// Type: Tool | Owner: admin
// ================================================================
import React from 'react';

export default function SessionMonitor() {
    return (
        <div data-cy="page.container" style={{ padding: '24px' }}>
            <div style={{ marginBottom: '32px' }}>
                <h1 data-cy="page.title" style={{ fontSize: '28px', fontWeight: '800', marginBottom: '8px' }}>Session Monitor</h1>
                <p style={{ color: '#6B7280' }}>Real-time user session status and anomaly detection.</p>
            </div>

            <div className="pc-card">
                <div className="pc-card-h">Authenticated Sessions (Active)</div>
                <div className="pc-card-b">
                    <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead>
                            <tr style={{ textAlign: 'left', color: '#6B7280', fontSize: '12px', textTransform: 'uppercase' }}>
                                <th style={{ padding: '12px' }}>User</th>
                                <th style={{ padding: '12px' }}>Role</th>
                                <th style={{ padding: '12px' }}>Tenant</th>
                                <th style={{ padding: '12px' }}>Device / OS</th>
                                <th style={{ padding: '12px' }}>Login Time</th>
                                <th style={{ padding: '12px' }}>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td style={{ padding: '12px' }}><strong>shaikh.rais</strong></td>
                                <td style={{ padding: '12px' }}><span className="badge primary">ADMIN</span></td>
                                <td style={{ padding: '12px' }}>PrimeCare Global</td>
                                <td style={{ padding: '12px' }}>Chrome / Windows</td>
                                <td style={{ padding: '12px' }}>10m ago</td>
                                <td style={{ padding: '12px' }}><span style={{ color: '#10B981' }}>Active</span></td>
                            </tr>
                            <tr>
                                <td style={{ padding: '12px' }}><strong>staff.jane</strong></td>
                                <td style={{ padding: '12px' }}><span className="badge secondary">STAFF</span></td>
                                <td style={{ padding: '12px' }}>North Branch</td>
                                <td style={{ padding: '12px' }}>Safari / iOS</td>
                                <td style={{ padding: '12px' }}>2h ago</td>
                                <td style={{ padding: '12px' }}><span style={{ color: '#10B981' }}>Active</span></td>
                            </tr>
                            <tr style={{ background: '#FFF7ED' }}>
                                <td style={{ padding: '12px' }}><strong>psw.mike</strong></td>
                                <td style={{ padding: '12px' }}><span className="badge secondary">PSW</span></td>
                                <td style={{ padding: '12px' }}>West Branch</td>
                                <td style={{ padding: '12px' }}>Unknown / Linux</td>
                                <td style={{ padding: '12px' }}>5m ago</td>
                                <td style={{ padding: '12px' }}><span style={{ color: '#F59E0B' }}>Suspicious (IP)</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    );
}
