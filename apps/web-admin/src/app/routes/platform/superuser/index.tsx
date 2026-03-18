import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from RiskSurveillanceDashboard.tsx ---
export function RiskSurveillanceDashboard() {
    return (
        <PageTemplate 
            pageId="PGE-RSD" 
            title="✨ Risk Surveillance Dashboard" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-RSD']}
        />
    );
}
