import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from R5-MedicalSummary.tsx ---
export function MedicalSummary() {
    return (
        <PageTemplate pageId="R5" title="Medical Summary" subtitle="Comprehensive medical history and health record summary"
            sectionData={{
                'R5.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}
