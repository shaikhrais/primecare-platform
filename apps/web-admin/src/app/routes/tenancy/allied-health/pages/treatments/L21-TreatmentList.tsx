import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function TreatmentList() {
    return (
        <PageTemplate pageId="L21" title="Treatment List" subtitle="Active treatments, therapy sessions and progress tracking"
            sectionData={{
                'L21.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}