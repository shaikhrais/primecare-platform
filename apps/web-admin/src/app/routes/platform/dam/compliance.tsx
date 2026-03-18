import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from LegalComplianceBlockers.tsx ---
export function LegalComplianceBlockers() {
    return (
        <PageTemplate 
            pageId="PGE-LCB" 
            title="✨ Legal Compliance Blockers" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-LCB']}
        />
    );
}
