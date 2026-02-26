import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CoreAreaChart } from './core';

interface Props {
    data?: any[];
    isDemo?: boolean;
}

export const CareContinuityChart = React.memo(({ data, isDemo }: Props) => {
    const navigate = useNavigate();
    const chartData = (data || []).map((d: any) => ({
        name: d.month,
        continuity: d.percentage
    }));

    return (
        <ChartCard title="Care Continuity" subtitle="Provider Consistency" isDemo={isDemo}>
            <CoreAreaChart
                data={chartData}
                xKey="name"
                unit="%"
                series={[
                    { key: 'continuity', name: 'Continuity', color: '#4F46E5', stackId: '1' }
                ]}
                onGraphicClick={() => navigate('/client/care-team')}
            />
        </ChartCard>
    );
});

CareContinuityChart.displayName = 'CareContinuityChart';
