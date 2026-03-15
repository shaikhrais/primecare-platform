import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { useAuth } from '@/shared/context/AuthContext';
import { apiClient } from '@/shared/utils/apiClient';
import { useMutation } from '@tanstack/react-query';
import { CreateVisitModal } from '@/shared/components/modals/CreateVisitModal';
import { useTranslation } from 'react-i18next';
import { PageActionBar } from '@/shared/components/ui/PageActionBar';
import { PcButton } from '@/shared/components/ui/PcButton';
import { SetupBanner } from './components/SetupBanner';
import { DashboardStats } from './components/DashboardStats';
import { HealthAlerts } from './components/HealthAlerts';
import { DashboardCharts } from './components/DashboardCharts';
import { QuickActions } from './components/QuickActions';
import { OperationalStatus } from './components/OperationalStatus';
import { BusinessIntelligenceSection } from './components/BusinessIntelligence';
import { useDialog } from '@/shared/hooks/useDialog';
import { useRealtimeQuery } from '@/shared/hooks/useRealtimeQuery';
import { LiveIndicator } from '@/shared/components/ui/LiveIndicator';
import { DashboardSkeleton } from '@/shared/components/ui/Skeleton';

const { ContentRegistry, RouteRegistry, ApiRegistry } = AdminRegistry;

export default function AdminDashboard() {
    const { t } = useTranslation();
    const { confirm, DialogRenderer } = useDialog();
    const { showToast } = useNotification();
    const { user } = useAuth();
    const navigate = useNavigate();

    // TanStack Query: live-updating admin stats (polls every 15s)
    const { data: stats = { totalUsers: 0, pendingVisits: 0, totalVisits: 0, totalLeads: 0, modelScore: 0, healthAlerts: null }, isLoading: loading, isLive, lastUpdated } = useRealtimeQuery<any>(ApiRegistry.ADMIN.STATS, {
        queryKey: ['admin', 'stats'],
        interval: 15_000,
    });

    const [isPostShiftModalOpen, setIsPostShiftModalOpen] = useState(false);

    const actionMutation = useMutation({
        mutationFn: async ({ endpoint }: { endpoint: string }) => {
            const res = await apiClient.post(endpoint, {});
            if (!res.ok) { const err = await res.json(); throw new Error(err.error || 'Action failed'); }
            return res.json();
        },
    });

    const handleApiAction = (endpoint: string, successMsg: string, errorMsg: string) => {
        actionMutation.mutate({ endpoint }, {
            onSuccess: () => showToast(successMsg, 'success'),
            onError: (err: any) => showToast(err?.message || errorMsg, 'error'),
        });
    };

    const handleExport = async () => {
        try {
            const res = await apiClient.get('/v1/admin/actions/export?format=csv');
            if (res.ok) {
                const blob = await res.blob();
                const url = URL.createObjectURL(blob);
                const a = document.createElement('a'); a.href = url; a.download = `export-${new Date().toISOString().split('T')[0]}.csv`;
                document.body.appendChild(a); a.click(); document.body.removeChild(a); URL.revokeObjectURL(url);
                showToast('Export downloaded successfully', 'success');
            } else { showToast('Export failed — check permissions', 'error'); }
        } catch { showToast('Network error during export', 'error'); }
    };

    const handleSuspendReseller = async () => {
        if (!(await confirm('Suspend Reseller Agreement', 'Are you sure you want to suspend the reseller agreement? This cannot be undone easily.'))) return;
        await handleApiAction('/v1/admin/actions/suspend-reseller', 'Reseller agreement suspended', 'Failed to suspend reseller');
    };

    const handleVerifyChain = async () => {
        try {
            const res = await apiClient.get('/v1/admin/actions/audit-chain/verify');
            if (res.ok) {
                const data = await res.json();
                showToast(data.message, data.chain?.valid ? 'success' : 'error');
            } else { showToast('Chain verification failed', 'error'); }
        } catch { showToast('Network error during verification', 'error'); }
    };

    const handleAuditStats = async () => {
        try {
            const res = await apiClient.get('/v1/admin/actions/audit-chain/stats');
            if (res.ok) {
                const data = await res.json();
                const s = data.stats;
                showToast(`📊 Audit Chain: ${s.totalEntries} entries (${s.entriesToday} today)`, 'success');
            } else { showToast('Failed to fetch stats', 'error'); }
        } catch { showToast('Network error', 'error'); }
    };
    return (
        <div data-cy="page.container" role="main" aria-label="Admin Dashboard">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '1.5rem' }}>
                <div>
                    <h1 style={{ margin: '0 0 6px 0', fontSize: '32px', color: 'var(--text)' }} data-cy="page.title">
                        {user?.tenantId ? `Master Dashboard` : t(ContentRegistry.ADMIN_DASHBOARD.TITLES.WELCOME)}
                    </h1>
                    <p style={{ margin: 0, opacity: 0.6, display: 'flex', alignItems: 'center', gap: '8px' }} data-cy="page.subtitle">
                        {user?.email} • Franchise Command Center
                        <LiveIndicator isLive={isLive} lastUpdated={lastUpdated} />
                    </p>
                </div>
                <PageActionBar pageId="admin.dashboard" size="sm" handlers={{
                    'btn-admin-report-export': handleExport,
                    'btn-reseller-suspend': handleSuspendReseller,
                }} />
            </div>
            {/* Custom audit actions (not in ButtonRegistry) */}
            <div style={{ display: 'flex', gap: '0.5rem', marginBottom: '1.5rem' }}>
                <PcButton variant="primary" size="xs" label="🛡️ Verify Chain" onClick={handleVerifyChain} data-cy="btn-verify-chain" />
                <PcButton variant="secondary" size="xs" label="📊 Audit Stats" onClick={handleAuditStats} data-cy="btn-audit-stats" />
            </div>

            {/* Business Model Score & Setup Wizard Banner */}
            <SetupBanner modelScore={stats.modelScore} />

            {/* Statistics Cards */}
            <DashboardStats stats={stats} />

            {/* Business Health Monitor Section */}
            <HealthAlerts alerts={stats.healthAlerts as any} />

            {/* Interactive Charts Section */}
            <DashboardCharts />

            {/* Business Intelligence Section */}
            <BusinessIntelligenceSection />

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
            <DialogRenderer />
        </div >
    );
}
