import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CoreLineChart } from './core';

interface Props {
    data?: any[];
}

export const WellnessTrendChart = memo(({ data }: Props) => {
    const navigate = useNavigate();
    const chartData = data || [];

    return (
        <ChartCard title="My Wellness Trends" height={400}>
            <CoreLineChart
                data={chartData}
                xKey="day"
                series={[
                    { key: 'mood', name: 'Mood', color: '#8884d8' },
                    { key: 'energy', name: 'Energy', color: '#82ca9d' }
                ]}
                onLineClick={() => navigate('/client/wellness')}
            />
        </ChartCard>
    );
});

WellnessTrendChart.displayName = 'WellnessTrendChart';
