import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function WoundCareDashboard() {
    return (
        <PageTemplate pageId="D17" title="Wound Care Dashboard" subtitle="Active wound assessments, healing progress and treatment protocols"
            sectionData={{
                'D17.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}