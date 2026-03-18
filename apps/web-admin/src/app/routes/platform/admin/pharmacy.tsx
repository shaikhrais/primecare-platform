import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from H2-PharmacyHub.tsx ---
// ================================================================
// PAGE IDENTITY: H2 · Pharmacy Hub
// Type: Hub | Owner: admin | Registry: H2
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import type { TableColumn } from '@/shared/components/sections';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

export function PharmacyHub() {
    return (
        <PageTemplate
            pageId="H2"
            title="💊 Pharmacy & Medication Hub"
            subtitle="E-prescribing, MAR tracking, ADC integration, and BCMA"
            actionPageId="admin.pharmacy"
            sectionData={PageSectionRegistry['H2']}
        />
    );
}
