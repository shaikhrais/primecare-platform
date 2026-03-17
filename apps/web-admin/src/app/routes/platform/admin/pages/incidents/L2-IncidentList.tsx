// PAGE IDENTITY: L2 · Incident List
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const incidents = [
    { id: 'INC-042', date: 'Mar 15', type: 'Fall', client: 'Helen Taylor', severity: '🟡 Medium', status: '⏳ Open' },
    { id: 'INC-041', date: 'Mar 13', type: 'Medication Error', client: 'Margaret Chen', severity: '🔴 High', status: '🔍 Investigating' },
    { id: 'INC-040', date: 'Mar 10', type: 'Near Miss', client: 'Robert Williams', severity: '🟢 Low', status: '✅ Closed' },
    { id: 'INC-039', date: 'Mar 7', type: 'Workplace Injury', client: '—', severity: '🟡 Medium', status: '✅ Closed' },
];

const cols: TableColumn[] = [
    { key: 'id', label: 'ID' }, { key: 'date', label: 'Date' },
    { key: 'type', label: 'Type' }, { key: 'client', label: 'Client' },
    { key: 'severity', label: 'Severity' }, { key: 'status', label: 'Status' },
];

export default function IncidentList() {
    return (
        <PageTemplate pageId="L2" title="🚨 Incident List" subtitle="Track workplace incidents, near-misses, investigations & resolutions"
            sectionData={{
                'L2.stats': { kpiCards: [
                    { label: 'Open', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Investigating', value: 1, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Closed MTD', value: 2, color: 'var(--pc-success)' },
                    { label: 'Total MTD', value: 4, color: 'var(--pc-primary)' },
                ]},
                'L2.table': { table: { columns: cols, rows: incidents } },
            }}
        />
    );
}
