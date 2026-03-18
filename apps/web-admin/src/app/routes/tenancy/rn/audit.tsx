import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: T30-EntryVerify.tsx
// removed broken export: export { default } from './T30-EntryVerify';


// --- Merged from T30-EntryVerify.tsx ---
export function EntryVerify() {
    return (
        <PageTemplate pageId="T30" title="Entry Verification" subtitle="Verify and approve daily care entries and documentation"
            sectionData={PageSectionRegistry['T30']}
        />
    );
}