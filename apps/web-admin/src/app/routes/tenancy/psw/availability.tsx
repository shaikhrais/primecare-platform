import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: F15-Availability.tsx
// removed broken export: export { default } from './F15-Availability';


// --- Merged from F15-Availability.tsx ---
export function AvailabilityPage() {
    return (
        <PageTemplate pageId="F15" title="Set Availability" subtitle="Manage your weekly availability and time-off preferences"
            sectionData={PageSectionRegistry['F15']}
        />
    );
}