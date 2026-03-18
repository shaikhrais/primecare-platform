import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: D8-ClientDashboard.tsx
// removed broken export: export { default } from './D8-ClientDashboard';


// --- Merged from D8-ClientDashboard.tsx ---
// ================================================================
// PAGE IDENTITY: D8 — Client Dashboard
// Type: Dashboard | Owner: client
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================



export function ClientDashboard() {
    return (
        <PageTemplate pageId="D8" title="🏡 My Care Dashboard" subtitle="Your upcoming visits, care team & health journey at a glance"
            sectionData={PageSectionRegistry['D8']}
        />
    );
}