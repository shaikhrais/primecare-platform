import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: L1-Schedule.tsx
// removed broken export: export { default } from './L1-Schedule';


// --- Merged from L1-Schedule.tsx ---
// PAGE IDENTITY: L1 · Schedule



export function Schedule() {
    return (
        <PageTemplate pageId="L1" title="📅 Schedule Management" subtitle="Shift scheduling, coverage tracking & calendar overview"
            sectionData={PageSectionRegistry['L1']}
        />
    );
}