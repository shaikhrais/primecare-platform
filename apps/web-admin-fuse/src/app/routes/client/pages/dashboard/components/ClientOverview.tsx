import React from 'react';
import { BudgetUtilizationChart } from '@/shared/components/charts/BudgetUtilizationChart';
import { WellnessTrendChart } from '@/shared/components/charts/WellnessTrendChart';
import { CareContinuityChart } from '@/shared/components/charts/CareContinuityChart';
import { ClientSatisfactionRadar } from '@/shared/components/charts/ClientSatisfactionRadar';
import { MOCK_CLIENT_DATA, MOCK_MANAGER_DATA } from '@/shared/data/mockChartData';

interface ClientOverviewProps {
    stats: any;
}

export const ClientOverview: React.FC<ClientOverviewProps> = ({ stats }) => {
    return (
        <>
            <WellnessTrendChart data={(stats?.wellnessTrends?.length > 0) ? stats.wellnessTrends : MOCK_CLIENT_DATA.wellness} isDemo={!stats?.wellnessTrends?.length} />
            <CareContinuityChart data={(stats?.careContinuity?.length > 0) ? stats.careContinuity : MOCK_CLIENT_DATA.continuity} isDemo={!stats?.careContinuity?.length} />
            <BudgetUtilizationChart data={(stats?.budgetUtilization?.length > 0) ? stats.budgetUtilization : MOCK_CLIENT_DATA.budget} isDemo={!stats?.budgetUtilization?.length} />
            <ClientSatisfactionRadar data={(stats?.satisfaction?.length > 0) ? stats.satisfaction : MOCK_MANAGER_DATA.clientSatisfaction} isDemo={!stats?.satisfaction?.length} />
        </>
    );
};
