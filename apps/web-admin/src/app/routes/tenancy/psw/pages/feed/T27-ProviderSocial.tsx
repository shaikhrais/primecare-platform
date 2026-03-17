import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function ProviderSocial() {
    return (
        <PageTemplate pageId="T27" title="Provider Social" subtitle="Team social feed, announcements and peer recognition"
            sectionData={{
                'T27.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}