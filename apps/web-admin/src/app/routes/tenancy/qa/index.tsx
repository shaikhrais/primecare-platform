import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from D13-ClinicalQaDashboard.tsx ---
export function ClinicalQaDashboard() {
    return (
        <PageTemplate pageId="D13" title="Clinical QA Dashboard" subtitle="Clinical quality assurance metrics, compliance scores and audit results"
            sectionData={PageSectionRegistry['D13']}
        />
    );
}
