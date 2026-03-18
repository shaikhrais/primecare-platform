import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: D19-StaffDashboard.tsx
// removed broken export: export { default } from './D19-StaffDashboard';


// --- Merged from D19-StaffDashboard.tsx ---
export function StaffDashboard() {
    return (
        <PageTemplate pageId="D19" title="Staff Dashboard" subtitle="Your daily tasks, messages and team operations"
            sectionData={PageSectionRegistry['D19']}
        />
    );
}