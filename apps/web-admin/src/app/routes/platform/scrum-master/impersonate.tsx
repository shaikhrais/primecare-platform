import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from ImpersonationTool.tsx ---
export function ImpersonationTool() {
    return (
        <PageTemplate 
            pageId="PGE-IT" 
            title="✨ Impersonation Tool" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-IT']}
        />
    );
}
