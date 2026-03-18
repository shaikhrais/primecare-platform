import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: T19-Portfolio.tsx
// removed broken export: export { default } from './T19-Portfolio';


// --- Merged from T19-Portfolio.tsx ---
export function ManagementPortfolio() {
    return (
        <PageTemplate pageId="T19" title="Client Portfolio" subtitle="Client case portfolio with revenue and visit analytics"
            sectionData={PageSectionRegistry['T19']}
        />
    );
}