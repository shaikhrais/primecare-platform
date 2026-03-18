import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from ApiEndpointsHub.tsx ---
export function ApiEndpointsHub() {
    return (
        <PageTemplate 
            pageId="PGE-AEH" 
            title="✨ Api Endpoints Hub" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-AEH']}
        />
    );
}
