import React from 'react';
import { ChartCard } from './ChartCard';
import { CorePieChart } from './core';

const COLORS = ['#00875A', '#F59E0B', '#EF4444'];

interface Props {
    data?: any[];
}

export const StaffUtilizationChart = React.memo(({ data }: Props) => {
    const chartData = data || [];
    return (
        <ChartCard title="Staff Time Utilization" height={400}>
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
