import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CoreAreaChart } from './core';

interface Props {
    data?: any[];
}

export const IncidentTrendChart = memo(({ data }: Props) => {
    const navigate = useNavigate();

    const chartData = data || [];
    return (
        <ChartCard title="Incident Trends" height={400}>
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
