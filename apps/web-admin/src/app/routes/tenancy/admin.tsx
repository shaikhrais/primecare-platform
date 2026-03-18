import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "..\shared\PageSectionRegistry";

// --- Extracted from ops.tsx ---
// removed re-export: export { LogisticsHub, RegionMapping, RealtimeCapacity };


// --- Merged from H20-LogisticsHub.tsx ---
export function LogisticsHub() {
    return (
        <PageTemplate pageId="H20" title="Logistics Hub" subtitle="Fleet management, route optimization and delivery tracking"
            sectionData={PageSectionRegistry['H20']}
        />
    );
}

// --- Merged from T64-RegionMapping.tsx ---
export function RegionMapping() {
    return (
        <PageTemplate pageId="T64" title="Region Mapping" subtitle="Geographic region configuration and service area boundaries"
            sectionData={PageSectionRegistry['T64']}
        />
    );
}

// --- Merged from T65-RealtimeCapacity.tsx ---
export function RealtimeCapacity() {
    return (
        <PageTemplate pageId="T65" title="Realtime Capacity" subtitle="Live staffing capacity and availability dashboard"
            sectionData={PageSectionRegistry['T65']}
        />
    );
}
