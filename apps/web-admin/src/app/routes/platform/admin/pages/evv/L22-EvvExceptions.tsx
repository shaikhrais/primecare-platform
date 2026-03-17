// PAGE IDENTITY: L22 · EVV Exceptions
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const exceptions = [
    { date: 'Mar 16', psw: 'Kevin Chen', client: 'Robert Williams', type: 'GPS Mismatch', detail: '50m outside zone', status: '⏳ Review' },
    { date: 'Mar 16', psw: 'Maria Santos', client: 'James Brown', type: 'Missing Clock-In', detail: 'Visit started, no EVV', status: '⚠️ Open' },
    { date: 'Mar 15', psw: 'Lisa Park', client: 'Helen Taylor', type: 'Duration Mismatch', detail: '3.5h vs 2h authorized', status: '✅ Resolved' },
];

const cols: TableColumn[] = [
    { key: 'date', label: 'Date' }, { key: 'psw', label: 'PSW' },
    { key: 'client', label: 'Client' }, { key: 'type', label: 'Exception Type' },
    { key: 'detail', label: 'Detail' }, { key: 'status', label: 'Status' },
];

export default function EvvExceptions() {
    return (
        <PageTemplate pageId="L22" title="⚠️ EVV Exceptions" subtitle="GPS mismatches, missing clock-ins & duration discrepancies"
            sectionData={{
                'L22.stats': { kpiCards: [
                    { label: 'Open', value: 2, color: 'var(--pc-warning)' },
                    { label: 'Resolved', value: 1, color: 'var(--pc-success)' },
                    { label: 'Avg Resolution', value: '4 hrs', color: 'var(--pc-info, #2563EB)' },
                ]},
                'L22.table': { table: { columns: cols, rows: exceptions } },
            }}
        />
    );
}
