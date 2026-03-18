import { TableColumn } from '@/shared/components/sections/SectionTable';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';



// removed re-export: export { IncidentList, IncidentEntry };


// --- Merged from F10-IncidentEntry.tsx ---
// PAGE IDENTITY: F10 · Incident Entry



export function IncidentEntry() {
    return (
        <PageTemplate pageId="F10" title="🚨 Incident Report" subtitle="Submit workplace incidents, near-misses & safety concerns"
            sectionData={{
                'F10.stats': { kpiCards: [
                    { label: 'Open Incidents', value: 2, color: 'var(--pc-warning)' },
                    { label: 'This Month', value: 4, color: 'var(--pc-primary)' },
                    { label: 'Avg Resolution', value: '3 days', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Severity Avg', value: 'Low', color: 'var(--pc-success)' },
                ]},
                'F10.form': { cardGrid: { items: [
                    { icon: '📋', title: 'Incident Details', subtitle: 'Date, time, location & description' },
                    { icon: '👤', title: 'Involved Parties', subtitle: 'Client, PSW, witnesses & supervisor' },
                    { icon: '🏥', title: 'Injury Assessment', subtitle: 'Type, severity & treatment administered' },
                    { icon: '📊', title: 'Root Cause Analysis', subtitle: 'Contributing factors & prevention plan' },
                ], columns: 2 } },
            }}
        />
    );
}

// --- Merged from IncidentEntry.tsx ---
export function IncidentEntryForm() {
    return (
        <PageTemplate 
            pageId="PGE-IEF" 
            title="✨ Incident Entry Form" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'IEF.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'IEF.empty']: { emptyState: { title: 'Incident Entry Form Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}

// --- Merged from IncidentList.tsx ---
export function IncidentList_OLD1() {
    return (
        <PageTemplate 
            pageId="PGE-IL" 
            title="✨ Incident List" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'IL.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'IL.empty']: { emptyState: { title: 'Incident List Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}

// --- Merged from L2-IncidentList.tsx ---
// PAGE IDENTITY: L2 · Incident List




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

export function IncidentList() {
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