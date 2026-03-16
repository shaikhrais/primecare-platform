// ================================================================
// PAGE IDENTITY: L16 · Audit Trail Viewer
// Type: List | Owner: admin | Registry: L24
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const auditEntries = [
    { timestamp: '2026-03-16 16:42', actor: 'admin@primecare.ca', action: 'UPDATE', resource: 'User/PSW-045', details: 'Role changed psw → rn', severity: '🟠 HIGH', ip: '198.51.100.23' },
    { timestamp: '2026-03-16 16:38', actor: 'sarah.mgr@primecare.ca', action: 'CREATE', resource: 'Visit/V-2847', details: 'New visit: Sharma → Chen', severity: 'ℹ️ INFO', ip: '203.0.113.42' },
    { timestamp: '2026-03-16 16:35', actor: 'system', action: 'DELETE', resource: 'Session/batch', details: 'Purged 23 expired sessions', severity: 'ℹ️ INFO', ip: '10.0.0.1' },
    { timestamp: '2026-03-16 16:30', actor: 'kevin.psw@primecare.ca', action: 'AUTH_FAIL', resource: 'Auth/Login', details: 'Failed login (wrong password)', severity: '⚠️ WARN', ip: '72.134.215.90' },
    { timestamp: '2026-03-16 16:25', actor: 'admin@primecare.ca', action: 'UPDATE', resource: 'Tenant/T-001', details: 'Feature flag "telehealth" enabled', severity: '🟠 HIGH', ip: '198.51.100.23' },
    { timestamp: '2026-03-16 16:20', actor: 'finance@primecare.ca', action: 'EXPORT', resource: 'Invoice/batch', details: 'Exported 47 invoices to CSV', severity: 'ℹ️ INFO', ip: '198.51.100.25' },
    { timestamp: '2026-03-16 16:15', actor: 'admin@primecare.ca', action: 'DELETE', resource: 'User/PSW-012', details: 'Deactivated user (termination)', severity: '🔴 CRIT', ip: '198.51.100.23' },
    { timestamp: '2026-03-16 16:10', actor: 'system', action: 'BACKUP', resource: 'Database/primary', details: 'Daily backup completed (245MB)', severity: 'ℹ️ INFO', ip: '10.0.0.1' },
    { timestamp: '2026-03-16 16:05', actor: 'unknown', action: 'AUTH_FAIL', resource: 'Auth/Login', details: 'Brute force: 15 attempts/60s. IP blocked.', severity: '🔴 CRIT', ip: '185.220.101.42' },
    { timestamp: '2026-03-16 16:00', actor: 'sarah.mgr@primecare.ca', action: 'UPDATE', resource: 'Schedule/W12', details: 'Modified 8 shifts for next week', severity: 'ℹ️ INFO', ip: '203.0.113.42' },
];

const auditCols: TableColumn[] = [
    { key: 'timestamp', label: 'Time' }, { key: 'actor', label: 'Actor' },
    { key: 'action', label: 'Action' }, { key: 'resource', label: 'Resource' },
    { key: 'details', label: 'Details' }, { key: 'severity', label: 'Severity' },
    { key: 'ip', label: 'IP' },
];

export default function AuditTrailViewer() {
    return (
        <PageTemplate
            pageId="L24"
            title="🔍 Audit Trail"
            subtitle="Complete system activity log — who did what, when, and from where"
            actionPageId="admin.audit-trail"
            sectionData={{
                'L24.stats': { kpiCards: [
                    { label: 'Total Events', value: 10, color: 'var(--pc-primary)' },
                    { label: 'Critical', value: 2, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Auth Failures', value: 2, color: 'var(--pc-warning)' },
                    { label: 'Unique Actors', value: 5, color: 'var(--pc-info, #2563EB)' },
                ]},
                'L24.audit-table': { table: { columns: auditCols, rows: auditEntries } },
            }}
        />
    );
}
