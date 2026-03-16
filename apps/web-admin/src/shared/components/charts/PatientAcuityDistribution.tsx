import React, { memo } from 'react';
import { useNavigate } from 'react-router';
import { ChartCard } from './ChartCard';
import { CorePieChart } from './core';

interface Props {
    data?: any[];
    isDemo?: boolean;
}

const COLORS = ['#10B981', '#F59E0B', '#EF4444', '#7F1D1D'];

export const PatientAcuityDistribution = React.memo(({ data, isDemo }: Props) => {
    const navigate = useNavigate();
    const chartData = (data || []).map((d: any) => ({
        name: d.level,
        value: d.count
    }));

    return (
        <ChartCard title="Patient Acuity Distribution" subtitle="Active Caseload" isDemo={isDemo}>
            <CorePieChart
                data={chartData}
                dataKey="value"
                nameKey="name"
                colors={COLORS}
                innerRadius={60}
                outerRadius={100}
                onPieClick={() => navigate('/patients')}
            />
        </ChartCard>
    );
});

PatientAcuityDistribution.displayName = 'PatientAcuityDistribution';
