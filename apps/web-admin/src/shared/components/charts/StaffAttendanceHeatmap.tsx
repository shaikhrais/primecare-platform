import React, { memo } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChartCard } from './ChartCard';
import { CoreScatterChart } from './core';

const days = ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

interface Props {
    data?: any[];
}

export const StaffAttendanceHeatmap = memo(({ data }: Props) => {
    const navigate = useNavigate();
    const chartData = data || [];
    return (
        <ChartCard title="Lateness Heatmap" height={400}>
            <CoreScatterChart
                data={chartData}
                scatterName="Late Arrivals"
                fillColor="#F59E0B"
                xAxis={{
                    dataKey: 'day',
                    name: 'Day',
                    tickFormatter: (val: number) => days[val] || '',
                    domain: [0, 5],
                    tickCount: 6
                }}
                yAxis={{
                    dataKey: 'hour',
                    name: 'Hour',
                    unit: 'h',
                    domain: [6, 22]
                }}
                zAxis={{
                    dataKey: 'count',
                    range: [50, 400],
                    name: 'Late Arrivals'
                }}
                onScatterClick={() => navigate('/staff/attendance')}
            />
        </ChartCard>
    );
});

StaffAttendanceHeatmap.displayName = 'StaffAttendanceHeatmap';
