import { TableColumn } from '@/shared/components/sections/SectionTable';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../../shared/PageSectionRegistry";

// Re-export from identity file: T59-Reconciliation.tsx
// removed broken export: export { default } from './T59-Reconciliation';


// --- Merged from T59-Reconciliation.tsx ---
// ================================================================
// PAGE IDENTITY: T59 · Reconciliation
// Type: Tool | Owner: admin
// Converted: FuzzyMatcher inlined — old ./components/ removed
// ================================================================
const cols: TableColumn[] = [
    { key: 'id', label: 'Feed ID' }, { key: 'bank', label: 'Bank' },
    { key: 'description', label: 'Description' }, { key: 'amount', label: 'Amount' },
    { key: 'match', label: 'Ledger Match' }, { key: 'confidence', label: 'Confidence' },
];

export function FinancialReconciliation() {
    return (
        <PageTemplate pageId="T59" title="🛡️ Financial Reconciliation Hub" subtitle="Verify the ledger against bank feeds — fuzzy matching, auto-reconciliation & audit trail"
            sectionData={PageSectionRegistry['T59']}
        />
    );
}