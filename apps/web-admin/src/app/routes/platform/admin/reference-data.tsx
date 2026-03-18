import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from H9-ReferenceDataHub.tsx ---
// ================================================================
// PAGE IDENTITY: H9 · Reference Data Hub
// Type: Hub | Owner: admin | Registry: H9
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function ReferenceDataHub() {
    return (
        <PageTemplate
            pageId="H9"
            title="🗂️ Reference Data Hub"
            subtitle="Master data management — service codes, diagnosis codes, facilities & fee schedules"
            actionPageId="admin.reference-data"
            sectionData={PageSectionRegistry['H9']}
        />
    );
}
