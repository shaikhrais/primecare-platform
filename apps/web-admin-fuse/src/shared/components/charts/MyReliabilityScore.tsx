import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CoreRadialBarChart } from './core';

interface Props {
    data?: any[];
    isDemo?: boolean;
}

export const MyReliabilityScore = memo(({ data, isDemo }: Props) => {
    const navigate = useNavigate();
    const chartData = data || [];

    return (
        <ChartCard title="Reliability Score" subtitle="Attendance & Punctuality" isDemo={isDemo}>
            <CoreRadialBarChart
                data={chartData}
                dataKey="count"
                onBarClick={() => navigate('/psw/performance')}
            />
        </ChartCard>
    );
});

MyReliabilityScore.displayName = 'MyReliabilityScore';
