import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function AlliedHealthDashboard() {
    return (
        <PageTemplate pageId="D18" title="Allied Health Dashboard" subtitle="Allied health team coordination and treatment tracking"
            sectionData={{
                'D18.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}