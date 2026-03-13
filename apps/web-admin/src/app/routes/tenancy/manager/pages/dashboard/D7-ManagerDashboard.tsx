// ================================================================
// PAGE IDENTITY: D7 � Manager Dashboard
// Type: Dashboard | Owner: manager
// ================================================================
import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useAuth } from '@/shared/context/AuthContext';
import { apiClient } from '@/shared/utils/apiClient';

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
    const [kpi, setKpi] = useState<KPIData>({ activeClients: 0, staffOnDuty: 0, openIncidents: 0, todayShifts: 0 });
    const [shifts, setShifts] = useState<ShiftDisplay[]>([]);
    const [loading, setLoading] = useState(true);
    const [branchHealth, setBranchHealth] = useState<{ status: 'healthy' | 'warning' | 'critical', alerts: any[] }>({ status: 'healthy', alerts: [] });
    const [perspective, setPerspective] = useState('Operations');
    const [chartData, setChartData] = useState<any>(null);

    useEffect(() => {
        const fetchData = async () => {
            try {
                const [kpiRes, todayRes, statsRes, healthRes]: any = await Promise.all([
                    apiClient.get(ApiRegistry.TENANCY.MANAGER.DASHBOARD_KPI),
                    apiClient.get(ApiRegistry.TENANCY.MANAGER.DASHBOARD_TODAY),
                    apiClient.get(ApiRegistry.TENANCY.MANAGER.DASHBOARD_STATS),
                    apiClient.get(ApiRegistry.TENANCY.MANAGER.BRANCH_HEALTH)
                ]);

                const [kpiData, todayData, statsData, healthData] = await Promise.all([
                    kpiRes.json(),
                    todayRes.json(),
                    statsRes.json(),
                    healthRes.json()
                ]);

                if (kpiData) setKpi(kpiData);
                if (todayData && Array.isArray(todayData)) setShifts(todayData);
                if (statsData) setChartData(statsData);
                if (healthData) setBranchHealth(healthData);
            } catch (error) {
                console.error('Failed to load dashboard data', error);
            } finally {
                setLoading(false);
            }
        };

        fetchData();
    }, []);

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
            <div data-cy="page.container" style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh', flexDirection: 'column', gap: '1rem' }}>
                <div className="spinner"></div>
                <p style={{ color: 'var(--text-300)' }}>{t(ContentRegistry.MANAGER_DASHBOARD.MESSAGES.LOADING)}</p>
            </div>
        );
    }

    const { user } = useAuth();

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
                    <Link to={RouteRegistry.LEARN} className="btn-modern btn-outline" style={{ textDecoration: 'none', color: 'inherit' }}>
                        🎓 {t(ContentRegistry.MENU.KNOWLEDGE_BASE)}
                    </Link>
                    <div className="btn-perspective-group">
                        {ContentRegistry.MANAGER_DASHBOARD.PERSPECTIVES.map((p: string) => (
                            <button
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

            <DashboardStats
                activeClients={kpi.activeClients}
                staffOnDuty={kpi.staffOnDuty}
                openIncidents={kpi.openIncidents}
                todayShifts={kpi.todayShifts}
                healthStatus={branchHealth.status}
                alertsCount={branchHealth.alerts.length}
            />

            <QuickActions />

            <div className="dashboard-main-content">
                {perspective === 'Operations' ? (
                    <>
                        <AnalyticsSection displayData={displayData} isDemo={false} />
                        <ShiftTimeline shifts={shifts} />
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
