import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CoreRadarChart } from './core';

interface Props {
    data?: any[];
}

export const ClientSatisfactionRadar = memo(({ data }: Props) => {
    const navigate = useNavigate();
    const chartData = data || [];
    return (
        <ChartCard title="Client Satisfaction Metrics" height={400}>
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
