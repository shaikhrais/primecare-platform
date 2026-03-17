// PAGE IDENTITY: R12 · Claims ERA
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const eraRows = [
    { eraId: 'ERA-0215', payer: 'OHIP', claimCount: 12, amount: '$14,500', received: 'Mar 15', status: '✅ Reconciled' },
    { eraId: 'ERA-0214', payer: 'WSIB', claimCount: 4, amount: '$3,200', received: 'Mar 14', status: '✅ Reconciled' },
    { eraId: 'ERA-0213', payer: 'CCAC', claimCount: 8, amount: '$9,800', received: 'Mar 12', status: '⚠️ Partial' },
    { eraId: 'ERA-0212', payer: 'OHIP', claimCount: 15, amount: '$18,200', received: 'Mar 10', status: '✅ Reconciled' },
];

const cols: TableColumn[] = [
    { key: 'eraId', label: 'ERA ID' }, { key: 'payer', label: 'Payer' },
    { key: 'claimCount', label: 'Claims' }, { key: 'amount', label: 'Amount' },
    { key: 'received', label: 'Received' }, { key: 'status', label: 'Status' },
];

export default function ClaimsEra() {
    return (
        <PageTemplate pageId="R12" title="💳 ERA Processing" subtitle="Electronic remittance advice reconciliation & posting"
            sectionData={{
                'R12.stats': { kpiCards: [
                    { label: 'ERAs Received', value: 4, color: 'var(--pc-primary)' },
                    { label: 'Reconciled', value: '$45,700', color: 'var(--pc-success)' },
                    { label: 'Partial Match', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Auto-Post Rate', value: '92%', color: 'var(--pc-info, #2563EB)' },
                ]},
                'R12.table': { table: { columns: cols, rows: eraRows } },
            }}
        />
    );
}
