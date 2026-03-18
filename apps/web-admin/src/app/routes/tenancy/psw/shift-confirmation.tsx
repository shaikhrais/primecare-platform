import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: T26-ShiftConfirmation.tsx
// removed broken export: export { default } from './T26-ShiftConfirmation';


// --- Merged from T26-ShiftConfirmation.tsx ---
export function ShiftConfirmation() {
    return (
        <PageTemplate pageId="T26" title="Shift Confirmation" subtitle="Confirm, modify or cancel upcoming shift assignments"
            sectionData={PageSectionRegistry['T26']}
        />
    );
}