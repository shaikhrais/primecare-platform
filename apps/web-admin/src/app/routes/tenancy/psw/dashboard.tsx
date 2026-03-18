import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: D14-PswDashboard.tsx
// removed broken export: export { default } from './D14-PswDashboard';


// --- Merged from D14-PswDashboard.tsx ---
// ================================================================
// PAGE IDENTITY: D14 — PSW Dashboard
// Type: Dashboard | Owner: psw
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================



export function PswDashboard() {
    return (
        <PageTemplate pageId="D14" title="🏠 PSW Dashboard" subtitle="Your home base — shifts, earnings, compliance & wellness at a glance"
            sectionData={PageSectionRegistry['D14']}
        />
    );
}