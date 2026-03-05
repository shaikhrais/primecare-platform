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
    <div className="kpi-card" data-cy={dataCy} style={{ borderTop: `4px solid ${color}` }}>
        <div className="kpi-label">{label}</div>
        <div className="kpi-value">{value}</div>
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
        <div className="kpi-grid">
            <KPICard label={t(ContentRegistry.MANAGER_DASHBOARD.KPI.TODAY_SHIFTS)} value={todayShifts} color="#3b82f6" dataCy="kpi-today-shifts" />
            <KPICard label={t(ContentRegistry.MANAGER_DASHBOARD.KPI.ACTIVE_CLIENTS)} value={activeClients} color="#10b981" dataCy="kpi-active-clients" />
            <KPICard label={t(ContentRegistry.MANAGER_DASHBOARD.KPI.STAFF_ON_DUTY)} value={staffOnDuty} color="#f59e0b" dataCy="kpi-staff-on-duty" />
            <KPICard label={t(ContentRegistry.MANAGER_DASHBOARD.KPI.OPEN_INCIDENTS)} value={openIncidents} color="#ef4444" dataCy="kpi-open-incidents" />
        </div>
    );
};
