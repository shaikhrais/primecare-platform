import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: T25-ComplianceSync.tsx
// removed broken export: export { default } from './T25-ComplianceSync';


// --- Merged from T25-ComplianceSync.tsx ---
export function ComplianceSync() {
    return (
        <PageTemplate pageId="T25" title="Compliance Sync" subtitle="Regulatory compliance status and document synchronization"
            sectionData={PageSectionRegistry['T25']}
        />
    );
}