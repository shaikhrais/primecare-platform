import React, { useState, useEffect } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { apiClient } from '@/shared/utils/apiClient';

const { ApiRegistry, ButtonRegistry } = AdminRegistry;

export default function RevenueCycleHub() {
    const [claims, setClaims] = useState<any[]>([]);
    const [isLoading, setIsLoading] = useState(true);
    const { showToast } = useNotification();

    const fetchData = async () => {
        setIsLoading(true);
        try {
            const token = localStorage.getItem('token');
            const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:4000';

 // data for demo
            setClaims([
                { id: '1', patient: 'Sarah Jenkins', provider: 'BlueCross', amount: 450.00, status: 'Paid', date: '2026-03-01' },
                { id: '2', patient: 'Robert Chen', provider: 'Aetna', amount: 1200.50, status: 'Pending', date: '2026-03-02' },
                { id: '3', patient: 'Emma Watson', provider: 'UnitedHealth', amount: 85.00, status: 'Denied', reason: 'Missing ICD-10 Code' }
            ]);
        } catch (e) {
            console.error(e);
        } finally {
            setIsLoading(false);
        }
    };

    useEffect(() => { fetchData(); }, []);

    const submitBtn = ButtonRegistry.find((b: any) => b.id === 'btn-rcm-claim-submit');
    const syncBtn = ButtonRegistry.find((b: any) => b.id === 'btn-rcm-revenue-sync');

    return (
        <div style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: 'var(--brand-50)', padding: '16px', borderRadius: '12px', fontSize: '32px', border: '1px solid var(--brand-100)' }}>
                        💵
                    </div>
                    <div>
                        <h1 style={{ fontSize: '28px', fontWeight: '800', margin: '0', color: 'var(--text-100)' }}>Revenue Cycle Management (RCM)</h1>
                        <p style={{ color: 'var(--text-300)', margin: '4px 0 0 0' }}>Manage insurance claims, adjudications, and financial health.</p>
                    </div>
                </div>
                <div style={{ display: 'flex', gap: '12px' }}>
                    <button className="btn secondary" onClick={async () => {
                        try {
                            const res: any = await apiClient.post('/v1/admin/claims/system/sync', {});
                            showToast(res?.message || 'Revenue synced via clearinghouse.', 'success');
                        } catch { showToast('Revenue sync failed.', 'error'); }
                    }}>
                        {syncBtn?.label || 'Sync Revenue'}
                    </button>
                    <button className="btn primary" onClick={async () => {
                        try {
                            const res: any = await apiClient.post('/v1/admin/claims/system/submit', {});
                            showToast(res?.message || 'Claims package aggregated and transmitted.', 'success');
                        } catch { showToast('Claim submission failed.', 'error'); }
                    }}>
                        {submitBtn?.label || 'Submit Claim'}
                    </button>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: '20px', marginBottom: '32px' }}>
                <div className="pc-card" style={{ padding: '20px' }}>
                    <div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>Total Revenue (MTD)</div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: 'var(--text-100)', marginTop: '4px' }}>$142,500</div>
                </div>
                <div className="pc-card" style={{ padding: '20px' }}>
                    <div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>Pending Claims</div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: 'var(--brand-500)', marginTop: '4px' }}>42</div>
                </div>
                <div className="pc-card" style={{ padding: '20px' }}>
                    <div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>Denied Claims</div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: '#EF4444', marginTop: '4px' }}>8</div>
                </div>
                <div className="pc-card" style={{ padding: '20px' }}>
                    <div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>Clean Claim Rate</div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: '#10B981', marginTop: '4px' }}>94.2%</div>
                </div>
            </div>

            <div className="pc-card" style={{ padding: '0', overflow: 'hidden' }}>
                <div className="pc-card-h">Claims Management Ledger</div>
                <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                    <thead style={{ backgroundColor: 'var(--bg-200)', borderBottom: '1px solid var(--border)' }}>
                        <tr>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Patient</th>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Payer</th>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Amount</th>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Status</th>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {claims.map(c => (
                            <tr key={c.id} style={{ borderBottom: '1px solid var(--border)' }}>
                                <td style={{ padding: '16px 24px', fontSize: '14px', fontWeight: '600', color: 'var(--text-100)' }}>{c.patient}</td>
                                <td style={{ padding: '16px 24px', fontSize: '14px', color: 'var(--text-300)' }}>{c.provider}</td>
                                <td style={{ padding: '16px 24px', fontSize: '14px', fontWeight: '800', color: 'var(--text-100)' }}>${c.amount.toFixed(2)}</td>
                                <td style={{ padding: '16px 24px' }}>
                                    <span className={`pc-badge ${c.status === 'Paid' ? 'primary' : c.status === 'Denied' ? 'danger' : 'secondary'}`}>
                                        {c.status}
                                    </span>
                                </td>
                                <td style={{ padding: '16px 24px' }}>
                                    <button className="btn secondary" style={{ padding: '4px 8px', fontSize: '11px' }}>View Details</button>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
}
