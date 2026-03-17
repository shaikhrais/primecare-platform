import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function SupervisionHub() {
    return (
        <PageTemplate pageId="H16" title="Supervision Hub" subtitle="Staff supervision sessions, notes and delegation tracking"
            sectionData={{
                'H16.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}