import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { useAuth } from '@/shared/context/AuthContext';
import { apiClient } from '@/shared/utils/apiClient';
import { CreateVisitModal } from '@/shared/components/modals/CreateVisitModal';
import { useTranslation } from 'react-i18next';

// Components
import { SetupBanner } from './components/SetupBanner';
import { DashboardStats } from './components/DashboardStats';
import { HealthAlerts } from './components/HealthAlerts';
import { DashboardCharts } from './components/DashboardCharts';
import { QuickActions } from './components/QuickActions';
import { OperationalStatus } from './components/OperationalStatus';

const { ContentRegistry, RouteRegistry, ApiRegistry } = AdminRegistry;

export default function AdminDashboard() {
    const { t } = useTranslation();
    const { showToast } = useNotification();
    const { user } = useAuth();
    const [stats, setStats] = useState({ totalUsers: 0, pendingVisits: 0, totalVisits: 0, totalLeads: 0, modelScore: 0, healthAlerts: null });
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
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '1.5rem' }}>
                <div>
                    <h1 style={{ margin: '0 0 6px 0', fontSize: '32px', color: 'var(--text)' }} data-cy="page.title">
                        {user?.tenantId ? `Master Dashboard` : t(ContentRegistry.ADMIN_DASHBOARD.TITLES.WELCOME)}
                    </h1>
                    <p style={{ margin: 0, opacity: 0.6 }} data-cy="page.subtitle">
                        {user?.email} • Franchise Command Center
                    </p>
                </div>
                <Link to={RouteRegistry.SCRUM_MASTER.DEV_KB}>
                    <button style={{
                        padding: '0.5rem 1rem',
                        background: '#f3f4f6',
                        color: '#4b5563',
                        border: '1px solid #e5e7eb',
                        borderRadius: '0.75rem',
                        fontSize: '0.875rem',
                        fontWeight: '600',
                        cursor: 'pointer',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '0.5rem'
                    }}>
                        {AdminRegistry.ButtonRegistry.find((b: any) => b.id === 'btn-sm-universal-sweep')?.label || '🛠️ Developer Audit'}
                    </button>
                </Link>
            </div>

            {/* Business Model Score & Setup Wizard Banner */}
            <SetupBanner modelScore={stats.modelScore} />

            {/* Statistics Cards */}
            <DashboardStats stats={stats} />

            {/* Business Health Monitor Section */}
            <HealthAlerts alerts={stats.healthAlerts as any} />

            {/* Interactive Charts Section */}
            <DashboardCharts />

            <div className="grid" style={{ marginTop: '2rem' }}>
                <QuickActions onPostShift={() => setIsPostShiftModalOpen(true)} />
                <OperationalStatus />
            </div>

            <CreateVisitModal
                isOpen={isPostShiftModalOpen}
                onClose={() => setIsPostShiftModalOpen(false)}
                onSuccess={() => {
                    setIsPostShiftModalOpen(false);
                    showToast(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.POST_SUCCESS, 'success');
                }}
            />
        </div >
    );
}
