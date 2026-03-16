import React, { memo } from 'react';
import { useNavigate } from 'react-router';
import { ChartCard } from './ChartCard';
import { CoreRadialBarChart } from './core';

interface Props {
    data?: any[];
    isDemo?: boolean;
}

export const CarePlanAdherenceGauge = memo(({ data, isDemo }: Props) => {
    const navigate = useNavigate();
    const chartData = data || [];
    const displayValue = (data && data.length > 0) ? data[0].value : 0;
    return (
        <ChartCard title="Care Plan Adherence" subtitle="Overall compliance" isDemo={isDemo}>
            <CoreRadialBarChart
                data={chartData}
                dataKey="count"
                onBarClick={() => navigate('/compliance/care-plans')}
            />
        </ChartCard>
    );
});

CarePlanAdherenceGauge.displayName = 'CarePlanAdherenceGauge';
