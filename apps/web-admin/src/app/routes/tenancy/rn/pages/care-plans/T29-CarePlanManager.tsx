import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function CarePlanManager() {
    return (
        <PageTemplate pageId="T29" title="Care Plan Manager" subtitle="Create and manage individualized client care plans"
            sectionData={{
                'T29.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}