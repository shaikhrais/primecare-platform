import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function WoundCareClient() {
    return (
        <PageTemplate pageId="T32" title="Wound Care Client" subtitle="Document wound assessments, measurements and treatment progress"
            sectionData={{
                'T32.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}