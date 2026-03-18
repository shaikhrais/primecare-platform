import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: R1-ReportCenter.tsx
// removed broken export: export { default } from './R1-ReportCenter';


// --- Merged from R1-ReportCenter.tsx ---
// PAGE IDENTITY: R1 · Report Center

export function ReportCenter() {
    return (
        <PageTemplate pageId="R1" title="📊 Report Center" subtitle="Comprehensive reporting suite — financial, clinical, HR, compliance & custom"
            sectionData={PageSectionRegistry['R1']}
        />
    );
}

// --- Merged from R2-ExportPage.tsx ---
// PAGE IDENTITY: R2 · Export Page



export function ExportPage() {
    return (
        <PageTemplate pageId="R2" title="📥 Data Export" subtitle="Export platform data in CSV, PDF, Excel & JSON formats"
            sectionData={PageSectionRegistry['R2']}
        />
    );
}