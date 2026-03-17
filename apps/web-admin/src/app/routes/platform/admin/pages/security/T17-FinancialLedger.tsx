// ================================================================
// PAGE IDENTITY: T17 · Financial Ledger
// Type: Tool | Owner: admin | Registry: T17
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const journalEntries = [
    { date: 'Mar 16', ref: 'JE-2451', description: 'Payroll — Week 11', debit: '$147,250.00', credit: '$147,250.00', status: 'Posted' },
    { date: 'Mar 15', ref: 'JE-2450', description: 'Client Billing — Chen, Park', debit: '$8,420.00', credit: '$8,420.00', status: 'Posted' },
    { date: 'Mar 14', ref: 'JE-2449', description: 'OHIP Claim — Batch #127', debit: '$23,100.00', credit: '$23,100.00', status: 'Pending' },
    { date: 'Mar 13', ref: 'JE-2448', description: 'Supply Purchase — MedEquip', debit: '$1,840.00', credit: '$1,840.00', status: 'Posted' },
    { date: 'Mar 12', ref: 'JE-2447', description: 'HST Remittance — Feb 2026', debit: '$12,350.00', credit: '$12,350.00', status: 'Posted' },
];

const ledgerCols: TableColumn[] = [
    { key: 'date', label: 'Date' }, { key: 'ref', label: 'Reference' },
    { key: 'description', label: 'Description' }, { key: 'debit', label: 'Debit' },
    { key: 'credit', label: 'Credit' }, { key: 'status', label: 'Status' },
];

export default function FinancialLedger() {
    return (
        <PageTemplate
            pageId="T17"
            title="📒 Financial Ledger"
            subtitle="Double-entry journal, general ledger, trial balance & reconciliation"
            actionPageId="admin.financial-ledger"
            sectionData={{
                'T17.stats': { kpiCards: [
                    { label: 'Total Assets', value: '$2.4M', color: 'var(--pc-primary)' },
                    { label: 'Revenue MTD', value: '$185K', color: 'var(--pc-success)' },
                    { label: 'Expenses MTD', value: '$162K', color: 'var(--pc-warning)' },
                    { label: 'Net Income', value: '$23K', color: '#10B981' },
                ]},
                'T17.journal': { table: { columns: ledgerCols, rows: journalEntries } },
                'T17.pl-chart': { chart: { title: 'Revenue vs Expenses (6 Months)', type: 'bar', data: [
                    { label: 'Oct', value: 175, color: '#10B981' }, { label: 'Nov', value: 182, color: '#10B981' },
                    { label: 'Dec', value: 168, color: '#F59E0B' }, { label: 'Jan', value: 190, color: '#10B981' },
                    { label: 'Feb', value: 178, color: '#10B981' }, { label: 'Mar', value: 185, color: '#10B981' },
                ]}},
            }}
        />
    );
}
