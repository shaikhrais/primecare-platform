import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CorePieChart } from './core';

const COLORS = ['#EF4444', '#10B981'];

interface Props {
    data?: any[];
}

export const BudgetUtilizationChart = memo(({ data }: Props) => {
    const navigate = useNavigate();

    // Fallback if no data
    const chartData = data || [
        { name: 'Used', value: 0 },
        { name: 'Remaining', value: 100 }
    ];

    return (
        <ChartCard
            title="Budget Utilization"
            height={400}
            subtitle="Total Budget: $5,000"
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
