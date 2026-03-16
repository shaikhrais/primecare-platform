import React from 'react';
import { useNavigate } from 'react-router';
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
    <div className="qa-card" data-cy={dataCy} onClick={onClick}>
        <div className="qa-icon">{icon}</div>
        <div className="qa-label">{label}</div>
    </div>
);

export const QuickActions: React.FC = () => {
    const { t } = useTranslation();
    const navigate = useNavigate();

    return (
        <div className="qa-section">
            <h2 data-cy="h2-manager.quick-actions-0" className="section-title">
                {t(ContentRegistry.MANAGER_DASHBOARD.QUICK_ACTIONS)}
            </h2>
            <div className="qa-grid">
                <QuickActionCard label={t(ContentRegistry.MANAGER_DASHBOARD.ACTIONS.DAILY_CARE)} icon="📝" onClick={() => navigate(RouteRegistry.MANAGER.DAILY_ENTRY)} dataCy="qa-daily-entry" />
                <QuickActionCard label={t(ContentRegistry.MANAGER_DASHBOARD.ACTIONS.STAFF_EVAL)} icon="📋" onClick={() => navigate(RouteRegistry.MANAGER.EVALUATIONS)} dataCy="qa-evaluations" />
                <QuickActionCard label={t(ContentRegistry.MANAGER_DASHBOARD.ACTIONS.SERVICE_REVIEW)} icon="⭐" onClick={() => navigate(RouteRegistry.MANAGER.SERVICE_REVIEW)} dataCy="qa-service-reviews" />
                <QuickActionCard label={t(ContentRegistry.MANAGER_DASHBOARD.ACTIONS.LOG_INCIDENT)} icon="⚠️" onClick={() => navigate(RouteRegistry.ADMIN.INCIDENTS)} dataCy="qa-log-incident" />
                <QuickActionCard label={t(ContentRegistry.MANAGER_DASHBOARD.ACTIONS.VIEW_CLIENTS)} icon="👥" onClick={() => navigate(RouteRegistry.STAFF.CUSTOMERS)} dataCy="qa-view-clients" />
            </div>
        </div>
    );
};
