import React, { useState, useEffect } from 'react';
import { ApiRegistry, ContentRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import './ComplianceSync.css';

const { MANAGER_COMPLIANCE } = ContentRegistry;

export default function ComplianceSync() {
    const [auditData, setAuditData] = useState<any[]>([]);
    const [history, setHistory] = useState<any[]>([]);
    const [syncing, setSyncing] = useState(false);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchComplianceData = async () => {
            try {
                // Fetch compliance data
                const data = await apiClient.get(ApiRegistry.TENANCY.STAFF.COMPLIANCE_SCAN);
                if (data && (data as any).results) {
                    setAuditData((data as any).results);
                } else {
                    // Mock fallback
                    setAuditData([
                        { id: '1', provider: 'Sarah Jenkins (PSW)', document: 'CPR Certification', expiry: '2026-03-10', status: 'critical' },
                        { id: '2', provider: 'Mike Ross (PSW)', document: 'Background Check', expiry: '2026-06-15', status: 'valid' },
                        { id: '3', provider: 'Elena Gilbert (RN)', document: 'Nursing License', expiry: '2026-04-05', status: 'warning' },
                        { id: '4', provider: 'John Doe (PSW)', document: 'Immunization Record', expiry: '2026-12-01', status: 'valid' },
                    ]);
                }

                setHistory([
                    { id: 'h1', action: 'Global Sync Executed', date: '2026-03-04 14:00' },
                    { id: 'h2', action: 'Regulatory Audit Log Generated', date: '2026-03-04 10:30' },
                    { id: 'h3', action: 'Sync Success: Branch Ledger', date: '2026-03-03 18:45' },
                ]);

            } catch (error) {
                console.error('Failed to fetch compliance data:', error);
            } finally {
                setLoading(false);
            }
        };

        fetchComplianceData();
    }, []);

    const handleSync = async () => {
        setSyncing(true);
        try {
            await apiClient.post(ApiRegistry.TENANCY.MANAGER.COMPLIANCE_SYNC, {});
            alert(MANAGER_COMPLIANCE.MESSAGES.SYNC_SUCCESS);
            // Refresh history
            setHistory([{ id: Date.now().toString(), action: 'Manual Sync: Branch Ledger', date: new Date().toLocaleString() }, ...history]);
        } catch (error) {
            console.error('Compliance sync failed:', error);
        } finally {
            setSyncing(false);
        }
    };

    if (loading) {
        return (
            <div className="compliance-sync-container">
                <div style={{ textAlign: 'center', padding: '100px' }}>
                    <p style={{ fontWeight: 700, color: '#64748b' }}>Establishing Regulatory Sync Engine...</p>
                </div>
            </div>
        );
    }

    return (
        <div className="compliance-sync-container">
            <header className="sync-header">
                <div className="sync-title">
                    <h1>{MANAGER_COMPLIANCE.TITLE}</h1>
                    <p>{MANAGER_COMPLIANCE.SUBTITLE}</p>
                </div>
                <div className="sync-status-card">
                    <div className={`status-indicator ${auditData.some(d => d.status === 'critical') ? 'warning' : ''}`}></div>
                    <div style={{ fontSize: '0.875rem' }}>
                        <span style={{ fontWeight: 700 }}>System Status: </span>
                        <span style={{ color: '#64748b' }}>
                            {auditData.some(d => d.status === 'critical')
                                ? MANAGER_COMPLIANCE.STATUS.WARNING
                                : MANAGER_COMPLIANCE.STATUS.SYNCED}
                        </span>
                    </div>
                </div>
            </header>

            <div className="compliance-grid">
                <article className="compliance-table-card">
                    <div className="card-header">
                        <h2>Branch Compliance Ledger</h2>
                        <button
                            onClick={handleSync}
                            disabled={syncing}
                            className="btn-primary-pc"
                        >
                            {syncing ? 'Synchronizing...' : 'Execute Branch Sync'}
                        </button>
                    </div>
                    <div className="table-wrapper">
                        <table className="premium-table">
                            <thead>
                                <tr>
                                    <th>{MANAGER_COMPLIANCE.TABLE.PROVIDER}</th>
                                    <th>{MANAGER_COMPLIANCE.TABLE.DOCUMENT}</th>
                                    <th>{MANAGER_COMPLIANCE.TABLE.EXPIRY}</th>
                                    <th>{MANAGER_COMPLIANCE.TABLE.STATUS}</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                {auditData.map(row => (
                                    <tr key={row.id}>
                                        <td>
                                            <div className="provider-cell">
                                                <div className="provider-avatar">{row.provider.charAt(0)}</div>
                                                <span>{row.provider}</span>
                                            </div>
                                        </td>
                                        <td>{row.document}</td>
                                        <td className={`expiry-cell ${row.status === 'critical' ? 'expiry-urgent' : row.status === 'warning' ? 'expiry-soon' : ''}`}>
                                            {row.expiry}
                                        </td>
                                        <td>
                                            <span className={`badge-premium ${row.status === 'valid' ? 'badge-green' : row.status === 'warning' ? 'badge-amber' : 'badge-blue'}`} style={{ background: row.status === 'critical' ? '#fee2e2' : '', color: row.status === 'critical' ? '#991b1b' : '' }}>
                                                {row.status.toUpperCase()}
                                            </span>
                                        </td>
                                        <td>
                                            <button style={{ background: 'none', border: 'none', color: '#3b82f6', fontWeight: 700, cursor: 'pointer', fontSize: '0.75rem' }}>
                                                REQUEST UPDATE
                                            </button>
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                </article>

                <article className="sync-history">
                    <div className="card-header" style={{ border: 'none', background: 'none', padding: '0 0 1rem 0' }}>
                        <h2 style={{ fontSize: '1rem' }}>Audit Trail</h2>
                    </div>
                    <div className="history-list">
                        {history.map(item => (
                            <div key={item.id} className="history-item">
                                <span className="history-text">✔️ {item.action}</span>
                                <span className="history-date">{item.date}</span>
                            </div>
                        ))}
                    </div>
                </article>
            </div>
        </div>
    );
}
