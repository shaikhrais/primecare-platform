import React from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';
import { CoreRadarChart } from '@/shared/components/charts/core/CoreRadarChart';

const { ContentRegistry } = AdminRegistry;

interface AdvancedAnalyticsProps {
    onDrillMesh: () => void;
}

export const AdvancedAnalytics: React.FC<AdvancedAnalyticsProps> = ({ onDrillMesh }) => {
    const { t } = useTranslation();

    const radarData = [
        { subject: 'API Latency', value: 95, fullMark: 100 },
        { subject: 'Error Rate', value: 98, fullMark: 100 },
        { subject: 'Reg Compliance', value: 100, fullMark: 100 },
        { subject: 'DB Health', value: 85, fullMark: 100 },
        { subject: 'Cache Efficiency', value: 75, fullMark: 100 },
        { subject: 'Security Drift', value: 90, fullMark: 100 },
    ];

    return (
        <div className="sm-card" style={{ padding: '2.5rem', background: '#ffffff', marginBottom: '3rem' }}>
            <h3 data-cy="h3-advanced-analytics-0" style={{ margin: '0 0 1.5rem 0', display: 'flex', alignItems: 'center', gap: '10px', fontSize: '1.25rem', fontWeight: 800 }}>
                💠 {t(ContentRegistry.SCRUM_MASTER.ANALYTICS.AVAILABILITY)}
            </h3>
            <div style={{ height: '400px', display: 'flex', justifyContent: 'center' }}>
                <CoreRadarChart
                    data={radarData}
                    angleKey="subject"
                    radiusKey="value"
                    radarName="Platform Core"
                    color="var(--brand-500)"
                    onRadarClick={onDrillMesh}
                />
            </div>
        </div>
    );
};
