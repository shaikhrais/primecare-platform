import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { useAuth } from '@/shared/context/AuthContext';
import { apiClient } from '@/shared/utils/apiClient';
import { CreateVisitModal } from '@/shared/components/modals/CreateVisitModal';
import { RevenueChart } from '@/shared/components/charts/RevenueChart';
import { VisitVolumeChart } from '@/shared/components/charts/VisitVolumeChart';
import { ShiftFulfillmentChart } from '@/shared/components/charts/ShiftFulfillmentChart';
import { ServicePopularityChart } from '@/shared/components/charts/ServicePopularityChart';
import { IncidentTrendChart } from '@/shared/components/charts/IncidentTrendChart';
import { CarePlanAdherenceGauge } from '@/shared/components/charts/CarePlanAdherenceGauge';
import { StaffAttendanceHeatmap } from '@/shared/components/charts/StaffAttendanceHeatmap';
import { ClientSatisfactionRadar } from '@/shared/components/charts/ClientSatisfactionRadar';
import { RevenueForecastChart } from '@/shared/components/charts/RevenueForecastChart';
import { useTranslation } from 'react-i18next';

const { ContentRegistry, RouteRegistry, ApiRegistry } = AdminRegistry;

export default function AdminDashboard() {
    const { t } = useTranslation();
    const { showToast } = useNotification();
    const [stats, setStats] = useState({ totalUsers: 0, pendingVisits: 0, totalVisits: 0, totalLeads: 0 });
    const [loading, setLoading] = useState(true);
    const [isPostShiftModalOpen, setIsPostShiftModalOpen] = useState(false);

    useEffect(() => {
        const fetchStats = async () => {
            try {
                const response = await apiClient.get(ApiRegistry.ADMIN.STATS);
                if (response.ok) {
                    const data = await response.json();
                    setStats(data);
                }
            } catch (error) {
                console.error('Failed to fetch stats', error);
            } finally {
                setLoading(false);
            }
        };
        fetchStats();
    }, []);


    const { user } = useAuth();

    return (
        <div data-cy="page.container">
            <div style={{ marginBottom: '2rem' }}>
                <h1 style={{ margin: '0 0 6px 0', fontSize: '32px', color: 'var(--text)' }} data-cy="page.title">
                    {user?.tenantId ? `Master Dashboard` : t(ContentRegistry.ADMIN_DASHBOARD.TITLES.WELCOME)}
                </h1>
                <p style={{ margin: 0, opacity: 0.6 }} data-cy="page.subtitle">
                    {user?.email} • Franchise Command Center
                </p>
            </div>

            {/* Business Model Score & Setup Wizard Banner */}
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 300px', gap: '1.5rem', marginBottom: '2rem' }}>
                <div style={{
                    background: 'linear-gradient(135deg, #004d40 0%, #00695c 100%)',
                    padding: '2rem',
                    borderRadius: '1.5rem',
                    color: 'white',
                    display: 'flex',
                    justifyContent: 'space-between',
                    alignItems: 'center',
                    boxShadow: '0 10px 15px -3px rgba(0, 0, 0, 0.1)'
                }} data-cy="setup-wizard-banner">
                    <div>
                        <h2 style={{ fontSize: '1.5rem', fontWeight: '800', marginBottom: '0.5rem' }}>{t(ContentRegistry.ADMIN_DASHBOARD.SETUP_BANNER.TITLE)}</h2>
                        <p style={{ opacity: 0.9 }}>{t(ContentRegistry.ADMIN_DASHBOARD.SETUP_BANNER.SUBTITLE)}</p>
                    </div>
                    <Link to={RouteRegistry.BUSINESS_STATUS}>
                        <button style={{
                            padding: '1rem 2rem',
                            background: 'white',
                            color: '#004d40',
                            fontWeight: 'bold',
                            border: 'none',
                            borderRadius: '1rem',
                            cursor: 'pointer'
                        }}>
                            {t(ContentRegistry.ADMIN_DASHBOARD.SETUP_BANNER.ACTION)}
                        </button>
                    </Link>
                </div>

                <div style={{ background: 'white', padding: '1.5rem', borderRadius: '1.5rem', border: '1px solid #e5e7eb', display: 'flex', flexDirection: 'column', justifyContent: 'center' }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.75rem' }}>
                        <span style={{ fontWeight: '700', fontSize: '0.875rem' }}>{t(ContentRegistry.ADMIN_DASHBOARD.SETUP_BANNER.SCORE_LABEL)}</span>
                        <span style={{ fontWeight: '800', color: '#4f46e5' }}>{(stats as any).modelScore || 0}%</span>
                    </div>
                    <div style={{ width: '100%', height: '10px', background: '#f3f4f6', borderRadius: '5px', overflow: 'hidden' }}>
                        <div style={{
                            width: `${(stats as any).modelScore || 0}%`,
                            height: '100%',
                            background: 'linear-gradient(90deg, #4f46e5 0%, #7c3aed 100%)',
                            transition: 'width 0.5s ease-out'
                        }} />
                    </div>
                    <p style={{ fontSize: '0.75rem', color: '#6b7280', marginTop: '0.75rem' }}>
                        Complete your <Link to={RouteRegistry.BUSINESS_MODEL_WIZARD} style={{ color: '#4f46e5', fontWeight: '600' }}>{t(ContentRegistry.ADMIN_DASHBOARD.SETUP_BANNER.STRATEGY_LINK)}</Link> {t(ContentRegistry.ADMIN_DASHBOARD.SETUP_BANNER.STRATEGY_DESC)}
                    </p>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))', gap: '1.5rem', marginBottom: '3rem' }} data-cy="stats-cards">
                {[
                    { label: t(ContentRegistry.ADMIN_DASHBOARD.STATS.TOTAL_USERS), value: stats.totalUsers, icon: '👥', link: `${RouteRegistry.USERS}?role=psw` },
                    { label: t(ContentRegistry.ADMIN_DASHBOARD.STATS.NEW_INQUIRIES), value: stats.totalLeads, icon: '📥', link: `${RouteRegistry.LEADS}?status=new` },
                    { label: t(ContentRegistry.ADMIN_DASHBOARD.STATS.PENDING_VISITS), value: stats.pendingVisits, icon: '📝', link: `${RouteRegistry.SCHEDULE}` },
                    { label: t(ContentRegistry.ADMIN_DASHBOARD.STATS.TOTAL_VISITS), value: stats.totalVisits, icon: '📋', link: `${RouteRegistry.SCHEDULE}` },
                ].map((card, index) => (
                    <Link key={index} to={card.link} style={{ textDecoration: 'none' }}>
                        <div className="pc-card" data-cy={`stat-card-${card.label.toLowerCase().replace(/\s+/g, '-')}`} style={{
                            padding: '1.5rem',
                            display: 'flex',
                            flexDirection: 'column',
                            gap: '0.5rem',
                            cursor: 'pointer',
                            transition: 'transform 0.2s, box-shadow 0.2s',
                        }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                                <span style={{ color: 'var(--text-300)', fontSize: '0.875rem', fontWeight: '600' }}>{card.label}</span>
                                <span style={{ fontSize: '1.25rem' }}>{card.icon}</span>
                            </div>
                            <div style={{ fontSize: '2rem', fontWeight: 800, color: 'var(--brand-500)' }}>
                                {card.value}
                            </div>
                            <div style={{ fontSize: '0.75rem', color: 'var(--text-300)', marginTop: '0.5rem' }}>
                                {t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.VIEW_DETAILS)}
                            </div>
                        </div>
                    </Link>
                ))}
            </div>

            {/* Business Health Monitor Section */}
            <h2 style={{ fontSize: '0.75rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '2px', marginBottom: '1.5rem', color: 'var(--text-300)' }}>
                {t(ContentRegistry.HEALTH_ALERTS.TITLE)}
            </h2>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '1.5rem', marginBottom: '3rem' }}>
                <div style={{ background: '#FFF5F5', border: '1px solid #FEB2B2', borderRadius: '1rem', padding: '1.5rem', display: 'flex', alignItems: 'center', gap: '1rem' }}>
                    <div style={{ fontSize: '2rem' }}>⚖️</div>
                    <div>
                        <div style={{ fontWeight: '800', color: '#C53030' }}>{t(ContentRegistry.HEALTH_ALERTS.COMPLIANCE.LABEL)}</div>
                        <div style={{ fontSize: '1.5rem', fontWeight: '900', color: '#9B2C2C' }}>{(stats as any).healthAlerts?.complianceRisk || 0}</div>
                        <div style={{ fontSize: '0.75rem', color: '#E53E3E' }}>{t(ContentRegistry.HEALTH_ALERTS.COMPLIANCE.DESC)}</div>
                    </div>
                    <Link to={RouteRegistry.STAFF_ONBOARDING} style={{ marginLeft: 'auto' }}>
                        <button style={{ background: '#C53030', color: 'white', border: 'none', padding: '0.5rem 1rem', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer' }}>Fix</button>
                    </Link>
                </div>

                <div style={{ background: '#FFFBEB', border: '1px solid #FDE68A', borderRadius: '1rem', padding: '1.5rem', display: 'flex', alignItems: 'center', gap: '1rem' }}>
                    <div style={{ fontSize: '2rem' }}>📅</div>
                    <div>
                        <div style={{ fontWeight: '800', color: '#92400E' }}>{t(ContentRegistry.HEALTH_ALERTS.COVERAGE.LABEL)}</div>
                        <div style={{ fontSize: '1.5rem', fontWeight: '900', color: '#92400E' }}>{(stats as any).healthAlerts?.coverageGap || 0}</div>
                        <div style={{ fontSize: '0.75rem', color: '#B45309' }}>{t(ContentRegistry.HEALTH_ALERTS.COVERAGE.DESC)}</div>
                    </div>
                    <Link to={RouteRegistry.SCHEDULE} style={{ marginLeft: 'auto' }}>
                        <button style={{ background: '#D97706', color: 'white', border: 'none', padding: '0.5rem 1rem', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer' }}>View</button>
                    </Link>
                </div>

                <div style={{ background: '#F0FFF4', border: '1px solid #9AE6B4', borderRadius: '1rem', padding: '1.5rem', display: 'flex', alignItems: 'center', gap: '1rem' }}>
                    <div style={{ fontSize: '2rem' }}>⏳</div>
                    <div>
                        <div style={{ fontWeight: '800', color: '#276749' }}>{t(ContentRegistry.HEALTH_ALERTS.PIPELINE.LABEL)}</div>
                        <div style={{ fontSize: '1.5rem', fontWeight: '900', color: '#276749' }}>{(stats as any).healthAlerts?.pipelineStagnation || 0}</div>
                        <div style={{ fontSize: '0.75rem', color: '#2F855A' }}>{t(ContentRegistry.HEALTH_ALERTS.PIPELINE.DESC)}</div>
                    </div>
                    <Link to={RouteRegistry.LEADS} style={{ marginLeft: 'auto' }}>
                        <button style={{ background: '#38A169', color: 'white', border: 'none', padding: '0.5rem 1rem', borderRadius: '0.5rem', fontWeight: 'bold', cursor: 'pointer' }}>Action</button>
                    </Link>
                </div>
            </div>

            {/* Interactive Charts Section */}
            <h2 style={{ fontSize: '0.75rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '2px', marginBottom: '1.5rem', color: 'var(--text-300)' }}>
                {t(ContentRegistry.ADMIN_DASHBOARD.TITLES.ANALYTICS)}
            </h2>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(400px, 1fr))', gap: '1.5rem', marginBottom: '3rem' }}>
                <RevenueChart />
                <VisitVolumeChart />
                <ShiftFulfillmentChart />
                <ServicePopularityChart />
                <IncidentTrendChart />
                <CarePlanAdherenceGauge />
                <StaffAttendanceHeatmap />
                <ClientSatisfactionRadar />
                <RevenueForecastChart />
            </div>

            <div className="grid">
                {/* Recent Activity / Quick Actions Container */}
                <div className="pc-card strip">
                    <div className="pc-card-h">
                        {t(ContentRegistry.ADMIN_DASHBOARD.TITLES.QUICK_ACTIONS)}
                    </div>
                    <div className="pc-card-b">
                        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem', marginTop: '1rem' }}>
                            <Link to={RouteRegistry.USERS} style={{ textDecoration: 'none' }} data-cy="qa-link-users">
                                <button className="btn" style={{ width: '100%', textAlign: 'left', background: '#F9FAFB' }}>
                                    <div style={{ color: 'var(--brand-500)' }}>{t(ContentRegistry.USERS.TITLE)}</div>
                                    <div style={{ fontSize: '0.75rem', color: 'var(--text-300)' }}>{t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.CHECK_CERTS)}</div>
                                </button>
                            </Link>
                            <Link to={RouteRegistry.SCHEDULE} style={{ textDecoration: 'none' }} data-cy="qa-link-schedule">
                                <button className="btn" style={{ width: '100%', textAlign: 'left', background: '#F9FAFB' }}>
                                    <div style={{ color: 'var(--brand-500)' }}>{t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.VIEW_SCHEDULE)}</div>
                                    <div style={{ fontSize: '0.75rem', color: 'var(--text-300)' }}>{t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.MANAGE_ASSIGNMENTS)}</div>
                                </button>
                            </Link>
                            <Link to={RouteRegistry.LEADS} style={{ textDecoration: 'none' }} data-cy="qa-link-leads">
                                <button className="btn" style={{ width: '100%', textAlign: 'left', background: '#F9FAFB' }}>
                                    <div style={{ color: 'var(--brand-500)' }}>{t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.REVIEW_LEADS)}</div>
                                    <div style={{ fontSize: '0.75rem', color: 'var(--text-300)' }}>{t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.RESPOND_INQUIRIES)}</div>
                                </button>
                            </Link>
                            <Link to={RouteRegistry.SETTINGS} style={{ textDecoration: 'none' }} data-cy="qa-link-settings">
                                <button className="btn" style={{ width: '100%', textAlign: 'left', background: '#F9FAFB' }}>
                                    <div style={{ color: 'var(--brand-500)' }}>{t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.SYSTEM_CONFIG)}</div>
                                    <div style={{ fontSize: '0.75rem', color: 'var(--text-300)' }}>{t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.APP_ADJUSTS)}</div>
                                </button>
                            </Link>

                            <button
                                onClick={() => setIsPostShiftModalOpen(true)}
                                className="btn"
                                style={{ width: '100%', textAlign: 'left', background: '#E6F4EA', border: '1px solid #00875A' }}
                                data-cy="qa-btn-post-shift"
                            >
                                <div style={{ color: '#00875A', fontWeight: 'bold' }}>{t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.POST_SHIFT)}</div>
                                <div style={{ fontSize: '0.75rem', color: '#00875A' }}>{t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.POST_SHIFT_DESC)}</div>
                            </button>
                        </div>
                    </div>
                </div>

                <div className="pc-card">
                    <div className="pc-card-h">
                        {t(ContentRegistry.ADMIN_DASHBOARD.TITLES.OPERATIONAL_STATUS)}
                    </div>
                    <div className="pc-card-b">
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', padding: '0.75rem 0', borderBottom: '1px solid var(--card-border)' }} data-cy="status-item-api">
                                <span style={{ color: 'var(--text-200)' }}>{t(ContentRegistry.ADMIN_DASHBOARD.STATUS.API)}</span>
                                <span style={{ color: 'var(--success-600)', fontWeight: '900' }}>{t(ContentRegistry.ADMIN_DASHBOARD.STATUS.HEALTHY)}</span>
                            </div>
                            <div style={{ display: 'flex', justifyContent: 'space-between', padding: '0.75rem 0', borderBottom: '1px solid var(--card-border)' }} data-cy="status-item-client-app">
                                <span style={{ color: 'var(--text-200)' }}>{t(ContentRegistry.ADMIN_DASHBOARD.STATUS.CLIENT_APP)}</span>
                                <span style={{ color: 'var(--success-600)', fontWeight: '900' }}>{ContentRegistry.ADMIN_DASHBOARD.STATUS.ONLINE('1.0.4')}</span>
                            </div>
                            <div style={{ display: 'flex', justifyContent: 'space-between', padding: '0.75rem 0' }} data-cy="status-item-psw-app">
                                <span style={{ color: 'var(--text-200)' }}>{t(ContentRegistry.ADMIN_DASHBOARD.STATUS.PSW_APP)}</span>
                                <span style={{ color: 'var(--success-600)', fontWeight: '900' }}>{ContentRegistry.ADMIN_DASHBOARD.STATUS.ONLINE('1.0.4')}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <CreateVisitModal
                isOpen={isPostShiftModalOpen}
                onClose={() => setIsPostShiftModalOpen(false)}
                onSuccess={() => {
                    setIsPostShiftModalOpen(false);
                    showToast(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.POST_SUCCESS, 'success');
                }}
            />
        </div>
    );
}
