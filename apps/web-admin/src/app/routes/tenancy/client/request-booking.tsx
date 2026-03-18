import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: F17-RequestBooking.tsx
// removed broken export: export { default } from './F17-RequestBooking';


// --- Merged from F17-RequestBooking.tsx ---
export function RequestBooking() {
    return (
        <PageTemplate pageId="F17" title="Request Booking" subtitle="Request a new care visit or service appointment"
            sectionData={PageSectionRegistry['F17']}
        />
    );
}