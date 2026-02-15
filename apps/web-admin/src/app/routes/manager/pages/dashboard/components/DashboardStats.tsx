import React from 'react';

interface SubComponentProps {
    label: string;
    value: number;
    color: string;
    dataCy: string;
}

const KPICard = ({ label, value, color, dataCy }: SubComponentProps) => (
    <div className="pc-card" data-cy={dataCy} style={{ padding: '20px', borderLeft: `4px solid ${color}` }}>
        <div style={{ color: 'var(--text-300)', fontSize: '0.75rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '1px', marginBottom: '4px' }}>{label}</div>
        <div style={{ fontSize: '2.2rem', fontWeight: 900, color: 'var(--text-100)', letterSpacing: '1px' }}>{value}</div>
    </div>
);

interface DashboardStatsProps {
    activeClients: number;
    staffOnDuty: number;
    openIncidents: number;
    todayShifts: number;
}

export const DashboardStats: React.FC<DashboardStatsProps> = ({ activeClients, staffOnDuty, openIncidents, todayShifts }) => {
    return (
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '20px', marginBottom: '32px' }}>
            <KPICard label="Today's Shifts" value={todayShifts} color="#2196f3" dataCy="kpi-today-shifts" />
            <KPICard label="Active Clients" value={activeClients} color="#4caf50" dataCy="kpi-active-clients" />
            <KPICard label="Staff On Duty" value={staffOnDuty} color="#ff9800" dataCy="kpi-staff-on-duty" />
            <KPICard label="Open Incidents" value={openIncidents} color="#f44336" dataCy="kpi-open-incidents" />
        </div>
    );
};
