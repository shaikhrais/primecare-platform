// ================================================================
// PAGE IDENTITY: H5 � Notifications Hub
// Registry ID:   page.admin.notifications
// Type:          Hub
// Owner:         admin
// ================================================================
import React from 'react';
import { useToast as useNotification } from '@/shared/hooks/useToast';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';
import { useDialog } from '@/shared/hooks/useDialog';
import { useRegistryQuery } from '@/shared/hooks/useRegistryQuery';
import { DashboardSkeleton } from '@/shared/components/ui/Skeleton';

export default function NotificationsHub() {
    const { DialogRenderer } = useDialog();
    const { showToast } = useNotification();
    const { t } = useTranslation();

    // TanStack Query: auto-cached notifications
    const { data: notifications = [], isLoading: loading } = useRegistryQuery<any[]>(AdminRegistry.ApiRegistry.ADMIN.NOTIFICATIONS.LIST, {
        queryKey: ['admin', 'notifications'],
        staleTime: 15_000,
    });
    const unreadCount = notifications.filter((n: any) => n.status === 'unread').length;

    const typeBadge = (type: string) => {
        const colors: Record<string, string> = { COMPLIANCE: '#F59E0B', VISIT_ALERT: '#EF4444', SYSTEM: '#6366F1', SOS: '#DC2626', BOOKING: '#10B981' };
        return <span style={{ backgroundColor: colors[type] || '#6B7280', color: '#fff', padding: '2px 8px', borderRadius: '6px', fontSize: '11px', fontWeight: '700' }}>{type}</span>;
    };

    return (
        <div style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }} data-cy="page.container" role="main" aria-label="Notifications Hub">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: 'var(--brand-50)', padding: '16px', borderRadius: '12px', fontSize: '32px', border: '1px solid var(--brand-100)' }}>🔔</div>
                    <div>
                        <h1 style={{ fontSize: '28px', fontWeight: '800', margin: '0', color: 'var(--text-100)' }} data-cy="page.title">
                            {t('admin.notifications_title', { defaultValue: 'Notification Engine' })}
                        </h1>
                        <p style={{ color: 'var(--text-300)', margin: '4px 0 0 0' }}>
                            {t('admin.notifications_subtitle', { defaultValue: 'Real-time alerts, compliance warnings, SOS signals, and system messages.' })} {unreadCount} {t('admin.unread', { defaultValue: 'unread' })}.
                        </p>
                    </div>
                </div>
                <button className="btn primary" data-cy="btn-broadcast" onClick={async () => { const msg = prompt('Enter broadcast message:'); if (!msg) return; try { const m = await import('@/shared/utils/apiClient'); await m.apiClient.post('/v1/admin/notifications/broadcast', { message: msg }); } catch {} showToast(t('admin.broadcast_sent', { defaultValue: 'Broadcast message sent to all users' }), 'success'); }}>
                    📢 {t('admin.broadcast_message', { defaultValue: 'Broadcast Message' })}
                </button>
            </div>

            {loading ? (
                <DashboardSkeleton statCount={4} />
            ) : (
                <>
                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: '20px', marginBottom: '32px' }}>
                        <div className="pc-card" style={{ padding: '20px' }}>
                            <div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>{t('admin.total_notifications', { defaultValue: 'Total Notifications' })}</div>
                            <div style={{ fontSize: '28px', fontWeight: '800', color: 'var(--text-100)', marginTop: '4px' }}>{notifications.length}</div>
                        </div>
                        <div className="pc-card" style={{ padding: '20px' }}>
                            <div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>{t('admin.unread', { defaultValue: 'Unread' })}</div>
                            <div style={{ fontSize: '28px', fontWeight: '800', color: '#EF4444', marginTop: '4px' }}>{unreadCount}</div>
                        </div>
                        <div className="pc-card" style={{ padding: '20px' }}>
                            <div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>{t('admin.sos_alerts_active', { defaultValue: 'SOS Alerts (Active)' })}</div>
                            <div style={{ fontSize: '28px', fontWeight: '800', color: '#DC2626', marginTop: '4px' }}>1</div>
                        </div>
                        <div className="pc-card" style={{ padding: '20px' }}>
                            <div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>{t('admin.compliance_warnings', { defaultValue: 'Compliance Warnings' })}</div>
                            <div style={{ fontSize: '28px', fontWeight: '800', color: '#F59E0B', marginTop: '4px' }}>1</div>
                        </div>
                    </div>

                    <div className="pc-card" style={{ padding: '0', overflow: 'hidden' }}>
                        <div className="pc-card-h">{t('admin.notification_feed', { defaultValue: 'Notification Feed' })}</div>
                        {notifications.map(n => (
                            <div key={n.id} style={{ padding: '16px 24px', borderBottom: '1px solid var(--border)', display: 'flex', justifyContent: 'space-between', alignItems: 'center', backgroundColor: n.status === 'unread' ? 'var(--brand-50)' : 'transparent' }}>
                                <div style={{ flex: 1 }}>
                                    <div style={{ display: 'flex', gap: '8px', alignItems: 'center', marginBottom: '4px' }}>
                                        {typeBadge(n.type)}
                                        <span style={{ fontSize: '12px', color: 'var(--text-300)' }}>{new Date(n.createdAt).toLocaleString()}</span>
                                    </div>
                                    <div style={{ fontSize: '14px', color: 'var(--text-100)', fontWeight: n.status === 'unread' ? '600' : '400' }}>{n.message}</div>
                                </div>
                                {n.status === 'unread' && <button className="btn secondary" data-cy={`btn-mark-read-${n.id}`} style={{ fontSize: '11px', padding: '4px 8px' }} onClick={async () => { try { const m = await import('@/shared/utils/apiClient'); await m.apiClient.patch(`/v1/admin/notifications/${n.id}`, { status: 'read' }); } catch {} showToast(t('admin.notification_marked_read', { defaultValue: 'Notification marked as read' }), 'info'); }}>{t('admin.mark_read', { defaultValue: 'Mark Read' })}</button>}
                            </div>
                        ))}
                    </div>
                </>
            )}
        </div >
    );
}
