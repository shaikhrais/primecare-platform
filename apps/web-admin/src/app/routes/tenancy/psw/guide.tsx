import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from G1-PswUserGuide.tsx ---
export function PswUserGuide() {
    return (
        <PageTemplate pageId="G1" title="PSW User Guide" subtitle="Interactive guide to using the PrimeCare PSW platform"
            sectionData={PageSectionRegistry['G1']}
        />
    );
}
