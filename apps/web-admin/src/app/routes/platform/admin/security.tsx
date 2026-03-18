import type { TableColumn } from '@/shared/components/sections';
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from D3-AccountingDashboard.tsx ---
// ================================================================
// PAGE IDENTITY: D3 · Accounting Dashboard
// Type: Dashboard | Owner: admin | Registry: D3
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================


const recentJournals = [
    { date: 'Mar 16', ref: 'JE-2451', account: 'Payroll Expense', debit: '$147,250', credit: '—', balance: '$847,250' },
    { date: 'Mar 16', ref: 'JE-2451', account: 'Cash — Operating', debit: '—', credit: '$147,250', balance: '$1,232,400' },
    { date: 'Mar 15', ref: 'JE-2450', account: 'Accounts Receivable', debit: '$8,420', credit: '—', balance: '$156,840' },
    { date: 'Mar 14', ref: 'JE-2449', account: 'OHIP Claims Receivable', debit: '$23,100', credit: '—', balance: '$89,400' },
];

const journalCols: TableColumn[] = [
    { key: 'date', label: 'Date' }, { key: 'ref', label: 'Ref' },
    { key: 'account', label: 'Account' }, { key: 'debit', label: 'Debit' },
    { key: 'credit', label: 'Credit' }, { key: 'balance', label: 'Balance' },
];

export function AccountingDashboard() {
    return (
        <PageTemplate
            pageId="D3"
            title="📒 Accounting Dashboard"
            subtitle="Double-entry ledger, P&L, balance sheet & cash flow overview"
            actionPageId="admin.accounting"
            sectionData={{
                'D3.ledger-summary': { kpiCards: [
                    { label: 'Total Assets', value: '$2.4M', color: 'var(--pc-primary)' },
                    { label: 'Revenue MTD', value: '$185K', color: 'var(--pc-success)' },
                    { label: 'Expenses MTD', value: '$162K', color: 'var(--pc-warning)' },
                    { label: 'Net Income', value: '$23K', color: '#10B981' },
                    { label: 'Cash Flow', value: '+$41K', color: 'var(--pc-info, #2563EB)' },
                ]},
                'D3.pl-chart': { chart: { title: 'P&L — Revenue vs Expenses', type: 'bar', data: [
                    { label: 'Oct', value: 175, color: '#10B981' }, { label: 'Nov', value: 182, color: '#10B981' },
                    { label: 'Dec', value: 168, color: '#F59E0B' }, { label: 'Jan', value: 190, color: '#10B981' },
                    { label: 'Feb', value: 178, color: '#10B981' }, { label: 'Mar', value: 185, color: '#10B981' },
                ]}},
                'D3.journal-table': { table: { columns: journalCols, rows: recentJournals } },
                'D3.balance-sheet': { chart: { title: 'Asset Allocation', type: 'donut', data: [
                    { label: 'Cash', value: 45, color: '#10B981' }, { label: 'Receivables', value: 25, color: '#3B82F6' },
                    { label: 'Equipment', value: 18, color: '#F59E0B' }, { label: 'Prepaid', value: 12, color: '#8B5CF6' },
                ]}},
                'D3.cash-flow': { chart: { title: 'Cash Flow Forecast (Next 6 Months)', type: 'bar', data: [
                    { label: 'Apr', value: 38 }, { label: 'May', value: 42 },
                    { label: 'Jun', value: 35 }, { label: 'Jul', value: 48 },
                    { label: 'Aug', value: 44 }, { label: 'Sep', value: 51 },
                ]}},
            }}
        />
    );
}

// --- Merged from L16-AuditTrailViewer.tsx ---
// ================================================================
// PAGE IDENTITY: L16 · Audit Trail Viewer
// Type: List | Owner: admin | Registry: L24
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================


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

