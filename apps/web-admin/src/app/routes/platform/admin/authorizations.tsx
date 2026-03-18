import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from L7-AuthList.tsx ---
// ================================================================
// PAGE IDENTITY: L7 · Authorization List
// Type: List | Owner: admin
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import type { TableColumn } from '@/shared/components/sections';

const authRows = [
    { client: 'Margaret Chen', payer: 'OHIP', service: 'PSW Home Care', approved: '120 hrs', used: '98 hrs (82%)', expires: 'Apr 30', status: '⚠️ Near Limit' },
    { client: 'Robert Williams', payer: 'WSIB', service: 'RN Wound Care', approved: '40 hrs', used: '12 hrs (30%)', expires: 'Jun 15', status: '✅ Active' },
    { client: 'Susan Park', payer: 'Private', service: 'PSW Respite', approved: '60 hrs', used: '55 hrs (92%)', expires: 'Mar 31', status: '🔴 Critical' },
    { client: 'James Brown', payer: 'OHIP', service: 'OT Assessment', approved: '8 hrs', used: '6 hrs (75%)', expires: 'May 20', status: '✅ Active' },
    { client: 'Helen Taylor', payer: 'CCAC', service: 'PSW Personal Care', approved: '200 hrs', used: '145 hrs (73%)', expires: 'Jul 31', status: '✅ Active' },
];

const cols: TableColumn[] = [
    { key: 'client', label: 'Client' }, { key: 'payer', label: 'Payer' },
    { key: 'service', label: 'Service' }, { key: 'approved', label: 'Approved' },
    { key: 'used', label: 'Used' }, { key: 'expires', label: 'Expires' },
    { key: 'status', label: 'Status' },
];

export function AuthList() {
    return (
        <PageTemplate pageId="L7" title="📋 Service Authorizations" subtitle="Track approved hours, utilization & expiration dates"
            actionPageId="admin.authorizations"
            sectionData={{
                'L7.stats': { kpiCards: [
                    { label: 'Active Auths', value: 5, color: 'var(--pc-primary)' },
                    { label: 'Near Limit', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Critical', value: 1, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Avg Utilization', value: '70%', color: 'var(--pc-info, #2563EB)' },
                ]},
                'L7.table': { table: { columns: cols, rows: authRows } },
            }}
        />
    );
}

// --- Merged from R6-AuthUtilization.tsx ---
// PAGE IDENTITY: R6 · Auth Utilization | T49 · Auth Alerts

export function AuthUtilization() {
    return (
        <PageTemplate pageId="R6" title="📊 Authorization Utilization" subtitle="Payer-specific utilization rates, exhaustion forecasts & renewal tracking"
            sectionData={{
                'R6.stats': { kpiCards: [
                    { label: 'Avg Utilization', value: '70%', color: 'var(--pc-primary)' },
                    { label: 'Exhausting (>80%)', value: 3, color: 'var(--pc-warning)' },
                    { label: 'Renewals Due', value: 2, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Unused Hours', value: 340, color: 'var(--pc-success)' },
                ]},
                'R6.chart': { chart: { title: 'Utilization by Payer', type: 'horizontal-bar', data: [
                    { label: 'OHIP', value: 77, color: '#3B82F6' }, { label: 'WSIB', value: 30, color: '#10B981' },
                    { label: 'Private', value: 92, color: '#EF4444' }, { label: 'CCAC', value: 73, color: '#F59E0B' },
                ]}},
            }}
        />
    );
}

// --- Merged from T49-AuthAlerts.tsx ---
// PAGE IDENTITY: T49 · Authorization Alerts

const alertFeed = [
    { icon: '🔴', title: 'Susan Park — Auth expires Mar 31, 92% used, NO renewal filed', time: 'Urgent', level: 'danger' as const },
    { icon: '🟠', title: 'Margaret Chen — 82% used (98/120 hrs), 6 weeks remaining', time: '2 hrs ago', level: 'warning' as const },
    { icon: '🟡', title: 'James Brown — OT auth 75% used, renewal recommended', time: '1 day ago', level: 'warning' as const },
    { icon: '🟢', title: 'Helen Taylor — Renewal approved, new auth starts Apr 1', time: '2 days ago', level: 'success' as const },
];

export function AuthAlerts() {
    return (
        <PageTemplate pageId="T49" title="🔔 Authorization Alerts" subtitle="Exhaustion warnings, expiration alerts & renewal notifications"
            sectionData={{
                'T49.stats': { kpiCards: [
                    { label: 'Critical', value: 1, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Warnings', value: 2, color: 'var(--pc-warning)' },
                    { label: 'Resolved', value: 1, color: 'var(--pc-success)' },
                ]},
                'T49.feed': { feed: { title: '🔔 Active Alerts', items: alertFeed } },
            }}
        />
    );
}
