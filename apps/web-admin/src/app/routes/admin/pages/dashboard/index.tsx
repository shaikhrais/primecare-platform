import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { apiClient } from '@/shared/utils/apiClient';

const { ContentRegistry, RouteRegistry, ApiRegistry } = AdminRegistry;

export default function AdminDashboard() {
    const { showToast } = useNotification();
    const [stats, setStats] = useState({ totalUsers: 0, pendingVisits: 0, totalVisits: 0, totalLeads: 0 });
    const [loading, setLoading] = useState(true);

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

    const statCards = [
        { label: ContentRegistry.ADMIN_DASHBOARD.STATS.TOTAL_USERS, value: stats.totalUsers, color: '#004d40', icon: '👥' },
        { label: ContentRegistry.ADMIN_DASHBOARD.STATS.NEW_INQUIRIES, value: stats.totalLeads, color: '#2563eb', icon: '📥' },
        { label: ContentRegistry.ADMIN_DASHBOARD.STATS.PENDING_VISITS, value: stats.pendingVisits, color: '#f59e0b', icon: '📝' },
        { label: ContentRegistry.ADMIN_DASHBOARD.STATS.TOTAL_VISITS, value: stats.totalVisits, color: '#ef4444', icon: '📋' },
    ];

    return (
        <div data-cy="page.container">
            <div style={{ marginBottom: '2rem' }}>
                <h1 style={{ margin: '0 0 6px 0', fontSize: '34px', letterSpacing: '.2px', color: 'var(--text-100)' }} data-cy="page.title">
                    {ContentRegistry.ADMIN_DASHBOARD.TITLES.WELCOME}
                </h1>
                <p className="sub" style={{ margin: 0 }} data-cy="page.subtitle">{ContentRegistry.ADMIN_DASHBOARD.TITLES.SUBTITLE}</p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))', gap: '1.5rem', marginBottom: '3rem' }} data-cy="stats-cards">
                {statCards.map((card, index) => (
                    <div key={index} className="pc-card" data-cy={`stat-card-${card.label.toLowerCase().replace(/\s+/g, '-')}`} style={{
                        padding: '1.5rem',
                        display: 'flex',
                        flexDirection: 'column',
                        gap: '0.5rem'
                    }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                            <span style={{ color: 'var(--text-300)', fontSize: '0.875rem', fontWeight: '500' }}>{card.label}</span>
                            <span style={{ fontSize: '1.25rem' }}>{card.icon}</span>
                        </div>
                        <div style={{ fontSize: '2rem', fontWeight: 900, color: 'var(--brand-500)', letterSpacing: '1px' }}>
                            {card.value}
                        </div>
                    </div>
                ))}
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
                                <button className="btn" style={{ width: '100%', textAlign: 'left', background: 'rgba(255,255,255,.03)' }}>
                                    <div style={{ color: 'var(--brand-500)' }}>{ContentRegistry.USERS.TITLE}</div>
                                    <div style={{ fontSize: '0.75rem', color: 'var(--text-300)' }}>Check certifications</div>
                                </button>
                            </Link>
                            <Link to={RouteRegistry.SCHEDULE} style={{ textDecoration: 'none' }} data-cy="qa-link-schedule">
                                <button className="btn" style={{ width: '100%', textAlign: 'left', background: 'rgba(255,255,255,.03)' }}>
                                    <div style={{ color: 'var(--brand-500)' }}>View Schedule</div>
                                    <div style={{ fontSize: '0.75rem', color: 'var(--text-300)' }}>Manage assignments</div>
                                </button>
                            </Link>
                            <Link to="/leads" style={{ textDecoration: 'none' }} data-cy="qa-link-leads">
                                <button className="btn" style={{ width: '100%', textAlign: 'left', background: 'rgba(255,255,255,.03)' }}>
                                    <div style={{ color: 'var(--brand-500)' }}>Review Leads</div>
                                    <div style={{ fontSize: '0.75rem', color: 'var(--text-300)' }}>Respond to inquiries</div>
                                </button>
                            </Link>
                            <Link to="/settings" style={{ textDecoration: 'none' }} data-cy="qa-link-settings">
                                <button className="btn" style={{ width: '100%', textAlign: 'left', background: 'rgba(255,255,255,.03)' }}>
                                    <div style={{ color: 'var(--brand-500)' }}>System Config</div>
                                    <div style={{ fontSize: '0.75rem', color: 'var(--text-300)' }}>App adjustments</div>
                                </button>
                            </Link>
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
                                <span style={{ color: 'var(--text-200)' }}>Worker API Status</span>
                                <span style={{ color: 'var(--success-600)', fontWeight: '900' }}>● Healthy</span>
                            </div>
                            <div style={{ display: 'flex', justifyContent: 'space-between', padding: '0.75rem 0', borderBottom: '1px solid var(--card-border)' }} data-cy="status-item-client-app">
                                <span style={{ color: 'var(--text-200)' }}>Mobile Client App</span>
                                <span style={{ color: 'var(--success-600)', fontWeight: '900' }}>● v1.0.4 Online</span>
                            </div>
                            <div style={{ display: 'flex', justifyContent: 'space-between', padding: '0.75rem 0' }} data-cy="status-item-psw-app">
                                <span style={{ color: 'var(--text-200)' }}>Mobile PSW App</span>
                                <span style={{ color: 'var(--success-600)', fontWeight: '900' }}>● v1.0.4 Online</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}
