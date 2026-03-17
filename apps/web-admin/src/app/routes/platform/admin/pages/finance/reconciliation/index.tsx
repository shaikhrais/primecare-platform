import { TableColumn } from '@/shared/components/sections/SectionTable';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
// Re-export from identity file: T59-Reconciliation.tsx
// removed broken export: export { default } from './T59-Reconciliation';


// --- Merged from T59-Reconciliation.tsx ---
// ================================================================
// PAGE IDENTITY: T59 · Reconciliation
// Type: Tool | Owner: admin
// Converted: FuzzyMatcher inlined — old ./components/ removed
// ================================================================




const reconciliationRows = [
    { id: 'BF-001', bank: 'TD Canada Trust', description: 'OHIP Deposit — Mar Billing', amount: '$12,450.00', match: '✅ Auto-matched (Invoice INV-2024-038)', confidence: '99%' },
    { id: 'BF-002', bank: 'TD Canada Trust', description: 'WSIB Payout', amount: '$3,200.00', match: '⚠️ Fuzzy match (Payroll PR-042)', confidence: '87%' },
    { id: 'BF-003', bank: 'TD Canada Trust', description: 'Office Supplies — Staples', amount: '-$142.50', match: '❌ No match found', confidence: '—' },
];

const cols: TableColumn[] = [
    { key: 'id', label: 'Feed ID' }, { key: 'bank', label: 'Bank' },
    { key: 'description', label: 'Description' }, { key: 'amount', label: 'Amount' },
    { key: 'match', label: 'Ledger Match' }, { key: 'confidence', label: 'Confidence' },
];

export function FinancialReconciliation() {
    return (
        <PageTemplate pageId="T59" title="🛡️ Financial Reconciliation Hub" subtitle="Verify the ledger against bank feeds — fuzzy matching, auto-reconciliation & audit trail"
            sectionData={{
                'T59.stats': { kpiCards: [
                    { label: 'Bank Feeds', value: 3, color: 'var(--pc-primary)' },
                    { label: 'Auto-Matched', value: 1, color: 'var(--pc-success)' },
                    { label: 'Fuzzy Matches', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Unmatched', value: 1, color: 'var(--pc-error, #EF4444)' },
                ]},
                'T59.table': { table: { columns: cols, rows: reconciliationRows } },
            }}
        />
    );
}