export function AuditTrailViewer() {
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

// --- Merged from SecurityDashboard.tsx ---
export function SecurityDashboard() {
    return (
        <PageTemplate 
            pageId="PGE-SD" 
            title="✨ Security Dashboard" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'SD.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'SD.empty']: { emptyState: { title: 'Security Dashboard Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}

// --- Merged from T10-SecurityGovernance.tsx ---
// ================================================================
// PAGE IDENTITY: T10 · Security Governance
// Type: Tool | Owner: admin | Registry: T10
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

const securityModules = [
    { icon: '🔍', title: 'Threat Overview', subtitle: 'Active threats, intrusion attempts, blocked IPs' },
    { icon: '📋', title: 'Policy Compliance', subtitle: 'HIPAA, PIPEDA, SOC2 compliance status' },
    { icon: '🔑', title: 'Access Reviews', subtitle: 'Periodic access certification & role audits' },
    { icon: '🚨', title: 'Incident Response', subtitle: 'Active incidents, SLA tracking, resolution logs' },
];

const activityFeed = [
    { icon: '🔴', title: 'Brute force attempt blocked — 15 attempts from 185.220.x.x', time: '2 min ago', level: 'danger' as const },
    { icon: '🟠', title: 'PSW-045 role escalation detected — admin access requested', time: '15 min ago', level: 'warning' as const },
    { icon: '🟢', title: 'HIPAA compliance audit passed — all 47 checks green', time: '1 hr ago', level: 'success' as const },
    { icon: 'ℹ️', title: 'Session purge completed — 23 expired sessions removed', time: '2 hrs ago', level: 'info' as const },
    { icon: '🟢', title: 'SSL certificate renewed — expires Dec 2027', time: '3 hrs ago', level: 'success' as const },
];

export function SecurityGovernance() {
    return (
        <PageTemplate
            pageId="T10"
            title="🛡️ Security Governance"
            subtitle="Threat monitoring, compliance, access reviews & incident response"
            actionPageId="admin.security-governance"
            sectionData={{
                'T10.threat-stats': { kpiCards: [
                    { label: 'Active Threats', value: 3, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Blocked IPs', value: 127, color: 'var(--pc-warning)' },
                    { label: 'Compliance Score', value: '98.2%', color: 'var(--pc-success)' },
                    { label: 'Open Incidents', value: 1, color: '#7C3AED' },
                    { label: 'Last Audit', value: '2 hrs ago', color: 'var(--pc-info, #2563EB)' },
                ]},
                'T10.nav-cards': { cardGrid: { items: securityModules, columns: 4 } },
                'T10.activity-feed': { feed: { items: activityFeed, title: '📡 Security Activity Feed' } },
            }}
        />
    );
}

// --- Merged from T13-DeviceManagement.tsx ---
// PAGE IDENTITY: T13 · Device Management


const devices = [
    { name: 'iPhone 14 Pro', user: 'Kevin Chen (PSW)', os: 'iOS 17.4', lastSeen: 'Today 14:23', status: '✅ Active', trust: 'Trusted' },
    { name: 'Samsung Galaxy S24', user: 'Maria Santos (PSW)', os: 'Android 14', lastSeen: 'Today 13:45', status: '✅ Active', trust: 'Trusted' },
    { name: 'iPad Air (5th)', user: 'Sarah Manager', os: 'iPadOS 17.4', lastSeen: 'Today 10:00', status: '✅ Active', trust: 'Trusted' },
    { name: 'Chrome — Windows', user: 'admin@primecare.ca', os: 'Win 11', lastSeen: 'Today 14:30', status: '✅ Active', trust: 'Trusted' },
    { name: 'Unknown Android', user: 'lisa.park@primecare.ca', os: 'Android 13', lastSeen: 'Mar 10', status: '⚠️ Stale', trust: 'Untrusted' },
];

const cols_5: TableColumn[] = [
    { key: 'name', label: 'Device' }, { key: 'user', label: 'User' },
    { key: 'os', label: 'OS' }, { key: 'lastSeen', label: 'Last Seen' },
    { key: 'status', label: 'Status' }, { key: 'trust', label: 'Trust' },
];

export function DeviceManagement() {
    return (
        <PageTemplate pageId="T13" title="📱 Device Management" subtitle="Registered devices, trust levels, remote wipe & session management"
            sectionData={{
                'T13.stats': { kpiCards: [
                    { label: 'Registered', value: 5, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 4, color: 'var(--pc-success)' },
                    { label: 'Untrusted', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Max per User', value: 3, color: 'var(--pc-info, #2563EB)' },
                ]},
                'T13.table': { table: { columns: cols_5, rows: devices } },
            }}
        />
    );
}

// --- Merged from T14-ForensicTrails.tsx ---
// ================================================================
// PAGE IDENTITY: T14 · Forensic Trails
// Type: Tool | Owner: admin | Registry: T14
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================


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

export function ForensicTrails() {
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

// --- Merged from T15-CorsSettings.tsx ---
// ================================================================
// PAGE IDENTITY: T15 · CORS Settings
// Type: Tool | Owner: admin | Registry: T15
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================


const origins = [
    { origin: '✅ primecare-admin.pages.dev', type: 'Production', methods: 'GET, POST, PUT, DELETE', status: 'Active' },
    { origin: '✅ localhost:5173', type: 'Development', methods: 'GET, POST, PUT, DELETE', status: 'Active' },
    { origin: '✅ primecare-api.workers.dev', type: 'API Worker', methods: 'GET, POST', status: 'Active' },
    { origin: '⚠️ staging.primecare.ca', type: 'Staging', methods: 'GET, POST', status: 'Review' },
];

const corsCols: TableColumn[] = [
    { key: 'origin', label: 'Origin' }, { key: 'type', label: 'Environment' },
    { key: 'methods', label: 'Allowed Methods' }, { key: 'status', label: 'Status' },
];

export function CorsSettings() {
    return (
        <PageTemplate
            pageId="T15"
            title="🌐 CORS Settings"
            subtitle="Cross-Origin Resource Sharing configuration and allowed origins management"
            actionPageId="admin.cors-settings"
            sectionData={{
                'T15.stats': { kpiCards: [
                    { label: 'Allowed Origins', value: 4, color: 'var(--pc-primary)' },
                    { label: 'Pending Review', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Blocked Today', value: 0, color: 'var(--pc-success)' },
                    { label: 'Max Age', value: '86400s', color: 'var(--pc-info, #2563EB)' },
                ]},
                'T15.origins': { table: { columns: corsCols, rows: origins } },
            }}
        />
    );
}

// --- Merged from T16-IntegrityVerification.tsx ---
// PAGE IDENTITY: T16 · Integrity Verification

export function IntegrityVerification() {
    return (
        <PageTemplate pageId="T16" title="🔒 Integrity Verification" subtitle="Data integrity checks, checksum validation & tamper detection"
            sectionData={{
                'T16.stats': { kpiCards: [
                    { label: 'Records Verified', value: '45K', color: 'var(--pc-success)' },
                    { label: 'Integrity Score', value: '100%', color: 'var(--pc-primary)' },
                    { label: 'Last Scan', value: 'Today 06:00', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Tamper Alerts', value: 0, color: 'var(--pc-success)' },
                ]},
                'T16.modules': { cardGrid: { items: [
                    { icon: '🔐', title: 'Database Checksums', subtitle: 'SHA-256 validation of all critical tables' },
                    { icon: '📋', title: 'Audit Log Integrity', subtitle: 'Immutable log chain verification' },
                    { icon: '📄', title: 'Document Fingerprints', subtitle: 'File hash comparison for uploaded docs' },
                    { icon: '🔍', title: 'API Response Signing', subtitle: 'Response integrity verification headers' },
                ], columns: 2 } },
            }}
        />
    );
}

// --- Merged from T17-FinancialLedger.tsx ---
// ================================================================
// PAGE IDENTITY: T17 · Financial Ledger
// Type: Tool | Owner: admin | Registry: T17
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================


const journalEntries = [
    { date: 'Mar 16', ref: 'JE-2451', description: 'Payroll — Week 11', debit: '$147,250.00', credit: '$147,250.00', status: 'Posted' },
    { date: 'Mar 15', ref: 'JE-2450', description: 'Client Billing — Chen, Park', debit: '$8,420.00', credit: '$8,420.00', status: 'Posted' },
    { date: 'Mar 14', ref: 'JE-2449', description: 'OHIP Claim — Batch #127', debit: '$23,100.00', credit: '$23,100.00', status: 'Pending' },
    { date: 'Mar 13', ref: 'JE-2448', description: 'Supply Purchase — MedEquip', debit: '$1,840.00', credit: '$1,840.00', status: 'Posted' },
    { date: 'Mar 12', ref: 'JE-2447', description: 'HST Remittance — Feb 2026', debit: '$12,350.00', credit: '$12,350.00', status: 'Posted' },
];

const ledgerCols: TableColumn[] = [
    { key: 'date', label: 'Date' }, { key: 'ref', label: 'Reference' },
    { key: 'description', label: 'Description' }, { key: 'debit', label: 'Debit' },
    { key: 'credit', label: 'Credit' }, { key: 'status', label: 'Status' },
];

export function FinancialLedger() {
    return (
        <PageTemplate
            pageId="T17"
            title="📒 Financial Ledger"
            subtitle="Double-entry journal, general ledger, trial balance & reconciliation"
            actionPageId="admin.financial-ledger"
            sectionData={{
                'T17.stats': { kpiCards: [
                    { label: 'Total Assets', value: '$2.4M', color: 'var(--pc-primary)' },
                    { label: 'Revenue MTD', value: '$185K', color: 'var(--pc-success)' },
                    { label: 'Expenses MTD', value: '$162K', color: 'var(--pc-warning)' },
                    { label: 'Net Income', value: '$23K', color: '#10B981' },
                ]},
                'T17.journal': { table: { columns: ledgerCols, rows: journalEntries } },
                'T17.pl-chart': { chart: { title: 'Revenue vs Expenses (6 Months)', type: 'bar', data: [
                    { label: 'Oct', value: 175, color: '#10B981' }, { label: 'Nov', value: 182, color: '#10B981' },
                    { label: 'Dec', value: 168, color: '#F59E0B' }, { label: 'Jan', value: 190, color: '#10B981' },
                    { label: 'Feb', value: 178, color: '#10B981' }, { label: 'Mar', value: 185, color: '#10B981' },
                ]}},
            }}
        />
    );
}

// --- Merged from T18-TaxComplianceHub.tsx ---
// ================================================================
// PAGE IDENTITY: T18 · Tax Compliance Hub
// Type: Tool | Owner: admin | Registry: T18
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

const complianceCards = [
    { icon: '🇨🇦', title: 'HST/GST Filing', subtitle: 'Next filing: Apr 30 — Q1 2026 | Estimated: $12,350' },
    { icon: '📋', title: 'WSIB Premiums', subtitle: 'Current rate: 2.46% | Annual est: $48,200' },
    { icon: '💳', title: 'T4/T4A Generation', subtitle: 'Due: Feb 28 | 82 employees processed' },
    { icon: '🏛️', title: 'EHT (Employer Health Tax)', subtitle: 'Ontario threshold: $1M | Current payroll: $1.8M' },
    { icon: '📊', title: 'CRA Audit Trail', subtitle: 'Last CRA correspondence: Jan 15 — resolved' },
    { icon: '🔒', title: 'PIPEDA Compliance', subtitle: 'Annual privacy impact assessment: ✅ Complete' },
];

export function TaxComplianceHub() {
    return (
        <PageTemplate
            pageId="T18"
            title="🏛️ Tax Compliance Hub"
            subtitle="HST/GST filing, WSIB, T4 generation, EHT & CRA audit trail"
            actionPageId="admin.tax-compliance"
            sectionData={{
                'T18.stats': { kpiCards: [
                    { label: 'HST Owing', value: '$12,350', color: 'var(--pc-warning)' },
                    { label: 'Next Filing', value: 'Apr 30', color: 'var(--pc-primary)' },
                    { label: 'Compliance Score', value: '100%', color: 'var(--pc-success)' },
                    { label: 'Open Items', value: 0, color: 'var(--pc-success)' },
                ]},
                'T18.modules': { cardGrid: { items: complianceCards, columns: 3 } },
            }}
        />
    );
}

// --- Merged from T56-PermissionGrid.tsx ---
// ================================================================
// PAGE IDENTITY: T56 · Permission Grid
// Type: Tool | Owner: admin | Registry: T56
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================


const roleMatrix = [
    { role: '🔑 Admin', users: 3, permissions: 60, level: 'Full Access', lastAudit: 'Mar 15' },
    { role: '👩‍⚕️ RN (Registered Nurse)', users: 8, permissions: 35, level: 'Clinical', lastAudit: 'Mar 14' },
    { role: '👤 Manager', users: 5, permissions: 42, level: 'Operations', lastAudit: 'Mar 14' },
    { role: '🏥 PSW', users: 77, permissions: 12, level: 'Field', lastAudit: 'Mar 13' },
    { role: '📊 Coordinator', users: 4, permissions: 28, level: 'Scheduling', lastAudit: 'Mar 12' },
    { role: '💰 Finance', users: 2, permissions: 18, level: 'Financial', lastAudit: 'Mar 10' },
];

const roleCols: TableColumn[] = [
    { key: 'role', label: 'Role' }, { key: 'users', label: 'Users' },
    { key: 'permissions', label: 'Permissions' }, { key: 'level', label: 'Access Level' },
    { key: 'lastAudit', label: 'Last Audit' },
];

export function PermissionGrid() {
    return (
        <PageTemplate
            pageId="T56"
            title="🔒 Permission Grid"
            subtitle="Role-based access control matrix, permission audits & conflict detection"
            actionPageId="admin.permission-grid"
            sectionData={{
                'T56.stats': { kpiCards: [
                    { label: 'Roles', value: 25, color: 'var(--pc-primary)' },
                    { label: 'Permissions', value: 60, color: '#7C3AED' },
                    { label: 'Users', value: 99, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Conflicts', value: 0, color: 'var(--pc-success)' },
                ]},
                'T56.matrix': { table: { columns: roleCols, rows: roleMatrix } },
                'T56.distribution': { chart: { title: 'Permission Distribution by Role', type: 'donut', data: [
                    { label: 'Admin', value: 60, color: '#EF4444' },
                    { label: 'Manager', value: 42, color: '#F59E0B' },
                    { label: 'RN', value: 35, color: '#3B82F6' },
                    { label: 'Coordinator', value: 28, color: '#8B5CF6' },
                    { label: 'Finance', value: 18, color: '#10B981' },
                    { label: 'PSW', value: 12, color: '#6B7280' },
                ]}},
            }}
        />
    );
}

// --- Merged from T57-SessionMonitor.tsx ---
// ================================================================
// PAGE IDENTITY: T57 · Session Monitor
// Type: Tool | Owner: admin | Registry: T57
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================


const sessions = [
    { user: '🟢 admin@primecare.ca', role: 'Admin', device: 'Chrome / Windows', ip: '198.51.100.23', duration: '2h 15m', location: 'Toronto, ON' },
    { user: '🟢 sarah.mgr@primecare.ca', role: 'Manager', device: 'Safari / macOS', ip: '203.0.113.42', duration: '45m', location: 'North York, ON' },
    { user: '🟢 kevin.psw@primecare.ca', role: 'PSW', device: 'PrimeCare PWA / Android', ip: '72.134.215.90', duration: '1h 30m', location: 'Mississauga, ON' },
    { user: '🟡 finance@primecare.ca', role: 'Finance', device: 'Firefox / Linux', ip: '198.51.100.25', duration: '10m', location: 'Ottawa, ON' },
    { user: '🔴 unknown@test.com', role: '—', device: 'curl/7.88.1', ip: '185.220.101.42', duration: 'Blocked', location: 'TOR Exit Node' },
];

const sessionCols: TableColumn[] = [
    { key: 'user', label: 'User' }, { key: 'role', label: 'Role' },
    { key: 'device', label: 'Device' }, { key: 'ip', label: 'IP' },
    { key: 'duration', label: 'Duration' }, { key: 'location', label: 'Location' },
];

export function SessionMonitor() {
    return (
        <PageTemplate
            pageId="T57"
            title="📡 Session Monitor"
            subtitle="Real-time active sessions, suspicious activity detection & session management"
            actionPageId="admin.session-monitor"
            isLive
            sectionData={{
                'T57.stats': { kpiCards: [
                    { label: 'Active Sessions', value: 4, color: 'var(--pc-primary)' },
                    { label: 'Blocked', value: 1, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Avg Duration', value: '1.1 hrs', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Unique IPs', value: 5, color: '#7C3AED' },
                ]},
                'T57.sessions': { table: { columns: sessionCols, rows: sessions } },
            }}
        />
    );
}

// --- Merged from T58-ThreatDetection.tsx ---
// ================================================================
// PAGE IDENTITY: T58 · Threat Detection
// Type: Tool | Owner: admin | Registry: T58
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

const threats = [
    { icon: '🔴', title: 'Brute Force Attack — 185.220.101.42 — 47 attempts in 60s', time: '2 min ago', level: 'danger' as const },
    { icon: '🟠', title: 'Suspicious Login — admin@primecare.ca from new location (Kyiv, UA)', time: '15 min ago', level: 'warning' as const },
    { icon: '🟡', title: 'Rate Limit Exceeded — API endpoint /v1/admin/users — 250 req/min', time: '1 hr ago', level: 'warning' as const },
    { icon: '🟢', title: 'Vulnerability Scan Completed — 0 critical findings', time: '3 hrs ago', level: 'success' as const },
    { icon: '🟢', title: 'SSL Certificate Valid — expires Dec 2027', time: '6 hrs ago', level: 'success' as const },
    { icon: 'ℹ️', title: 'WAF rule update applied — 12 new signatures', time: '12 hrs ago', level: 'info' as const },
];

export function ThreatDetection() {
    return (
        <PageTemplate
            pageId="T58"
            title="🚨 Threat Detection"
            subtitle="Real-time threat monitoring, intrusion detection & automated response"
            actionPageId="admin.threat-detection"
            isLive
            sectionData={{
                'T58.stats': { kpiCards: [
                    { label: 'Active Threats', value: 1, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Blocked Today', value: 47, color: 'var(--pc-warning)' },
                    { label: 'WAF Rules', value: 234, color: 'var(--pc-primary)' },
                    { label: 'Uptime', value: '99.98%', color: 'var(--pc-success)' },
                ]},
                'T58.threat-feed': { feed: { title: '📡 Live Threat Feed', items: threats } },
                'T58.history': { chart: { title: 'Blocked Attacks (7 Days)', type: 'bar', data: [
                    { label: 'Mon', value: 23, color: '#EF4444' }, { label: 'Tue', value: 15, color: '#EF4444' },
                    { label: 'Wed', value: 8, color: '#F59E0B' }, { label: 'Thu', value: 31, color: '#EF4444' },
                    { label: 'Fri', value: 47, color: '#EF4444' }, { label: 'Sat', value: 12, color: '#F59E0B' },
                    { label: 'Sun', value: 5, color: '#10B981' },
                ]}},
            }}
        />
    );
}
