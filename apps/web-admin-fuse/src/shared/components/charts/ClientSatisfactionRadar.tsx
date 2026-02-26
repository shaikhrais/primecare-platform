import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CoreRadarChart } from './core';

interface Props {
    data?: any[];
    isDemo?: boolean;
}

export const ClientSatisfactionRadar = React.memo(({ data, isDemo }: Props) => {
    const navigate = useNavigate();
    const chartData = data || [];
    return (
        <ChartCard title="Client Satisfaction" subtitle="By category" isDemo={isDemo}>
            <CoreRadarChart
                data={chartData}
                angleKey="subject"
                radiusKey="A"
                radarName="Satisfaction"
                color="#8884d8"
                onRadarClick={() => navigate('/surveys/results')}
            />
        </ChartCard>
    );
});

ClientSatisfactionRadar.displayName = 'ClientSatisfactionRadar';
