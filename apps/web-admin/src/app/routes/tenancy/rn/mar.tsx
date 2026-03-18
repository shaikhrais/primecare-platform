import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from D16-MarDashboard.tsx ---
export function MarDashboard() {
    return (
        <PageTemplate pageId="D16" title="MAR Dashboard" subtitle="Medication administration overview with compliance tracking"
            sectionData={PageSectionRegistry['D16']}
        />
    );
}

// --- Merged from T31-MarClient.tsx ---
export function MarClient() {
    return (
        <PageTemplate pageId="T31" title="eMAR Client" subtitle="Electronic medication administration record for client visits"
            sectionData={PageSectionRegistry['T31']}
        />
    );
}
