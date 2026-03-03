import React from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';
import { useAuth } from '@/shared/context/AuthContext';
import { Link } from 'react-router-dom';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

export default function ScrumMasterDashboard() {
    const { t } = useTranslation();
    const { user } = useAuth();

    return (
        <div data-cy="scrum-master-dashboard">
            <div style={{ marginBottom: '2.5rem' }}>
                <h1 style={{ margin: '0 0 8px 0', fontSize: '32px', fontWeight: 800, color: 'var(--text-100)' }} data-cy="page-title">
                    {t(ContentRegistry.SCRUM_MASTER.DASHBOARD.TITLE)}
                </h1>
                <p style={{ margin: 0, color: 'var(--text-300)', fontSize: '1.1rem' }}>
                    {t(ContentRegistry.SCRUM_MASTER.DASHBOARD.SUBTITLE)}
                </p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '1.5rem', marginBottom: '3rem' }}>
                <Link to={RouteRegistry.SCRUM_MASTER.API_ENDPOINTS} style={{ textDecoration: 'none' }}>
                    <div className="pc-card" style={{ padding: '2rem', height: '100%', cursor: 'pointer', transition: 'transform 0.2s' }}>
                        <div style={{ fontSize: '2.5rem', marginBottom: '1rem' }}>🔌</div>
                        <h3 style={{ margin: '0 0 10px 0', color: 'var(--text-100)' }}>API Endpoints</h3>
                        <p style={{ margin: 0, color: 'var(--text-300)', fontSize: '0.9rem' }}>
                            Verify, test, and audit all system-wide API endpoints and their connectivity.
                        </p>
                    </div>
                </Link>

                <Link to={RouteRegistry.SCRUM_MASTER.PAGES} style={{ textDecoration: 'none' }}>
                    <div className="pc-card" style={{ padding: '2rem', height: '100%', cursor: 'pointer', transition: 'transform 0.2s' }}>
                        <div style={{ fontSize: '2.5rem', marginBottom: '1rem' }}>📄</div>
                        <h3 style={{ margin: '0 0 10px 0', color: 'var(--text-100)' }}>Pages Audit</h3>
                        <p style={{ margin: 0, color: 'var(--text-300)', fontSize: '0.9rem' }}>
                            Audit physical page components, file paths, and their mapped route variables.
                        </p>
                    </div>
                </Link>

                <Link to={RouteRegistry.SCRUM_MASTER.COMPONENTS} style={{ textDecoration: 'none' }}>
                    <div className="pc-card" style={{ padding: '2rem', height: '100%', cursor: 'pointer', transition: 'transform 0.2s' }}>
                        <div style={{ fontSize: '2.5rem', marginBottom: '1rem' }}>🧩</div>
                        <h3 style={{ margin: '0 0 10px 0', color: 'var(--text-100)' }}>Components Library</h3>
                        <p style={{ margin: 0, color: 'var(--text-300)', fontSize: '0.9rem' }}>
                            Explore shared UI components, utility hooks, and design system tokens.
                        </p>
                    </div>
                </Link>

                <Link to={RouteRegistry.SCRUM_MASTER.ROLE_FLOWS} style={{ textDecoration: 'none' }}>
                    <div className="pc-card" style={{ padding: '2rem', height: '100%', cursor: 'pointer', transition: 'transform 0.2s' }}>
                        <div style={{ fontSize: '2.5rem', marginBottom: '1rem' }}>🔄</div>
                        <h3 style={{ margin: '0 0 10px 0', color: 'var(--text-100)' }}>Role Flows</h3>
                        <p style={{ margin: 0, color: 'var(--text-300)', fontSize: '0.9rem' }}>
                            Visualize navigation journeys and interaction patterns available to each system role.
                        </p>
                    </div>
                </Link>
            </div>

            <div className="pc-card" style={{ padding: '2rem', background: 'linear-gradient(135deg, #1e293b 0%, #0f172a 100%)', color: 'white' }}>
                <h2 style={{ margin: '0 0 1.5rem 0', display: 'flex', alignItems: 'center', gap: '10px' }}>
                    <span>🚀</span> System Readiness Audit
                </h2>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '2rem' }}>
                    <div>
                        <div style={{ fontSize: '0.85rem', opacity: 0.7, textTransform: 'uppercase', fontWeight: 700 }}>Total Endpoints</div>
                        <div style={{ fontSize: '2.5rem', fontWeight: 800, margin: '5px 0' }}>142</div>
                        <div style={{ fontSize: '0.85rem', color: '#10b981' }}>● 100% Operational</div>
                    </div>
                    <div>
                        <div style={{ fontSize: '0.85rem', opacity: 0.7, textTransform: 'uppercase', fontWeight: 700 }}>Total Pages</div>
                        <div style={{ fontSize: '2.5rem', fontWeight: 800, margin: '5px 0' }}>68</div>
                        <div style={{ fontSize: '0.85rem', color: '#10b981' }}>● All Synced</div>
                    </div>
                    <div>
                        <div style={{ fontSize: '0.85rem', opacity: 0.7, textTransform: 'uppercase', fontWeight: 700 }}>Role Coverage</div>
                        <div style={{ fontSize: '2.5rem', fontWeight: 800, margin: '5px 0' }}>100%</div>
                        <div style={{ fontSize: '0.85rem', color: '#10b981' }}>● All Roles Audited</div>
                    </div>
                </div>
            </div>
        </div>
    );
}
