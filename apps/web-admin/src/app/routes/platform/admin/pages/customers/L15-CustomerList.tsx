// PAGE IDENTITY: L15 · Customer List
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const customers = [
    { name: 'Margaret Chen', age: 78, service: 'PSW Home Care', visits: '3x/week', status: '✅ Active', since: 'Jan 2024' },
    { name: 'Robert Williams', age: 82, service: 'RN Wound Care', visits: '2x/week', status: '✅ Active', since: 'Mar 2025' },
    { name: 'Susan Park', age: 71, service: 'Respite Care', visits: '1x/week', status: '✅ Active', since: 'Sep 2025' },
    { name: 'James Brown', age: 85, service: 'PT + OT', visits: '2x/week', status: '⏳ Intake', since: 'Mar 2026' },
    { name: 'Helen Taylor', age: 89, service: 'PSW Personal Care', visits: 'Daily', status: '✅ Active', since: 'Jun 2023' },
];

const cols: TableColumn[] = [
    { key: 'name', label: 'Client' }, { key: 'age', label: 'Age' },
    { key: 'service', label: 'Service' }, { key: 'visits', label: 'Frequency' },
    { key: 'status', label: 'Status' }, { key: 'since', label: 'Since' },
];

export default function CustomerList() {
    return (
        <PageTemplate pageId="L15" title="👥 Client Directory" subtitle="All active clients, service details & care history"
            sectionData={{
                'L15.stats': { kpiCards: [
                    { label: 'Total Clients', value: 67, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 64, color: 'var(--pc-success)' },
                    { label: 'Intake', value: 3, color: 'var(--pc-warning)' },
                    { label: 'Avg Age', value: 79, color: 'var(--pc-info, #2563EB)' },
                ]},
                'L15.table': { table: { columns: cols, rows: customers } },
            }}
        />
    );
}
