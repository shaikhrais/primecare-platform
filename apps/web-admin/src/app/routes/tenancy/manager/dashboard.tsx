import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: D7-ManagerDashboard.tsx
// removed broken export: export { default } from './D7-ManagerDashboard';


// --- Merged from D7-ManagerDashboard.tsx ---
// ================================================================
// PAGE IDENTITY: D7 — Manager Dashboard
// Type: Dashboard | Owner: manager
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================



export function ManagerDashboard() {
    return (
        <PageTemplate pageId="D7" title="📊 Manager Dashboard" subtitle="Branch operations, staff performance & business intelligence"
            sectionData={PageSectionRegistry['D7']}
        />
    );
}