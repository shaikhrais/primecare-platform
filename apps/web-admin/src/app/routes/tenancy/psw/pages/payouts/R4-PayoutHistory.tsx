import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function PayoutHistory() {
    return (
        <PageTemplate pageId="R4" title="Payout History" subtitle="Historical payout records with filtering and export"
            sectionData={{
                'R4.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}