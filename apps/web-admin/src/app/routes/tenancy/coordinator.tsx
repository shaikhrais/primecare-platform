import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "..\shared\PageSectionRegistry";

// --- Extracted from fleet.tsx ---
// --- Merged from T40-FleetManagement.tsx ---
export function FleetManagement() {
    return (
        <PageTemplate pageId="T40" title="Fleet Management" subtitle="Vehicle tracking, maintenance schedules and driver assignments"
            sectionData={PageSectionRegistry['T40']}
        />
    );
}

// --- Extracted from hub.tsx ---
// --- Merged from H18-CoordinatorHub.tsx ---
export function CoordinatorHub() {
    return (
        <PageTemplate pageId="H18" title="Coordinator Hub" subtitle="Dispatch coordination, team management and scheduling overview"
            sectionData={PageSectionRegistry['H18']}
        />
    );
}

// --- Extracted from map.tsx ---
// Re-export from identity file: T38-DispatchMap.tsx
// removed broken export: export { default } from './T38-DispatchMap';


// --- Merged from T38-DispatchMap.tsx ---
export function DispatchMap() {
    return (
        <PageTemplate pageId="T38" title="Dispatch Map" subtitle="Real-time field staff locations and active visit tracking"
            sectionData={PageSectionRegistry['T38']}
        />
    );
}

// --- Extracted from shift-swap.tsx ---
// --- Merged from T41-ShiftSwap.tsx ---
export function ShiftSwap() {
    return (
        <PageTemplate pageId="T41" title="Shift Swap" subtitle="Request and approve shift swaps between team members"
            sectionData={PageSectionRegistry['T41']}
        />
    );
}

// --- Extracted from sos.tsx ---
// Re-export from identity file: T39-SosCenter.tsx
// removed broken export: export { default } from './T39-SosCenter';


// --- Merged from T39-SosCenter.tsx ---
export function SosCenter() {
    return (
        <PageTemplate pageId="T39" title="SOS Center" subtitle="Emergency response coordination and alert management"
            sectionData={PageSectionRegistry['T39']}
        />
    );
}

// --- Extracted from waitlist.tsx ---
// Re-export from identity file: L20-WaitlistManager.tsx
// removed broken export: export { default } from './L20-WaitlistManager';


// --- Merged from L20-WaitlistManager.tsx ---
export function WaitlistManager() {
    return (
        <PageTemplate pageId="L20" title="Waitlist Manager" subtitle="Client waitlist management with priority scoring"
            sectionData={PageSectionRegistry['L20']}
        />
    );
}
