import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from SalesTerritoryMap.tsx ---
export function SalesTerritoryMap() {
    return (
        <PageTemplate 
            pageId="PGE-STM" 
            title="✨ Sales Territory Map" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-STM']}
        />
    );
}
