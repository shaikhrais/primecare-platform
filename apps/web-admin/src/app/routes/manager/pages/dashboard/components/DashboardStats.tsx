import React from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';

const { ContentRegistry } = AdminRegistry;

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
    const { t } = useTranslation();
    return (
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '20px', marginBottom: '32px' }}>
            <KPICard label={t(ContentRegistry.MANAGER_DASHBOARD.KPI.TODAY_SHIFTS)} value={todayShifts} color="#2196f3" dataCy="kpi-today-shifts" />
            <KPICard label={t(ContentRegistry.MANAGER_DASHBOARD.KPI.ACTIVE_CLIENTS)} value={activeClients} color="#4caf50" dataCy="kpi-active-clients" />
            <KPICard label={t(ContentRegistry.MANAGER_DASHBOARD.KPI.STAFF_ON_DUTY)} value={staffOnDuty} color="#ff9800" dataCy="kpi-staff-on-duty" />
            <KPICard label={t(ContentRegistry.MANAGER_DASHBOARD.KPI.OPEN_INCIDENTS)} value={openIncidents} color="#f44336" dataCy="kpi-open-incidents" />
        </div>
    );
};
