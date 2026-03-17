import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function DispatchMap() {
    return (
        <PageTemplate pageId="T38" title="Dispatch Map" subtitle="Real-time field staff locations and active visit tracking"
            sectionData={{
                'T38.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}