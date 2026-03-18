import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from R5-MedicalSummary.tsx ---
export function MedicalSummary() {
    return (
        <PageTemplate pageId="R5" title="Medical Summary" subtitle="Comprehensive medical history and health record summary"
            sectionData={PageSectionRegistry['R5']}
        />
    );
}
