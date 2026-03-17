// PAGE IDENTITY: L8 · Consent List
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
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

export default function ConsentList() {
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
