import React from 'react';
import { MyEarningsTrend } from '@/shared/components/charts/MyEarningsTrend';
import { MyReliabilityScore } from '@/shared/components/charts/MyReliabilityScore';
import { ShiftDistributionChart } from '@/shared/components/charts/ShiftDistributionChart';
import { StaffAttendanceHeatmap } from '@/shared/components/charts/StaffAttendanceHeatmap';
interface PswStatsProps {
    chartData: any;
}

export const PswStats: React.FC<PswStatsProps> = ({ chartData }) => {
    return (
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '20px', marginBottom: '30px' }}>
            <MyEarningsTrend data={chartData?.earnings || []} isDemo={false} />
            <MyReliabilityScore data={chartData?.reliability || []} isDemo={false} />
            <ShiftDistributionChart data={chartData?.shifts || []} isDemo={false} />
            <StaffAttendanceHeatmap data={chartData?.attendance || []} isDemo={false} />
        </div>
    );
};
