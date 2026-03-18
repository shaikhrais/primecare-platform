import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from UsageStatisticsManager.tsx ---
export function UsageStatisticsManager() {
    return (
        <PageTemplate 
            pageId="PG-128" 
            title="📊 Usage Statistics Manager" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-128']}
        />
    );
}
