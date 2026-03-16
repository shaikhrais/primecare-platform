import React, { memo } from 'react';
import { useNavigate } from 'react-router';
import { ChartCard } from './ChartCard';
import { CorePieChart } from './core';

const COLORS = ['#F59E0B', '#3B82F6', '#8B5CF6'];

interface Props {
    data?: any[];
    isDemo?: boolean;
}

export const ShiftDistributionChart = React.memo(({ data, isDemo }: Props) => {
    const navigate = useNavigate();

    const chartData = (data || []).map((d: any) => ({
        name: d.type,
        value: d.count
    }));

    return (
        <ChartCard title="Shift Distribution" subtitle="By Service Type" isDemo={isDemo}>
            <CorePieChart
                data={chartData}
                dataKey="value"
                nameKey="name"
                colors={COLORS}
                innerRadius={60}
                outerRadius={100}
                onPieClick={() => navigate('/psw/schedule')}
            />
        </ChartCard>
    );
});

ShiftDistributionChart.displayName = 'ShiftDistributionChart';
