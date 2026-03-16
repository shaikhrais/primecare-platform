import React, { memo } from 'react';
import { useNavigate } from 'react-router';
import { ChartCard } from './ChartCard';
import { CorePieChart } from './core';

const COLORS = ['#EF4444', '#10B981'];

interface Props {
    data?: any[];
    isDemo?: boolean;
}

export const BudgetUtilizationChart = memo(({ data, isDemo }: Props) => {
    const navigate = useNavigate();

    const chartData = data || [
        { name: 'Used', value: 0 },
        { name: 'Remaining', value: 100 }
    ];

    return (
        <ChartCard
            title="Budget Utilization"
            height={400}
            subtitle="Total Budget"
            isDemo={isDemo}
        >
            <CorePieChart
                data={chartData}
                dataKey="value"
                nameKey="name"
                colors={COLORS}
                innerRadius={60}
                outerRadius={100}
                onPieClick={() => navigate('/client/billing')}
            />
        </ChartCard>
    );
});

BudgetUtilizationChart.displayName = 'BudgetUtilizationChart';
