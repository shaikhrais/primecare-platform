// PAGE IDENTITY: T66 · Lead Conversion
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function LeadConversion() {
    return (
        <PageTemplate pageId="T66" title="🔄 Lead Conversion" subtitle="Convert qualified leads to active clients with automated onboarding"
            sectionData={{
                'T66.stats': { kpiCards: [
                    { label: 'Conversion Rate', value: '72%', color: 'var(--pc-success)' },
                    { label: 'Avg Days to Convert', value: 5.2, color: 'var(--pc-primary)' },
                    { label: 'Ready to Convert', value: 3, color: 'var(--pc-warning)' },
                    { label: 'Converted MTD', value: 8, color: 'var(--pc-info, #2563EB)' },
                ]},
                'T66.chart': { chart: { title: 'Monthly Conversions', type: 'bar', data: [
                    { label: 'Oct', value: 6 }, { label: 'Nov', value: 8 },
                    { label: 'Dec', value: 5 }, { label: 'Jan', value: 10 },
                    { label: 'Feb', value: 7 }, { label: 'Mar', value: 8 },
                ]}},
            }}
        />
    );
}
