// PAGE IDENTITY: R6 · Auth Utilization | T49 · Auth Alerts
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function AuthUtilization() {
    return (
        <PageTemplate pageId="R6" title="📊 Authorization Utilization" subtitle="Payer-specific utilization rates, exhaustion forecasts & renewal tracking"
            sectionData={{
                'R6.stats': { kpiCards: [
                    { label: 'Avg Utilization', value: '70%', color: 'var(--pc-primary)' },
                    { label: 'Exhausting (>80%)', value: 3, color: 'var(--pc-warning)' },
                    { label: 'Renewals Due', value: 2, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Unused Hours', value: 340, color: 'var(--pc-success)' },
                ]},
                'R6.chart': { chart: { title: 'Utilization by Payer', type: 'horizontal-bar', data: [
                    { label: 'OHIP', value: 77, color: '#3B82F6' }, { label: 'WSIB', value: 30, color: '#10B981' },
                    { label: 'Private', value: 92, color: '#EF4444' }, { label: 'CCAC', value: 73, color: '#F59E0B' },
                ]}},
            }}
        />
    );
}
