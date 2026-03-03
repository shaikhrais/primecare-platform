import React, { useEffect, useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import { useTranslation } from 'react-i18next';

// Components
import { BusinessProgressHeader } from './components/BusinessProgressHeader';
import { BusinessDomainCard } from './components/BusinessDomainCard';
import { BusinessStatusFooter } from './components/BusinessStatusFooter';

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
            route: RouteRegistry.ADMIN.SETUP_WIZARD
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

            <BusinessProgressHeader score={stats?.modelScore || 0} />

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(340px, 1fr))', gap: '1.5rem' }}>
                {domains.map(domain => (
                    <BusinessDomainCard key={domain.id} domain={domain} />
                ))}
            </div>

            <BusinessStatusFooter />
        </div>
    );
}
