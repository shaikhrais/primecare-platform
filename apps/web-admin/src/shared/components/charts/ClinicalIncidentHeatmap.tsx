import React, { memo } from 'react';
import { useNavigate } from 'react-router';
import { ChartCard } from './ChartCard';
import { CoreScatterChart } from './core';

const types = ['', 'Falls', 'Meds', 'Skin', 'Behavior'];
const severities = ['', 'Low', 'Medium', 'High', 'Critical'];

interface Props {
    data?: any[];
    isDemo?: boolean;
}

export const ClinicalIncidentHeatmap = memo(({ data, isDemo }: Props) => {
    const navigate = useNavigate();

    const chartData = (data || []).map((d: any) => ({
        x: d.dates,
        y: d.type,
        value: d.severity === 'Critical' ? 100 : d.severity === 'High' ? 75 : d.severity === 'Medium' ? 50 : 25
    }));

    return (
        <ChartCard title="Incident Heatmap" subtitle="Severity & Frequency" isDemo={isDemo}>
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
