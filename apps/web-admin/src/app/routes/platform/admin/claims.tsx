import type { TableColumn } from '@/shared/components/sections';
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from L10-ClaimsList.tsx ---
// PAGE IDENTITY: L10 · Claims List


const claims = [
    { id: 'CLM-4821', client: 'Margaret Chen', payer: 'OHIP', amount: '$2,450', submitted: 'Mar 14', status: '⏳ Pending' },
    { id: 'CLM-4820', client: 'Robert Williams', payer: 'WSIB', amount: '$890', submitted: 'Mar 13', status: '✅ Paid' },
    { id: 'CLM-4819', client: 'Susan Park', payer: 'Private', amount: '$1,200', submitted: 'Mar 12', status: '✅ Paid' },
    { id: 'CLM-4818', client: 'James Brown', payer: 'OHIP', amount: '$3,100', submitted: 'Mar 11', status: '❌ Denied' },
    { id: 'CLM-4817', client: 'Helen Taylor', payer: 'CCAC', amount: '$4,500', submitted: 'Mar 10', status: '✅ Paid' },
];

const cols_1: TableColumn[] = [
    { key: 'id', label: 'Claim ID' }, { key: 'client', label: 'Client' },
    { key: 'payer', label: 'Payer' }, { key: 'amount', label: 'Amount' },
    { key: 'submitted', label: 'Submitted' }, { key: 'status', label: 'Status' },
];

export function ClaimsList() {
    return (
        <PageTemplate pageId="L10" title="📋 Claims Management" subtitle="Submit, track & manage insurance claims across all payers"
            actionPageId="admin.claims"
            sectionData={{
                'L10.stats': { kpiCards: [
                    { label: 'Pending', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Paid MTD', value: '$8,590', color: 'var(--pc-success)' },
                    { label: 'Denied', value: 1, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Clean Rate', value: '80%', color: 'var(--pc-primary)' },
                ]},
                'L10.table': { table: { columns: cols_1, rows: claims } },
            }}
        />
    );
}

// --- Merged from R12-ClaimsEra.tsx ---
// PAGE IDENTITY: R12 · Claims ERA


const eraRows = [
    { eraId: 'ERA-0215', payer: 'OHIP', claimCount: 12, amount: '$14,500', received: 'Mar 15', status: '✅ Reconciled' },
    { eraId: 'ERA-0214', payer: 'WSIB', claimCount: 4, amount: '$3,200', received: 'Mar 14', status: '✅ Reconciled' },
    { eraId: 'ERA-0213', payer: 'CCAC', claimCount: 8, amount: '$9,800', received: 'Mar 12', status: '⚠️ Partial' },
    { eraId: 'ERA-0212', payer: 'OHIP', claimCount: 15, amount: '$18,200', received: 'Mar 10', status: '✅ Reconciled' },
];

const cols_2: TableColumn[] = [
    { key: 'eraId', label: 'ERA ID' }, { key: 'payer', label: 'Payer' },
    { key: 'claimCount', label: 'Claims' }, { key: 'amount', label: 'Amount' },
    { key: 'received', label: 'Received' }, { key: 'status', label: 'Status' },
];

export function ClaimsEra() {
    return (
        <PageTemplate pageId="R12" title="💳 ERA Processing" subtitle="Electronic remittance advice reconciliation & posting"
            sectionData={{
                'R12.stats': { kpiCards: [
                    { label: 'ERAs Received', value: 4, color: 'var(--pc-primary)' },
                    { label: 'Reconciled', value: '$45,700', color: 'var(--pc-success)' },
                    { label: 'Partial Match', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Auto-Post Rate', value: '92%', color: 'var(--pc-info, #2563EB)' },
                ]},
                'R12.table': { table: { columns: cols_2, rows: eraRows } },
            }}
        />
    );
}
