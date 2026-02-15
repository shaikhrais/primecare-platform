import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CorePieChart } from './core';

const COLORS = ['#F59E0B', '#3B82F6', '#8B5CF6'];

interface Props {
    data?: any[];
}

export const ShiftDistributionChart = memo(({ data }: Props) => {
    const navigate = useNavigate();

    const chartData = data || [];

    return (
        <ChartCard title="My Shift Types" height={400}>
            <CorePieChart
                data={chartData}
                dataKey="value"
                nameKey="name"
                colors={COLORS}
                innerRadius={60}
                outerRadius={100}
                onPieClick={() => navigate('/psw/schedule')}
            />
        </ChartCard>
    );
});

ShiftDistributionChart.displayName = 'ShiftDistributionChart';
