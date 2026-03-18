import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from D10-RegionalStats.tsx ---
export function RegionalStats() {
    return (
        <PageTemplate pageId="D10" title="Regional Statistics" subtitle="Regional performance metrics and KPI comparisons"
            sectionData={PageSectionRegistry['D10']}
        />
    );
}
