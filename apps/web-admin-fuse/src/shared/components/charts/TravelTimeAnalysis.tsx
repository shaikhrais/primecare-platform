import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CorePieChart } from './core';

interface Props {
    data?: any[];
    isDemo?: boolean;
}

export const TravelTimeAnalysis = memo(({ data, isDemo }: Props) => {
    const navigate = useNavigate();
    const chartData = (data || []).map((d: any) => ({
        name: d.zone,
        value: d.travel
    }));
    return (
        <ChartCard title="Travel Time Analysis" subtitle="Commute distribution" isDemo={isDemo}>
            <CorePieChart
                data={chartData}
                dataKey="value"
                nameKey="name"
                colors={['#EF4444', '#10B981', '#3B82F6', '#F59E0B']}
                innerRadius={60}
                outerRadius={100}
                onPieClick={() => navigate('/logistics')}
            />
        </ChartCard>
    );
});

TravelTimeAnalysis.displayName = 'TravelTimeAnalysis';
