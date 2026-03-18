import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: L14-ClientBookings.tsx
// removed broken export: export { default } from './L14-ClientBookings';


// --- Merged from L14-ClientBookings.tsx ---
// ================================================================
// PAGE IDENTITY: L14 — Client Bookings
// Type: List | Owner: client
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================



export function ClientBookings() {
    return (
        <PageTemplate pageId="L14" title="📅 My Bookings" subtitle="View, request & manage your upcoming care appointments"
            sectionData={PageSectionRegistry['L14']}
        />
    );
}