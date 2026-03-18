import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from PerformancePage.tsx ---
export function PerformancePage() {
    return (
        <PageTemplate 
            pageId="PG-128" 
            title="Performance Orchestration" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-128']}
        />
    );
}
