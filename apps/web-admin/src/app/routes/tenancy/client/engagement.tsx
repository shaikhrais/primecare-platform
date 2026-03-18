import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from H17-FamilyCareHub.tsx ---
export function FamilyCareHub() {
    return (
        <PageTemplate pageId="H17" title="Family Care Hub" subtitle="Family member access, care updates and communication center"
            sectionData={{
                'H17.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}
