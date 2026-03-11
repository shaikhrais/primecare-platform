import React from 'react';
import { BudgetUtilizationChart } from '@/shared/components/charts/BudgetUtilizationChart';
import { WellnessTrendChart } from '@/shared/components/charts/WellnessTrendChart';
import { CareContinuityChart } from '@/shared/components/charts/CareContinuityChart';
import { ClientSatisfactionRadar } from '@/shared/components/charts/ClientSatisfactionRadar';
// Removed MOCK_ data to enforce strict DB mode
interface ClientOverviewProps {
    stats: any;
}

export const ClientOverview: React.FC<ClientOverviewProps> = ({ stats }) => {
    return (
        <>
            <WellnessTrendChart data={stats?.wellnessTrends || []} />
            <CareContinuityChart data={stats?.careContinuity || []} />
            <BudgetUtilizationChart data={stats?.budgetUtilization || []} />
            <ClientSatisfactionRadar data={stats?.satisfaction || []} />
        </>
    );
};
