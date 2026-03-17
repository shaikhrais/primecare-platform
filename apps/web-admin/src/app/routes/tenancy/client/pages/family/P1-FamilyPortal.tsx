import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function FamilyPortal() {
    return (
        <PageTemplate pageId="P1" title="Family Portal" subtitle="Family member access to care updates, schedule and billing"
            sectionData={{
                'P1.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}