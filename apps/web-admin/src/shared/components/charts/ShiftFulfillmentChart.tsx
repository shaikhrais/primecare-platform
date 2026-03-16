import React, { memo } from 'react';
import { useNavigate } from 'react-router';
import { ChartCard } from './ChartCard';
import { CoreBarChart } from './core';

interface Props {
    data?: any[];
    isDemo?: boolean;
}

export const ShiftFulfillmentChart = React.memo(({ data, isDemo }: Props) => {
    const navigate = useNavigate();

    const chartData = (data || []).map((d: any) => ({
        name: d.month,
        fulfilled: d.fulfilled,
        unfilled: d.unfilled
    }));

    return (
        <ChartCard title="Shift Fulfillment" subtitle="Filled vs Unfilled Shifts" isDemo={isDemo}>
            <CoreBarChart
                data={chartData}
                xKey="name"
                series={[
                    { key: 'fulfilled', name: 'Filled Shifts', color: '#10B981', stackId: 'a' },
                    { key: 'unfilled', name: 'Open Shifts', color: '#EF4444', stackId: 'a' }
                ]}
                onBarClick={() => navigate('/schedule')}
            />
        </ChartCard>
    );
});

ShiftFulfillmentChart.displayName = 'ShiftFulfillmentChart';
