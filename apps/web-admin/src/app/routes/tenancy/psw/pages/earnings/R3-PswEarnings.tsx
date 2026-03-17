import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function PswEarnings() {
    return (
        <PageTemplate pageId="R3" title="My Earnings" subtitle="View your earnings breakdown, pay stubs and projections"
            sectionData={{
                'R3.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}