import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: L13-Evaluations.tsx
// removed broken export: export { default } from './L13-Evaluations';


// --- Merged from L13-Evaluations.tsx ---
export function Evaluations() {
    return (
        <PageTemplate pageId="L13" title="Performance Evaluations" subtitle="Staff evaluation records, scores and improvement plans"
            sectionData={PageSectionRegistry['L13']}
        />
    );
}