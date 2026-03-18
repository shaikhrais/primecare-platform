import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
// Re-export from identity file: T21-ServiceReview.tsx
// removed broken export: export { default } from './T21-ServiceReview';


// --- Merged from T21-ServiceReview.tsx ---
export function ServiceReview() {
    return (
        <PageTemplate pageId="T21" title="Service Review" subtitle="Service quality reviews and improvement tracking"
            sectionData={{
                'T21.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}