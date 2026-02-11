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

    const QuickActionCard = ({ label, icon, onClick, color = 'var(--bg-elev)', dataCy }: any) => (
        <div
            data-cy={dataCy}
            onClick={onClick}
            style={{
                backgroundColor: color,
                padding: '24px',
                borderRadius: '16px',
                border: '1px solid var(--line)',
                display: 'flex',
                alignItems: 'center',
                gap: '16px',
                cursor: 'pointer',
                transition: 'transform 0.2s, box-shadow 0.2s',
                boxShadow: '0 4px 6px rgba(0,0,0,0.05)'
            }}
            onMouseEnter={(e) => e.currentTarget.style.transform = 'translateY(-2px)'}
            onMouseLeave={(e) => e.currentTarget.style.transform = 'translateY(0)'}
        >
            <div style={{ fontSize: '2.5rem' }}>{icon}</div>
            <div style={{ fontWeight: 700, fontSize: '1.1rem' }}>{label}</div>
        </div>
    );

    const KPICard = ({ label, value, color, dataCy }: any) => (
        <div data-cy={dataCy} style={{ padding: '20px', borderRadius: '12px', background: 'var(--bg-elev)', borderLeft: `5px solid ${color}`, boxShadow: '0 2px 8px rgba(0,0,0,0.05)' }}>
            <div style={{ color: 'var(--text-muted)', fontSize: '0.9rem', fontWeight: 600, textTransform: 'uppercase' }}>{label}</div>
            <div style={{ fontSize: '2rem', fontWeight: 800, color: 'var(--text)' }}>{value}</div>
        </div>
    );

    return (
        <div style={{ maxWidth: '1200px', margin: '0 auto' }} data-cy="page.container">

            <h1 className="display-text" style={{ marginBottom: '24px' }} data-cy="page.title">Manager Dashboard</h1>

            {/* KPI Section */}
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '20px', marginBottom: '32px' }}>
                <KPICard label="Today's Shifts" value={kpi.todayShifts} color="#2196f3" dataCy="kpi-today-shifts" />
                <KPICard label="Active Clients" value={kpi.activeClients} color="#4caf50" dataCy="kpi-active-clients" />
                <KPICard label="Staff On Duty" value={kpi.staffOnDuty} color="#ff9800" dataCy="kpi-staff-on-duty" />
                <KPICard label="Open Incidents" value={kpi.openIncidents} color="#f44336" dataCy="kpi-open-incidents" />
            </div>

            {/* Quick Action Grid */}
            <h2 style={{ fontSize: '1.2rem', marginBottom: '16px', opacity: 0.8 }}>Quick Actions</h2>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(240px, 1fr))', gap: '20px', marginBottom: '40px' }}>
                <QuickActionCard label="Daily Care Entry" icon="📝" onClick={() => navigate('/manager/daily-entry')} color="var(--primary-light)" dataCy="qa-daily-entry" />
                <QuickActionCard label="Start Shift" icon="⏱️" onClick={() => { }} dataCy="qa-start-shift" />
                <QuickActionCard label="End Shift" icon="🏁" onClick={() => { }} dataCy="qa-end-shift" />
                <QuickActionCard label="Log Incident" icon="⚠️" onClick={() => navigate('/incidents')} dataCy="qa-log-incident" />
                <QuickActionCard label="View Clients" icon="👥" onClick={() => navigate('/customers')} dataCy="qa-view-clients" />
                <QuickActionCard label="Generate Report" icon="📈" onClick={() => navigate('/reports')} dataCy="qa-generate-report" />
            </div>

            {/* Today's Timeline */}
            <h2 style={{ fontSize: '1.2rem', marginBottom: '16px', opacity: 0.8 }}>Today's Timeline</h2>
            <div style={{ background: 'var(--bg-elev)', borderRadius: '16px', padding: '20px', border: '1px solid var(--line)' }}>
                {shifts.length === 0 ? (
                    <p style={{ opacity: 0.6, textAlign: 'center', padding: '20px' }}>No shifts scheduled for today.</p>
                ) : (
                    shifts.map((shift) => (
                        <div key={shift.id} style={{ display: 'flex', gap: '20px', padding: '16px 0', borderBottom: '1px solid var(--line)', alignItems: 'center' }}>
                            <div style={{ fontWeight: 800, width: '80px', textAlign: 'right', color: 'var(--primary)' }}>
                                {new Date(shift.requestedStartAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                            </div>
                            <div style={{ flex: 1 }}>
                                <div style={{ fontWeight: 700 }}>{shift.client?.fullName || 'Untitled Client'}</div>
                                <div style={{ fontSize: '0.9rem', opacity: 0.7 }}>{shift.service?.name || 'General Service'} • {shift.psw ? shift.psw.fullName : 'Unassigned'}</div>
                            </div>
                            <button data-cy={`btn-view-shift-${shift.id}`} className="btn btn-sm" onClick={() => navigate(`/visits/${shift.id}`)}>View</button>
                        </div>
                    ))
                )}
            </div>

        </div>
    );
}
