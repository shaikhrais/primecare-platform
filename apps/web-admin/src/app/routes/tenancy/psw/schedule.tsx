import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: L16-PswSchedule.tsx
// removed broken export: export { default } from './L16-PswSchedule';


// --- Merged from L16-PswSchedule.tsx ---
export function PswSchedule() {
    return (
        <PageTemplate pageId="L16" title="My Schedule" subtitle="View and manage your upcoming shifts and appointments"
            sectionData={PageSectionRegistry['L16']}
        />
    );
}

// --- Merged from T61-LiveVisit.tsx ---
export function LiveVisit() {
    return (
        <PageTemplate pageId="T61" title="Live Visit" subtitle="Active visit tracking with real-time check-in and task completion"
            sectionData={PageSectionRegistry['T61']}
        />
    );
}

// --- Merged from T62-CheckInScreen.tsx ---
export function CheckInScreen() {
    return (
        <PageTemplate pageId="T62" title="Check-In" subtitle="GPS-verified check-in and check-out for client visits"
            sectionData={PageSectionRegistry['T62']}
        />
    );
}