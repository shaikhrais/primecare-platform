import React, { useEffect, useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import { useTranslation } from 'react-i18next';

const { ContentRegistry, RouteRegistry, ApiRegistry } = AdminRegistry;

interface BusinessStatusData {
    totalUsers: number;
    totalLeads: number;
    pendingVisits: number;
    totalVisits: number;
    modelScore: number;
    healthAlerts: {
        complianceRisk: number;
        coverageGap: number;
        pipelineStagnation: number;
    };
}

export default function BusinessStatus() {
    const { t } = useTranslation();
    const navigate = useNavigate();
    const [stats, setStats] = useState<BusinessStatusData | null>(null);
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
                console.error('Failed to fetch business status', error);
            } finally {
                setLoading(false);
            }
        };
        fetchStats();
    }, []);

    const domains = [
        {
            id: 'strategy',
            name: t(ContentRegistry.BUSINESS_STATUS.DOMAINS.STRATEGY),
            status: stats && stats.modelScore > 0 ? 'Active' : 'Pending',
            count: `${stats?.modelScore || 0}% Complete`,
            icon: '🚀',
            color: '#4f46e5',
            action: 'Update Strategy',
            route: RouteRegistry.ADMIN.BUSINESS_MODEL_WIZARD
        },
        {
            id: 'services',
            name: t(ContentRegistry.BUSINESS_STATUS.DOMAINS.SERVICES),
            status: 'Operational',
            count: `${stats?.totalVisits || 0} Total Visits`,
            icon: '🩺',
            color: '#0ea5e9',
            action: 'Configure Services',
            route: RouteRegistry.ADMIN.SETUP_WIZARD // Step 1 is services
        },
        {
            id: 'staff',
            name: t(ContentRegistry.BUSINESS_STATUS.DOMAINS.STAFF),
            status: stats && stats.totalUsers > 0 ? 'Staffed' : 'Empty',
            count: `${stats?.totalUsers || 0} Providers`,
            icon: '👥',
            color: '#10b981',
            action: 'Add Provider',
            route: RouteRegistry.ADMIN.STAFF_ONBOARDING
        },
        {
            id: 'clients',
            name: t(ContentRegistry.BUSINESS_STATUS.DOMAINS.CLIENTS),
            status: stats && stats.totalLeads > 0 ? 'Active' : 'Scanning',
            count: `${stats?.totalLeads || 0} Leads/Clients`,
            icon: '🏠',
            color: '#f59e0b',
            action: 'Admit Client',
            route: RouteRegistry.ADMIN.CARE_PLAN_WIZARD
        },
        {
            id: 'finance',
            name: t(ContentRegistry.BUSINESS_STATUS.DOMAINS.FINANCE),
            status: 'Ready',
            count: 'Billing Active',
            icon: '💰',
            color: '#8b5cf6',
            action: 'Manage Billing',
            route: RouteRegistry.ADMIN.REVENUE_WIZARD
        }
    ];

    if (loading) {
        return <div style={{ padding: '4rem', textAlign: 'center', color: 'var(--text-300)' }}>{t(ContentRegistry.BUSINESS_STATUS.INITIALIZING)}</div>;
    }

    return (
        <div style={{ maxWidth: '1200px', margin: '0 auto', padding: '2rem' }}>
            <div style={{ marginBottom: '3rem' }}>
                <h1 style={{ fontSize: '2.5rem', fontWeight: '900', color: '#111827', margin: 0 }}>
                    {t(ContentRegistry.BUSINESS_STATUS.TITLE)}
                </h1>
                <p style={{ fontSize: '1.125rem', color: '#6b7280', marginTop: '0.5rem' }}>
                    {t(ContentRegistry.BUSINESS_STATUS.SUBTITLE)}
                </p>
            </div>

            {/* Overall Setup Progress */}
            <div style={{ background: 'white', padding: '2.5rem', borderRadius: '2rem', border: '1px solid #e5e7eb', marginBottom: '3rem', boxShadow: '0 1px 3px 0 rgba(0, 0, 0, 0.1)' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', marginBottom: '1.5rem' }}>
                    <div>
                        <div style={{ fontSize: '0.875rem', fontWeight: '700', color: '#4f46e5', textTransform: 'uppercase', letterSpacing: '0.05em' }}>Overall Readiness</div>
                        <div style={{ fontSize: '2.5rem', fontWeight: '900', color: '#111827' }}>{stats?.modelScore || 0}%</div>
                    </div>
                    <div style={{ textAlign: 'right', color: '#6b7280', fontSize: '0.875rem' }}>
                        Completing all wizards unlocks full automation.
                    </div>
                </div>
                <div style={{ width: '100%', height: '16px', background: '#f3f4f6', borderRadius: '8px', overflow: 'hidden', display: 'flex' }}>
                    <div style={{
                        width: `${stats?.modelScore || 0}%`,
                        height: '100%',
                        background: 'linear-gradient(90deg, #4f46e5 0%, #06b6d4 100%)',
                        transition: 'width 1s cubic-bezier(0.4, 0, 0.2, 1)'
                    }} />
                </div>
            </div>

            {/* Domain Grid */}
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(340px, 1fr))', gap: '1.5rem' }}>
                {domains.map(domain => (
                    <div key={domain.id} style={{
                        background: 'white',
                        borderRadius: '1.5rem',
                        padding: '2rem',
                        border: '1px solid #e5e7eb',
                        display: 'flex',
                        flexDirection: 'column',
                        gap: '1.5rem',
                        transition: 'transform 0.2s, box-shadow 0.2s',
                        cursor: 'default'
                    }}
                        onMouseOver={e => {
                            e.currentTarget.style.transform = 'translateY(-4px)';
                            e.currentTarget.style.boxShadow = '0 10px 15px -3px rgba(0, 0, 0, 0.1)';
                        }}
                        onMouseOut={e => {
                            e.currentTarget.style.transform = 'translateY(0)';
                            e.currentTarget.style.boxShadow = 'none';
                        }}
                    >
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                            <div style={{
                                width: '56px',
                                height: '56px',
                                borderRadius: '1rem',
                                background: `${domain.color}15`,
                                display: 'flex',
                                alignItems: 'center',
                                justifyContent: 'center',
                                fontSize: '2rem'
                            }}>
                                {domain.icon}
                            </div>
                            <div style={{
                                padding: '0.375rem 0.75rem',
                                borderRadius: '9999px',
                                background: domain.status === 'Active' || domain.status === 'Staffed' || domain.status === 'Operational' || domain.status === 'Ready'
                                    ? '#ecfdf5' : '#fff7ed',
                                color: domain.status === 'Active' || domain.status === 'Staffed' || domain.status === 'Operational' || domain.status === 'Ready'
                                    ? '#059669' : '#d97706',
                                fontSize: '0.75rem',
                                fontWeight: '700'
                            }}>
                                {domain.status}
                            </div>
                        </div>

                        <div>
                            <h3 style={{ fontSize: '1.25rem', fontWeight: '800', color: '#111827', margin: 0 }}>{domain.name}</h3>
                            <p style={{ fontSize: '1rem', color: '#6b7280', margin: '0.25rem 0 0 0' }}>{domain.count}</p>
                        </div>

                        <div style={{ marginTop: 'auto', display: 'flex', gap: '0.75rem' }}>
                            <button
                                onClick={() => navigate(domain.route)}
                                style={{
                                    flex: 1,
                                    padding: '0.75rem',
                                    background: domain.color,
                                    color: 'white',
                                    border: 'none',
                                    borderRadius: '0.75rem',
                                    fontWeight: '700',
                                    fontSize: '0.875rem',
                                    cursor: 'pointer'
                                }}
                            >
                                {domain.action}
                            </button>
                            <Link to={RouteRegistry.ADMIN.WIZARD_HUB} style={{ flex: 1 }}>
                                <button style={{
                                    width: '100%',
                                    padding: '0.75rem',
                                    background: 'white',
                                    color: '#374151',
                                    border: '1px solid #d1d5db',
                                    borderRadius: '0.75rem',
                                    fontWeight: '600',
                                    fontSize: '0.875rem',
                                    cursor: 'pointer'
                                }}>
                                    Wizards
                                </button>
                            </Link>
                        </div>
                    </div>
                ))}
            </div>

            {/* Quick Actions Footer */}
            <div style={{ marginTop: '4rem', padding: '2rem', background: '#f9fafb', borderRadius: '1.5rem', textAlign: 'center' }}>
                <h4 style={{ fontWeight: '800', marginBottom: '1rem' }}>{t(ContentRegistry.BUSINESS_STATUS.FOOTER.TITLE)}</h4>
                <div style={{ display: 'flex', justifyContent: 'center', gap: '2rem', flexWrap: 'wrap' }}>
                    <Link to={RouteRegistry.ADMIN.USERS} style={{ color: '#4f46e5', fontWeight: '600', textDecoration: 'none' }}>{t(ContentRegistry.BUSINESS_STATUS.FOOTER.VIEW_STAFF)}</Link>
                    <Link to={RouteRegistry.ADMIN.LEADS} style={{ color: '#4f46e5', fontWeight: '600', textDecoration: 'none' }}>{t(ContentRegistry.BUSINESS_STATUS.FOOTER.MANAGE_LEADS)}</Link>
                    <Link to={RouteRegistry.ADMIN.SCHEDULE} style={{ color: '#4f46e5', fontWeight: '600', textDecoration: 'none' }}>{t(ContentRegistry.BUSINESS_STATUS.FOOTER.DISPATCH_SHIFTS)}</Link>
                </div>
            </div>
        </div>
    );
}
