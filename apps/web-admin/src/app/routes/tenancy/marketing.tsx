import { PageSectionRegistry } from '../shared/PageSectionRegistry';
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from D11-MarketingDashboard.tsx ---
export function MarketingDashboard() {
    return (
        <PageTemplate pageId="D11" title="Marketing Dashboard" subtitle="Campaign performance, lead funnel analytics and ROI tracking"
            sectionData={PageSectionRegistry['D11']}
        />
    );
}
