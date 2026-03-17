import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function MarClient() {
    return (
        <PageTemplate pageId="T31" title="eMAR Client" subtitle="Electronic medication administration record for client visits"
            sectionData={{
                'T31.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}