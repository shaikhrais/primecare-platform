import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from BuildHealthPage.tsx ---
export function BuildHealthPage() {
    return (
        <PageTemplate 
            pageId="PG-610" 
            title="Build & Deployment Health" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-610']}
        />
    );
}
