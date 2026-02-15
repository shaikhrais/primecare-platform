import React from 'react';
import { ChartCard } from './ChartCard';
import { CoreLineChart } from './core';

const data = [
    { name: 'Week 1', current: 4000, previous: 2400 },
    { name: 'Week 2', current: 3000, previous: 1398 },
    { name: 'Week 3', current: 2000, previous: 9800 },
    { name: 'Week 4', current: 2780, previous: 3908 },
    { name: 'Week 5', current: 1890, previous: 4800 },
    { name: 'Week 6', current: 2390, previous: 3800 },
    { name: 'Week 7', current: 3490, previous: 4300 },
];

export const RevenueTrendChart = React.memo(() => {
    return (
        <ChartCard title="Revenue Trends" height={400}>
            <CoreLineChart
                data={data}
                xKey="name"
                yAxisFormatter={(val) => `$${val}`}
                series={[
                    { key: 'current', name: 'Current Period', color: '#00875A', activeDot: { r: 8 } },
                    { key: 'previous', name: 'Previous Period', color: '#9CA3AF', strokeDasharray: '5 5' }
                ]}
            />
        </ChartCard>
    );
});
