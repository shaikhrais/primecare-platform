import React, { memo } from 'react';
import { useNavigate } from 'react-router';
import { ChartCard } from './ChartCard';
import { CoreAreaChart } from './core';

interface Props {
    data?: any[];
    isDemo?: boolean;
}

export const IncidentTrendChart = React.memo(({ data, isDemo }: Props) => {
    const navigate = useNavigate();

    const chartData = data || [];

    return (
        <ChartCard title="Incident Trends" subtitle="Reported incidents over time" isDemo={isDemo}>
            <CoreAreaChart
                data={chartData}
                xKey="name"
                series={[{ key: 'count', color: '#EF4444' }]}
                onGraphicClick={() => navigate('/incidents')}
            />
        </ChartCard>
    );
});

IncidentTrendChart.displayName = 'IncidentTrendChart';
