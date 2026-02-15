import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CoreRadialBarChart } from './core';

interface Props {
    data?: any[];
}

export const CarePlanAdherenceGauge = memo(({ data }: Props) => {
    const navigate = useNavigate();
    const chartData = data || [];
    return (
        <ChartCard title="Care Plan Adherence" height={400}>
            <CoreRadialBarChart
                data={chartData}
                dataKey="count"
                onBarClick={() => navigate('/compliance/care-plans')}
            />
        </ChartCard>
    );
});

CarePlanAdherenceGauge.displayName = 'CarePlanAdherenceGauge';
