// ================================================================
// PAGE IDENTITY: D7 — Manager Dashboard
// Type: Dashboard | Owner: manager
// ================================================================
import React, { useState } from 'react';
import { Link } from 'react-router';
import { AdminRegistry } from 'prime-care-shared';
import { useAuth } from '@/shared/context/AuthContext';
import { useRegistryQuery } from '@/shared/hooks/useRegistryQuery';
import { PageActionBar } from '@/shared/components/ui/PageActionBar';

const { ApiRegistry, ContentRegistry, RouteRegistry } = AdminRegistry;
import './ManagerDashboard.css';

import { DashboardStats } from './components/DashboardStats';
import { QuickActions } from './components/QuickActions';
import { AnalyticsSection } from './components/AnalyticsSection';
import { ShiftTimeline } from './components/ShiftTimeline';
import { FleetRadarMap } from '../logistics/components/FleetRadarMap';
import { TriageHeatmap } from '../intake/components/TriageHeatmap';
import { ShiftDragBoard } from '../logistics/components/ShiftDragBoard';
import { useTranslation } from 'react-i18next';
import { LiveFeedIndicator } from '@/shared/components/LiveFeedIndicator';

interface KPIData {
    activeClients: number;
    staffOnDuty: number;
    openIncidents: number;
    todayShifts: number;
}

interface ShiftDisplay {
    id: string;
    requestedStartAt: string;
    client: { fullName: string };
    psw?: { fullName: string };
    service: { name: string };
}

export default function ManagerDashboard() {
    const { t } = useTranslation();
    const { user } = useAuth();
    const [perspective, setPerspective] = useState('Operations');

    // TanStack Query: 4 parallel auto-cached queries with independent loading
    const { data: kpi } = useRegistryQuery<KPIData>(ApiRegistry.TENANCY.MANAGER.DASHBOARD_KPI, {
        queryKey: ['manager', 'kpi'],
        staleTime: 30_000,
    });
    const { data: shifts } = useRegistryQuery<ShiftDisplay[]>(ApiRegistry.TENANCY.MANAGER.DASHBOARD_TODAY, {
        queryKey: ['manager', 'today'],
        staleTime: 30_000,
    });
    const { data: chartData } = useRegistryQuery<any>(ApiRegistry.TENANCY.MANAGER.DASHBOARD_STATS, {
        queryKey: ['manager', 'stats'],
        staleTime: 60_000,
    });
    const { data: branchHealth, isLoading: loading } = useRegistryQuery<{ status: 'healthy' | 'warning' | 'critical', alerts: any[] }>(ApiRegistry.TENANCY.MANAGER.BRANCH_HEALTH, {
        queryKey: ['manager', 'branchHealth'],
        staleTime: 60_000,
    });

    const kpiData = kpi || { activeClients: 0, staffOnDuty: 0, openIncidents: 0, todayShifts: 0 };
    const shiftData = shifts || [];
    const healthData = branchHealth || { status: 'healthy' as const, alerts: [] };

    // Helper for chart data mapping
    const getChartData = (key: string, realValue: any) => {
        if (realValue && Array.isArray(realValue) && realValue.length > 0) return realValue;
        return [];
    };

    const displayData = {
        revenue: getChartData('revenue', chartData?.revenue),
        visitVolume: getChartData('visitVolume', chartData?.visitVolume),
        staffUtilization: getChartData('staffUtilization', chartData?.staffUtilization),
        shiftFulfillment: getChartData('shiftFulfillment', chartData?.shiftFulfillment),
        servicePopularity: getChartData('servicePopularity', chartData?.servicePopularity),
        incidents: getChartData('incidents', chartData?.incidents),
        carePlanAdherence: getChartData('carePlanAdherence', chartData?.carePlanAdherence),
        staffAttendance: getChartData('staffAttendance', chartData?.staffAttendance),
        clientSatisfaction: getChartData('clientSatisfaction', chartData?.clientSatisfaction),
        revenueForecast: getChartData('revenue', chartData?.revenue),
        travelTime: getChartData('travelTime', chartData?.travelTime),
        overtimeRisk: getChartData('overtimeRisk', chartData?.overtimeRisk),
        resourceAvailability: getChartData('resourceAvailability', chartData?.resourceAvailability),
    };

    if (loading) {
        return (
            <div data-cy="page.container" role="main" aria-label="Manager Dashboard" style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh', flexDirection: 'column', gap: '1rem' }}>
                <div className="spinner"></div>
                <p style={{ color: 'var(--text-300)' }}>{t(ContentRegistry.MANAGER_DASHBOARD.MESSAGES.LOADING)}</p>
            </div>
        );
    }

    return (
        <div className="mgr-dashboard-container">
            <header className="mgr-header">
                <div className="mgr-title-group">
                    <h1 data-cy="page.title">{t(ContentRegistry.MANAGER_DASHBOARD.TITLE)}</h1>
                    <p className="mgr-subtitle">
                        {user?.email ? `${user.email} • ${t(ContentRegistry.MANAGER_DASHBOARD.SUBTITLE)}` : t(ContentRegistry.MANAGER_DASHBOARD.SUBTITLE)}
                    </p>
                </div>
                <div className="mgr-controls">
                    <PageActionBar pageId="manager.dashboard" size="sm" />
                    <div className="btn-perspective-group">
                        {ContentRegistry.MANAGER_DASHBOARD.PERSPECTIVES.map((p: string) => (
                            <button data-cy="btn-mgr-perspective"
                                key={p}
                                onClick={() => setPerspective(p)}
                                className={`btn-perspective ${p === perspective ? 'active' : ''}`}
                            >
                                {p}
                            </button>
                        ))}
                    </div>
                </div>
            </header>

            <LiveFeedIndicator />

            <DashboardStats
                activeClients={kpiData.activeClients}
                staffOnDuty={kpiData.staffOnDuty}
                openIncidents={kpiData.openIncidents}
                todayShifts={kpiData.todayShifts}
                healthStatus={healthData.status}
                alertsCount={healthData.alerts.length}
            />

            <QuickActions />

            <div className="dashboard-main-content">
                {perspective === 'Operations' ? (
                    <>
                        <AnalyticsSection displayData={displayData} isDemo={false} />
                        <ShiftTimeline shifts={shiftData} />
                    </>
                ) : (
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '32px', width: '100%' }}>
                        <div style={{ display: 'grid', gridTemplateColumns: 'minmax(0, 1fr) minmax(0, 1fr)', gap: '24px' }}>
                            <FleetRadarMap />
                            <TriageHeatmap />
                        </div>
                        <ShiftDragBoard />
                    </div>
                )}
            </div>
        </div>
    );
}
