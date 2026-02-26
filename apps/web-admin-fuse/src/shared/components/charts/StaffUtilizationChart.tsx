import React from 'react';
import { ChartCard } from './ChartCard';
import { CorePieChart } from './core';

const COLORS = ['#00875A', '#F59E0B', '#EF4444'];

interface Props {
    data?: any[];
    isDemo?: boolean;
}

export const StaffUtilizationChart = React.memo(({ data, isDemo }: Props) => {
    const chartData = data || [];
    return (
        <ChartCard title="Staff Time Utilization" height={400} isDemo={isDemo}>
            <CorePieChart
                data={chartData}
                dataKey="value"
                nameKey="name"
                colors={COLORS}
                innerRadius={60}
                outerRadius={100}
            />
        </ChartCard>
    );
});
