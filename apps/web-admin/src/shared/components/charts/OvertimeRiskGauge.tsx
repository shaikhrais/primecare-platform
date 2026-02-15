import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CoreRadialBarChart } from './core';

interface Props {
    data?: any[];
}

export const OvertimeRiskGauge = memo(({ data }: Props) => {
    const navigate = useNavigate();
    const chartData = data || [];
    return (
        <ChartCard title="Overtime Risk Monitor" height={400}>
            <CoreRadialBarChart
                data={chartData}
                dataKey="count"
                onBarClick={() => navigate('/staff/overtime')}
            />
        </ChartCard>
    );
});

OvertimeRiskGauge.displayName = 'OvertimeRiskGauge';
