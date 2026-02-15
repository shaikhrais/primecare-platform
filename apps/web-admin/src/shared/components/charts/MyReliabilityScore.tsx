import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CoreRadialBarChart } from './core';

interface Props {
    data?: any[];
}

export const MyReliabilityScore = memo(({ data }: Props) => {
    const navigate = useNavigate();
    const chartData = data || [];

    return (
        <ChartCard title="My Reliability Score" height={400} subtitle="Score: 95% (Top 10% of Staff)">
            <CoreRadialBarChart
                data={chartData}
                dataKey="count"
                onBarClick={() => navigate('/psw/performance')}
            />
        </ChartCard>
    );
});

MyReliabilityScore.displayName = 'MyReliabilityScore';
