import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CoreBarChart } from './core';

interface Props {
    data?: any[];
    isDemo?: boolean;
}

export const ResourceAvailabilityChart = memo(({ data, isDemo }: Props) => {
    const navigate = useNavigate();
    const chartData = (data || []).map((d: any) => ({
        name: d.hour,
        busy: d.busy,
        available: d.available
    }));

    return (
        <ChartCard title="Resource Availability" subtitle="Staff on standby" isDemo={isDemo}>
            <CoreBarChart
                data={chartData}
                xKey="name"
                series={[
                    { key: 'busy', name: 'Busy', color: '#EF4444', stackId: 'a' },
                    { key: 'available', name: 'Available', color: '#10B981', stackId: 'a' }
                ]}
                onBarClick={() => navigate('/schedule')}
            />
        </ChartCard>
    );
});

ResourceAvailabilityChart.displayName = 'ResourceAvailabilityChart';
