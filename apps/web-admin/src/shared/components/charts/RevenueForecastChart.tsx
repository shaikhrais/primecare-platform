import React, { memo } from 'react';
import { useNavigate } from 'react-router';
import { ChartCard } from './ChartCard';
import { CoreBarChart } from './core';

interface Props {
    data?: any[];
    isDemo?: boolean;
}

export const RevenueForecastChart = memo(({ data, isDemo }: Props) => {
    const navigate = useNavigate();
    const chartData = (data || []).map((d: any) => ({
        month: d.month,
        actual: d.actual,
        forecast: d.projected
    }));
    return (
        <ChartCard title="Revenue Forecast" subtitle="Projected vs Actual" isDemo={isDemo}>
            <CoreBarChart
                data={chartData}
                xKey="month"
                series={[
                    { key: 'actual', name: 'Actual Revenue', color: '#10B981', radius: [4, 4, 0, 0] },
                    { key: 'forecast', name: 'Projected', color: '#6B7280', radius: [4, 4, 0, 0] }
                ]}
                yAxisFormatter={(value) => `$${value}`}
                onBarClick={() => navigate('/finance/revenue')}
            />
        </ChartCard>
    );
});

RevenueForecastChart.displayName = 'RevenueForecastChart';
