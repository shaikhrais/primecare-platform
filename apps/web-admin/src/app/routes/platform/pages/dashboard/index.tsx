import React, { useState, useEffect } from 'react';
import { apiClient } from '@/shared/utils/apiClient';

const PlatformDashboard: React.FC = () => {
    const [stats, setStats] = useState<any>(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchStats = async () => {
            try {
                const response = await apiClient.get('/v1/system/platform/stats');
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

    if (loading) return <div>Loading Global Stats...</div>;

    return (
        <div style={{ padding: '2rem' }}>
            <h1 style={{ marginBottom: '2rem', fontSize: '1.875rem', fontWeight: 'bold', color: '#111827' }}>Platform Global Overview</h1>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))', gap: '1.5rem' }}>
                <StatCard title="Total Businesses" value={stats?.tenants || 0} icon="🏢" color="#2563EB" />
                <StatCard title="Total Users" value={stats?.users || 0} icon="👥" color="#10B981" />
                <StatCard title="Total Visits" value={stats?.visits || 0} icon="🚗" color="#F59E0B" />
            </div>

            <div style={{ marginTop: '3rem', padding: '1.5rem', backgroundColor: '#F9FAFB', borderRadius: '0.75rem', border: '1px solid #E5E7EB' }}>
                <h2 style={{ fontSize: '1.25rem', fontWeight: 'semibold', color: '#374151' }}>Platform Health</h2>
                <p style={{ color: '#6B7280', marginTop: '0.5rem' }}>All systems operational across all tenant nodes.</p>
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
