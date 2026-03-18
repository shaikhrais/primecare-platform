import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from NoCodeBuilderMock.tsx ---
export function NoCodeBuilderMock() {
    return (
        <PageTemplate 
            pageId="PGE-NCB" 
            title="✨ No Code Builder Mock" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-NCB']}
        />
    );
}
