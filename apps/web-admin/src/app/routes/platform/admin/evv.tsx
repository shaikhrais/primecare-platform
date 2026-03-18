import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from D4-EvvDashboard.tsx ---
// PAGE IDENTITY: D4 · EVV Dashboard

export function EvvDashboard() {
    return (
        <PageTemplate pageId="D4" title="📍 EVV Dashboard" subtitle="Electronic Visit Verification — real-time GPS, clock-in/out & compliance"
            isLive
            sectionData={{
                'D4.stats': { kpiCards: [
                    { label: 'Active Visits', value: 23, color: 'var(--pc-primary)' },
                    { label: 'On-Time Rate', value: '94%', color: 'var(--pc-success)' },
                    { label: 'GPS Verified', value: '98%', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Exceptions', value: 3, color: 'var(--pc-warning)' },
                ]},
                'D4.map': { map: {
                    title: '📍 Live Visit Locations',
                    markers: [
                        { id: 'm1', lat: 43.65, lng: -79.38, label: 'PSW Santos — Chen residence', status: 'active' },
                        { id: 'm2', lat: 43.72, lng: -79.34, label: 'PSW Williams — Park home', status: 'active' },
                        { id: 'm3', lat: 43.68, lng: -79.42, label: 'PSW Brown — Taylor facility', status: 'active' },
                        { id: 'm4', lat: 43.71, lng: -79.40, label: 'PSW Chen — Williams home', status: 'danger' },
                    ],
                }},
                'D4.recent': { feed: { title: '📡 Live EVV Feed', items: [
                    { icon: '🟢', title: 'PSW Santos clocked in — Margaret Chen — GPS ✓', time: '14:23', level: 'success' as const },
                    { icon: '🟢', title: 'PSW Williams clocked out — Robert Williams — 2h 15m', time: '14:10', level: 'success' as const },
                    { icon: '🟡', title: 'PSW Brown — GPS outside service area (50m)', time: '13:55', level: 'warning' as const },
                    { icon: '🔴', title: 'PSW Chen — No clock-in for scheduled visit', time: '13:30', level: 'danger' as const },
                ]}},
            }}
        />
    );
}

// --- Merged from L22-EvvExceptions.tsx ---
// PAGE IDENTITY: L22 · EVV Exceptions
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

export function EvvExceptions() {
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

// --- Merged from R8-EvvExport.tsx ---
// PAGE IDENTITY: R8 · EVV Export

export function EvvExport() {
    return (
        <PageTemplate pageId="R8" title="📥 EVV Export" subtitle="Export EVV data for billing, compliance & payer submissions"
            sectionData={{
                'R8.stats': { kpiCards: [
                    { label: 'Exportable Records', value: '2.4K', color: 'var(--pc-primary)' },
                    { label: 'Last Export', value: 'Today', color: 'var(--pc-success)' },
                    { label: 'Format', value: 'CSV/XML', color: 'var(--pc-info, #2563EB)' },
                ]},
                'R8.formats': { cardGrid: { items: [
                    { icon: '📄', title: 'CSV Export', subtitle: 'Raw EVV data — all fields, date-filterable' },
                    { icon: '📋', title: 'XML (Payer Format)', subtitle: 'OHIP/CCAC-compliant structured format' },
                    { icon: '📊', title: 'Summary PDF', subtitle: 'Aggregated EVV compliance report' },
                ], columns: 3 } },
            }}
        />
    );
}
