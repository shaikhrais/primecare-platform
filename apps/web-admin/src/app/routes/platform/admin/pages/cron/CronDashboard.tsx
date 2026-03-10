import React, { useState } from 'react';
import { useNotification } from '@/shared/context/NotificationContext';
import { useTranslation } from 'react-i18next';

export default function CronDashboard() {
    const { showToast } = useNotification();
    const { t } = useTranslation();
    const [jobs] = useState([
        { id: 'compliance-sweep', name: 'Compliance Sweep', description: 'Scans all PSW credentials for expired certifications, licenses, and VSS docs. Auto-generates compliance alerts.', schedule: 'Daily @ 06:00', lastRun: '2026-03-09T06:00:00', status: 'success', duration: '12s' },
        { id: 'training-reminders', name: 'Training Reminders', description: 'Sends reminder notifications to PSWs with overdue or upcoming training module deadlines.', schedule: 'Daily @ 08:00', lastRun: '2026-03-09T08:00:00', status: 'success', duration: '4s' },
        { id: 'auth-exhaustion', name: 'Authorization Exhaustion Check', description: 'Checks clients nearing 80%+ utilization of approved service authorization hours. Creates alerts before exhaustion.', schedule: 'Mon/Wed/Fri @ 07:00', lastRun: '2026-03-07T07:00:00', status: 'success', duration: '8s' },
        { id: 'inventory-reorder', name: 'Inventory Reorder Alerts', description: 'Scans medical supply inventory levels. Generates purchase order suggestions when stock falls below reorder threshold.', schedule: 'Weekly @ Mon 09:00', lastRun: '2026-03-03T09:00:00', status: 'warning', duration: '15s' },
    ]);

    return (
        <div style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }} data-cy="page.container">
            <div style={{ display: 'flex', alignItems: 'center', gap: '16px', marginBottom: '32px' }}>
                <div style={{ backgroundColor: 'var(--brand-50)', padding: '16px', borderRadius: '12px', fontSize: '32px', border: '1px solid var(--brand-100)' }}>⏱️</div>
                <div>
                    <h1 style={{ fontSize: '28px', fontWeight: '800', margin: '0', color: 'var(--text-100)' }} data-cy="page.title">
                        {t('admin.cron_title', { defaultValue: 'Scheduled Jobs Dashboard' })}
                    </h1>
                    <p style={{ color: 'var(--text-300)', margin: '4px 0 0 0' }}>
                        {t('admin.cron_subtitle', { defaultValue: 'Monitor automated cron tasks: compliance sweeps, training reminders, authorization monitoring, and inventory alerts. Powered by Cloudflare Cron Triggers.' })}
                    </p>
                </div>
            </div>

            <div style={{ display: 'grid', gap: '20px' }}>
                {jobs.map(j => (
                    <div key={j.id} className="pc-card" style={{ padding: '24px' }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                            <div>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '6px' }}>
                                    <h3 style={{ fontSize: '18px', fontWeight: '700', margin: '0', color: 'var(--text-100)' }}>{j.name}</h3>
                                    <span style={{ backgroundColor: j.status === 'success' ? '#DCFCE7' : '#FEF3C7', color: j.status === 'success' ? '#15803D' : '#92400E', padding: '2px 10px', borderRadius: '6px', fontSize: '11px', fontWeight: '700' }}>
                                        {j.status === 'success' ? `✅ ${t('admin.healthy', { defaultValue: 'Healthy' })}` : `⚠️ ${t('admin.warning', { defaultValue: 'Warning' })}`}
                                    </span>
                                </div>
                                <p style={{ color: 'var(--text-300)', margin: '0', fontSize: '14px', maxWidth: '700px' }}>{j.description}</p>
                            </div>
                            <button className="btn secondary" data-cy={`btn-run-${j.id}`} onClick={() => showToast(t('admin.job_triggered', { defaultValue: `${j.name} triggered manually`, name: j.name }), 'success')}>▶ {t('admin.run_now', { defaultValue: 'Run Now' })}</button>
                        </div>
                        <div style={{ display: 'flex', gap: '32px', marginTop: '16px', fontSize: '13px', color: 'var(--text-300)' }}>
                            <span><strong>{t('admin.schedule', { defaultValue: 'Schedule' })}:</strong> {j.schedule}</span>
                            <span><strong>{t('admin.last_run', { defaultValue: 'Last Run' })}:</strong> {new Date(j.lastRun).toLocaleString()}</span>
                            <span><strong>{t('admin.duration', { defaultValue: 'Duration' })}:</strong> {j.duration}</span>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
}
