import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CoreBarChart } from './core';

interface Props {
    data?: any[];
}

export const ResourceAvailabilityChart = memo(({ data }: Props) => {
    const navigate = useNavigate();
    const chartData = data || [];
    return (
        <ChartCard title="Resource Availability" height={400}>
            <CoreBarChart
                data={chartData}
                xKey="hour"
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
