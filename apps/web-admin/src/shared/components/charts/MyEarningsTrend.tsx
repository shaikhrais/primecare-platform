import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CoreBarChart } from './core';

interface Props {
    data?: any[];
}

export const MyEarningsTrend = memo(({ data }: Props) => {
    const navigate = useNavigate();
    const chartData = data || [];

    return (
        <ChartCard title="My Monthly Earnings" height={400}>
            <CoreBarChart
                data={chartData}
                xKey="name"
                series={[{ key: 'earnings', name: 'Earnings', color: '#4F46E5', radius: [4, 4, 0, 0] }]}
                yAxisFormatter={(value) => `$${value}`}
                onBarClick={() => navigate('/psw/earnings')}
            />
        </ChartCard>
    );
});

MyEarningsTrend.displayName = 'MyEarningsTrend';
