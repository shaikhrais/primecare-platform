import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { ChartCard } from './ChartCard';
import { CoreAreaChart } from './core';

const { RouteRegistry } = AdminRegistry;

interface Props {
    data?: any[];
    isDemo?: boolean;
}

export const VisitVolumeChart = React.memo(({ data, isDemo }: Props) => {
    const navigate = useNavigate();

    // Transform data...
    const chartData = (data || []).map((d: any) => ({
        name: d.date,
        visits: d.count
    }));

    const handleClick = (data: any) => {
        // Drill down to schedule
        navigate(`${RouteRegistry.ADMIN.SCHEDULE}?view=week`);
    };

    return (
        <ChartCard title="Visit Volume" subtitle="Daily visit counts" isDemo={isDemo}>
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
