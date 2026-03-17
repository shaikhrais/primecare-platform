import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function RealtimeCapacity() {
    return (
        <PageTemplate pageId="T65" title="Realtime Capacity" subtitle="Live staffing capacity and availability dashboard"
            sectionData={{
                'T65.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}