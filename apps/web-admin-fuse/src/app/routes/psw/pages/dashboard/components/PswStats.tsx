import React from 'react';
import { MyEarningsTrend } from '@/shared/components/charts/MyEarningsTrend';
import { MyReliabilityScore } from '@/shared/components/charts/MyReliabilityScore';
import { ShiftDistributionChart } from '@/shared/components/charts/ShiftDistributionChart';
import { StaffAttendanceHeatmap } from '@/shared/components/charts/StaffAttendanceHeatmap';
import { MOCK_PSW_DATA, MOCK_MANAGER_DATA } from '@/shared/data/mockChartData';

interface PswStatsProps {
    chartData: any;
}

export const PswStats: React.FC<PswStatsProps> = ({ chartData }) => {
    return (
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '20px', marginBottom: '30px' }}>
            <MyEarningsTrend data={(chartData?.earnings?.length > 0) ? chartData.earnings : MOCK_PSW_DATA.earnings} isDemo={!chartData?.earnings?.length} />
            <MyReliabilityScore data={(chartData?.reliability?.length > 0) ? chartData.reliability : MOCK_PSW_DATA.reliability} isDemo={!chartData?.reliability?.length} />
            <ShiftDistributionChart data={(chartData?.shiftDistribution?.length > 0) ? chartData.shiftDistribution : MOCK_PSW_DATA.distribution} isDemo={!chartData?.shiftDistribution?.length} />
            <StaffAttendanceHeatmap data={(chartData?.attendance?.length > 0) ? chartData.attendance : MOCK_MANAGER_DATA.staffAttendance} isDemo={!chartData?.attendance?.length} />
        </div>
    );
};
