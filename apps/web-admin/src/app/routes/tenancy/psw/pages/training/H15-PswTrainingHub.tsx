import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function PswTrainingHub() {
    return (
        <PageTemplate pageId="H15" title="PSW Training Hub" subtitle="Training modules, certifications and compliance tracking"
            sectionData={{
                'H15.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}