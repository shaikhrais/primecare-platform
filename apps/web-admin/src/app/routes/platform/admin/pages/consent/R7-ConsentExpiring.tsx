// PAGE IDENTITY: R7 · Consent Expiring Report
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function ConsentExpiring() {
    return (
        <PageTemplate pageId="R7" title="⏰ Consent Expiration Report" subtitle="Consents expiring within 30/60/90 days, renewal reminders"
            sectionData={{
                'R7.stats': { kpiCards: [
                    { label: 'Expiring 30d', value: 3, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Expiring 60d', value: 5, color: 'var(--pc-warning)' },
                    { label: 'Expiring 90d', value: 8, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Auto-Renewed', value: 12, color: 'var(--pc-success)' },
                ]},
                'R7.chart': { chart: { title: 'Expiration Timeline', type: 'bar', data: [
                    { label: '< 30d', value: 3, color: '#EF4444' }, { label: '30-60d', value: 5, color: '#F59E0B' },
                    { label: '60-90d', value: 8, color: '#3B82F6' }, { label: '> 90d', value: 45, color: '#10B981' },
                ]}},
            }}
        />
    );
}
