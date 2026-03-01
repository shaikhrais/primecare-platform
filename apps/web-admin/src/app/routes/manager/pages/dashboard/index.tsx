import React, { useEffect, useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useAuth } from '@/shared/context/AuthContext';
const { ApiRegistry, ContentRegistry } = AdminRegistry;
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
                const token = localStorage.getItem('token');
                const headers = { 'Authorization': `Bearer ${token}` };

                const { ApiRegistry } = AdminRegistry;
                const [kpiRes, shiftsRes, statsRes] = await Promise.all([
                    fetch(`${import.meta.env.VITE_API_URL}${ApiRegistry.MANAGER.DASHBOARD_KPI}`, { headers }),
                    fetch(`${import.meta.env.VITE_API_URL}${ApiRegistry.MANAGER.DASHBOARD_TODAY}`, { headers }),
                    fetch(`${import.meta.env.VITE_API_URL}${ApiRegistry.MANAGER.DASHBOARD_STATS}`, { headers })
                ]);

                if (kpiRes.ok) setKpi(await kpiRes.json());
                if (shiftsRes.ok) setShifts(await shiftsRes.json());
                if (statsRes.ok) setChartData(await statsRes.json());
            } catch (error) {
                console.error('Failed to load dashboard data', error);
                // Fallback to MOCK DATA
                console.log('Using Mock Data Fallback');
                setKpi({ activeClients: 154, staffOnDuty: 42, openIncidents: 3, todayShifts: 85 });
                setShifts([
                    { id: '1', requestedStartAt: new Date().toISOString(), client: { fullName: 'Alice Johnson' }, service: { name: 'Personal Care' }, psw: { fullName: 'Sarah Smith' } },
                    { id: '2', requestedStartAt: new Date(Date.now() + 3600000).toISOString(), client: { fullName: 'Bob Williams' }, service: { name: 'Nursing' }, psw: { fullName: 'Mike Jones' } }
                ]);
            } finally {
                setLoading(false);
            }
        };

        fetchData();
    }, []);

    // Combine API data with Mock data (prefer API, fallback to Mock if empty/null)
    const checkData = (real: any[], mock: any[]) => (real && real.length > 0) ? real : mock;

    const displayData = {
        revenue: checkData(chartData?.revenue, MOCK_MANAGER_DATA.revenue),
        visitVolume: checkData(chartData?.visitVolume, MOCK_MANAGER_DATA.visitVolume),
        staffUtilization: checkData(chartData?.staffUtilization, MOCK_MANAGER_DATA.staffUtilization),
        shiftFulfillment: checkData(chartData?.shiftFulfillment, MOCK_MANAGER_DATA.shiftFulfillment),
        servicePopularity: checkData(chartData?.servicePopularity, MOCK_MANAGER_DATA.servicePopularity),
        incidents: checkData(chartData?.incidents, MOCK_MANAGER_DATA.incidents),
        carePlanAdherence: checkData(chartData?.carePlanAdherence, MOCK_MANAGER_DATA.carePlanAdherence),
        staffAttendance: checkData(chartData?.staffAttendance, MOCK_MANAGER_DATA.staffAttendance),
        clientSatisfaction: checkData(chartData?.clientSatisfaction, MOCK_MANAGER_DATA.clientSatisfaction),
        revenueForecast: checkData(chartData?.revenue, MOCK_MANAGER_DATA.revenue), // Reusing revenue data structure
        travelTime: checkData(chartData?.travelTime, MOCK_MANAGER_DATA.travelTime),
        overtimeRisk: checkData(chartData?.overtimeRisk, MOCK_MANAGER_DATA.overtimeRisk),
        resourceAvailability: checkData(chartData?.resourceAvailability, MOCK_MANAGER_DATA.resourceAvailability),
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
                            {user?.tenantId ? t(ContentRegistry.MANAGER_DASHBOARD.TITLE) : t(ContentRegistry.MANAGER_DASHBOARD.TITLE)}
                        </h1>
                        <p className="sub" style={{ margin: 0 }} data-cy="page.subtitle">
                            {user?.email ? `${user.email} • ${t(ContentRegistry.MANAGER_DASHBOARD.SUBTITLE)}` : t(ContentRegistry.MANAGER_DASHBOARD.SUBTITLE)}
                        </p>
                    </div>
                    <div style={{ display: 'flex', gap: '8px', backgroundColor: '#F3F4F6', padding: '4px', borderRadius: '12px' }}>
                        {t(ContentRegistry.MANAGER_DASHBOARD.PERSPECTIVES.map)(p => (
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

                <QuickActions />

                <AnalyticsSection displayData={displayData} isDemo={!chartData} />

                <ShiftTimeline shifts={shifts} />

            </div>
        </div>
    );
}
