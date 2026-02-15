import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CoreBarChart } from './core';

interface Props {
    data?: any[];
}

export const ShiftFulfillmentChart = memo(({ data }: Props) => {
    const navigate = useNavigate();

    const chartData = data || [];
    return (
        <ChartCard title="Shift Fulfillment" height={400}>
            <CoreBarChart
                data={chartData}
                xKey="day"
                series={[
                    { key: 'filled', name: 'Filled Shifts', color: '#10B981', stackId: 'a' },
                    { key: 'open', name: 'Open Shifts', color: '#EF4444', stackId: 'a' }
                ]}
                onBarClick={() => navigate('/schedule')}
            />
        </ChartCard>
    );
});

ShiftFulfillmentChart.displayName = 'ShiftFulfillmentChart';
