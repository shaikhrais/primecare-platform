import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function RaiAssessments() {
    return (
        <PageTemplate pageId="L19" title="RAI Assessments" subtitle="Resident Assessment Instrument records and scoring"
            sectionData={{
                'L19.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}