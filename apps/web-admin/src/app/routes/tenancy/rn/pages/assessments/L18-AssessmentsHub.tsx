import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function AssessmentsHub() {
    return (
        <PageTemplate pageId="L18" title="Assessments Hub" subtitle="Clinical assessments, evaluations and care plan reviews"
            sectionData={{
                'L18.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}