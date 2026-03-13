import React from 'react';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';
import { useDialog } from '@/shared/hooks/useDialog';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

interface QuickActionsProps {
    onPostShift: () => void;
}

export const QuickActions: React.FC<QuickActionsProps> = ({ onPostShift }) => {
    const { DialogRenderer } = useDialog();
    const { t } = useTranslation();

    return (
        <div className="pc-card strip">
            <div className="pc-card-h">
                {t(ContentRegistry.ADMIN_DASHBOARD.TITLES.QUICK_ACTIONS)}
            </div>
            <div className="pc-card-b">
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem', marginTop: '1rem' }}>
                    <Link to={RouteRegistry.ADMIN.USERS} style={{ textDecoration: 'none' }} data-cy="qa-link-users">
                        <button data-cy="btn-admin.quick-actions-0" className="btn" style={{ width: '100%', textAlign: 'left', background: '#F9FAFB' }}>
                            <div style={{ color: 'var(--brand-500)' }}>{AdminRegistry.LinkRegistry.find((l: any) => l.path === RouteRegistry.ADMIN.USERS)?.label || t(ContentRegistry.USERS.TITLE)}</div>
                            <div style={{ fontSize: '0.75rem', color: 'var(--text-300)' }}>{t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.CHECK_CERTS)}</div>
                        </button>
                    </Link>
                    <Link to={RouteRegistry.ADMIN.SCHEDULE} style={{ textDecoration: 'none' }} data-cy="qa-link-schedule">
                        <button data-cy="btn-admin.quick-actions-1" className="btn" style={{ width: '100%', textAlign: 'left', background: '#F9FAFB' }}>
                            <div style={{ color: 'var(--brand-500)' }}>{AdminRegistry.ButtonRegistry.find((b: any) => b.id === 'btn-adm-schedule-optimize')?.label || t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.VIEW_SCHEDULE)}</div>
                            <div style={{ fontSize: '0.75rem', color: 'var(--text-300)' }}>{t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.MANAGE_ASSIGNMENTS)}</div>
                        </button>
                    </Link>
                    <Link to={RouteRegistry.ADMIN.LEADS} style={{ textDecoration: 'none' }} data-cy="qa-link-leads">
                        <button data-cy="btn-admin.quick-actions-2" className="btn" style={{ width: '100%', textAlign: 'left', background: '#F9FAFB' }}>
                            <div style={{ color: 'var(--brand-500)' }}>{t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.REVIEW_LEADS)}</div>
                            <div style={{ fontSize: '0.75rem', color: 'var(--text-300)' }}>{t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.RESPOND_INQUIRIES)}</div>
                        </button>
                    </Link>
                    <Link to={RouteRegistry.ADMIN.SETTINGS} style={{ textDecoration: 'none' }} data-cy="qa-link-settings">
                        <button data-cy="btn-admin.quick-actions-3" className="btn" style={{ width: '100%', textAlign: 'left', background: '#F9FAFB' }}>
                            <div style={{ color: 'var(--brand-500)' }}>{t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.SYSTEM_CONFIG)}</div>
                            <div style={{ fontSize: '0.75rem', color: 'var(--text-300)' }}>{t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.APP_ADJUSTS)}</div>
                        </button>
                    </Link>

                    <button
                        onClick={onPostShift}
                        className="btn"
                        style={{ width: '100%', textAlign: 'left', background: '#E6F4EA', border: '1px solid #00875A' }}
                        data-cy="qa-btn-post-shift"
                    >
                        <div style={{ color: '#00875A', fontWeight: 'bold' }}>{t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.POST_SHIFT)}</div>
                        <div style={{ fontSize: '0.75rem', color: '#00875A' }}>{t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.POST_SHIFT_DESC)}</div>
                    </button>
                </div>
            </div>
        <DialogRenderer />
            </div>
    );
};
