import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from L19-RaiAssessments.tsx ---
export function RaiAssessments() {
    return (
        <PageTemplate pageId="L19" title="RAI Assessments" subtitle="Resident Assessment Instrument records and scoring"
            sectionData={PageSectionRegistry['L19']}
        />
    );
}

// --- Merged from T33-RaiAssessmentDetail.tsx ---
export function RaiAssessmentDetail() {
    return (
        <PageTemplate pageId="T33" title="RAI Assessment Detail" subtitle="Detailed RAI assessment form with scoring and care planning"
            sectionData={PageSectionRegistry['T33']}
        />
    );
}
