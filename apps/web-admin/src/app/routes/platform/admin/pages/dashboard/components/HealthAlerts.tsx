import React from 'react';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

interface HealthAlertsProps {
    alerts: {
        complianceRisk: number;
        coverageGap: number;
        pipelineStagnation: number;
    };
}

export const HealthAlerts: React.FC<HealthAlertsProps> = ({ alerts }) => {
    const { t } = useTranslation();

    return (
        <>
            <h2 style={{ fontSize: '0.75rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '2px', marginBottom: '1.5rem', color: 'var(--text-300)' }}>
                {t(ContentRegistry.HEALTH_ALERTS.TITLE)}
            </h2>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '1.5rem', marginBottom: '3rem' }}>
                <div style={{ background: '#FFF5F5', border: '1px solid #FEB2B2', borderRadius: '1rem', padding: '1.5rem', display: 'flex', alignItems: 'center', gap: '1rem' }}>
                    <div style={{ fontSize: '2rem' }}>⚖️</div>
                    <div>
                        <div style={{ fontWeight: '800', color: '#C53030' }}>{t(ContentRegistry.HEALTH_ALERTS.COMPLIANCE.LABEL)}</div>
                        <div style={{ fontSize: '1.5rem', fontWeight: '900', color: '#9B2C2C' }}>{alerts?.complianceRisk || 0}</div>
                        <div style={{ fontSize: '0.75rem', color: '#E53E3E' }}>{t(ContentRegistry.HEALTH_ALERTS.COMPLIANCE.DESC)}</div>
                    </div>
                    <Link to={RouteRegistry.ADMIN.STAFF_ONBOARDING} style={{ marginLeft: 'auto' }}>
                        <button style={{ background: '#C53030', color: 'white', border: 'none', padding: '0.5rem 1rem', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer' }}>{t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.FIX)}</button>
                    </Link>
                </div>

                <div style={{ background: '#FFFBEB', border: '1px solid #FDE68A', borderRadius: '1rem', padding: '1.5rem', display: 'flex', alignItems: 'center', gap: '1rem' }}>
                    <div style={{ fontSize: '2rem' }}>📅</div>
                    <div>
                        <div style={{ fontWeight: '800', color: '#92400E' }}>{t(ContentRegistry.HEALTH_ALERTS.COVERAGE.LABEL)}</div>
                        <div style={{ fontSize: '1.5rem', fontWeight: '900', color: '#92400E' }}>{alerts?.coverageGap || 0}</div>
                        <div style={{ fontSize: '0.75rem', color: '#B45309' }}>{t(ContentRegistry.HEALTH_ALERTS.COVERAGE.DESC)}</div>
                    </div>
                    <Link to={RouteRegistry.ADMIN.SCHEDULE} style={{ marginLeft: 'auto' }}>
                        <button style={{ background: '#D97706', color: 'white', border: 'none', padding: '0.5rem 1rem', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer' }}>{t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.VIEW)}</button>
                    </Link>
                </div>

                <div style={{ background: '#F0FFF4', border: '1px solid #9AE6B4', borderRadius: '1rem', padding: '1.5rem', display: 'flex', alignItems: 'center', gap: '1rem' }}>
                    <div style={{ fontSize: '2rem' }}>⏳</div>
                    <div>
                        <div style={{ fontWeight: '800', color: '#276749' }}>{t(ContentRegistry.HEALTH_ALERTS.PIPELINE.LABEL)}</div>
                        <div style={{ fontSize: '1.5rem', fontWeight: '900', color: '#276749' }}>{alerts?.pipelineStagnation || 0}</div>
                        <div style={{ fontSize: '0.75rem', color: '#2F855A' }}>{t(ContentRegistry.HEALTH_ALERTS.PIPELINE.DESC)}</div>
                    </div>
                    <Link to={RouteRegistry.ADMIN.LEADS} style={{ marginLeft: 'auto' }}>
                        <button style={{ background: '#38A169', color: 'white', border: 'none', padding: '0.5rem 1rem', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer' }}>{t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.ACTION)}</button>
                    </Link>
                </div>
            </div>
        </>
    );
};
