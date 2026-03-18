import type { TableColumn } from '@/shared/components/sections';
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from L10-ClaimsList.tsx ---
// PAGE IDENTITY: L10 · Claims List

export function ClaimsList() {
    return (
        <PageTemplate pageId="L10" title="📋 Claims Management" subtitle="Submit, track & manage insurance claims across all payers"
            actionPageId="admin.claims"
            sectionData={PageSectionRegistry['L10']}
        />
    );
}

// --- Merged from R12-ClaimsEra.tsx ---
// PAGE IDENTITY: R12 · Claims ERA

export function ClaimsEra() {
    return (
        <PageTemplate pageId="R12" title="💳 ERA Processing" subtitle="Electronic remittance advice reconciliation & posting"
            sectionData={PageSectionRegistry['R12']}
        />
    );
}
