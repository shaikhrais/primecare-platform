import React, { memo } from 'react';
import { useNavigate } from 'react-router';
import { ChartCard } from './ChartCard';
import { CoreLineChart } from './core';

interface Props {
    data?: any[];
    isDemo?: boolean;
}

export const WellnessTrendChart = memo(({ data, isDemo }: Props) => {
    const navigate = useNavigate();
    const chartData = (data || []).map((d: any) => ({
        name: d.date,
        score: d.score
    }));

    return (
        <ChartCard title="Wellness Trends" subtitle="Health Score History" isDemo={isDemo}>
            <CoreLineChart
                data={chartData}
                xKey="name"
                series={[
                    { key: 'score', name: 'Wellness Score', color: '#8884d8' }
                ]}
                onLineClick={() => navigate('/client/wellness')}
            />
        </ChartCard>
    );
});

WellnessTrendChart.displayName = 'WellnessTrendChart';
