import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Barrel re-export — identity file: F13-ShiftHandover.tsx
// removed broken export: export { default } from './F13-ShiftHandover';


// --- Merged from F13-ShiftHandover.tsx ---
export function HandoverPage() {
    return (
        <PageTemplate pageId="F13" title="Shift Handover" subtitle="Complete shift handover documentation and notes"
            sectionData={PageSectionRegistry['F13']}
        />
    );
}