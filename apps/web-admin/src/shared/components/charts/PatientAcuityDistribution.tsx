import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CoreBarChart } from './core';

interface Props {
    data?: any[];
}

const COLORS = ['#10B981', '#F59E0B', '#EF4444', '#7F1D1D'];

export const PatientAcuityDistribution = memo(({ data }: Props) => {
    const navigate = useNavigate();
    const chartData = (data || []).map((d, i) => ({ ...d, fill: COLORS[i % COLORS.length] }));

    return (
        <ChartCard title="Patient Acuity Distribution" height={400}>
            <CoreBarChart
                data={chartData}
                xKey="name"
                series={[{ key: 'count', name: 'Count', color: '#8884d8' }]}
                onBarClick={() => navigate('/rn/patients')}
                highlightLastBar={true} // Reusing this prop to trigger cell rendering, though we need custom colors
                highlightColor={COLORS[3]} // Just a placeholder, we need to pass colors
            />
        </ChartCard>
    );
});

PatientAcuityDistribution.displayName = 'PatientAcuityDistribution';
