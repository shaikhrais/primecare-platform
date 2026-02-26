import React from 'react';
import { RevenueChart } from '@/shared/components/charts/RevenueChart';
import { ResourceAvailabilityChart } from '@/shared/components/charts/ResourceAvailabilityChart';
import { VisitVolumeChart } from '@/shared/components/charts/VisitVolumeChart';
import { StaffUtilizationChart } from '@/shared/components/charts/StaffUtilizationChart';

interface AnalyticsSectionProps {
    displayData: any;
    isDemo: boolean;
}

export const AnalyticsSection: React.FC<AnalyticsSectionProps> = ({ displayData, isDemo }) => {
    return (
        <>
            <h2 data-cy="section.analytics" style={{ fontSize: '0.75rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '2px', marginBottom: '1.5rem', color: 'var(--text-300)' }}>Performance Analytics</h2>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))', gap: '20px', marginBottom: '40px' }}>
                <RevenueChart data={displayData.revenue} isDemo={isDemo} />
                <VisitVolumeChart data={displayData.visitVolume} isDemo={isDemo} />
                <StaffUtilizationChart data={displayData.staffUtilization} isDemo={isDemo} />
                <ResourceAvailabilityChart data={displayData.resourceAvailability} isDemo={isDemo} />
            </div>
        </>
    );
};
