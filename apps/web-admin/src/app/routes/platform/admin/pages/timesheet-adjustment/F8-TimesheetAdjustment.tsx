// PAGE IDENTITY: F8 · Timesheet Adjustment
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const adjustments = [
    { id: 'ADJ-102', psw: 'Kevin Chen', date: 'Mar 14', original: '8.0 hrs', adjusted: '8.5 hrs', reason: 'Missed clock-out — client confirmed', status: '⏳ Pending' },
    { id: 'ADJ-101', psw: 'Maria Santos', date: 'Mar 12', original: '4.0 hrs', adjusted: '3.5 hrs', reason: 'Early departure — PSW illness', status: '✅ Approved' },
    { id: 'ADJ-100', psw: 'Lisa Park', date: 'Mar 10', original: '6.0 hrs', adjusted: '6.5 hrs', reason: 'Extended care — client emergency', status: '✅ Approved' },
];

const cols: TableColumn[] = [
    { key: 'id', label: 'ID' }, { key: 'psw', label: 'PSW' },
    { key: 'date', label: 'Date' }, { key: 'original', label: 'Original' },
    { key: 'adjusted', label: 'Adjusted' }, { key: 'reason', label: 'Reason' },
    { key: 'status', label: 'Status' },
];

export default function TimesheetAdjustment() {
    return (
        <PageTemplate pageId="F8" title="⏱️ Timesheet Adjustments" subtitle="Review and process PSW timesheet corrections & overtime adjustments"
            sectionData={{
                'F8.stats': { kpiCards: [
                    { label: 'Pending', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Approved MTD', value: 2, color: 'var(--pc-success)' },
                    { label: 'Net Change', value: '+1.0 hrs', color: 'var(--pc-primary)' },
                ]},
                'F8.table': { table: { columns: cols, rows: adjustments } },
            }}
        />
    );
}
