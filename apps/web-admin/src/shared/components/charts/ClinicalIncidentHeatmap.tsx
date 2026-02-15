import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CoreScatterChart } from './core';

const types = ['', 'Falls', 'Meds', 'Skin', 'Behavior'];
const severities = ['', 'Low', 'Medium', 'High', 'Critical'];

interface Props {
    data?: any[];
}

export const ClinicalIncidentHeatmap = memo(({ data }: Props) => {
    const navigate = useNavigate();

    const chartData = data || [];

    return (
        <ChartCard title="Clinical Incident Hotspots" height={400}>
            <CoreScatterChart
                data={chartData}
                scatterName="Incidents"
                xAxis={{
                    dataKey: 'type',
                    name: 'Type',
                    type: 'number',
                    domain: [0, 5],
                    tickCount: 6,
                    tickFormatter: (val: number) => types[val] || ''
                }}
                yAxis={{
                    dataKey: 'severity',
                    name: 'Severity',
                    type: 'number',
                    domain: [0, 5],
                    tickCount: 6,
                    tickFormatter: (val: number) => severities[val] || ''
                }}
                zAxis={{
                    dataKey: 'count',
                    range: [100, 500],
                    name: 'Frequency'
                }}
                fillColor="#EF4444"
                onScatterClick={() => navigate('/rn/incidents')}
            />
        </ChartCard>
    );
});

ClinicalIncidentHeatmap.displayName = 'ClinicalIncidentHeatmap';
