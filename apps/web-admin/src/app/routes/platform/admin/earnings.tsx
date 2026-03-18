// PAGE IDENTITY: Earnings Page
// Converted to use shared sections instead of old per-page sub-components
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const earningsRows = [
    { invoice: 'INV-2024-042', client: 'Margaret Chen', service: 'PSW Home Care', hours: '38.5', amount: '$943.25', status: '✅ Paid', date: 'Mar 15' },
    { invoice: 'INV-2024-041', client: 'Robert Williams', service: 'RN Wound Care', hours: '4.0', amount: '$168.00', status: '✅ Paid', date: 'Mar 14' },
    { invoice: 'INV-2024-040', client: 'Helen Taylor', service: 'PSW Personal Care', hours: '20.0', amount: '$490.00', status: '⏳ Pending', date: 'Mar 13' },
    { invoice: 'INV-2024-039', client: 'James Brown', service: 'Respite Care', hours: '12.0', amount: '$312.00', status: '⏳ Pending', date: 'Mar 12' },
];

const cols: TableColumn[] = [
    { key: 'invoice', label: 'Invoice' }, { key: 'client', label: 'Client' },
    { key: 'service', label: 'Service' }, { key: 'hours', label: 'Hours' },
    { key: 'amount', label: 'Amount' }, { key: 'status', label: 'Status' },
    { key: 'date', label: 'Date' },
];

export default function AdminEarningsPage() {
    return (
        <PageTemplate pageId="EARN" title="💰 Earnings & Revenue" subtitle="Invoices, payouts, revenue tracking & financial reporting"
            sectionData={{
                'EARN.stats': { kpiCards: [
                    { label: 'Total Revenue', value: '$1,913.25', color: 'var(--pc-success)' },
                    { label: 'Paid', value: 2, color: 'var(--pc-primary)' },
                    { label: 'Pending', value: 2, color: 'var(--pc-warning)' },
                    { label: 'Total Hours', value: '74.5', color: 'var(--pc-info, #2563EB)' },
                ]},
                'EARN.filters': { filters: {
                    searchPlaceholder: 'Search by Invoice, Client, or Service...',
                    filters: [{ label: 'Status', options: ['All Statuses', 'Paid', 'Pending'] }],
                }},
                'EARN.table': { table: { columns: cols, rows: earningsRows } },
            }}
        />
    );
}
