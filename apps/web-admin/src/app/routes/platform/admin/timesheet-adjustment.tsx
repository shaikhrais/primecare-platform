import { TableColumn } from '@/shared/components/sections/SectionTable';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Barrel re-export — identity file: F8-TimesheetAdjustment.tsx
// removed broken export: export { default } from './F8-TimesheetAdjustment';


// --- Merged from F8-TimesheetAdjustment.tsx ---
// PAGE IDENTITY: F8 · Timesheet Adjustment
const cols: TableColumn[] = [
    { key: 'id', label: 'ID' }, { key: 'psw', label: 'PSW' },
    { key: 'date', label: 'Date' }, { key: 'original', label: 'Original' },
    { key: 'adjusted', label: 'Adjusted' }, { key: 'reason', label: 'Reason' },
    { key: 'status', label: 'Status' },
];

export function TimesheetAdjustment() {
    return (
        <PageTemplate pageId="F8" title="⏱️ Timesheet Adjustments" subtitle="Review and process PSW timesheet corrections & overtime adjustments"
            sectionData={PageSectionRegistry['F8']}
        />
    );
}