import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from D7-OperationsCenter.tsx ---
// ================================================================
// PAGE IDENTITY: D7 · Operations Center  
// Type: Dashboard | Owner: admin | Registry: D7
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function OperationsCenter() {
    return (
        <PageTemplate
            pageId="D7"
            title="⚙️ Operations Center"
            subtitle="Real-time operational command — shifts, logistics, incidents & capacity"
            actionPageId="admin.operations"
            isLive
            sectionData={PageSectionRegistry['D7']}
        />
    );
}

// --- Merged from T67-SupplyDemand.tsx ---
// PAGE IDENTITY: T67 · Supply & Demand

export function SupplyDemand() {
    return (
        <PageTemplate pageId="T67" title="📊 Supply & Demand Analytics" subtitle="Staff capacity vs client demand — coverage gaps, forecasting & optimization"
            sectionData={PageSectionRegistry['T67']}
        />
    );
}
