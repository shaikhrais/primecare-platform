import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from AssetCostAttribution.tsx ---
export function AssetCostAttribution() {
    return (
        <PageTemplate 
            pageId="PGE-ACA" 
            title="✨ Asset Cost Attribution" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-ACA']}
        />
    );
}

// --- Merged from ErrorBoundaryAggregator.tsx ---
export function ErrorBoundaryAggregator() {
    return (
        <PageTemplate 
            pageId="PGE-EBA" 
            title="✨ Error Boundary Aggregator" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-EBA']}
        />
    );
}

// --- Merged from ThirdPartyScriptManager.tsx ---
export function ThirdPartyScriptManager() {
    return (
        <PageTemplate 
            pageId="PGE-TPS" 
            title="✨ Third Party Script Manager" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-TPS']}
        />
    );
}
