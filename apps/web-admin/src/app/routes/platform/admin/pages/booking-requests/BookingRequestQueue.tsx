import React, { useState } from 'react';
import { useNotification } from '@/shared/context/NotificationContext';
import { useTranslation } from 'react-i18next';

export default function BookingRequestQueue() {
    const { showToast } = useNotification();
    const { t } = useTranslation();
    const [requests] = useState([
        { id: '1', clientName: 'Sarah Jenkins', serviceType: 'Personal Care', preferredDate: '2026-03-12', notes: 'Morning preferred', status: 'pending', createdAt: '2026-03-08' },
        { id: '2', clientName: 'Emily Wilson', serviceType: 'Respite Care', preferredDate: '2026-03-15', notes: 'Full day needed — caregiver medical appointment', status: 'pending', createdAt: '2026-03-07' },
        { id: '3', clientName: 'Robert Chen', serviceType: 'Meal Preparation', preferredDate: '2026-03-14', notes: '', status: 'approved', createdAt: '2026-03-06' },
    ]);

    return (
        <div style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }} data-cy="page.container">
            <div style={{ display: 'flex', alignItems: 'center', gap: '16px', marginBottom: '32px' }}>
                <div style={{ backgroundColor: 'var(--brand-50)', padding: '16px', borderRadius: '12px', fontSize: '32px', border: '1px solid var(--brand-100)' }}>📋</div>
                <div>
                    <h1 style={{ fontSize: '28px', fontWeight: '800', margin: '0', color: 'var(--text-100)' }} data-cy="page.title">
                        {t('admin.booking_queue_title', { defaultValue: 'Booking Request Approval Queue' })}
                    </h1>
                    <p style={{ color: 'var(--text-300)', margin: '4px 0 0 0' }}>
                        {t('admin.booking_queue_subtitle', { defaultValue: 'Review client self-service booking requests. Approve to auto-create visits, or reject with reason.' })}
                    </p>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '20px', marginBottom: '32px' }}>
                <div className="pc-card" style={{ padding: '20px' }}><div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>{t('admin.pending_requests', { defaultValue: 'Pending Requests' })}</div><div style={{ fontSize: '28px', fontWeight: '800', color: '#F59E0B', marginTop: '4px' }}>{requests.filter(r => r.status === 'pending').length}</div></div>
                <div className="pc-card" style={{ padding: '20px' }}><div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>{t('admin.approved_this_week', { defaultValue: 'Approved This Week' })}</div><div style={{ fontSize: '28px', fontWeight: '800', color: '#10B981', marginTop: '4px' }}>1</div></div>
                <div className="pc-card" style={{ padding: '20px' }}><div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>{t('admin.total_requests_mtd', { defaultValue: 'Total Requests (MTD)' })}</div><div style={{ fontSize: '28px', fontWeight: '800', color: 'var(--text-100)', marginTop: '4px' }}>{requests.length}</div></div>
            </div>

            <div className="pc-card" style={{ padding: '0', overflow: 'hidden' }}>
                <div className="pc-card-h">{t('admin.booking_requests', { defaultValue: 'Booking Requests' })}</div>
                <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                    <thead style={{ backgroundColor: 'var(--bg-200)', borderBottom: '1px solid var(--border)' }}>
                        <tr>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.client', { defaultValue: 'Client' })}</th>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.service', { defaultValue: 'Service' })}</th>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.preferred_date', { defaultValue: 'Preferred Date' })}</th>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.notes', { defaultValue: 'Notes' })}</th>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.status', { defaultValue: 'Status' })}</th>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>{t('admin.actions', { defaultValue: 'Actions' })}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {requests.map(r => (
                            <tr key={r.id} style={{ borderBottom: '1px solid var(--border)' }}>
                                <td style={{ padding: '16px 24px', fontSize: '14px', fontWeight: '600', color: 'var(--text-100)' }}>{r.clientName}</td>
                                <td style={{ padding: '16px 24px', fontSize: '14px', color: 'var(--text-300)' }}>{r.serviceType}</td>
                                <td style={{ padding: '16px 24px', fontSize: '14px', color: 'var(--text-300)' }}>{r.preferredDate}</td>
                                <td style={{ padding: '16px 24px', fontSize: '13px', color: 'var(--text-300)', maxWidth: '200px' }}>{r.notes || '—'}</td>
                                <td style={{ padding: '16px 24px' }}><span className={`pc-badge ${r.status === 'approved' ? 'primary' : 'secondary'}`}>{r.status === 'approved' ? `✅ ${t('admin.approved', { defaultValue: 'Approved' })}` : `⏳ ${t('admin.pending', { defaultValue: 'Pending' })}`}</span></td>
                                <td style={{ padding: '16px 24px', display: 'flex', gap: '6px' }}>
                                    {r.status === 'pending' && <><button className="btn primary" data-cy={`btn-approve-${r.id}`} style={{ fontSize: '11px', padding: '4px 8px' }} onClick={() => showToast(t('admin.booking_approved_msg', { defaultValue: `Booking request from ${r.clientName} approved`, name: r.clientName }), 'success')}>{t('admin.approve', { defaultValue: 'Approve' })}</button><button className="btn secondary" data-cy={`btn-reject-${r.id}`} style={{ fontSize: '11px', padding: '4px 8px' }} onClick={() => showToast(t('admin.booking_rejected_msg', { defaultValue: `Booking request from ${r.clientName} rejected`, name: r.clientName }), 'warning')}>{t('admin.reject', { defaultValue: 'Reject' })}</button></>}
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
}
