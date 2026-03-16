import React, { memo } from 'react';
import { useNavigate } from 'react-router';
import { ChartCard } from './ChartCard';
import { CoreScatterChart } from './core';

const days = ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

interface Props {
    data?: any[];
    isDemo?: boolean;
}

export const StaffAttendanceHeatmap = React.memo(({ data, isDemo }: Props) => {
    const navigate = useNavigate();
    const chartData = (data || []).map((d: any) => ({
        x: d.dates,
        y: d.name,
        value: d.status === 'Present' ? 100 : d.status === 'Late' ? 75 : d.status === 'Absent' ? 0 : 50
    }));

    return (
        <ChartCard title="Staff Attendance" subtitle="Recent patterns" isDemo={isDemo}>
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
