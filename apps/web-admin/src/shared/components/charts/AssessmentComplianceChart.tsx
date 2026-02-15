import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CoreBarChart } from './core';

interface Props {
    data?: any[];
}

export const AssessmentComplianceChart = memo(({ data }: Props) => {
    const navigate = useNavigate();

    const chartData = data || [];

    return (
        <ChartCard title="Assessment Compliance" height={400}>
            <CoreBarChart
                data={chartData}
                layout="vertical"
                xKey="name"
                series={[
                    { key: 'overdue', name: 'Overdue', color: '#EF4444', stackId: 'a', radius: [0, 4, 4, 0] },
                    { key: 'completed', name: 'Completed', color: '#10B981', stackId: 'a', radius: [4, 0, 0, 4] }
                ]}
                onBarClick={() => navigate('/rn/assessments')}
            />
        </ChartCard>
    );
});

AssessmentComplianceChart.displayName = 'AssessmentComplianceChart';
