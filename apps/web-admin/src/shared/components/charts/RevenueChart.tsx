import React from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { ChartCard } from './ChartCard';
import { CoreBarChart } from './core';

const { RouteRegistry } = AdminRegistry;

interface Props {
    data?: any[];
}

export const RevenueChart = React.memo(({ data }: Props) => {
    const navigate = useNavigate();

    // Transform API data (month, actual, projected) to Chart data (name, revenue)
    const chartData = (data || []).map((d: any) => ({
        name: d.month,
        revenue: d.actual
    }));

    const handleClick = (data: any) => {
        if (data && data.activePayload && data.activePayload.length > 0) {
            // Drill down to earnings for that month (mock filter)
            navigate(`${RouteRegistry.EARNINGS}?tab=Overview&month=${data.activeLabel}`);
        }
    };

    return (
        <ChartCard title="Revenue Trends" subtitle="Click bars to drill down">
            <CoreBarChart
                data={chartData}
                xKey="name"
                series={[{ key: 'revenue', color: '#00875A' }]}
                yAxisFormatter={(value) => `$${value}`}
                onBarClick={handleClick}
                highlightLastBar={true}
                highlightColor="#006644"
            />
        </ChartCard>
    );
});
