import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from H15-PswTrainingHub.tsx ---
export function PswTrainingHub() {
    return (
        <PageTemplate pageId="H15" title="PSW Training Hub" subtitle="Training modules, certifications and compliance tracking"
            sectionData={PageSectionRegistry['H15']}
        />
    );
}
