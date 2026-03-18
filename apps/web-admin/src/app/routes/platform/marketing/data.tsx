import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from GeoFencedAdDashboard.tsx ---
export function GeoFencedAdDashboard() {
    return (
        <PageTemplate 
            pageId="PGE-GFA" 
            title="✨ Geo Fenced Ad Dashboard" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-GFA']}
        />
    );
}
