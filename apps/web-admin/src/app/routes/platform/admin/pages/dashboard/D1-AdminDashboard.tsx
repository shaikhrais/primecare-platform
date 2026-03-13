import React, { useEffect, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
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
import { useDialog } from '@/shared/hooks/useDialog';

const { ContentRegistry, RouteRegistry, ApiRegistry } = AdminRegistry;

export default function AdminDashboard() {
    const { t } = useTranslation();
    const { confirm, DialogRenderer } = useDialog();
    const { showToast } = useNotification();
    const { user } = useAuth();
    const navigate = useNavigate();
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

    const handleApiAction = async (endpoint: string, successMsg: string, errorMsg: string) => {
        try {
            const res = await apiClient.post(endpoint, {});
            if (res.ok) { showToast(successMsg, 'success'); }
            else { const err = await res.json(); showToast(err.error || errorMsg, 'error'); }
        } catch { showToast(errorMsg, 'error'); }
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
                <div style={{ display: 'flex', gap: '0.5rem' }}>
                    <button data-cy="btn-admin.admin-dashboard-0" style={{
                        padding: '0.5rem 1rem',
                        background: '#0f172a',
                        color: '#ffffff',
                        border: 'none',
                        borderRadius: '0.75rem',
                        fontSize: '0.875rem',
                        fontWeight: '600',
                        cursor: 'pointer',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '0.5rem'
                    }} onClick={() => handleApiAction('/v1/admin/actions/commit-overrides', 'UI overrides committed to registry', 'Failed to commit overrides')}>
                        {AdminRegistry.ButtonRegistry.find((b: any) => b.id === 'btn-admin-ui-override')?.label || 'Commit UI Overrides'}
                    </button>
                    <button data-cy="btn-admin.admin-dashboard-1" style={{
                        padding: '0.5rem 1rem',
                        background: 'var(--brand-500)',
                        color: 'white',
                        border: 'none',
                        borderRadius: '0.75rem',
                        fontSize: '0.875rem',
                        fontWeight: '600',
                        cursor: 'pointer'
                    }} onClick={() => navigate('/platform/admin/users?action=invite')}>
                        {AdminRegistry.ButtonRegistry.find((b: any) => b.id === 'btn-admin-user-invite')?.label || 'Invite User'}
                    </button>
                    <button data-cy="btn-admin.admin-dashboard-2" style={{
                        padding: '0.5rem 1rem',
                        background: '#f3f4f6',
                        color: '#4b5563',
                        border: '1px solid #e5e7eb',
                        borderRadius: '0.75rem',
                        fontSize: '0.875rem',
                        fontWeight: '600',
                        cursor: 'pointer'
                    }} onClick={handleExport}>
                        {AdminRegistry.ButtonRegistry.find((b: any) => b.id === 'btn-admin-report-export')?.label || 'Export'}
                    </button>
                    <Link to={RouteRegistry.SCRUM_MASTER.DEV_KB}>
                        <button data-cy="btn-admin.admin-dashboard-3" style={{
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
            </div>
            {/* Phase 13 exhaustive button group */}
            <div style={{ display: 'flex', gap: '0.5rem', marginBottom: '1.5rem', flexWrap: 'wrap' }}>
                <button className="btn" style={{ fontSize: '0.8rem', padding: '4px 8px' }} data-cy="btn-trigger-automation" onClick={() => handleApiAction('/v1/admin/actions/trigger-automation', 'Automation triggered — tasks queued', 'Automation trigger failed')}>{AdminRegistry.ButtonRegistry.find((b: any) => b.id === 'btn-adm-automation-trigger')?.label || 'Trigger Automation'}</button>
                <button className="btn" style={{ fontSize: '0.8rem', padding: '4px 8px' }} data-cy="btn-optimize-ops" onClick={() => handleApiAction('/v1/admin/actions/optimize', 'Operations optimized — metrics recalculated', 'Optimization failed')}>{AdminRegistry.ButtonRegistry.find((b: any) => b.id === 'btn-adm-ops-optimize')?.label || 'Optimize Ops'}</button>
                <button className="btn" style={{ fontSize: '0.8rem', padding: '4px 8px' }} data-cy="btn-save-settings" onClick={() => handleApiAction('/v1/admin/settings', 'Platform settings saved', 'Failed to save settings')}>{AdminRegistry.ButtonRegistry.find((b: any) => b.id === 'btn-admin-settings-save')?.label || 'Save Settings'}</button>
                <button className="btn" style={{ fontSize: '0.8rem', padding: '4px 8px' }} data-cy="btn-publish-content" onClick={() => handleApiAction('/v1/admin/actions/publish-content', 'Content published to production', 'Publish failed')}>{AdminRegistry.ButtonRegistry.find((b: any) => b.id === 'btn-admin-content-publish')?.label || 'Publish'}</button>
                <button className="btn" style={{ fontSize: '0.8rem', padding: '4px 8px' }} data-cy="btn-reindex-search" onClick={() => handleApiAction('/v1/admin/actions/reindex-search', 'Search index rebuilt successfully', 'Reindex failed')}>{AdminRegistry.ButtonRegistry.find((b: any) => b.id === 'btn-admin-search-reindex')?.label || 'Reindex Search'}</button>
                <button className="btn" style={{ fontSize: '0.8rem', padding: '4px 8px' }} data-cy="btn-new-tenant" onClick={() => navigate('/platform/admin/tenants/new')}>{AdminRegistry.ButtonRegistry.find((b: any) => b.id === 'btn-superuser-tenant-new')?.label || 'New Tenant'}</button>
                <button className="btn" style={{ fontSize: '0.8rem', padding: '4px 8px', color: 'red' }} data-cy="btn-suspend-reseller" onClick={handleSuspendReseller}>{AdminRegistry.ButtonRegistry.find((b: any) => b.id === 'btn-reseller-suspend')?.label || 'Suspend Reseller'}</button>
                <button className="btn" style={{ fontSize: '0.8rem', padding: '4px 8px', background: '#059669', color: 'white' }} data-cy="btn-verify-chain" onClick={handleVerifyChain}>🛡️ Verify Chain</button>
                <button className="btn" style={{ fontSize: '0.8rem', padding: '4px 8px' }} data-cy="btn-audit-stats" onClick={handleAuditStats}>📊 Audit Stats</button>
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
            <DialogRenderer />
        </div >
    );
}
