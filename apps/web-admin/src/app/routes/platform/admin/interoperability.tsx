import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from T5-FHIRCenter.tsx ---
// PAGE IDENTITY: T5 · FHIR Interoperability Center

export function FHIRCenter() {
    return (
        <PageTemplate pageId="T5" title="🔗 FHIR Interoperability Center" subtitle="HL7 FHIR resource management, API endpoints & data exchange"
            sectionData={PageSectionRegistry['T5']}
        />
    );
}
