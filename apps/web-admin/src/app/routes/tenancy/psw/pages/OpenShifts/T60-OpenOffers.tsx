import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function OpenOffers() {
    return (
        <PageTemplate pageId="T60" title="Open Offers" subtitle="Browse and accept available shift offers in your area"
            sectionData={{
                'T60.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}