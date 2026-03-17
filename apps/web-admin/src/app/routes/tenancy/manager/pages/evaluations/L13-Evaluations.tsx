import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function Evaluations() {
    return (
        <PageTemplate pageId="L13" title="Performance Evaluations" subtitle="Staff evaluation records, scores and improvement plans"
            sectionData={{
                'L13.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}