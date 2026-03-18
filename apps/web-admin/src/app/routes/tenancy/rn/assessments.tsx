import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: L18-AssessmentsHub.tsx
// removed broken export: export { default } from './L18-AssessmentsHub';


// --- Merged from L18-AssessmentsHub.tsx ---
export function AssessmentsHub() {
    return (
        <PageTemplate pageId="L18" title="Assessments Hub" subtitle="Clinical assessments, evaluations and care plan reviews"
            sectionData={PageSectionRegistry['L18']}
        />
    );
}