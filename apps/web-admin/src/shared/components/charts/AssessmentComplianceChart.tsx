import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CoreBarChart } from './core';

interface Props {
    data?: any[];
    isDemo?: boolean;
}

export const AssessmentComplianceChart = React.memo(({ data, isDemo }: Props) => {
    const navigate = useNavigate();

    const chartData = (data || []).map((d: any) => ({
        name: d.name,
        value: d.value
    }));

    return (
        <ChartCard title="Assessment Compliance" subtitle="Last 30 Days" isDemo={isDemo}>
            <CoreBarChart
                data={chartData}
                layout="vertical"
                xKey="name"
                series={[
                    { key: 'value', name: 'Count', color: '#10B981', stackId: 'a', radius: [4, 4, 4, 4] }
                ]}
                onBarClick={() => navigate('/rn/assessments')}
            />
        </ChartCard>
    );
});

AssessmentComplianceChart.displayName = 'AssessmentComplianceChart';
