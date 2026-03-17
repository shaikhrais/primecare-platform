// ================================================================
// PAGE IDENTITY: L7 · Authorization List
// Type: List | Owner: admin
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
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

export default function AuthList() {
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
