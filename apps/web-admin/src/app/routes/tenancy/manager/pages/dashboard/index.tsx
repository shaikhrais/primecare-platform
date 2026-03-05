import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useAuth } from '@/shared/context/AuthContext';
import { apiClient } from '@/shared/utils/apiClient';
const { ApiRegistry, ContentRegistry, RouteRegistry } = AdminRegistry;
import { MOCK_MANAGER_DATA } from '@/shared/data/mockChartData';

// Components
import { DashboardStats } from './components/DashboardStats';
import { QuickActions } from './components/QuickActions';
import { AnalyticsSection } from './components/AnalyticsSection';
import { ShiftTimeline } from './components/ShiftTimeline';
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
    const [perspective, setPerspective] = useState('Operations');
    const [chartData, setChartData] = useState<any>(null);

    useEffect(() => {
        const fetchData = async () => {
            try {
                const [kpiData, todayData, statsData] = await Promise.all([
                    apiClient.get(ApiRegistry.MANAGER.DASHBOARD_KPI),
                    apiClient.get(ApiRegistry.MANAGER.DASHBOARD_TODAY),
                    apiClient.get(ApiRegistry.MANAGER.DASHBOARD_STATS)
                ]);

                if (kpiData) setKpi(kpiData as any);
                if (todayData && Array.isArray(todayData)) setShifts(todayData);
                if (statsData) setChartData(statsData as any);
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
        return (MOCK_MANAGER_DATA as any)[key] || [];
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
            <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh', flexDirection: 'column', gap: '1rem' }}>
                <div className="spinner"></div>
                <p style={{ color: 'var(--text-300)' }}>{t(ContentRegistry.MANAGER_DASHBOARD.MESSAGES.LOADING)}</p>
            </div>
        );
    }

    const { user } = useAuth();

    return (
        <div data-cy="page.container">
            <div data-cy="mgr-dashboard">

                <div style={{ marginBottom: '2.5rem', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end' }}>
                    <div>
                        <h1 style={{ margin: '0 0 6px 0', fontSize: '34px', letterSpacing: '.2px', color: 'var(--text-100)' }} data-cy="page.title">
                            {t(ContentRegistry.MANAGER_DASHBOARD.TITLE)}
                        </h1>
                        <p className="sub" style={{ margin: 0 }} data-cy="page.subtitle">
                            {user?.email ? `${user.email} • ${t(ContentRegistry.MANAGER_DASHBOARD.SUBTITLE)}` : t(ContentRegistry.MANAGER_DASHBOARD.SUBTITLE)}
                        </p>
                    </div>
                    <div style={{ display: 'flex', gap: '12px', alignItems: 'center' }}>
                        <Link
                            to={RouteRegistry.LEARN}
                            style={{
                                display: 'inline-flex',
                                alignItems: 'center',
                                gap: '8px',
                                padding: '10px 20px',
                                backgroundColor: '#f8fafc',
                                color: '#475569',
                                borderRadius: '10px',
                                textDecoration: 'none',
                                fontWeight: 700,
                                fontSize: '0.9rem',
                                border: '1px solid #e2e8f0'
                            }}
                        >
                            🎓 {t(ContentRegistry.LEARN.TITLE)}
                        </Link>
                        <div style={{ display: 'flex', gap: '8px', backgroundColor: '#F3F4F6', padding: '4px', borderRadius: '12px' }}>
                            {ContentRegistry.MANAGER_DASHBOARD.PERSPECTIVES.map(p => (
                                <button
                                    key={p}
                                    onClick={() => setPerspective(p)}
                                    style={{
                                        padding: '8px 16px',
                                        borderRadius: '8px',
                                        border: 'none',
                                        backgroundColor: p === perspective ? '#FFFFFF' : 'transparent',
                                        color: p === perspective ? '#111827' : '#6B7280',
                                        fontWeight: 700,
                                        fontSize: '0.85rem',
                                        cursor: 'pointer',
                                        boxShadow: p === perspective ? '0 2px 4px rgba(0,0,0,0.05)' : 'none',
                                        transition: 'all 0.2s'
                                    }}
                                >
                                    {p}
                                </button>
                            ))}
                        </div>
                    </div>

                    <DashboardStats
                        activeClients={kpi.activeClients}
                        staffOnDuty={kpi.staffOnDuty}
                        openIncidents={kpi.openIncidents}
                        todayShifts={kpi.todayShifts}
                    />

                </div>

                <QuickActions />

                <AnalyticsSection displayData={displayData} isDemo={!chartData} />

                <ShiftTimeline shifts={shifts} />

            </div>
        </div>
    );
}
