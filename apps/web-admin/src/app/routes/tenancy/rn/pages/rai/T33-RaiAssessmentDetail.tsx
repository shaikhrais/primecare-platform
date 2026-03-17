import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function RaiAssessmentDetail() {
    return (
        <PageTemplate pageId="T33" title="RAI Assessment Detail" subtitle="Detailed RAI assessment form with scoring and care planning"
            sectionData={{
                'T33.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}