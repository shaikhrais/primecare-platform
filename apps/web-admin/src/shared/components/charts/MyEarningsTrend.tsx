import React, { memo } from 'react';
import { useNavigate } from 'react-router';
import { ChartCard } from './ChartCard';
import { CoreAreaChart } from './core';

interface Props {
    data?: any[];
    isDemo?: boolean;
}

export const MyEarningsTrend = React.memo(({ data, isDemo }: Props) => {
    const navigate = useNavigate();
    const chartData = (data || []).map((d: any) => ({
        name: d.date,
        amount: d.amount
    }));

    return (
        <ChartCard title="My Earnings" subtitle="Last 30 Days" isDemo={isDemo}>
            <CoreAreaChart
                data={chartData}
                xKey="name"
                series={[{ key: 'amount', name: 'Earnings', color: '#4F46E5' }]} // Corrected key to 'amount' based on map above
                yAxisFormatter={(value) => `$${value}`}
                onGraphicClick={() => navigate('/psw/earnings')}
            />
        </ChartCard>
    );
});

MyEarningsTrend.displayName = 'MyEarningsTrend';
