import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

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

    useEffect(() => {
        const fetchData = async () => {
            try {
                const token = localStorage.getItem('token');
                const headers = { 'Authorization': `Bearer ${token}` };

                const [kpiRes, shiftsRes] = await Promise.all([
                    fetch(`${import.meta.env.VITE_API_URL}/v1/manager/dashboard/kpi`, { headers }),
                    fetch(`${import.meta.env.VITE_API_URL}/v1/manager/dashboard/today`, { headers })
                ]);

                if (kpiRes.ok) setKpi(await kpiRes.json());
                if (shiftsRes.ok) setShifts(await shiftsRes.json());
            } catch (error) {
                console.error('Failed to load dashboard data', error);
            } finally {
                setLoading(false);
            }
        };

        fetchData();
    }, []);

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
                    <p className="sub" style={{ margin: 0 }}>Operational overview and rapid metrics</p>
                </div>

                {/* KPI Section */}
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '20px', marginBottom: '32px' }}>
                    <KPICard label="Today's Shifts" value={kpi.todayShifts} color="#2196f3" dataCy="kpi-today-shifts" />
                    <KPICard label="Active Clients" value={kpi.activeClients} color="#4caf50" dataCy="kpi-active-clients" />
                    <KPICard label="Staff On Duty" value={kpi.staffOnDuty} color="#ff9800" dataCy="kpi-staff-on-duty" />
                    <KPICard label="Open Incidents" value={kpi.openIncidents} color="#f44336" dataCy="kpi-open-incidents" />
                </div>

                {/* Quick Action Grid */}
                <h2 style={{ fontSize: '0.75rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '2px', marginBottom: '1.5rem', color: 'var(--text-300)' }}>Quick Actions</h2>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(240px, 1fr))', gap: '20px', marginBottom: '40px' }}>
                    <QuickActionCard label="Daily Care Entry" icon="📝" onClick={() => navigate('/manager/daily-entry')} dataCy="qa-daily-entry" />
                    <QuickActionCard label="Start Shift" icon="⏱️" onClick={() => { }} dataCy="qa-start-shift" />
                    <QuickActionCard label="End Shift" icon="🏁" onClick={() => { }} dataCy="qa-end-shift" />
                    <QuickActionCard label="Log Incident" icon="⚠️" onClick={() => navigate('/incidents')} dataCy="qa-log-incident" />
                    <QuickActionCard label="View Clients" icon="👥" onClick={() => navigate('/customers')} dataCy="qa-view-clients" />
                    <QuickActionCard label="Generate Report" icon="📈" onClick={() => navigate('/reports')} dataCy="qa-generate-report" />
                </div>

                {/* Today's Timeline */}
                <h2 style={{ fontSize: '0.75rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '2px', marginBottom: '1.5rem', color: 'var(--text-300)' }}>Today's Timeline</h2>
                <div className="pc-card">
                    <div className="pc-card-b" style={{ padding: '0 24px' }}>
                        {shifts.length === 0 ? (
                            <p style={{ color: 'var(--text-300)', textAlign: 'center', padding: '40px' }}>No shifts scheduled for today.</p>
                        ) : (
                            shifts.map((shift) => (
                                <div key={shift.id} style={{ display: 'flex', gap: '20px', padding: '20px 0', borderBottom: '1px solid var(--card-border)', alignItems: 'center' }}>
                                    <div style={{ fontWeight: 900, width: '90px', textAlign: 'right', color: 'var(--brand-500)', fontSize: '0.9rem' }}>
                                        {new Date(shift.requestedStartAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                                    </div>
                                    <div style={{ flex: 1 }}>
                                        <div style={{ fontWeight: 900, color: 'var(--text-100)', fontSize: '1.05rem' }}>{shift.client?.fullName || 'Untitled Client'}</div>
                                        <div style={{ fontSize: '0.85rem', color: 'var(--text-300)', marginTop: '2px' }}>{shift.service?.name || 'General Service'} • {shift.psw ? shift.psw.fullName : <span style={{ color: 'var(--brand-500)' }}>Unassigned</span>}</div>
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
