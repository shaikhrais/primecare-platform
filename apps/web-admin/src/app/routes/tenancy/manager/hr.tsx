import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from L15-PerformanceReviews.tsx ---
// ================================================================
// PAGE IDENTITY: L15 · Performance Reviews
// Type: List | Owner: manager | Registry: L23
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import type { TableColumn } from '@/shared/components/sections';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

export function PerformanceReviews() {
    return (
        <PageTemplate
            pageId="L23"
            title="📊 Performance Reviews"
            subtitle="Q1 2026 — PSW performance evaluations"
            actionPageId="manager.performance-reviews"
            sectionData={PageSectionRegistry['L23']}
        />
    );
}
