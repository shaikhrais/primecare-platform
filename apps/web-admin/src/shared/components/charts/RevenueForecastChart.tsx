import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CoreBarChart } from './core';

interface Props {
    data?: any[];
}

export const RevenueForecastChart = memo(({ data }: Props) => {
    const navigate = useNavigate();
    const chartData = data || [];
    return (
        <ChartCard title="Revenue Forecast" height={400}>
            <CoreBarChart
                data={chartData}
                xKey="month"
                series={[
                    { key: 'actual', name: 'Actual Revenue', color: '#10B981', radius: [4, 4, 0, 0] },
                    { key: 'projected', name: 'Projected', color: '#6B7280', radius: [4, 4, 0, 0] }
                ]}
                yAxisFormatter={(value) => `$${value}`}
                onBarClick={() => navigate('/finance/revenue')}
            />
        </ChartCard>
    );
});

RevenueForecastChart.displayName = 'RevenueForecastChart';
