import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { RevenueChart } from '@/shared/components/charts/RevenueChart';
import { VisitVolumeChart } from '@/shared/components/charts/VisitVolumeChart';
import { StaffUtilizationChart } from '@/shared/components/charts/StaffUtilizationChart';
import { ShiftFulfillmentChart } from '@/shared/components/charts/ShiftFulfillmentChart';
import { ServicePopularityChart } from '@/shared/components/charts/ServicePopularityChart';
import { IncidentTrendChart } from '@/shared/components/charts/IncidentTrendChart';
import { CarePlanAdherenceGauge } from '@/shared/components/charts/CarePlanAdherenceGauge';
import { StaffAttendanceHeatmap } from '@/shared/components/charts/StaffAttendanceHeatmap';
import { ClientSatisfactionRadar } from '@/shared/components/charts/ClientSatisfactionRadar';
import { RevenueForecastChart } from '@/shared/components/charts/RevenueForecastChart';
import { TravelTimeAnalysis } from '@/shared/components/charts/TravelTimeAnalysis';
import { OvertimeRiskGauge } from '@/shared/components/charts/OvertimeRiskGauge';
import { ResourceAvailabilityChart } from '@/shared/components/charts/ResourceAvailabilityChart';
import { MOCK_MANAGER_DATA } from '@/shared/data/mockChartData';

