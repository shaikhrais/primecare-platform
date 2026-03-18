import { TableColumn } from '@/shared/components/sections/SectionTable';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
// Re-export from identity file: L4-Timesheets.tsx
// removed broken export: export { default } from './L4-Timesheets';


// --- Merged from L4-Timesheets.tsx ---
// PAGE IDENTITY: L4 · Timesheets




const timesheets = [
    { psw: 'Kevin Chen', period: 'Mar 10-16', regular: '38.5 hrs', ot: '2.5 hrs', total: '$1,025', status: '⏳ Pending' },
    { psw: 'Maria Santos', period: 'Mar 10-16', regular: '40 hrs', ot: '0 hrs', total: '$980', status: '✅ Approved' },
    { psw: 'Lisa Park', period: 'Mar 10-16', regular: '36 hrs', ot: '4 hrs', total: '$1,040', status: '✅ Approved' },
    { psw: 'James Williams', period: 'Mar 10-16', regular: '32 hrs', ot: '0 hrs', total: '$784', status: '⏳ Pending' },
];

const cols: TableColumn[] = [
    { key: 'psw', label: 'PSW' }, { key: 'period', label: 'Period' },
    { key: 'regular', label: 'Regular' }, { key: 'ot', label: 'Overtime' },
    { key: 'total', label: 'Total' }, { key: 'status', label: 'Status' },
];

export function Timesheets() {
    return (
        <PageTemplate pageId="L4" title="⏱️ Timesheets" subtitle="PSW timesheet submissions, approval workflows & payroll integration"
            sectionData={{
                'L4.stats': { kpiCards: [
                    { label: 'Pending Approval', value: 2, color: 'var(--pc-warning)' },
                    { label: 'Approved', value: 2, color: 'var(--pc-success)' },
                    { label: 'Total Hours', value: '146.5', color: 'var(--pc-primary)' },
                    { label: 'OT Hours', value: 6.5, color: '#F59E0B' },
                ]},
                'L4.table': { table: { columns: cols, rows: timesheets } },
            }}
        />
    );
}