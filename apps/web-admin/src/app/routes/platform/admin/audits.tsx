import { TableColumn } from '@/shared/components/sections/SectionTable';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: L6-AuditLogs.tsx
// removed broken export: export { default } from './L6-AuditLogs';


// --- Merged from L6-AuditLogs.tsx ---
// ================================================================
// PAGE IDENTITY: L6 · Audit Logs
// Type: List | Owner: admin
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function AuditLogs() {
    return (
        <PageTemplate pageId="L6" title="📋 Audit Logs" subtitle="Complete audit trail of all platform actions"
            actionPageId="admin.audit-logs"
            sectionData={PageSectionRegistry['L6']}
        />
    );
}