const { ApiRegistry } = AdminRegistry;



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
    const navigate = useNavigate();
    const [kpi, setKpi] = useState<KPIData>({ activeClients: 0, staffOnDuty: 0, openIncidents: 0, todayShifts: 0 });
    const [shifts, setShifts] = useState<ShiftDisplay[]>([]);
    const [loading, setLoading] = useState(true);

    const [chartData, setChartData] = useState<any>(null);

    useEffect(() => {
        const fetchData = async () => {
            try {
                const token = localStorage.getItem('token');
                const headers = { 'Authorization': `Bearer ${token}` };

                const [kpiRes, shiftsRes, statsRes] = await Promise.all([
                    fetch(`${import.meta.env.VITE_API_URL}/v1/manager/dashboard/kpi`, { headers }),
                    fetch(`${import.meta.env.VITE_API_URL}/v1/manager/dashboard/today`, { headers }),
                    fetch(`${import.meta.env.VITE_API_URL}/v1/manager/dashboard/stats`, { headers })
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
    const displayData = {
        revenue: chartData?.revenue || MOCK_MANAGER_DATA.revenue,
        visitVolume: chartData?.visitVolume || MOCK_MANAGER_DATA.visitVolume,
        staffUtilization: chartData?.staffUtilization || MOCK_MANAGER_DATA.staffUtilization,
        shiftFulfillment: chartData?.shiftFulfillment || MOCK_MANAGER_DATA.shiftFulfillment,
        servicePopularity: chartData?.servicePopularity || MOCK_MANAGER_DATA.servicePopularity,
        incidents: chartData?.incidents || MOCK_MANAGER_DATA.incidents,
        carePlanAdherence: chartData?.carePlanAdherence || MOCK_MANAGER_DATA.carePlanAdherence,
        staffAttendance: chartData?.staffAttendance || MOCK_MANAGER_DATA.staffAttendance,
        clientSatisfaction: chartData?.clientSatisfaction || MOCK_MANAGER_DATA.clientSatisfaction,
        revenueForecast: chartData?.revenue || MOCK_MANAGER_DATA.revenue, // Reusing revenue data structure
        travelTime: chartData?.travelTime || MOCK_MANAGER_DATA.travelTime,
        overtimeRisk: chartData?.overtimeRisk || MOCK_MANAGER_DATA.overtimeRisk,
        resourceAvailability: chartData?.resourceAvailability || MOCK_MANAGER_DATA.resourceAvailability,
    };

    const QuickActionCard = ({ label, icon, onClick, dataCy }: any) => (
        <div
            className="pc-card"
            data-cy={dataCy}
            onClick={onClick}
            style={{
                padding: '24px',
                display: 'flex',
                alignItems: 'center',
                gap: '16px',
                cursor: 'pointer'
            }}
        >
            <div style={{ fontSize: '2.5rem' }}>{icon}</div>
            <div style={{ fontWeight: 900, fontSize: '1.2rem', color: 'var(--brand-500)', letterSpacing: '.2px' }}>{label}</div>
        </div>
    );

    const KPICard = ({ label, value, color, dataCy }: any) => (
        <div className="pc-card" data-cy={dataCy} style={{ padding: '20px', borderLeft: `4px solid ${color}` }}>
            <div style={{ color: 'var(--text-300)', fontSize: '0.75rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '1px', marginBottom: '4px' }}>{label}</div>
            <div style={{ fontSize: '2.2rem', fontWeight: 900, color: 'var(--text-100)', letterSpacing: '1px' }}>{value}</div>
        </div>
    );

    return (
        <div data-cy="page.container">
            <div data-cy="mgr-dashboard">

                <div style={{ marginBottom: '2.5rem' }}>
                    <h1 style={{ margin: '0 0 6px 0', fontSize: '34px', letterSpacing: '.2px', color: 'var(--text-100)' }} data-cy="page.title">Manager Dashboard</h1>
                    <p className="sub" style={{ margin: 0 }} data-cy="page.subtitle">Operational overview and rapid metrics</p>
                </div>

                {/* KPI Section */}
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '20px', marginBottom: '32px' }}>
                    <KPICard label="Today's Shifts" value={kpi.todayShifts} color="#2196f3" dataCy="kpi-today-shifts" />
                    <KPICard label="Active Clients" value={kpi.activeClients} color="#4caf50" dataCy="kpi-active-clients" />
                    <KPICard label="Staff On Duty" value={kpi.staffOnDuty} color="#ff9800" dataCy="kpi-staff-on-duty" />
                    <KPICard label="Open Incidents" value={kpi.openIncidents} color="#f44336" dataCy="kpi-open-incidents" />
                </div>

                {/* Quick Action Grid */}
                <h2 data-cy="section.quick-actions" style={{ fontSize: '0.75rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '2px', marginBottom: '1.5rem', color: 'var(--text-300)' }}>Quick Actions</h2>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(240px, 1fr))', gap: '20px', marginBottom: '40px' }}>
                    <QuickActionCard label="Daily Care Entry" icon="📝" onClick={() => navigate('/manager/daily-entry')} dataCy="qa-daily-entry" />
                    <QuickActionCard label="Staff Evaluations" icon="📋" onClick={() => navigate('/manager/evaluations')} dataCy="qa-evaluations" />
                    <QuickActionCard label="Service Reviews" icon="⭐" onClick={() => navigate('/manager/service-reviews')} dataCy="qa-service-reviews" />
                    <QuickActionCard label="Log Incident" icon="⚠️" onClick={() => navigate('/incidents')} dataCy="qa-log-incident" />
                    <QuickActionCard label="View Clients" icon="👥" onClick={() => navigate('/customers')} dataCy="qa-view-clients" />
                </div>

                {/* Interactive Charts Section */}
                <h2 data-cy="section.analytics" style={{ fontSize: '0.75rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '2px', marginBottom: '1.5rem', color: 'var(--text-300)' }}>Performance Analytics</h2>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '20px', marginBottom: '40px' }}>
                    <RevenueChart data={displayData.revenue} isDemo={!chartData} />
                    <ResourceAvailabilityChart data={displayData.resourceAvailability} isDemo={!chartData} />
                </div>

                {/* Today's Timeline (Preserved below charts) */}
                <h2 data-cy="section.timeline" style={{ fontSize: '0.75rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '2px', marginBottom: '1.5rem', color: 'var(--text-300)' }}>Today's Timeline</h2>
                <div className="pc-card">
                    <div className="pc-card-b" style={{ padding: '0 24px' }}>
                        {shifts.length === 0 ? (
                            <p data-cy="timeline-empty-message" style={{ color: 'var(--text-300)', textAlign: 'center', padding: '40px' }}>No shifts scheduled for today.</p>
                        ) : (
                            shifts.map((shift) => (
                                <div key={shift.id} data-cy="timeline-item" style={{ display: 'flex', gap: '20px', padding: '20px 0', borderBottom: '1px solid var(--card-border)', alignItems: 'center' }}>
                                    <div style={{ fontWeight: 900, width: '90px', textAlign: 'right', color: 'var(--brand-500)', fontSize: '0.9rem' }}>
                                        {new Date(shift.requestedStartAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                                    </div>
                                    <div style={{ flex: 1 }}>
                                        <div data-cy="timeline-client-name" style={{ fontWeight: 900, color: 'var(--text-100)', fontSize: '1.05rem' }}>{shift.client?.fullName || 'Untitled Client'}</div>
                                        <div data-cy="timeline-details" style={{ fontSize: '0.85rem', color: 'var(--text-300)', marginTop: '2px' }}>{shift.service?.name || 'General Service'} • {shift.psw ? shift.psw.fullName : <span style={{ color: 'var(--brand-500)' }}>Unassigned</span>}</div>
                                    </div>
                                    <button data-cy={`btn-view-shift-${shift.id}`} className="btn" style={{ padding: '8px 16px', fontSize: '13px' }} onClick={() => navigate(`/visits/${shift.id}`)}>View Details</button>
                                </div>
                            ))
                        )}
                    </div>
                </div>
            </div>
        </div>
    );
}
