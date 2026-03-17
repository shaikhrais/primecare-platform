// ================================================================
// PAGE IDENTITY: D3 · Accounting Dashboard
// Type: Dashboard | Owner: admin | Registry: D3
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const recentJournals = [
    { date: 'Mar 16', ref: 'JE-2451', account: 'Payroll Expense', debit: '$147,250', credit: '—', balance: '$847,250' },
    { date: 'Mar 16', ref: 'JE-2451', account: 'Cash — Operating', debit: '—', credit: '$147,250', balance: '$1,232,400' },
    { date: 'Mar 15', ref: 'JE-2450', account: 'Accounts Receivable', debit: '$8,420', credit: '—', balance: '$156,840' },
    { date: 'Mar 14', ref: 'JE-2449', account: 'OHIP Claims Receivable', debit: '$23,100', credit: '—', balance: '$89,400' },
];

const journalCols: TableColumn[] = [
    { key: 'date', label: 'Date' }, { key: 'ref', label: 'Ref' },
    { key: 'account', label: 'Account' }, { key: 'debit', label: 'Debit' },
    { key: 'credit', label: 'Credit' }, { key: 'balance', label: 'Balance' },
];

export default function AccountingDashboard() {
    return (
        <PageTemplate
            pageId="D3"
            title="📒 Accounting Dashboard"
            subtitle="Double-entry ledger, P&L, balance sheet & cash flow overview"
            actionPageId="admin.accounting"
            sectionData={{
                'D3.ledger-summary': { kpiCards: [
                    { label: 'Total Assets', value: '$2.4M', color: 'var(--pc-primary)' },
                    { label: 'Revenue MTD', value: '$185K', color: 'var(--pc-success)' },
                    { label: 'Expenses MTD', value: '$162K', color: 'var(--pc-warning)' },
                    { label: 'Net Income', value: '$23K', color: '#10B981' },
                    { label: 'Cash Flow', value: '+$41K', color: 'var(--pc-info, #2563EB)' },
                ]},
                'D3.pl-chart': { chart: { title: 'P&L — Revenue vs Expenses', type: 'bar', data: [
                    { label: 'Oct', value: 175, color: '#10B981' }, { label: 'Nov', value: 182, color: '#10B981' },
                    { label: 'Dec', value: 168, color: '#F59E0B' }, { label: 'Jan', value: 190, color: '#10B981' },
                    { label: 'Feb', value: 178, color: '#10B981' }, { label: 'Mar', value: 185, color: '#10B981' },
                ]}},
                'D3.journal-table': { table: { columns: journalCols, rows: recentJournals } },
                'D3.balance-sheet': { chart: { title: 'Asset Allocation', type: 'donut', data: [
                    { label: 'Cash', value: 45, color: '#10B981' }, { label: 'Receivables', value: 25, color: '#3B82F6' },
                    { label: 'Equipment', value: 18, color: '#F59E0B' }, { label: 'Prepaid', value: 12, color: '#8B5CF6' },
                ]}},
                'D3.cash-flow': { chart: { title: 'Cash Flow Forecast (Next 6 Months)', type: 'bar', data: [
                    { label: 'Apr', value: 38 }, { label: 'May', value: 42 },
                    { label: 'Jun', value: 35 }, { label: 'Jul', value: 48 },
                    { label: 'Aug', value: 44 }, { label: 'Sep', value: 51 },
                ]}},
            }}
        />
    );
}
