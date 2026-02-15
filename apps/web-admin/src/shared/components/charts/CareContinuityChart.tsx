import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CoreAreaChart } from './core';

interface Props {
    data?: any[];
}

export const CareContinuityChart = memo(({ data }: Props) => {
    const navigate = useNavigate();
    const chartData = data || [];

    return (
        <ChartCard title="Care Team Consistency" height={400} subtitle="Goal: 90% Primary Caregiver">
            <CoreAreaChart
                data={chartData}
                xKey="month"
                unit="%"
                series={[
                    { key: 'primary', name: 'Primary Caregiver', color: '#4F46E5', stackId: '1' },
                    { key: 'relief', name: 'Relief Staff', color: '#9CA3AF', stackId: '1' }
                ]}
                onGraphicClick={() => navigate('/client/care-team')}
            />
        </ChartCard>
    );
});

CareContinuityChart.displayName = 'CareContinuityChart';
