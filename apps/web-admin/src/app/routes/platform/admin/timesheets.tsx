import { TableColumn } from '@/shared/components/sections/SectionTable';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: L4-Timesheets.tsx
// removed broken export: export { default } from './L4-Timesheets';


// --- Merged from L4-Timesheets.tsx ---
// PAGE IDENTITY: L4 · Timesheets
const cols: TableColumn[] = [
    { key: 'psw', label: 'PSW' }, { key: 'period', label: 'Period' },
    { key: 'regular', label: 'Regular' }, { key: 'ot', label: 'Overtime' },
    { key: 'total', label: 'Total' }, { key: 'status', label: 'Status' },
];

export function Timesheets() {
    return (
        <PageTemplate pageId="L4" title="⏱️ Timesheets" subtitle="PSW timesheet submissions, approval workflows & payroll integration"
            sectionData={PageSectionRegistry['L4']}
        />
    );
}