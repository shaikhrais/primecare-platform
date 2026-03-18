import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from GrowthStrategy.tsx ---
export function GrowthStrategy() {
    return (
        <PageTemplate 
            pageId="PG-605" 
            title="Franchise Growth Model" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-605']}
        />
    );
}
