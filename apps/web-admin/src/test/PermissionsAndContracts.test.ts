/**
 * Permission Registry, API Contracts, CORS & Integrity Tests — Phase 33
 *
 * MEGA BATCH — replicas of logic from:
 * - PermissionRegistry.ts: 25 roles, 60+ permissions, can/canAny/canAll/getPermissions/getRolesWithPermission
 * - contracts.ts: API envelope, pagination, all domain types, status enums
 * - FeatureIntegrityChecker.ts: issue severity, categories, report structure
 * - CorsRegistry.ts: origins, methods, headers, preflight config
 * - WebChatService.ts: message parsing, URL construction, reconnect logic
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// 1. Permission Registry — Full RBAC Matrix (replicated from PermissionRegistry.ts)
// ═══════════════════════════════════════════════════════════════════════════

type Permission =
    | 'view_home' | 'view_admin_home' | 'view_finance_home'
    | 'view_clinical_home' | 'view_ops_home'
    | 'manage_users' | 'view_users' | 'create_users' | 'delete_users' | 'impersonate_users'
    | 'view_schedule' | 'manage_schedule' | 'create_visits' | 'approve_timesheets'
    | 'clinical_oversight' | 'manage_care_plans' | 'manage_assessments'
    | 'view_medical_records' | 'manage_medications' | 'manage_wound_care'
    | 'manage_incidents' | 'view_incidents'
    | 'view_reports' | 'manage_billing' | 'manage_invoices'
    | 'view_ledger' | 'manage_ledger' | 'manage_payroll'
    | 'view_earnings' | 'manage_reconciliation' | 'manage_tax'
    | 'manage_leads' | 'view_leads'
    | 'manage_services' | 'manage_content' | 'manage_templates'
    | 'view_audit_logs' | 'manage_compliance' | 'manage_consent'
    | 'manage_authorizations' | 'manage_security' | 'view_forensics'
    | 'manage_settings' | 'manage_tenants' | 'manage_devices'
    | 'manage_webhooks' | 'manage_integrations'
    | 'view_ai_insights' | 'manage_automation'
    | 'manage_telehealth' | 'manage_pharmacy'
    | 'manage_inventory' | 'manage_logistics' | 'manage_fleet'
    | 'manage_dispatch' | 'manage_sos' | 'manage_waitlist' | 'manage_shift_swap'
    | 'view_open_shifts' | 'manage_availability' | 'submit_handover'
    | 'clock_in_out' | 'view_own_earnings'
    | 'submit_feedback' | 'request_booking' | 'view_own_medical'
    | 'view_own_bookings' | 'view_own_billing' | 'view_family_portal'
    | 'view_knowledge_base' | 'manage_knowledge_base' | 'view_training'
    | 'manage_registries' | 'run_diagnostics' | 'manage_themes';

const ALL_PERMISSIONS: Permission[] = [
    'view_home', 'view_admin_home', 'view_finance_home',
    'view_clinical_home', 'view_ops_home',
    'manage_users', 'view_users', 'create_users', 'delete_users', 'impersonate_users',
    'view_schedule', 'manage_schedule', 'create_visits', 'approve_timesheets',
    'clinical_oversight', 'manage_care_plans', 'manage_assessments',
    'view_medical_records', 'manage_medications', 'manage_wound_care',
    'manage_incidents', 'view_incidents',
    'view_reports', 'manage_billing', 'manage_invoices',
    'view_ledger', 'manage_ledger', 'manage_payroll',
    'view_earnings', 'manage_reconciliation', 'manage_tax',
    'manage_leads', 'view_leads',
    'manage_services', 'manage_content', 'manage_templates',
    'view_audit_logs', 'manage_compliance', 'manage_consent',
    'manage_authorizations', 'manage_security', 'view_forensics',
    'manage_settings', 'manage_tenants', 'manage_devices',
    'manage_webhooks', 'manage_integrations',
    'view_ai_insights', 'manage_automation',
    'manage_telehealth', 'manage_pharmacy',
    'manage_inventory', 'manage_logistics', 'manage_fleet',
    'manage_dispatch', 'manage_sos', 'manage_waitlist', 'manage_shift_swap',
    'view_open_shifts', 'manage_availability', 'submit_handover',
    'clock_in_out', 'view_own_earnings',
    'submit_feedback', 'request_booking', 'view_own_medical',
    'view_own_bookings', 'view_own_billing', 'view_family_portal',
    'view_knowledge_base', 'manage_knowledge_base', 'view_training',
    'manage_registries', 'run_diagnostics', 'manage_themes',
];

const ROLE_PERMISSIONS: Record<string, Permission[]> = {
    super_admin: ALL_PERMISSIONS,
    scrum_master: ALL_PERMISSIONS,
    admin: [
        'view_home', 'view_admin_home', 'view_finance_home', 'view_ops_home',
        'manage_users', 'view_users', 'create_users', 'delete_users',
        'view_schedule', 'manage_schedule', 'create_visits', 'approve_timesheets',
        'clinical_oversight', 'manage_care_plans',
        'manage_incidents', 'view_incidents',
        'view_reports', 'manage_billing', 'manage_invoices',
        'view_ledger', 'manage_payroll', 'view_earnings',
        'manage_leads', 'view_leads',
        'manage_services', 'manage_content', 'manage_templates',
        'view_audit_logs', 'manage_compliance', 'manage_consent', 'manage_authorizations',
        'manage_security', 'view_forensics',
        'manage_settings', 'manage_devices', 'manage_webhooks', 'manage_integrations',
        'view_ai_insights', 'manage_automation',
        'manage_telehealth', 'manage_pharmacy',
        'manage_inventory', 'manage_logistics',
        'view_knowledge_base', 'manage_knowledge_base', 'view_training',
    ],
    manager: [
        'view_home', 'view_ops_home',
        'manage_users', 'view_users',
        'view_schedule', 'manage_schedule', 'create_visits', 'approve_timesheets',
        'manage_incidents', 'view_incidents',
        'view_reports', 'view_earnings',
        'manage_leads', 'view_leads',
        'manage_compliance',
        'view_knowledge_base', 'view_training',
    ],
    coordinator: [
        'view_home',
        'view_schedule', 'manage_schedule', 'create_visits',
        'manage_dispatch', 'manage_sos', 'manage_waitlist', 'manage_shift_swap',
        'manage_fleet',
        'view_incidents',
        'view_knowledge_base', 'view_training',
    ],
    finance_director: [
        'view_home', 'view_finance_home',
        'view_reports', 'manage_billing', 'manage_invoices',
        'view_ledger', 'manage_ledger', 'manage_payroll',
        'view_earnings', 'manage_reconciliation', 'manage_tax',
        'view_knowledge_base', 'view_training',
    ],
    rn: [
        'view_home', 'view_clinical_home',
        'clinical_oversight', 'manage_care_plans', 'manage_assessments',
        'view_medical_records', 'manage_medications', 'manage_wound_care',
        'view_schedule',
        'manage_telehealth', 'manage_pharmacy',
        'clock_in_out',
        'view_knowledge_base', 'view_training',
    ],
    psw: [
        'view_home', 'view_schedule',
        'view_open_shifts', 'manage_availability', 'submit_handover',
        'clock_in_out', 'view_own_earnings',
        'view_knowledge_base', 'view_training',
    ],
    client: [
        'view_home',
        'submit_feedback', 'request_booking',
        'view_own_medical', 'view_own_bookings', 'view_own_billing', 'view_family_portal',
        'view_knowledge_base', 'view_training',
    ],
    finance: [
        'view_home', 'view_finance_home',
        'view_reports', 'manage_billing',
        'view_earnings', 'approve_timesheets',
        'view_knowledge_base', 'view_training',
    ],
    compliance: ['view_home', 'manage_compliance', 'manage_incidents', 'view_reports', 'view_audit_logs', 'view_knowledge_base', 'view_training'],
    hr: ['view_home', 'manage_users', 'view_users', 'view_knowledge_base', 'view_training'],
    staff: ['view_home', 'view_users', 'manage_leads', 'view_leads', 'view_schedule', 'view_incidents', 'view_knowledge_base', 'view_training'],
    training: ['view_home', 'view_knowledge_base', 'view_training'],
};

function can(role: string, permission: Permission): boolean {
    const perms = ROLE_PERMISSIONS[role.toLowerCase()];
    return perms ? perms.includes(permission) : false;
}

function canAny(role: string, permissions: Permission[]): boolean {
    return permissions.some(p => can(role, p));
}

function canAll(role: string, permissions: Permission[]): boolean {
    return permissions.every(p => can(role, p));
}

function getPermissions(role: string): Permission[] {
    return ROLE_PERMISSIONS[role.toLowerCase()] || [];
}

function getRolesWithPermission(permission: Permission): string[] {
    return Object.entries(ROLE_PERMISSIONS)
        .filter(([_, perms]) => perms.includes(permission))
        .map(([role]) => role);
}

// --- Super Admin / Scrum Master (full access) ---
describe('Permissions — Super Admin', () => {
    it('has ALL permissions', () => expect(getPermissions('super_admin').length).toBe(ALL_PERMISSIONS.length));
    it('can manage_users', () => expect(can('super_admin', 'manage_users')).toBe(true));
    it('can delete_users', () => expect(can('super_admin', 'delete_users')).toBe(true));
    it('can manage_tenants', () => expect(can('super_admin', 'manage_tenants')).toBe(true));
    it('can manage_registries', () => expect(can('super_admin', 'manage_registries')).toBe(true));
    it('can run_diagnostics', () => expect(can('super_admin', 'run_diagnostics')).toBe(true));
    it('can manage_tax', () => expect(can('super_admin', 'manage_tax')).toBe(true));
    it('can impersonate_users', () => expect(can('super_admin', 'impersonate_users')).toBe(true));
});

describe('Permissions — Scrum Master', () => {
    it('has ALL permissions', () => expect(getPermissions('scrum_master').length).toBe(ALL_PERMISSIONS.length));
    it('can manage_themes', () => expect(can('scrum_master', 'manage_themes')).toBe(true));
    it('can manage_reconciliation', () => expect(can('scrum_master', 'manage_reconciliation')).toBe(true));
});

// --- Admin ---
describe('Permissions — Admin', () => {
    it('can manage_users', () => expect(can('admin', 'manage_users')).toBe(true));
    it('can delete_users', () => expect(can('admin', 'delete_users')).toBe(true));
    it('can view_admin_home', () => expect(can('admin', 'view_admin_home')).toBe(true));
    it('can manage_security', () => expect(can('admin', 'manage_security')).toBe(true));
    it('can manage_invoices', () => expect(can('admin', 'manage_invoices')).toBe(true));
    it('cannot manage_tenants', () => expect(can('admin', 'manage_tenants')).toBe(false));
    it('cannot manage_registries', () => expect(can('admin', 'manage_registries')).toBe(false));
    it('cannot manage_reconciliation', () => expect(can('admin', 'manage_reconciliation')).toBe(false));
});

// --- Manager ---
describe('Permissions — Manager', () => {
    it('can manage_users', () => expect(can('manager', 'manage_users')).toBe(true));
    it('can manage_schedule', () => expect(can('manager', 'manage_schedule')).toBe(true));
    it('can manage_leads', () => expect(can('manager', 'manage_leads')).toBe(true));
    it('cannot manage_billing', () => expect(can('manager', 'manage_billing')).toBe(false));
    it('cannot manage_security', () => expect(can('manager', 'manage_security')).toBe(false));
    it('cannot delete_users', () => expect(can('manager', 'delete_users')).toBe(false));
});

// --- Coordinator ---
describe('Permissions — Coordinator', () => {
    it('can manage_dispatch', () => expect(can('coordinator', 'manage_dispatch')).toBe(true));
    it('can manage_sos', () => expect(can('coordinator', 'manage_sos')).toBe(true));
    it('can manage_waitlist', () => expect(can('coordinator', 'manage_waitlist')).toBe(true));
    it('can manage_shift_swap', () => expect(can('coordinator', 'manage_shift_swap')).toBe(true));
    it('can manage_fleet', () => expect(can('coordinator', 'manage_fleet')).toBe(true));
    it('cannot manage_users', () => expect(can('coordinator', 'manage_users')).toBe(false));
    it('cannot manage_billing', () => expect(can('coordinator', 'manage_billing')).toBe(false));
});

// --- Finance Director ---
describe('Permissions — Finance Director', () => {
    it('can manage_ledger', () => expect(can('finance_director', 'manage_ledger')).toBe(true));
    it('can manage_reconciliation', () => expect(can('finance_director', 'manage_reconciliation')).toBe(true));
    it('can manage_tax', () => expect(can('finance_director', 'manage_tax')).toBe(true));
    it('can manage_payroll', () => expect(can('finance_director', 'manage_payroll')).toBe(true));
    it('cannot manage_users', () => expect(can('finance_director', 'manage_users')).toBe(false));
    it('cannot manage_security', () => expect(can('finance_director', 'manage_security')).toBe(false));
});

// --- RN ---
describe('Permissions — RN', () => {
    it('can clinical_oversight', () => expect(can('rn', 'clinical_oversight')).toBe(true));
    it('can manage_medications', () => expect(can('rn', 'manage_medications')).toBe(true));
    it('can manage_wound_care', () => expect(can('rn', 'manage_wound_care')).toBe(true));
    it('can manage_telehealth', () => expect(can('rn', 'manage_telehealth')).toBe(true));
    it('can clock_in_out', () => expect(can('rn', 'clock_in_out')).toBe(true));
    it('cannot manage_users', () => expect(can('rn', 'manage_users')).toBe(false));
    it('cannot manage_billing', () => expect(can('rn', 'manage_billing')).toBe(false));
});

// --- PSW ---
describe('Permissions — PSW', () => {
    it('can view_open_shifts', () => expect(can('psw', 'view_open_shifts')).toBe(true));
    it('can manage_availability', () => expect(can('psw', 'manage_availability')).toBe(true));
    it('can submit_handover', () => expect(can('psw', 'submit_handover')).toBe(true));
    it('can clock_in_out', () => expect(can('psw', 'clock_in_out')).toBe(true));
    it('can view_own_earnings', () => expect(can('psw', 'view_own_earnings')).toBe(true));
    it('cannot manage_users', () => expect(can('psw', 'manage_users')).toBe(false));
    it('cannot clinical_oversight', () => expect(can('psw', 'clinical_oversight')).toBe(false));
    it('cannot manage_billing', () => expect(can('psw', 'manage_billing')).toBe(false));
});

// --- Client ---
describe('Permissions — Client', () => {
    it('can submit_feedback', () => expect(can('client', 'submit_feedback')).toBe(true));
    it('can request_booking', () => expect(can('client', 'request_booking')).toBe(true));
    it('can view_own_medical', () => expect(can('client', 'view_own_medical')).toBe(true));
    it('can view_own_bookings', () => expect(can('client', 'view_own_bookings')).toBe(true));
    it('can view_family_portal', () => expect(can('client', 'view_family_portal')).toBe(true));
    it('cannot manage_users', () => expect(can('client', 'manage_users')).toBe(false));
    it('cannot manage_billing', () => expect(can('client', 'manage_billing')).toBe(false));
    it('cannot clinical_oversight', () => expect(can('client', 'clinical_oversight')).toBe(false));
    it('cannot view_schedule', () => expect(can('client', 'view_schedule')).toBe(false));
});

// --- Other roles ---
describe('Permissions — Finance Staff', () => {
    it('can manage_billing', () => expect(can('finance', 'manage_billing')).toBe(true));
    it('can approve_timesheets', () => expect(can('finance', 'approve_timesheets')).toBe(true));
    it('cannot manage_users', () => expect(can('finance', 'manage_users')).toBe(false));
});

describe('Permissions — Compliance', () => {
    it('can manage_compliance', () => expect(can('compliance', 'manage_compliance')).toBe(true));
    it('can view_audit_logs', () => expect(can('compliance', 'view_audit_logs')).toBe(true));
    it('can manage_incidents', () => expect(can('compliance', 'manage_incidents')).toBe(true));
    it('cannot manage_users', () => expect(can('compliance', 'manage_users')).toBe(false));
});

describe('Permissions — HR', () => {
    it('can manage_users', () => expect(can('hr', 'manage_users')).toBe(true));
    it('can view_users', () => expect(can('hr', 'view_users')).toBe(true));
    it('cannot manage_billing', () => expect(can('hr', 'manage_billing')).toBe(false));
});

describe('Permissions — Training', () => {
    it('can view_knowledge_base', () => expect(can('training', 'view_knowledge_base')).toBe(true));
    it('can view_training', () => expect(can('training', 'view_training')).toBe(true));
    it('only 3 permissions', () => expect(getPermissions('training').length).toBe(3));
    it('cannot manage_users', () => expect(can('training', 'manage_users')).toBe(false));
});

// --- Helper functions ---
describe('Permissions — canAny', () => {
    it('psw has any of clock/manage', () => expect(canAny('psw', ['clock_in_out', 'manage_users'])).toBe(true));
    it('client has none of manage', () => expect(canAny('client', ['manage_users', 'manage_billing'])).toBe(false));
    it('admin has any finance', () => expect(canAny('admin', ['manage_billing', 'manage_invoices'])).toBe(true));
});

describe('Permissions — canAll', () => {
    it('admin has all user perms', () => expect(canAll('admin', ['manage_users', 'view_users', 'create_users'])).toBe(true));
    it('psw lacks user perms', () => expect(canAll('psw', ['manage_users', 'view_users'])).toBe(false));
    it('rn has all clinical', () => expect(canAll('rn', ['clinical_oversight', 'manage_care_plans', 'manage_assessments'])).toBe(true));
});

describe('Permissions — getRolesWithPermission', () => {
    it('manage_dispatch has coordinator', () => expect(getRolesWithPermission('manage_dispatch')).toContain('coordinator'));
    it('manage_dispatch has super_admin', () => expect(getRolesWithPermission('manage_dispatch')).toContain('super_admin'));
    it('manage_tax has finance_director', () => expect(getRolesWithPermission('manage_tax')).toContain('finance_director'));
    it('submit_feedback has client', () => expect(getRolesWithPermission('submit_feedback')).toContain('client'));
});

describe('Permissions — Unknown Role', () => {
    it('unknown role returns empty', () => expect(getPermissions('nonexistent')).toEqual([]));
    it('unknown role cannot do anything', () => expect(can('nonexistent', 'manage_users')).toBe(false));
});

// --- Universal permissions ---
describe('Permissions — Universal view_home', () => {
    const allRoles = Object.keys(ROLE_PERMISSIONS);
    it('every role can view_home', () => {
        for (const role of allRoles) {
            expect(can(role, 'view_home')).toBe(true);
        }
    });
});

describe('Permissions — Universal knowledge_base', () => {
    const allRoles = Object.keys(ROLE_PERMISSIONS);
    it('every role can view_knowledge_base', () => {
        for (const role of allRoles) {
            expect(can(role, 'view_knowledge_base')).toBe(true);
        }
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// 2. API Contracts — Type Validation (replicated from contracts.ts)
// ═══════════════════════════════════════════════════════════════════════════

type VisitStatus = 'scheduled' | 'in_progress' | 'completed' | 'cancelled' | 'no_show';
type InvoiceStatus = 'draft' | 'sent' | 'paid' | 'overdue' | 'cancelled';
type IncidentSeverity = 'low' | 'medium' | 'high' | 'critical';
type IncidentStatus = 'open' | 'investigating' | 'resolved' | 'closed';
type LeadStatus = 'new' | 'contacted' | 'qualified' | 'converted' | 'lost';
type TimesheetStatus = 'draft' | 'submitted' | 'approved' | 'rejected';

function isValidVisitStatus(s: string): s is VisitStatus {
    return ['scheduled', 'in_progress', 'completed', 'cancelled', 'no_show'].includes(s);
}
function isValidInvoiceStatus(s: string): s is InvoiceStatus {
    return ['draft', 'sent', 'paid', 'overdue', 'cancelled'].includes(s);
}
function isValidIncidentSeverity(s: string): s is IncidentSeverity {
    return ['low', 'medium', 'high', 'critical'].includes(s);
}
function isValidIncidentStatus(s: string): s is IncidentStatus {
    return ['open', 'investigating', 'resolved', 'closed'].includes(s);
}
function isValidLeadStatus(s: string): s is LeadStatus {
    return ['new', 'contacted', 'qualified', 'converted', 'lost'].includes(s);
}
function isValidTimesheetStatus(s: string): s is TimesheetStatus {
    return ['draft', 'submitted', 'approved', 'rejected'].includes(s);
}

function buildApiEnvelope<T>(data: T, message?: string, meta?: any): { status: string; data: T; message?: string; meta?: any } {
    return { status: 'success', data, ...(message ? { message } : {}), ...(meta ? { meta } : {}) };
}

function buildErrorEnvelope(message: string): { status: string; data: null; message: string } {
    return { status: 'error', data: null, message };
}

function buildPaginationMeta(page: number, pageSize: number, total: number) {
    return { page, pageSize, total, totalPages: Math.ceil(total / pageSize) };
}

function calculateInvoiceTotal(items: Array<{ quantity: number; rate: number }>): number {
    return items.reduce((sum, item) => sum + item.quantity * item.rate, 0);
}

describe('Contracts — Visit Status', () => {
    it('scheduled', () => expect(isValidVisitStatus('scheduled')).toBe(true));
    it('in_progress', () => expect(isValidVisitStatus('in_progress')).toBe(true));
    it('completed', () => expect(isValidVisitStatus('completed')).toBe(true));
    it('cancelled', () => expect(isValidVisitStatus('cancelled')).toBe(true));
    it('no_show', () => expect(isValidVisitStatus('no_show')).toBe(true));
    it('invalid', () => expect(isValidVisitStatus('pending')).toBe(false));
});

describe('Contracts — Invoice Status', () => {
    it('draft', () => expect(isValidInvoiceStatus('draft')).toBe(true));
    it('sent', () => expect(isValidInvoiceStatus('sent')).toBe(true));
    it('paid', () => expect(isValidInvoiceStatus('paid')).toBe(true));
    it('overdue', () => expect(isValidInvoiceStatus('overdue')).toBe(true));
    it('cancelled', () => expect(isValidInvoiceStatus('cancelled')).toBe(true));
    it('invalid', () => expect(isValidInvoiceStatus('pending')).toBe(false));
});

describe('Contracts — Incident Severity', () => {
    it('low', () => expect(isValidIncidentSeverity('low')).toBe(true));
    it('medium', () => expect(isValidIncidentSeverity('medium')).toBe(true));
    it('high', () => expect(isValidIncidentSeverity('high')).toBe(true));
    it('critical', () => expect(isValidIncidentSeverity('critical')).toBe(true));
    it('invalid', () => expect(isValidIncidentSeverity('extreme')).toBe(false));
});

describe('Contracts — Incident Status', () => {
    it('open', () => expect(isValidIncidentStatus('open')).toBe(true));
    it('investigating', () => expect(isValidIncidentStatus('investigating')).toBe(true));
    it('resolved', () => expect(isValidIncidentStatus('resolved')).toBe(true));
    it('closed', () => expect(isValidIncidentStatus('closed')).toBe(true));
    it('invalid', () => expect(isValidIncidentStatus('pending')).toBe(false));
});

describe('Contracts — Lead Status', () => {
    it('new', () => expect(isValidLeadStatus('new')).toBe(true));
    it('contacted', () => expect(isValidLeadStatus('contacted')).toBe(true));
    it('qualified', () => expect(isValidLeadStatus('qualified')).toBe(true));
    it('converted', () => expect(isValidLeadStatus('converted')).toBe(true));
    it('lost', () => expect(isValidLeadStatus('lost')).toBe(true));
    it('invalid', () => expect(isValidLeadStatus('warm')).toBe(false));
});

describe('Contracts — Timesheet Status', () => {
    it('draft', () => expect(isValidTimesheetStatus('draft')).toBe(true));
    it('submitted', () => expect(isValidTimesheetStatus('submitted')).toBe(true));
    it('approved', () => expect(isValidTimesheetStatus('approved')).toBe(true));
    it('rejected', () => expect(isValidTimesheetStatus('rejected')).toBe(true));
    it('invalid', () => expect(isValidTimesheetStatus('pending')).toBe(false));
});

describe('Contracts — API Envelope', () => {
    it('success envelope', () => {
        const e = buildApiEnvelope({ id: '1' });
        expect(e.status).toBe('success');
        expect(e.data.id).toBe('1');
    });
    it('with message', () => {
        const e = buildApiEnvelope(null, 'Created');
        expect(e.message).toBe('Created');
    });
    it('with meta', () => {
        const e = buildApiEnvelope([], undefined, { page: 1 });
        expect(e.meta.page).toBe(1);
    });
    it('error envelope', () => {
        const e = buildErrorEnvelope('Not found');
        expect(e.status).toBe('error');
        expect(e.data).toBeNull();
        expect(e.message).toBe('Not found');
    });
});

describe('Contracts — Pagination', () => {
    it('first page', () => {
        const m = buildPaginationMeta(1, 20, 100);
        expect(m.totalPages).toBe(5);
    });
    it('single page', () => {
        const m = buildPaginationMeta(1, 20, 5);
        expect(m.totalPages).toBe(1);
    });
    it('exact division', () => {
        const m = buildPaginationMeta(1, 10, 30);
        expect(m.totalPages).toBe(3);
    });
    it('uneven', () => {
        const m = buildPaginationMeta(1, 10, 31);
        expect(m.totalPages).toBe(4);
    });
});

describe('Contracts — Invoice Total', () => {
    it('single', () => expect(calculateInvoiceTotal([{ quantity: 2, rate: 50 }])).toBe(100));
    it('multiple', () => expect(calculateInvoiceTotal([{ quantity: 1, rate: 100 }, { quantity: 3, rate: 25 }])).toBe(175));
    it('empty', () => expect(calculateInvoiceTotal([])).toBe(0));
});

// ═══════════════════════════════════════════════════════════════════════════
// 3. Feature Integrity Checker — Types & Validation (replicated)
// ═══════════════════════════════════════════════════════════════════════════

type IssueSeverity = 'error' | 'warning' | 'info';
type IssueCategory = 'ORPHAN_PAGE' | 'ORPHAN_BUTTON' | 'ORPHAN_FORM' | 'MISSING_BUTTON' | 'MISSING_FORM' | 'MISSING_API' | 'MISSING_ROUTE' | 'DEAD_LINK';

function isValidSeverity(s: string): s is IssueSeverity {
    return ['error', 'warning', 'info'].includes(s);
}

function isValidCategory(c: string): c is IssueCategory {
    return ['ORPHAN_PAGE', 'ORPHAN_BUTTON', 'ORPHAN_FORM', 'MISSING_BUTTON', 'MISSING_FORM', 'MISSING_API', 'MISSING_ROUTE', 'DEAD_LINK'].includes(c);
}

function categorizeIssues(issues: Array<{ severity: IssueSeverity }>) {
    return {
        errors: issues.filter(i => i.severity === 'error'),
        warnings: issues.filter(i => i.severity === 'warning'),
        info: issues.filter(i => i.severity === 'info'),
    };
}

function isDeadLink(path: string | undefined): boolean {
    return !path || path === '' || path === '/shared/404';
}

function hasApiPath(action: string, apiPath: string | undefined): boolean {
    if (['API_TRIGGER', 'API_SIGNATURE', 'API_DISPATCH', 'GEOLOCATION_STAMP'].includes(action)) {
        return !!apiPath;
    }
    return true;
}

describe('Integrity — Severity', () => {
    it('error', () => expect(isValidSeverity('error')).toBe(true));
    it('warning', () => expect(isValidSeverity('warning')).toBe(true));
    it('info', () => expect(isValidSeverity('info')).toBe(true));
    it('invalid', () => expect(isValidSeverity('debug')).toBe(false));
});

describe('Integrity — Category', () => {
    it('ORPHAN_PAGE', () => expect(isValidCategory('ORPHAN_PAGE')).toBe(true));
    it('MISSING_API', () => expect(isValidCategory('MISSING_API')).toBe(true));
    it('DEAD_LINK', () => expect(isValidCategory('DEAD_LINK')).toBe(true));
    it('invalid', () => expect(isValidCategory('UNKNOWN')).toBe(false));
    it('all 8 categories', () => {
        const cats = ['ORPHAN_PAGE', 'ORPHAN_BUTTON', 'ORPHAN_FORM', 'MISSING_BUTTON', 'MISSING_FORM', 'MISSING_API', 'MISSING_ROUTE', 'DEAD_LINK'];
        for (const c of cats) expect(isValidCategory(c)).toBe(true);
    });
});

describe('Integrity — Categorize Issues', () => {
    it('separates by severity', () => {
        const issues = [
            { severity: 'error' as const }, { severity: 'warning' as const },
            { severity: 'info' as const }, { severity: 'error' as const },
        ];
        const r = categorizeIssues(issues);
        expect(r.errors.length).toBe(2);
        expect(r.warnings.length).toBe(1);
        expect(r.info.length).toBe(1);
    });
});

describe('Integrity — Dead Link', () => {
    it('undefined', () => expect(isDeadLink(undefined)).toBe(true));
    it('empty', () => expect(isDeadLink('')).toBe(true));
    it('404 path', () => expect(isDeadLink('/shared/404')).toBe(true));
    it('valid path', () => expect(isDeadLink('/admin/users')).toBe(false));
});

describe('Integrity — API Path', () => {
    it('API_TRIGGER with path', () => expect(hasApiPath('API_TRIGGER', '/v1/users')).toBe(true));
    it('API_TRIGGER no path', () => expect(hasApiPath('API_TRIGGER', undefined)).toBe(false));
    it('NAVIGATE no path OK', () => expect(hasApiPath('NAVIGATE', undefined)).toBe(true));
});

// ═══════════════════════════════════════════════════════════════════════════
// 4. CORS Registry (replicated from CorsRegistry.ts)
// ═══════════════════════════════════════════════════════════════════════════

const CORS = {
    ALLOWED_ORIGINS: ['https://primecare-admin.pages.dev', 'http://localhost:5173', 'http://localhost:8787'],
    ALLOWED_METHODS: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'],
    ALLOWED_HEADERS: ['Content-Type', 'Authorization', 'X-Requested-With', 'Accept', 'X-Kinde-Status', 'X-Tenant-ID', 'x-tenant-id', 'x-tenant-slug', 'X-Device-ID', 'X-Device-Name', 'X-Device-Type', 'X-Is-Temporary'],
    EXPOSE_HEADERS: ['Content-Length', 'X-Kinde-Status'],
    MAX_AGE: 600,
    CREDENTIALS: true,
} as const;

function isAllowedOrigin(origin: string): boolean {
    return CORS.ALLOWED_ORIGINS.includes(origin as any);
}

function isAllowedMethod(method: string): boolean {
    return CORS.ALLOWED_METHODS.includes(method as any);
}

function isAllowedHeader(header: string): boolean {
    return CORS.ALLOWED_HEADERS.includes(header as any);
}

describe('CORS — Origins', () => {
    it('production', () => expect(isAllowedOrigin('https://primecare-admin.pages.dev')).toBe(true));
    it('dev 5173', () => expect(isAllowedOrigin('http://localhost:5173')).toBe(true));
    it('dev 8787', () => expect(isAllowedOrigin('http://localhost:8787')).toBe(true));
    it('unknown', () => expect(isAllowedOrigin('https://evil.com')).toBe(false));
    it('3 origins total', () => expect(CORS.ALLOWED_ORIGINS.length).toBe(3));
});

describe('CORS — Methods', () => {
    it('GET', () => expect(isAllowedMethod('GET')).toBe(true));
    it('POST', () => expect(isAllowedMethod('POST')).toBe(true));
    it('PUT', () => expect(isAllowedMethod('PUT')).toBe(true));
    it('PATCH', () => expect(isAllowedMethod('PATCH')).toBe(true));
    it('DELETE', () => expect(isAllowedMethod('DELETE')).toBe(true));
    it('OPTIONS', () => expect(isAllowedMethod('OPTIONS')).toBe(true));
    it('TRACE denied', () => expect(isAllowedMethod('TRACE')).toBe(false));
});

describe('CORS — Headers', () => {
    it('Content-Type', () => expect(isAllowedHeader('Content-Type')).toBe(true));
    it('Authorization', () => expect(isAllowedHeader('Authorization')).toBe(true));
    it('X-Tenant-ID', () => expect(isAllowedHeader('X-Tenant-ID')).toBe(true));
    it('X-Device-ID', () => expect(isAllowedHeader('X-Device-ID')).toBe(true));
    it('x-tenant-slug', () => expect(isAllowedHeader('x-tenant-slug')).toBe(true));
    it('Random denied', () => expect(isAllowedHeader('X-Evil')).toBe(false));
});

describe('CORS — Config', () => {
    it('max age', () => expect(CORS.MAX_AGE).toBe(600));
    it('credentials', () => expect(CORS.CREDENTIALS).toBe(true));
    it('expose headers', () => expect(CORS.EXPOSE_HEADERS.length).toBe(2));
});

// ═══════════════════════════════════════════════════════════════════════════
// 5. WebChat — Message Parsing & URL Construction (replicated)
// ═══════════════════════════════════════════════════════════════════════════

function buildWsUrl(baseUrl: string): string {
    return baseUrl.replace('http', 'ws') + '/ws/chat';
}

function buildWsConnectionUrl(wsUrl: string, userId: string): string {
    return `${wsUrl}?userId=${userId}`;
}

function parseMessage(data: string): Record<string, unknown> {
    try {
        return JSON.parse(data);
    } catch {
        return { message: data, sender: 'System' };
    }
}

function buildChatPayload(message: string, userId: string): string {
    return JSON.stringify({ message, userId, timestamp: new Date().toISOString() });
}

function isReadyState(state: number): 'CONNECTING' | 'OPEN' | 'CLOSING' | 'CLOSED' {
    switch (state) {
        case 0: return 'CONNECTING';
        case 1: return 'OPEN';
        case 2: return 'CLOSING';
        case 3: return 'CLOSED';
        default: return 'CLOSED';
    }
}

describe('WebChat — URL Construction', () => {
    it('http to ws', () => expect(buildWsUrl('http://localhost:8787')).toBe('ws://localhost:8787/ws/chat'));
    it('https to wss', () => expect(buildWsUrl('https://api.example.com')).toBe('wss://api.example.com/ws/chat'));
});

describe('WebChat — Connection URL', () => {
    it('includes userId', () => {
        const url = buildWsConnectionUrl('ws://localhost:8787/ws/chat', 'user-123');
        expect(url).toBe('ws://localhost:8787/ws/chat?userId=user-123');
    });
});

describe('WebChat — Parse Message', () => {
    it('valid JSON', () => {
        const r = parseMessage('{"message":"hello","sender":"John"}');
        expect(r.message).toBe('hello');
        expect(r.sender).toBe('John');
    });
    it('invalid JSON fallback', () => {
        const r = parseMessage('plain text');
        expect(r.message).toBe('plain text');
        expect(r.sender).toBe('System');
    });
});

describe('WebChat — Chat Payload', () => {
    it('builds payload', () => {
        const payload = JSON.parse(buildChatPayload('Hello', 'u-1'));
        expect(payload.message).toBe('Hello');
        expect(payload.userId).toBe('u-1');
        expect(payload.timestamp).toBeTruthy();
    });
});

describe('WebChat — Ready State', () => {
    it('0 = CONNECTING', () => expect(isReadyState(0)).toBe('CONNECTING'));
    it('1 = OPEN', () => expect(isReadyState(1)).toBe('OPEN'));
    it('2 = CLOSING', () => expect(isReadyState(2)).toBe('CLOSING'));
    it('3 = CLOSED', () => expect(isReadyState(3)).toBe('CLOSED'));
    it('99 = CLOSED', () => expect(isReadyState(99)).toBe('CLOSED'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 6. Realtime Events (replicated from contracts.ts)
// ═══════════════════════════════════════════════════════════════════════════

type RealtimeEventType = 'visit.updated' | 'visit.completed' | 'incident.created' | 'booking.created' | 'notification.new' | 'dispatch.updated' | 'fleet.heartbeat';

function isValidRealtimeEvent(type: string): type is RealtimeEventType {
    return ['visit.updated', 'visit.completed', 'incident.created', 'booking.created', 'notification.new', 'dispatch.updated', 'fleet.heartbeat'].includes(type);
}

function buildRealtimeEvent(type: RealtimeEventType, tenantId: string, data: any) {
    return { type, timestamp: new Date().toISOString(), tenantId, data };
}

describe('Realtime Events — Validation', () => {
    it('visit.updated', () => expect(isValidRealtimeEvent('visit.updated')).toBe(true));
    it('visit.completed', () => expect(isValidRealtimeEvent('visit.completed')).toBe(true));
    it('incident.created', () => expect(isValidRealtimeEvent('incident.created')).toBe(true));
    it('booking.created', () => expect(isValidRealtimeEvent('booking.created')).toBe(true));
    it('notification.new', () => expect(isValidRealtimeEvent('notification.new')).toBe(true));
    it('dispatch.updated', () => expect(isValidRealtimeEvent('dispatch.updated')).toBe(true));
    it('fleet.heartbeat', () => expect(isValidRealtimeEvent('fleet.heartbeat')).toBe(true));
    it('invalid', () => expect(isValidRealtimeEvent('user.created')).toBe(false));
});

describe('Realtime Events — Build', () => {
    it('builds event', () => {
        const e = buildRealtimeEvent('visit.updated', 'tenant-1', { id: 'v-1' });
        expect(e.type).toBe('visit.updated');
        expect(e.tenantId).toBe('tenant-1');
        expect(e.data.id).toBe('v-1');
        expect(e.timestamp).toBeTruthy();
    });
});
