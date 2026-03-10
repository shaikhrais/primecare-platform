import React, { useState, useEffect } from 'react';
import { useNotification } from '@/shared/context/NotificationContext';
import { useTranslation } from 'react-i18next';

export default function PayrollHub() {
    const { showToast } = useNotification();
    const { t } = useTranslation();
    const [timesheets, setTimesheets] = useState<any[]>([]);
    const [summary, setSummary] = useState({ totalHours: 0, totalPayout: 0, approvedCount: 0, pendingCount: 0 });
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        setLoading(true);
        setTimeout(() => {
            setTimesheets([
                { id: '1', pswName: 'Jane Smith', hours: 38.5, rate: 24.50, status: 'approved', weekOf: '2026-W10' },
                { id: '2', pswName: 'Maria Garcia', hours: 42.0, rate: 25.00, status: 'pending', weekOf: '2026-W10' },
                { id: '3', pswName: 'James Wilson', hours: 35.0, rate: 23.00, status: 'pending', weekOf: '2026-W10' },
                { id: '4', pswName: 'Sarah Johnson', hours: 40.0, rate: 26.00, status: 'approved', weekOf: '2026-W10' },
                { id: '5', pswName: 'Robert Chen', hours: 28.0, rate: 24.00, status: 'pending', weekOf: '2026-W10' },
            ]);
            setSummary({ totalHours: 183.5, totalPayout: 4578.00, approvedCount: 2, pendingCount: 3 });
            setLoading(false);
        }, 800);
    }, []);

    return (
        <div style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }} data-cy="page.container">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: 'var(--brand-50)', padding: '16px', borderRadius: '12px', fontSize: '32px', border: '1px solid var(--brand-100)' }}>💰</div>
                    <div>
                        <h1 style={{ fontSize: '28px', fontWeight: '800', margin: '0', color: 'var(--text-100)' }} data-cy="page.title">
                            {t('admin.payroll_title', { defaultValue: 'Payroll Batch Processing' })}
                        </h1>
                        <p style={{ color: 'var(--text-300)', margin: '4px 0 0 0' }}>
                            {t('admin.payroll_subtitle', { defaultValue: 'Approve timesheets in bulk, run payroll batches, and generate payouts for all providers.' })} {t('admin.week', { defaultValue: 'Week' })}: 2026-W10.
                        </p>
                    </div>
                </div>
                <div style={{ display: 'flex', gap: '12px' }}>
                    <button className="btn secondary" data-cy="btn-bulk-approve" onClick={() => showToast(t('admin.bulk_approve_success', { defaultValue: 'All pending timesheets approved' }), 'success')}>✅ {t('admin.bulk_approve_all', { defaultValue: 'Bulk Approve All' })}</button>
                    <button className="btn primary" data-cy="btn-run-payroll" onClick={() => showToast(t('admin.payroll_run_success', { defaultValue: 'Payroll batch initiated for period 2026-W10' }), 'success')}>🚀 {t('admin.run_payroll', { defaultValue: 'Run Payroll' })}</button>
                </div>
            </div>

            {loading ? (
                <div style={{ padding: '64px 0', textAlign: 'center', color: 'var(--text-300)' }}>
                    <div style={{ display: 'inline-block', width: '32px', height: '32px', border: '3px solid var(--brand-100)', borderTopColor: 'var(--brand-500)', borderRadius: '50%', animation: 'spin 1s linear infinite', marginBottom: '16px' }}></div>
                    <style>{`@keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }`}</style>
                    <div>{t('admin.loading_data', { defaultValue: 'Loading secure data...' })}</div>
                </div>
            ) : (
                <>
                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: '20px', marginBottom: '32px' }}>
                        <div className="pc-card" style={{ padding: '20px' }}><div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>{t('admin.total_hours_period', { defaultValue: 'Total Hours (Period)' })}</div><div style={{ fontSize: '28px', fontWeight: '800', color: 'var(--text-100)', marginTop: '4px' }}>{summary.totalHours}h</div></div>
                        <div className="pc-card" style={{ padding: '20px' }}><div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>{t('admin.total_payout', { defaultValue: 'Total Payout' })}</div><div style={{ fontSize: '28px', fontWeight: '800', color: '#10B981', marginTop: '4px' }}>${summary.totalPayout.toLocaleString()}</div></div>
                        <div className="pc-card" style={{ padding: '20px' }}><div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>{t('admin.approved_timesheets', { defaultValue: 'Approved Timesheets' })}</div><div style={{ fontSize: '28px', fontWeight: '800', color: '#10B981', marginTop: '4px' }}>{summary.approvedCount}</div></div>
                        <div className="pc-card" style={{ padding: '20px' }}><div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>{t('admin.pending_approval', { defaultValue: 'Pending Approval' })}</div><div style={{ fontSize: '28px', fontWeight: '800', color: '#F59E0B', marginTop: '4px' }}>{summary.pendingCount}</div></div>
                    </div>

                    <div className="pc-card" style={{ padding: '0', overflow: 'hidden' }}>
                        <div className="pc-card-h">{t('admin.timesheet_approval_queue', { defaultValue: 'Timesheet Approval Queue — Pay Period' })} 2026-W10</div>
                        <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                            <thead style={{ backgroundColor: 'var(--bg-200)', borderBottom: '1px solid var(--border)' }}>
                                <tr>
                                    <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.provider', { defaultValue: 'Provider' })}</th>
                                    <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.hours', { defaultValue: 'Hours' })}</th>
                                    <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.rate', { defaultValue: 'Rate' })}</th>
                                    <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.gross_pay', { defaultValue: 'Gross Pay' })}</th>
                                    <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.status', { defaultValue: 'Status' })}</th>
                                    <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.actions', { defaultValue: 'Actions' })}</th>
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
                                            <span className={`pc-badge ${t.status === 'approved' ? 'primary' : 'secondary'}`}>{t.status === 'approved' ? `✅ ${t('admin.approved', { defaultValue: 'Approved' })}` : `⏳ ${t('admin.pending', { defaultValue: 'Pending' })}`}</span>
                                        </td>
                                        <td style={{ padding: '16px 24px' }}>
                                            {t.status === 'pending' && <button className="btn primary" data-cy={`btn-approve-${t.id}`} style={{ fontSize: '11px', padding: '4px 8px' }} onClick={() => showToast(t('admin.timesheet_approved', { defaultValue: `Timesheet approved for ${t.pswName}`, name: t.pswName }), 'success')}>{t('admin.approve', { defaultValue: 'Approve' })}</button>}
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                </>
            )}
        </div>
    );
}
