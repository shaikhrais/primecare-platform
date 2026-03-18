import { PageSectionRegistry } from '../shared/PageSectionRegistry';
import { PageTemplate } from "@/shared/components/ui/PageTemplate";
import React from "react";

// --- Extracted from fleet.tsx ---
// --- Merged from T40-FleetManagement.tsx ---
export function FleetManagement() {
    return (
        <PageTemplate pageId="T40"  
            sectionData={PageSectionRegistry['T40']}
        />
    );
}

// --- Extracted from hub.tsx ---
// --- Merged from H18-CoordinatorHub.tsx ---
export function CoordinatorHub() {
    return (
        <PageTemplate pageId="H18"  
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
        <PageTemplate pageId="T38"  
            sectionData={PageSectionRegistry['T38']}
        />
    );
}

// --- Extracted from shift-swap.tsx ---
// --- Merged from T41-ShiftSwap.tsx ---
export function ShiftSwap() {
    return (
        <PageTemplate pageId="T41"  
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
        <PageTemplate pageId="T39"  
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
        <PageTemplate pageId="L20"  
            sectionData={PageSectionRegistry['L20']}
        />
    );
}
