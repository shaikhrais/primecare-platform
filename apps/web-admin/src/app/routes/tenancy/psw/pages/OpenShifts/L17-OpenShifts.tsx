import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function OpenShifts() {
    return (
        <PageTemplate pageId="L17" title="Open Shifts" subtitle="Available shifts to pick up and schedule requests"
            sectionData={{
                'L17.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}