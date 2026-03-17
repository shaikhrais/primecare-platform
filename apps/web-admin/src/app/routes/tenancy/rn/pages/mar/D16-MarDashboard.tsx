import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function MarDashboard() {
    return (
        <PageTemplate pageId="D16" title="MAR Dashboard" subtitle="Medication administration overview with compliance tracking"
            sectionData={{
                'D16.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}