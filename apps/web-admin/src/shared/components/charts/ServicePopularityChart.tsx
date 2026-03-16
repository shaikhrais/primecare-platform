import React, { memo } from 'react';
import { useNavigate } from 'react-router';
import { ChartCard } from './ChartCard';
import { CorePieChart } from './core';

const COLORS = ['#0088FE', '#00C49F', '#FFBB28', '#FF8042'];

interface Props {
    data?: any[];
    isDemo?: boolean;
}

export const ServicePopularityChart = React.memo(({ data, isDemo }: Props) => {
    const navigate = useNavigate();
    const chartData = data || [];

    return (
        <ChartCard title="Service Popularity" subtitle="Most requested services" isDemo={isDemo}>
            <CorePieChart
                data={chartData}
                dataKey="value"
                nameKey="name"
                colors={COLORS}
                onPieClick={() => navigate('/reports/services')}
            />
        </ChartCard>
    );
});

ServicePopularityChart.displayName = 'ServicePopularityChart';
