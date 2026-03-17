// ================================================================
// PAGE IDENTITY: T20 — Daily Entry
// Type: Tool | Owner: manager
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function DailyEntry() {
    return (
        <PageTemplate pageId="T20" title="📝 Daily Entry" subtitle="Record ADLs, vitals & wellness observations for client visits"
            sectionData={{
                'T20.stats': { kpiCards: [
                    { label: 'Entries Today', value: 5, color: 'var(--pc-primary)' },
                    { label: 'Unsigned', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Avg Duration', value: '12 min', color: 'var(--pc-success)' },
                    { label: 'Compliance', value: '96%', color: '#8B5CF6' },
                ]},
                'T20.entries': { table: { columns: [
                    { key: 'client', label: 'Client' }, { key: 'date', label: 'Date' },
                    { key: 'adl', label: 'ADLs Recorded' }, { key: 'vitals', label: 'Vitals' },
                    { key: 'status', label: 'Status' },
                ], rows: [
                    { client: 'J. Martinez', date: 'Today', adl: '✅ Bathing, Dressing, Grooming', vitals: 'BP: 120/80', status: '🟢 Signed' },
                    { client: 'R. Kim', date: 'Today', adl: '✅ Mobility, Eating', vitals: 'Temp: 36.8°C', status: '🟢 Signed' },
                    { client: 'S. Thompson', date: 'Today', adl: '⚠️ Partial — Needs review', vitals: 'HR: 92', status: '🟡 Unsigned' },
                ]}},
            }}
        />
    );
}
