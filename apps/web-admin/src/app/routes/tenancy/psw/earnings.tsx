import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: R3-PswEarnings.tsx
// removed broken export: export { default } from './R3-PswEarnings';


// --- Merged from R3-PswEarnings.tsx ---
export function PswEarnings() {
    return (
        <PageTemplate pageId="R3" title="My Earnings" subtitle="View your earnings breakdown, pay stubs and projections"
            sectionData={PageSectionRegistry['R3']}
        />
    );
}