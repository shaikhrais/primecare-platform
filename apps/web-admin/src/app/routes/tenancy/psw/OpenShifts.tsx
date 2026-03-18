import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: L17-OpenShifts.tsx
// removed broken export: export { default } from './L17-OpenShifts';


// --- Merged from L17-OpenShifts.tsx ---
export function OpenShifts() {
    return (
        <PageTemplate pageId="L17" title="Open Shifts" subtitle="Available shifts to pick up and schedule requests"
            sectionData={PageSectionRegistry['L17']}
        />
    );
}

// --- Merged from T60-OpenOffers.tsx ---
export function OpenOffers() {
    return (
        <PageTemplate pageId="T60" title="Open Offers" subtitle="Browse and accept available shift offers in your area"
            sectionData={PageSectionRegistry['T60']}
        />
    );
}