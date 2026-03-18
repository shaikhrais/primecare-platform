import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from AbVariantManager.tsx ---
export function AbVariantManager() {
    return (
        <PageTemplate 
            pageId="PGE-AVM" 
            title="✨ Ab Variant Manager" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-AVM']}
        />
    );
}
