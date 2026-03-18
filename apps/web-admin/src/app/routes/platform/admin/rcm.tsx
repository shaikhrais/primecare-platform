import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from H3-RevenueCycleHub.tsx ---
// ================================================================
// PAGE IDENTITY: H3 · Revenue Cycle Hub
// Type: Hub | Owner: admin | Registry: H3
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function RevenueCycleHub() {
    return (
        <PageTemplate
            pageId="H3"
            title="💰 Revenue Cycle Hub"
            subtitle="End-to-end revenue cycle management — claims, billing, ERA & collections"
            actionPageId="admin.revenue-cycle"
            sectionData={PageSectionRegistry['H3']}
        />
    );
}
