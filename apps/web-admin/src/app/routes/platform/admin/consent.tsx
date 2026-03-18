import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from L8-ConsentList.tsx ---
// PAGE IDENTITY: L8 · Consent List
import type { TableColumn } from '@/shared/components/sections';

const consents = [
    { client: 'Margaret Chen', type: 'General Consent', signed: 'Jan 15, 2026', expires: 'Jan 15, 2027', status: '✅ Active' },
    { client: 'Robert Williams', type: 'Telehealth Consent', signed: 'Feb 1, 2026', expires: 'Feb 1, 2027', status: '✅ Active' },
    { client: 'Susan Park', type: 'Medication Admin', signed: 'Dec 10, 2025', expires: 'Dec 10, 2026', status: '✅ Active' },
    { client: 'James Brown', type: 'Photography/Video', signed: 'Nov 5, 2025', expires: 'Nov 5, 2026', status: '✅ Active' },
    { client: 'Helen Taylor', type: 'General Consent', signed: 'Mar 1, 2025', expires: 'Mar 1, 2026', status: '🔴 Expired' },
];

const cols: TableColumn[] = [
    { key: 'client', label: 'Client' }, { key: 'type', label: 'Consent Type' },
    { key: 'signed', label: 'Signed' }, { key: 'expires', label: 'Expires' },
    { key: 'status', label: 'Status' },
];

export function ConsentList() {
    return (
        <PageTemplate pageId="L8" title="📝 Consent Management" subtitle="Track signed consents, expirations & renewal requirements"
            sectionData={{
                'L8.stats': { kpiCards: [
                    { label: 'Active Consents', value: 4, color: 'var(--pc-success)' },
                    { label: 'Expired', value: 1, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Expiring Soon', value: 0, color: 'var(--pc-warning)' },
                ]},
                'L8.table': { table: { columns: cols, rows: consents } },
            }}
        />
    );
}

// --- Merged from R7-ConsentExpiring.tsx ---
// PAGE IDENTITY: R7 · Consent Expiring Report

export function ConsentExpiring() {
    return (
        <PageTemplate pageId="R7" title="⏰ Consent Expiration Report" subtitle="Consents expiring within 30/60/90 days, renewal reminders"
            sectionData={{
                'R7.stats': { kpiCards: [
                    { label: 'Expiring 30d', value: 3, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Expiring 60d', value: 5, color: 'var(--pc-warning)' },
                    { label: 'Expiring 90d', value: 8, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Auto-Renewed', value: 12, color: 'var(--pc-success)' },
                ]},
                'R7.chart': { chart: { title: 'Expiration Timeline', type: 'bar', data: [
                    { label: '< 30d', value: 3, color: '#EF4444' }, { label: '30-60d', value: 5, color: '#F59E0B' },
                    { label: '60-90d', value: 8, color: '#3B82F6' }, { label: '> 90d', value: 45, color: '#10B981' },
                ]}},
            }}
        />
    );
}

// --- Merged from T50-ConsentTemplates.tsx ---
// PAGE IDENTITY: T50 · Consent Templates

const templates = [
    { icon: '📋', title: 'General Consent', subtitle: 'Standard service consent — annual renewal' },
    { icon: '📱', title: 'Telehealth Consent', subtitle: 'Virtual visit authorization — PHIPA compliant' },
    { icon: '💊', title: 'Medication Administration', subtitle: 'MAR consent for PSW-administered medications' },
    { icon: '📸', title: 'Photography/Video', subtitle: 'Media capture consent for documentation' },
    { icon: '🔬', title: 'Research Participation', subtitle: 'Optional research study consent' },
    { icon: '📊', title: 'Data Sharing', subtitle: 'Inter-provider health information sharing' },
];

export function ConsentTemplates() {
    return (
        <PageTemplate pageId="T50" title="📄 Consent Templates" subtitle="Manage consent form templates, versions & digital signature workflows"
            sectionData={{
                'T50.stats': { kpiCards: [
                    { label: 'Templates', value: 6, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 5, color: 'var(--pc-success)' },
                    { label: 'Draft', value: 1, color: 'var(--pc-warning)' },
                ]},
                'T50.templates': { cardGrid: { items: templates, columns: 3 } },
            }}
        />
    );
}
