import { TableColumn } from '@/shared/components/sections/SectionTable';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
// Re-export from identity file: L6-AuditLogs.tsx
// removed broken export: export { default } from './L6-AuditLogs';


// --- Merged from L6-AuditLogs.tsx ---
// ================================================================
// PAGE IDENTITY: L6 · Audit Logs
// Type: List | Owner: admin
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================




const auditRows = [
    { time: '14:23:15', user: 'admin@primecare.ca', action: 'UPDATE', resource: 'User.PSW-045', details: 'role changed', ip: '198.51.100.23' },
    { time: '14:20:08', user: 'system', action: 'PURGE', resource: 'Session.batch', details: '23 expired sessions', ip: 'Internal' },
    { time: '13:55:42', user: 'sarah.mgr@primecare.ca', action: 'CREATE', resource: 'Visit.V-4821', details: 'New visit', ip: '203.0.113.42' },
    { time: '12:30:00', user: 'cron:compliance', action: 'SCAN', resource: 'Credentials.*', details: '77 scanned, 2 flags', ip: 'Internal' },
    { time: '11:15:33', user: 'admin@primecare.ca', action: 'EXPORT', resource: 'Report.payroll', details: 'PDF exported', ip: '198.51.100.23' },
];

const cols: TableColumn[] = [
    { key: 'time', label: 'Time' }, { key: 'user', label: 'User' },
    { key: 'action', label: 'Action' }, { key: 'resource', label: 'Resource' },
    { key: 'details', label: 'Details' }, { key: 'ip', label: 'IP' },
];

export function AuditLogs() {
    return (
        <PageTemplate pageId="L6" title="📋 Audit Logs" subtitle="Complete audit trail of all platform actions"
            actionPageId="admin.audit-logs"
            sectionData={{
                'L6.stats': { kpiCards: [
                    { label: 'Events Today', value: 1247, color: 'var(--pc-primary)' },
                    { label: 'Users Active', value: 12, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Flagged', value: 3, color: 'var(--pc-warning)' },
                ]},
                'L6.table': { table: { columns: cols, rows: auditRows } },
            }}
        />
    );
}