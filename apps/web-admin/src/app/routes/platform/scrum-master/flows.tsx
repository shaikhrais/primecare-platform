import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from RoleFlowsPage.tsx ---
export function RoleFlowsPage() {
    return (
        <PageTemplate 
            pageId="PGE-RFP" 
            title="✨ Role Flows Page" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-RFP']}
        />
    );
}

// --- Merged from StepAuditModal.tsx ---
export function StepAuditModal() {
    return (
        <PageTemplate 
            pageId="PGE-SAM" 
            title="✨ Step Audit Modal" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-SAM']}
        />
    );
}
