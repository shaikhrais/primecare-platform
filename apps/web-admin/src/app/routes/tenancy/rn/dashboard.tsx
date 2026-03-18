import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: D15-RnDashboard.tsx
// removed broken export: export { default } from './D15-RnDashboard';


// --- Merged from D15-RnDashboard.tsx ---
// ================================================================
// PAGE IDENTITY: D15 — RN Dashboard
// Type: Dashboard | Owner: rn
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================



export function RnDashboard() {
    return (
        <PageTemplate pageId="D15" title="👩‍⚕️ RN Clinical Dashboard" subtitle="Patient assessments, delegations, care plans & medication oversight"
            sectionData={PageSectionRegistry['D15']}
        />
    );
}