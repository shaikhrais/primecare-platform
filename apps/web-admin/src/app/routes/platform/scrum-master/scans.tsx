import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from SecurityScansPage.tsx ---
export function SecurityScansPage() {
    return (
        <PageTemplate 
            pageId="PG-738" 
            title="Security & Vulnerability Scans" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-738']}
        />
    );
}
