import React from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

interface QuickActionCardProps {
    label: string;
    icon: string;
    onClick: () => void;
    dataCy: string;
}

const QuickActionCard = ({ label, icon, onClick, dataCy }: QuickActionCardProps) => (
    <div
        className="pc-card"
        data-cy={dataCy}
        onClick={onClick}
        style={{
            padding: '24px',
            display: 'flex',
            alignItems: 'center',
            gap: '16px',
            cursor: 'pointer'
        }}
    >
        <div style={{ fontSize: '2.5rem' }}>{icon}</div>
        <div style={{ fontWeight: 900, fontSize: '1.2rem', color: 'var(--brand-500)', letterSpacing: '.2px' }}>{label}</div>
    </div>
);

export const QuickActions: React.FC = () => {
    const { t } = useTranslation();
    const navigate = useNavigate();

    return (
        <>
            <h2 data-cy="section.quick-actions" style={{ fontSize: '0.75rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '2px', marginBottom: '1.5rem', color: 'var(--text-300)' }}>
                {t(ContentRegistry.MANAGER_DASHBOARD.QUICK_ACTIONS)}
            </h2>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(240px, 1fr))', gap: '20px', marginBottom: '40px' }}>
                <QuickActionCard label={t(ContentRegistry.MANAGER_DASHBOARD.ACTIONS.DAILY_CARE)} icon="📝" onClick={() => navigate(RouteRegistry.MANAGER.DAILY_ENTRY)} dataCy="qa-daily-entry" />
                <QuickActionCard label={t(ContentRegistry.MANAGER_DASHBOARD.ACTIONS.STAFF_EVAL)} icon="📋" onClick={() => navigate(RouteRegistry.MANAGER.EVALUATIONS)} dataCy="qa-evaluations" />
                <QuickActionCard label={t(ContentRegistry.MANAGER_DASHBOARD.ACTIONS.SERVICE_REVIEW)} icon="⭐" onClick={() => navigate(RouteRegistry.MANAGER.SERVICE_REVIEW)} dataCy="qa-service-reviews" />
                <QuickActionCard label={t(ContentRegistry.MANAGER_DASHBOARD.ACTIONS.LOG_INCIDENT)} icon="⚠️" onClick={() => navigate(RouteRegistry.ADMIN.INCIDENTS)} dataCy="qa-log-incident" />
                <QuickActionCard label={t(ContentRegistry.MANAGER_DASHBOARD.ACTIONS.VIEW_CLIENTS)} icon="👥" onClick={() => navigate(RouteRegistry.STAFF.CUSTOMERS)} dataCy="qa-view-clients" />
            </div>
        </>
    );
};
