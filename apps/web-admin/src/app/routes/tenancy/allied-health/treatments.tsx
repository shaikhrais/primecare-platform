import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from L21-TreatmentList.tsx ---
export function TreatmentList() {
    return (
        <PageTemplate pageId="L21" title="Treatment List" subtitle="Active treatments, therapy sessions and progress tracking"
            sectionData={PageSectionRegistry['L21']}
        />
    );
}
