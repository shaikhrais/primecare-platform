import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CoreBarChart } from './core';

interface Props {
    data?: any[];
}

export const TravelTimeAnalysis = memo(({ data }: Props) => {
    const navigate = useNavigate();
    const chartData = data || [];
    return (
        <ChartCard title="Travel vs Service Time" height={400}>
            <CoreBarChart
                data={chartData}
                layout="vertical"
                xKey="zone"
                series={[
                    { key: 'travel', name: 'Travel Time (min)', color: '#EF4444', stackId: 'a', radius: [0, 0, 0, 4] },
                    { key: 'service', name: 'Service Time (min)', color: '#10B981', stackId: 'a', radius: [0, 4, 4, 0] }
                ]}
                onBarClick={() => navigate('/schedule/logistics')}
            />
        </ChartCard>
    );
});

TravelTimeAnalysis.displayName = 'TravelTimeAnalysis';
