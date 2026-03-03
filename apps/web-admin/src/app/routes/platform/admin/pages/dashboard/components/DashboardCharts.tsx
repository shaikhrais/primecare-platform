import React from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

// Chart Components
import { RevenueChart } from '@/shared/components/charts/RevenueChart';
import { VisitVolumeChart } from '@/shared/components/charts/VisitVolumeChart';
import { ShiftFulfillmentChart } from '@/shared/components/charts/ShiftFulfillmentChart';
import { ServicePopularityChart } from '@/shared/components/charts/ServicePopularityChart';
import { IncidentTrendChart } from '@/shared/components/charts/IncidentTrendChart';
import { CarePlanAdherenceGauge } from '@/shared/components/charts/CarePlanAdherenceGauge';
import { StaffAttendanceHeatmap } from '@/shared/components/charts/StaffAttendanceHeatmap';
import { ClientSatisfactionRadar } from '@/shared/components/charts/ClientSatisfactionRadar';
import { RevenueForecastChart } from '@/shared/components/charts/RevenueForecastChart';

const { ContentRegistry } = AdminRegistry;

export const DashboardCharts: React.FC = () => {
    const { t } = useTranslation();

    return (
        <>
            <h2 style={{ fontSize: '0.75rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '2px', marginBottom: '1.5rem', color: 'var(--text-300)' }}>
                {t(ContentRegistry.ADMIN_DASHBOARD.TITLES.ANALYTICS)}
            </h2>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(400px, 1fr))', gap: '1.5rem', marginBottom: '3rem' }}>
                <RevenueChart />
                <VisitVolumeChart />
                <ShiftFulfillmentChart />
                <ServicePopularityChart />
                <IncidentTrendChart />
                <CarePlanAdherenceGauge />
                <StaffAttendanceHeatmap />
                <ClientSatisfactionRadar />
                <RevenueForecastChart />
            </div>
        </>
    );
};
