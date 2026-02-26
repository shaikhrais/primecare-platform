import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
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

const { ContentRegistry, RouteRegistry, ApiRegistry } = AdminRegistry;

export default function AdminDashboard() {
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



    return (
        <div data-cy="page.container">
            <div style={{ marginBottom: '2rem' }}>
                <h1 style={{ margin: '0 0 6px 0', fontSize: '32px', color: 'var(--text)' }} data-cy="page.title">
                    {ContentRegistry.ADMIN_DASHBOARD.TITLES.WELCOME}
                </h1>
                <p style={{ margin: 0, opacity: 0.6 }} data-cy="page.subtitle">{ContentRegistry.ADMIN_DASHBOARD.TITLES.SUBTITLE}</p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))', gap: '1.5rem', marginBottom: '3rem' }} data-cy="stats-cards">
                {[
                    { label: ContentRegistry.ADMIN_DASHBOARD.STATS.TOTAL_USERS, value: stats.totalUsers, icon: '👥', link: `${RouteRegistry.USERS}?role=psw` },
                    { label: ContentRegistry.ADMIN_DASHBOARD.STATS.NEW_INQUIRIES, value: stats.totalLeads, icon: '📥', link: `${RouteRegistry.LEADS}?status=new` },
                    { label: ContentRegistry.ADMIN_DASHBOARD.STATS.PENDING_VISITS, value: stats.pendingVisits, icon: '📝', link: `${RouteRegistry.SCHEDULE}` },
                    { label: ContentRegistry.ADMIN_DASHBOARD.STATS.TOTAL_VISITS, value: stats.totalVisits, icon: '📋', link: `${RouteRegistry.SCHEDULE}` },
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
                                {ContentRegistry.ADMIN_DASHBOARD.ACTIONS.VIEW_DETAILS}
                            </div>
                        </div>
                    </Link>
                ))}
            </div>

            {/* Interactive Charts Section */}
            <h2 style={{ fontSize: '0.75rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '2px', marginBottom: '1.5rem', color: 'var(--text-300)' }}>
                {ContentRegistry.ADMIN_DASHBOARD.TITLES.ANALYTICS}
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
                        {ContentRegistry.ADMIN_DASHBOARD.TITLES.QUICK_ACTIONS}
                    </div>
                    <div className="pc-card-b">
                        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem', marginTop: '1rem' }}>
                            <Link to={RouteRegistry.USERS} style={{ textDecoration: 'none' }} data-cy="qa-link-users">
                                <button className="btn" style={{ width: '100%', textAlign: 'left', background: '#F9FAFB' }}>
                                    <div style={{ color: 'var(--brand-500)' }}>{ContentRegistry.USERS.TITLE}</div>
                                    <div style={{ fontSize: '0.75rem', color: 'var(--text-300)' }}>{ContentRegistry.ADMIN_DASHBOARD.ACTIONS.CHECK_CERTS}</div>
                                </button>
                            </Link>
                            <Link to={RouteRegistry.SCHEDULE} style={{ textDecoration: 'none' }} data-cy="qa-link-schedule">
                                <button className="btn" style={{ width: '100%', textAlign: 'left', background: '#F9FAFB' }}>
                                    <div style={{ color: 'var(--brand-500)' }}>{ContentRegistry.ADMIN_DASHBOARD.ACTIONS.VIEW_SCHEDULE}</div>
                                    <div style={{ fontSize: '0.75rem', color: 'var(--text-300)' }}>{ContentRegistry.ADMIN_DASHBOARD.ACTIONS.MANAGE_ASSIGNMENTS}</div>
                                </button>
                            </Link>
                            <Link to={RouteRegistry.LEADS} style={{ textDecoration: 'none' }} data-cy="qa-link-leads">
                                <button className="btn" style={{ width: '100%', textAlign: 'left', background: '#F9FAFB' }}>
                                    <div style={{ color: 'var(--brand-500)' }}>{ContentRegistry.ADMIN_DASHBOARD.ACTIONS.REVIEW_LEADS}</div>
                                    <div style={{ fontSize: '0.75rem', color: 'var(--text-300)' }}>{ContentRegistry.ADMIN_DASHBOARD.ACTIONS.RESPOND_INQUIRIES}</div>
                                </button>
                            </Link>
                            <Link to={RouteRegistry.SETTINGS} style={{ textDecoration: 'none' }} data-cy="qa-link-settings">
                                <button className="btn" style={{ width: '100%', textAlign: 'left', background: '#F9FAFB' }}>
                                    <div style={{ color: 'var(--brand-500)' }}>{ContentRegistry.ADMIN_DASHBOARD.ACTIONS.SYSTEM_CONFIG}</div>
                                    <div style={{ fontSize: '0.75rem', color: 'var(--text-300)' }}>{ContentRegistry.ADMIN_DASHBOARD.ACTIONS.APP_ADJUSTS}</div>
                                </button>
                            </Link>

                            <button
                                onClick={() => setIsPostShiftModalOpen(true)}
                                className="btn"
                                style={{ width: '100%', textAlign: 'left', background: '#E6F4EA', border: '1px solid #00875A' }}
                                data-cy="qa-btn-post-shift"
                            >
                                <div style={{ color: '#00875A', fontWeight: 'bold' }}>{ContentRegistry.ADMIN_DASHBOARD.ACTIONS.POST_SHIFT}</div>
                                <div style={{ fontSize: '0.75rem', color: '#00875A' }}>{ContentRegistry.ADMIN_DASHBOARD.ACTIONS.POST_SHIFT_DESC}</div>
                            </button>
                        </div>
                    </div>
                </div>

                <div className="pc-card">
                    <div className="pc-card-h">
                        {ContentRegistry.ADMIN_DASHBOARD.TITLES.OPERATIONAL_STATUS}
                    </div>
                    <div className="pc-card-b">
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', padding: '0.75rem 0', borderBottom: '1px solid var(--card-border)' }} data-cy="status-item-api">
                                <span style={{ color: 'var(--text-200)' }}>{ContentRegistry.ADMIN_DASHBOARD.STATUS.API}</span>
                                <span style={{ color: 'var(--success-600)', fontWeight: '900' }}>{ContentRegistry.ADMIN_DASHBOARD.STATUS.HEALTHY}</span>
                            </div>
                            <div style={{ display: 'flex', justifyContent: 'space-between', padding: '0.75rem 0', borderBottom: '1px solid var(--card-border)' }} data-cy="status-item-client-app">
                                <span style={{ color: 'var(--text-200)' }}>{ContentRegistry.ADMIN_DASHBOARD.STATUS.CLIENT_APP}</span>
                                <span style={{ color: 'var(--success-600)', fontWeight: '900' }}>{ContentRegistry.ADMIN_DASHBOARD.STATUS.ONLINE('1.0.4')}</span>
                            </div>
                            <div style={{ display: 'flex', justifyContent: 'space-between', padding: '0.75rem 0' }} data-cy="status-item-psw-app">
                                <span style={{ color: 'var(--text-200)' }}>{ContentRegistry.ADMIN_DASHBOARD.STATUS.PSW_APP}</span>
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
