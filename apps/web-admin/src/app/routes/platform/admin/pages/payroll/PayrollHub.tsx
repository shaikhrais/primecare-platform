import React, { useState, useEffect } from 'react';
import { useNotification } from '@/shared/context/NotificationContext';

export default function PayrollHub() {
    const { showToast } = useNotification();
    const [timesheets, setTimesheets] = useState<any[]>([]);
    const [summary, setSummary] = useState({ totalHours: 0, totalPayout: 0, approvedCount: 0, pendingCount: 0 });

    useEffect(() => {
        setTimesheets([
            { id: '1', pswName: 'Jane Smith', hours: 38.5, rate: 24.50, status: 'approved', weekOf: '2026-W10' },
            { id: '2', pswName: 'Maria Garcia', hours: 42.0, rate: 25.00, status: 'pending', weekOf: '2026-W10' },
            { id: '3', pswName: 'James Wilson', hours: 35.0, rate: 23.00, status: 'pending', weekOf: '2026-W10' },
            { id: '4', pswName: 'Sarah Johnson', hours: 40.0, rate: 26.00, status: 'approved', weekOf: '2026-W10' },
            { id: '5', pswName: 'Robert Chen', hours: 28.0, rate: 24.00, status: 'pending', weekOf: '2026-W10' },
        ]);
        setSummary({ totalHours: 183.5, totalPayout: 4578.00, approvedCount: 2, pendingCount: 3 });
    }, []);

    return (
        <div style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }} data-cy="page.container">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: 'var(--brand-50)', padding: '16px', borderRadius: '12px', fontSize: '32px', border: '1px solid var(--brand-100)' }}>💰</div>
                    <div>
                        <h1 style={{ fontSize: '28px', fontWeight: '800', margin: '0', color: 'var(--text-100)' }} data-cy="page.title">Payroll Batch Processing</h1>
                        <p style={{ color: 'var(--text-300)', margin: '4px 0 0 0' }}>Approve timesheets in bulk, run payroll batches, and generate payouts for all providers. Week: 2026-W10.</p>
                    </div>
                </div>
                <div style={{ display: 'flex', gap: '12px' }}>
                    <button className="btn secondary" data-cy="btn-bulk-approve" onClick={() => showToast('All pending timesheets approved', 'success')}>✅ Bulk Approve All</button>
                    <button className="btn primary" data-cy="btn-run-payroll" onClick={() => showToast('Payroll batch initiated for period 2026-W10', 'success')}>🚀 Run Payroll</button>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: '20px', marginBottom: '32px' }}>
                <div className="pc-card" style={{ padding: '20px' }}><div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>Total Hours (Period)</div><div style={{ fontSize: '28px', fontWeight: '800', color: 'var(--text-100)', marginTop: '4px' }}>{summary.totalHours}h</div></div>
                <div className="pc-card" style={{ padding: '20px' }}><div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>Total Payout</div><div style={{ fontSize: '28px', fontWeight: '800', color: '#10B981', marginTop: '4px' }}>${summary.totalPayout.toLocaleString()}</div></div>
                <div className="pc-card" style={{ padding: '20px' }}><div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>Approved Timesheets</div><div style={{ fontSize: '28px', fontWeight: '800', color: '#10B981', marginTop: '4px' }}>{summary.approvedCount}</div></div>
                <div className="pc-card" style={{ padding: '20px' }}><div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>Pending Approval</div><div style={{ fontSize: '28px', fontWeight: '800', color: '#F59E0B', marginTop: '4px' }}>{summary.pendingCount}</div></div>
            </div>

            <div className="pc-card" style={{ padding: '0', overflow: 'hidden' }}>
                <div className="pc-card-h">Timesheet Approval Queue — Pay Period 2026-W10</div>
                <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                    <thead style={{ backgroundColor: 'var(--bg-200)', borderBottom: '1px solid var(--border)' }}>
                        <tr>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Provider</th>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Hours</th>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Rate</th>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Gross Pay</th>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Status</th>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {timesheets.map(t => (
                            <tr key={t.id} style={{ borderBottom: '1px solid var(--border)' }}>
                                <td style={{ padding: '16px 24px', fontSize: '14px', fontWeight: '600', color: 'var(--text-100)' }}>{t.pswName}</td>
                                <td style={{ padding: '16px 24px', fontSize: '14px', color: 'var(--text-300)' }}>{t.hours}h</td>
                                <td style={{ padding: '16px 24px', fontSize: '14px', color: 'var(--text-300)' }}>${t.rate.toFixed(2)}/hr</td>
                                <td style={{ padding: '16px 24px', fontSize: '14px', fontWeight: '800', color: 'var(--text-100)' }}>${(t.hours * t.rate).toFixed(2)}</td>
                                <td style={{ padding: '16px 24px' }}>
                                    <span className={`pc-badge ${t.status === 'approved' ? 'primary' : 'secondary'}`}>{t.status === 'approved' ? '✅ Approved' : '⏳ Pending'}</span>
                                </td>
                                <td style={{ padding: '16px 24px' }}>
                                    {t.status === 'pending' && <button className="btn primary" data-cy={`btn-approve-${t.id}`} style={{ fontSize: '11px', padding: '4px 8px' }} onClick={() => showToast(`Timesheet approved for ${t.pswName}`, 'success')}>Approve</button>}
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
}
