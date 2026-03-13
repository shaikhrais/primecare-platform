import React, { useState, useEffect } from 'react';
import { apiClient } from '@/shared/utils/apiClient';
import { AdminRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';

const { ContentRegistry, ApiRegistry } = AdminRegistry;

const PlatformDashboard: React.FC = () => {
    const { t } = useTranslation();
    const [stats, setStats] = useState<any>(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchStats = async () => {
            try {
                const response = await apiClient.get(ApiRegistry.SYSTEM.PLATFORM_STATS);
                if (response.ok) {
                    const data = await response.json();
                    setStats(data);
                }
            } catch (error) {
                console.error('Failed to fetch platform stats', error);
            } finally {
                setLoading(false);
            }
        };
        fetchStats();
    }, []);

    if (loading) return <div>{t(ContentRegistry.PLATFORM_DASHBOARD.MESSAGES.LOADING)}</div>;

    return (
        <div style={{ padding: '2rem' }}>
            <h1 style={{ marginBottom: '2rem', fontSize: '1.875rem', fontWeight: 'bold', color: '#111827' }}>{t(ContentRegistry.PLATFORM_DASHBOARD.TITLE)}</h1>
            <p style={{ color: '#6B7280', marginBottom: '2rem' }}>{t(ContentRegistry.PLATFORM_DASHBOARD.SUBTITLE)}</p>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))', gap: '1.5rem' }}>
                <StatCard title={t(ContentRegistry.PLATFORM_DASHBOARD.STATS.MASTER_AGENCIES)} value={stats?.tenants || 0} icon="🏢" color="#2563EB" />
                <StatCard title={t(ContentRegistry.PLATFORM_DASHBOARD.STATS.NETWORK_USERS)} value={stats?.users || 0} icon="👥" color="#10B981" />
                <StatCard title={t(ContentRegistry.PLATFORM_DASHBOARD.STATS.PLATFORM_VISITS)} value={stats?.visits || 0} icon="🚗" color="#F59E0B" />
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem', marginTop: '3rem' }}>
                <div style={{ padding: '1.5rem', backgroundColor: '#F9FAFB', borderRadius: '0.75rem', border: '1px solid #E5E7EB' }}>
                    <h2 data-cy="h2-index-0" style={{ fontSize: '1.25rem', fontWeight: 'bold', color: '#374151' }}>{t(ContentRegistry.PLATFORM_DASHBOARD.HEALTH.TITLE)}</h2>
                    <p style={{ color: '#6B7280', marginTop: '0.5rem' }}>{t(ContentRegistry.PLATFORM_DASHBOARD.HEALTH.DESC)}</p>
                </div>

                <div style={{ padding: '1.5rem', backgroundColor: '#EFF6FF', borderRadius: '0.75rem', border: '1px solid #BFDBFE' }}>
                    <h2 data-cy="h2-index-1" style={{ fontSize: '1.25rem', fontWeight: 'bold', color: '#1E3A8A' }}>{t(ContentRegistry.PLATFORM_DASHBOARD.RISK.TITLE)}</h2>
                    <p style={{ color: '#3B82F6', marginTop: '0.5rem' }}>{t(ContentRegistry.PLATFORM_DASHBOARD.RISK.DESC)}</p>
                </div>
            </div>
        </div>
    );
};

const StatCard: React.FC<{ title: string; value: number; icon: string; color: string }> = ({ title, value, icon, color }) => (
    <div style={{
        padding: '1.5rem',
        backgroundColor: '#FFFFFF',
        borderRadius: '0.75rem',
        boxShadow: '0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06)',
        borderLeft: `4px solid ${color}`
    }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
            <div>
                <p style={{ fontSize: '0.875rem', fontWeight: 'medium', color: '#6B7280' }}>{title}</p>
                <p style={{ fontSize: '1.5rem', fontWeight: 'bold', color: '#111827', marginTop: '0.25rem' }}>{value.toLocaleString()}</p>
            </div>
            <span style={{ fontSize: '1.5rem' }}>{icon}</span>
        </div>
    </div>
);

export default PlatformDashboard;
