import { PageSectionRegistry } from '../shared/PageSectionRegistry';
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from D13-ClinicalQaDashboard.tsx ---
export function ClinicalQaDashboard() {
    return (
        <PageTemplate pageId="D13"  
            sectionData={PageSectionRegistry['D13']}
        />
    );
}
