import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function ServiceReview() {
    return (
        <PageTemplate pageId="T21" title="Service Review" subtitle="Service quality reviews and improvement tracking"
            sectionData={{
                'T21.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}