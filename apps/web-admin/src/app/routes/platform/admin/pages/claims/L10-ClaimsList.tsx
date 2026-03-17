// PAGE IDENTITY: L10 · Claims List
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const claims = [
    { id: 'CLM-4821', client: 'Margaret Chen', payer: 'OHIP', amount: '$2,450', submitted: 'Mar 14', status: '⏳ Pending' },
    { id: 'CLM-4820', client: 'Robert Williams', payer: 'WSIB', amount: '$890', submitted: 'Mar 13', status: '✅ Paid' },
    { id: 'CLM-4819', client: 'Susan Park', payer: 'Private', amount: '$1,200', submitted: 'Mar 12', status: '✅ Paid' },
    { id: 'CLM-4818', client: 'James Brown', payer: 'OHIP', amount: '$3,100', submitted: 'Mar 11', status: '❌ Denied' },
    { id: 'CLM-4817', client: 'Helen Taylor', payer: 'CCAC', amount: '$4,500', submitted: 'Mar 10', status: '✅ Paid' },
];

const cols: TableColumn[] = [
    { key: 'id', label: 'Claim ID' }, { key: 'client', label: 'Client' },
    { key: 'payer', label: 'Payer' }, { key: 'amount', label: 'Amount' },
    { key: 'submitted', label: 'Submitted' }, { key: 'status', label: 'Status' },
];

export default function ClaimsList() {
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
                'L10.table': { table: { columns: cols, rows: claims } },
            }}
        />
    );
}
