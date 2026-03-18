// PAGE IDENTITY: Earnings Page
// Converted to use shared sections instead of old per-page sub-components
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";
const cols: TableColumn[] = [
    { key: 'invoice', label: 'Invoice' }, { key: 'client', label: 'Client' },
    { key: 'service', label: 'Service' }, { key: 'hours', label: 'Hours' },
    { key: 'amount', label: 'Amount' }, { key: 'status', label: 'Status' },
    { key: 'date', label: 'Date' },
];

export default function AdminEarningsPage() {
    return (
        <PageTemplate pageId="EARN" title="💰 Earnings & Revenue" subtitle="Invoices, payouts, revenue tracking & financial reporting"
            sectionData={PageSectionRegistry['EARN']}
        />
    );
}
