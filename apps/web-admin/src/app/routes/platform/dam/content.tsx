import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from DynamicPageRouter.tsx ---
export function DynamicPageRouter() {
    return (
        <PageTemplate 
            pageId="PGE-DPR" 
            title="✨ Dynamic Page Router" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-DPR']}
        />
    );
}

// --- Merged from MicroCopyAbTesting.tsx ---
export function MicroCopyAbTesting() {
    return (
        <PageTemplate 
            pageId="PGE-MCA" 
            title="✨ Micro Copy Ab Testing" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-MCA']}
        />
    );
}

// --- Merged from RichTextGovernance.tsx ---
export function RichTextGovernance() {
    return (
        <PageTemplate 
            pageId="PGE-RTG" 
            title="✨ Rich Text Governance" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-RTG']}
        />
    );
}
