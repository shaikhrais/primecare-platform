import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { useAuth } from '@/shared/context/AuthContext';
import { AdminRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';
const { ContentRegistry, RouteRegistry } = AdminRegistry;

export default function StaffDashboard() {
    const { t } = useTranslation();
    const { user } = useAuth();
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        // Simulate loading staff specific data
        setTimeout(() => setLoading(false), 500);
    }, []);

    if (loading) {
        return <div style={{ padding: '2rem', textAlign: 'center' }}>{t(ContentRegistry.STAFF_DASHBOARD.MESSAGES.LOADING)}</div>;
    }

    return (
        <div data-cy="page.container">
            <div style={{ marginBottom: '2.5rem', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                <div>
                    <h1 style={{ margin: '0 0 6px 0', fontSize: '34px', letterSpacing: '.2px', color: 'var(--text-100)' }} data-cy="page.title">
                        {user?.tenantId ? t(ContentRegistry.STAFF_DASHBOARD.TITLE_BRANCH) : t(ContentRegistry.STAFF_DASHBOARD.TITLE_NETWORK)}
                    </h1>
                    <p className="sub" style={{ margin: 0 }} data-cy="page.subtitle">
                        {user?.email ? `${user.email} • ${t(ContentRegistry.ROLES.STAFF)}` : t(ContentRegistry.STAFF_DASHBOARD.SUBTITLE)}
                    </p>
                </div>
                <Link to={RouteRegistry.LEARN}>
                    <button style={{
                        padding: '10px 20px',
                        borderRadius: '10px',
                        border: '1px solid #e5e7eb',
                        backgroundColor: 'white',
                        color: '#111827',
                        fontWeight: 700,
                        fontSize: '0.85rem',
                        cursor: 'pointer',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '8px',
                        boxShadow: '0 1px 2px rgba(0,0,0,0.05)'
                    }}>
                        🎓 System Training
                    </button>
                </Link>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))', gap: '1.5rem', marginBottom: '3rem' }}>
                <div className="pc-card" style={{ padding: '1.5rem', borderLeft: '4px solid #3b82f6' }}>
                    <div style={{ color: 'var(--text-300)', fontSize: '0.85rem', fontWeight: 600 }}>{t(ContentRegistry.STAFF_DASHBOARD.STATS.URGENT_NEEDS)}</div>
                    <div style={{ fontSize: '2rem', fontWeight: 800, color: 'var(--brand-500)', marginTop: '0.5rem' }}>14</div>
                    <div style={{ fontSize: '0.75rem', color: 'var(--text-300)', marginTop: '0.5rem' }}>{t(ContentRegistry.STAFF_DASHBOARD.STATS.URGENT_DESC)}</div>
                </div>

                <div className="pc-card" style={{ padding: '1.5rem', borderLeft: '4px solid #10b981' }}>
                    <div style={{ color: 'var(--text-300)', fontSize: '0.85rem', fontWeight: 600 }}>{t(ContentRegistry.STAFF_DASHBOARD.STATS.ACTIVE_CAREGIVERS)}</div>
                    <div style={{ fontSize: '2rem', fontWeight: 800, color: 'var(--brand-500)', marginTop: '0.5rem' }}>128</div>
                    <div style={{ fontSize: '0.75rem', color: 'var(--text-300)', marginTop: '0.5rem' }}>{t(ContentRegistry.STAFF_DASHBOARD.STATS.ACTIVE_DESC)}</div>
                </div>

                <div className="pc-card" style={{ padding: '1.5rem', borderLeft: '4px solid #f59e0b' }}>
                    <div style={{ color: 'var(--text-300)', fontSize: '0.85rem', fontWeight: 600 }}>{t(ContentRegistry.STAFF_DASHBOARD.STATS.MISSING_TIMESHEETS)}</div>
                    <div style={{ fontSize: '2rem', fontWeight: 800, color: 'var(--brand-500)', marginTop: '0.5rem' }}>7</div>
                    <div style={{ fontSize: '0.75rem', color: 'var(--text-300)', marginTop: '0.5rem' }}>{t(ContentRegistry.STAFF_DASHBOARD.STATS.MISSING_DESC)}</div>
                </div>
            </div>

            <h2 style={{ fontSize: '1rem', fontWeight: 700, color: 'var(--text-100)', marginBottom: '1rem' }}>{t(ContentRegistry.STAFF_DASHBOARD.PRIORITIES.TITLE)}</h2>

            <div className="pc-card" style={{ padding: '0 1.5rem' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', padding: '1rem 0', borderBottom: '1px solid var(--card-border)' }}>
                    <div>
                        <div style={{ fontWeight: 600, color: 'var(--text-100)' }}>{t(ContentRegistry.STAFF_DASHBOARD.PRIORITIES.COMPLIANCE_TITLE)}</div>
                        <div style={{ fontSize: '0.85rem', color: 'var(--text-300)' }}>4 {t(ContentRegistry.STAFF_DASHBOARD.PRIORITIES.COMPLIANCE_DESC)}</div>
                    </div>
                    <button className="btn btn-primary" style={{ height: 'fit-content' }}>{t(ContentRegistry.STAFF_DASHBOARD.PRIORITIES.COMPLIANCE_BTN)}</button>
                </div>

                <div style={{ display: 'flex', justifyContent: 'space-between', padding: '1rem 0', borderBottom: '1px solid var(--card-border)' }}>
                    <div>
                        <div style={{ fontWeight: 600, color: 'var(--text-100)' }}>{t(ContentRegistry.STAFF_DASHBOARD.PRIORITIES.TIMESHEETS_TITLE)}</div>
                        <div style={{ fontSize: '0.85rem', color: 'var(--text-300)' }}>22 {t(ContentRegistry.STAFF_DASHBOARD.PRIORITIES.TIMESHEETS_DESC)}</div>
                    </div>
                    <button className="btn" style={{ height: 'fit-content', background: '#e5e7eb' }}>{t(ContentRegistry.STAFF_DASHBOARD.PRIORITIES.TIMESHEETS_BTN)}</button>
                </div>

                <div style={{ display: 'flex', justifyContent: 'space-between', padding: '1rem 0' }}>
                    <div>
                        <div style={{ fontWeight: 600, color: 'var(--text-100)' }}>{t(ContentRegistry.STAFF_DASHBOARD.PRIORITIES.FEEDBACK_TITLE)}</div>
                        <div style={{ fontSize: '0.85rem', color: 'var(--text-300)' }}>3 {t(ContentRegistry.STAFF_DASHBOARD.PRIORITIES.FEEDBACK_DESC)}</div>
                    </div>
                    <button className="btn" style={{ height: 'fit-content', background: '#e5e7eb' }}>{t(ContentRegistry.STAFF_DASHBOARD.PRIORITIES.FEEDBACK_BTN)}</button>
                </div>
            </div>
        </div>
    );
}
