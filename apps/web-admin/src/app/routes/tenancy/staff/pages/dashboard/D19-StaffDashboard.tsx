// ================================================================
// PAGE IDENTITY: D19 � Staff Dashboard
// Type: Dashboard | Owner: staff
// ================================================================
import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { useAuth } from '@/shared/context/AuthContext';
import { AdminRegistry, ApiRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';
import { PageActionBar } from '@/shared/components/ui/PageActionBar';
import './StaffDashboard.css';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

export default function StaffDashboard() {
    const { t } = useTranslation();
    const { user } = useAuth();
    const [loading, setLoading] = useState(true);
    const [stats, setStats] = useState<any>(null);

    useEffect(() => {
        const fetchStats = async () => {
            try {
                const token = localStorage.getItem('token');
                const res = await fetch(`${import.meta.env.VITE_API_URL}${ApiRegistry.TENANCY.STAFF.DASHBOARD_STATS}`, {
                    headers: { 'Authorization': `Bearer ${token}` }
                });
                if (res.ok) {
                    const data = await res.json();
                    setStats(data.kpi);
                }
            } catch (error) {
                console.error('Failed to fetch staff stats:', error);
            } finally {
                setLoading(false);
            }
        };
        fetchStats();
    }, []);

    if (loading) {
        return (
            <div className="staff-dashboard" style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '60vh' }}>
                <div className="animate-pulse flex flex-col items-center">
                    <div className="w-12 h-12 bg-primary/20 rounded-full mb-4"></div>
                    <p className="text-sm font-black uppercase tracking-widest text-muted-foreground">
                        {t(ContentRegistry.STAFF_DASHBOARD.MESSAGES.LOADING)}
                    </p>
                </div>
            </div>
        );
    }

    return (
        <div className="staff-dashboard" data-cy="page.container" role="main" aria-label="Staff Dashboard">
            <header className="staff-dashboard-header">
                <div>
                    <h1 data-cy="page.title">
                        {user?.tenantId ? t(ContentRegistry.STAFF_DASHBOARD.TITLE_BRANCH) : t(ContentRegistry.STAFF_DASHBOARD.TITLE_NETWORK)}
                    </h1>
                    <div className="staff-dashboard-subtitle" data-cy="page.subtitle">
                        {user?.email ? `${user.email} • ${t(ContentRegistry.ROLES.STAFF)}` : t(ContentRegistry.STAFF_DASHBOARD.SUBTITLE)}
                    </div>
                </div>
                <div className="staff-quick-actions">
                    <PageActionBar pageId="staff.dashboard" size="sm" />
                </div>
            </header>

            <div className="staff-bento-grid">
                {/* Large Stats Card */}
                <div className="staff-bento-card large">
                    <div>
                        <span className="staff-card-label">{t(ContentRegistry.STAFF_DASHBOARD.STATS.URGENT_NEEDS)}</span>
                        <div className="staff-card-value">{stats?.urgentSchedulingNeeds ?? '--'}</div>
                    </div>
                    <div className="staff-card-icon">⚡</div>
                    <p className="text-sm font-medium text-muted-foreground mt-4">
                        {t(ContentRegistry.STAFF_DASHBOARD.STATS.URGENT_DESC)}
                    </p>
                    <div className="mt-8">
                        <Link to={RouteRegistry.STAFF.TASKS} className="text-xs font-black uppercase tracking-wider text-primary text-decoration-none hover:underline">
                            Triage Queue →
                        </Link>
                    </div>
                </div>

                {/* Active Caregivers */}
                <div className="staff-bento-card">
                    <div>
                        <span className="staff-card-label">{t(ContentRegistry.STAFF_DASHBOARD.STATS.ACTIVE_CAREGIVERS)}</span>
                        <div className="staff-card-value text-green-600">{stats?.activeCaregivers ?? '--'}</div>
                    </div>
                    <div className="staff-card-icon">👥</div>
                </div>

                {/* Missing Timesheets */}
                <div className="staff-bento-card">
                    <div>
                        <span className="staff-card-label">{t(ContentRegistry.STAFF_DASHBOARD.STATS.MISSING_TIMESHEETS)}</span>
                        <div className="staff-card-value text-amber-500">{stats?.missingTimesheets ?? '--'}</div>
                    </div>
                    <div className="staff-card-icon">📄</div>
                </div>

                {/* Wide Integration Card */}
                <div className="staff-bento-card wide" style={{ background: 'var(--brand-900)', color: 'white' }}>
                    <div className="relative z-10">
                        <span className="staff-card-label" style={{ color: 'rgba(255,255,255,0.6)' }}>Operations Sync</span>
                        <div className="text-xl font-black mt-2">All Branch Nodes Online</div>
                        <p className="text-xs font-medium opacity-60 mt-1">Registry-driven audit complete at 21:15</p>
                    </div>
                    <div className="staff-card-icon" style={{ opacity: 0.2 }}>🌐</div>
                    <div className="mt-4 relative z-10">
                        <div className="flex gap-2">
                            <div className="px-3 py-1 bg-white/10 rounded-full text-[10px] font-black uppercase">GPS Live</div>
                            <div className="px-3 py-1 bg-white/10 rounded-full text-[10px] font-black uppercase">Interoperability Active</div>
                        </div>
                    </div>
                </div>
            </div>

            <section className="staff-priority-section">
                <div className="staff-priority-header">
                    <div className="w-8 h-8 rounded-xl bg-primary/10 flex items-center justify-center text-primary">🔔</div>
                    <h2>{t(ContentRegistry.STAFF_DASHBOARD.PRIORITIES.TITLE)}</h2>
                </div>

                <div className="staff-priority-list">
                    <div className="staff-priority-item">
                        <div className="staff-priority-info">
                            <h3>{t(ContentRegistry.STAFF_DASHBOARD.PRIORITIES.COMPLIANCE_TITLE)}</h3>
                            <p>4 {t(ContentRegistry.STAFF_DASHBOARD.PRIORITIES.COMPLIANCE_DESC)}</p>
                        </div>
                        <Link to={RouteRegistry.STAFF.COMPLIANCE} className="btn-modern btn-modern-primary">
                            {t(ContentRegistry.STAFF_DASHBOARD.PRIORITIES.COMPLIANCE_BTN)}
                        </Link>
                    </div>

                    <div className="staff-priority-item">
                        <div className="staff-priority-info">
                            <h3>{t(ContentRegistry.STAFF_DASHBOARD.PRIORITIES.TIMESHEETS_TITLE)}</h3>
                            <p>22 {t(ContentRegistry.STAFF_DASHBOARD.PRIORITIES.TIMESHEETS_DESC)}</p>
                        </div>
                        <button data-cy="btn-staff.staff-dashboard-0" className="btn-modern btn-modern-secondary">
                            {t(ContentRegistry.STAFF_DASHBOARD.PRIORITIES.TIMESHEETS_BTN)}
                        </button>
                    </div>

                    <div className="staff-priority-item">
                        <div className="staff-priority-info">
                            <h3>{t(ContentRegistry.STAFF_DASHBOARD.PRIORITIES.FEEDBACK_TITLE)}</h3>
                            <p>3 {t(ContentRegistry.STAFF_DASHBOARD.PRIORITIES.FEEDBACK_DESC)}</p>
                        </div>
                        <Link to={RouteRegistry.STAFF.MESSAGES} className="btn-modern btn-modern-secondary text-decoration-none">
                            {t(ContentRegistry.STAFF_DASHBOARD.PRIORITIES.FEEDBACK_BTN)}
                        </Link>
                    </div>
                </div>
            </section>
        </div>
    );
}
