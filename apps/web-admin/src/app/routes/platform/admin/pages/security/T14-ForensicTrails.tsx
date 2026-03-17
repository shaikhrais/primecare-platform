// ================================================================
// PAGE IDENTITY: T14 · Forensic Trails
// Type: Tool | Owner: admin | Registry: T14
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const forens = [
    { timestamp: '2026-03-16 14:23:15', actor: 'admin@primecare.ca', action: 'UPDATE', resource: 'User.PSW-045', detail: 'role: PSW → Manager', ip: '198.51.100.23' },
    { timestamp: '2026-03-16 14:20:08', actor: 'system', action: 'DELETE', resource: 'Session.expired-batch', detail: '23 sessions purged', ip: 'Internal' },
    { timestamp: '2026-03-16 13:55:42', actor: 'sarah.mgr@primecare.ca', action: 'CREATE', resource: 'Visit.V-4821', detail: 'New visit for Client Chen', ip: '203.0.113.42' },
    { timestamp: '2026-03-16 12:30:00', actor: 'cron:compliance-sweep', action: 'SCAN', resource: 'Credentials.*', detail: '77 PSW records scanned, 2 flags', ip: 'Internal' },
    { timestamp: '2026-03-16 11:15:33', actor: 'admin@primecare.ca', action: 'EXPORT', resource: 'Report.payroll-Q1', detail: 'PDF exported, 12 pages', ip: '198.51.100.23' },
];

const forensCols: TableColumn[] = [
    { key: 'timestamp', label: 'Timestamp' }, { key: 'actor', label: 'Actor' },
    { key: 'action', label: 'Action' }, { key: 'resource', label: 'Resource' },
    { key: 'detail', label: 'Detail' }, { key: 'ip', label: 'IP' },
];

export default function ForensicTrails() {
    return (
        <PageTemplate
            pageId="T14"
            title="🔬 Forensic Trails"
            subtitle="Immutable audit log with full chain-of-custody for compliance & investigations"
            actionPageId="admin.forensic-trails"
            sectionData={{
                'T14.stats': { kpiCards: [
                    { label: 'Events Today', value: 1247, color: 'var(--pc-primary)' },
                    { label: 'Flagged', value: 3, color: 'var(--pc-warning)' },
                    { label: 'Unique Actors', value: 12, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Retention', value: '7 yrs', color: 'var(--pc-success)' },
                ]},
                'T14.log': { table: { columns: forensCols, rows: forens } },
            }}
        />
    );
}
