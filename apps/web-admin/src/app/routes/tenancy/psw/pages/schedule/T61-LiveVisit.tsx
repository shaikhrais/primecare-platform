import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function LiveVisit() {
    return (
        <PageTemplate pageId="T61" title="Live Visit" subtitle="Active visit tracking with real-time check-in and task completion"
            sectionData={{
                'T61.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}