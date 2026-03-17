import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function PswSchedule() {
    return (
        <PageTemplate pageId="L16" title="My Schedule" subtitle="View and manage your upcoming shifts and appointments"
            sectionData={{
                'L16.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}