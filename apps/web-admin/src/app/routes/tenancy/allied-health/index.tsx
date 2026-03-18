import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from D18-AlliedHealthDashboard.tsx ---
export function AlliedHealthDashboard() {
    return (
        <PageTemplate pageId="D18" title="Allied Health Dashboard" subtitle="Allied health team coordination and treatment tracking"
            sectionData={PageSectionRegistry['D18']}
        />
    );
}
