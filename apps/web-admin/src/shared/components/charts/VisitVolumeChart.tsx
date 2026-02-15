import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { ChartCard } from './ChartCard';
import { CoreAreaChart } from './core';

const { RouteRegistry } = AdminRegistry;

interface Props {
    data?: any[];
}

export const VisitVolumeChart = memo(({ data }: Props) => {
    const navigate = useNavigate();

    const chartData = data || [];

    const handleClick = (data: any) => {
        // Drill down to schedule
        navigate(`${RouteRegistry.SCHEDULE}?view=week`);
    };

    return (
        <ChartCard title="Visit Volume" subtitle="Last 7 Days">
            <CoreAreaChart
                data={chartData}
                xKey="name"
                series={[{ key: 'visits', color: '#3B82F6' }]}
                onGraphicClick={handleClick}
                showGradient={true}
            />
        </ChartCard>
    );
});
