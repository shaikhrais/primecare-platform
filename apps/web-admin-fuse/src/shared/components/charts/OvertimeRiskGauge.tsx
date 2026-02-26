import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CoreRadialBarChart } from './core';

interface Props {
    data?: any[];
    isDemo?: boolean;
}

export const OvertimeRiskGauge = memo(({ data, isDemo }: Props) => {
    const navigate = useNavigate();
    const chartData = data || [];

    return (
        <ChartCard title="Overtime Risk" subtitle="Current risk level" isDemo={isDemo}>
            <CoreRadialBarChart
                data={chartData}
                dataKey="count"
                onBarClick={() => navigate('/staff/overtime')}
            />
        </ChartCard>
    );
});

OvertimeRiskGauge.displayName = 'OvertimeRiskGauge';
