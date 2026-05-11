/**
 * PermissionRegistry — Granular RBAC Permission System
 *
 * Auto-derived from the platform's domain structure. Maps permissions to roles,
 * and provides helpers for both frontend (can) and backend (requirePermission).
 *
 * ADDING A NEW PERMISSION:
 *   1. Add the permission string to the Permission union type
 *   2. Assign it to the appropriate roles in ROLE_PERMISSIONS
 *   3. Use can(role, permission) in frontend or requirePermission(permission) in API
 */

// ── All Platform Roles ───────────────────────────────────────────────────────
export type PlatformRole =
    | 'super_admin' | 'admin' | 'scrum_master'
    | 'manager' | 'regional_manager' | 'operations_manager' | 'clinical_manager'
    | 'hr_manager' | 'finance_manager' | 'marketing_manager' | 'recruiting_manager'
    | 'coordinator'
    | 'staff' | 'finance' | 'hr' | 'compliance' | 'crm' | 'training'
    | 'finance_director'
    | 'rn' | 'psw' | 'rmt' | 'rpt' | 'rch'
    | 'allied'
    | 'client';

export const PLATFORM_ROLES: PlatformRole[] = [
    'super_admin', 'admin', 'scrum_master',
    'manager', 'regional_manager', 'operations_manager', 'clinical_manager',
    'hr_manager', 'finance_manager', 'marketing_manager', 'recruiting_manager',
    'coordinator',
    'staff', 'finance', 'hr', 'compliance', 'crm', 'training',
    'finance_director',
    'rn', 'psw', 'rmt', 'rpt', 'rch',
    'allied',
    'client',
];

// ── Permission Categories ────────────────────────────────────────────────────
export type Permission =
    // Home & Navigation
    | 'view_home' | 'view_admin_home' | 'view_finance_home'
    | 'view_clinical_home' | 'view_ops_home'
    // User Management
    | 'manage_users' | 'view_users' | 'create_users' | 'delete_users'
    | 'impersonate_users'
    // Schedule & Visits
    | 'view_schedule' | 'manage_schedule' | 'create_visits' | 'approve_timesheets'
    // Clinical
    | 'clinical_oversight' | 'manage_care_plans' | 'manage_assessments'
    | 'view_medical_records' | 'manage_medications' | 'manage_wound_care'
    // Incidents
    | 'manage_incidents' | 'view_incidents'
    // Finance
    | 'view_reports' | 'manage_billing' | 'manage_invoices'
    | 'view_ledger' | 'manage_ledger' | 'manage_payroll'
    | 'view_earnings' | 'manage_reconciliation' | 'manage_tax'
    // Leads & CRM
    | 'manage_leads' | 'view_leads'
    // Services & Content
    | 'manage_services' | 'manage_content' | 'manage_templates'
    // Compliance & Security
    | 'view_audit_logs' | 'manage_compliance' | 'manage_consent'
    | 'manage_authorizations' | 'manage_security' | 'view_forensics'
    // Platform & System
    | 'manage_settings' | 'manage_tenants' | 'manage_devices'
    | 'manage_webhooks' | 'manage_integrations'
    // AI & Automation
    | 'view_ai_insights' | 'manage_automation'
    // Telehealth & Pharmacy
    | 'manage_telehealth' | 'manage_pharmacy'
    // ERP & Logistics
    | 'manage_inventory' | 'manage_logistics' | 'manage_fleet'
    // Coordinator
    | 'manage_dispatch' | 'manage_sos' | 'manage_waitlist' | 'manage_shift_swap'
    // PSW
    | 'view_open_shifts' | 'manage_availability' | 'submit_handover'
    | 'clock_in_out' | 'view_own_earnings'
    // Client
    | 'submit_feedback' | 'request_booking' | 'view_own_medical'
    | 'view_own_bookings' | 'view_own_billing' | 'view_family_portal'
    // Knowledge & Training
    | 'view_knowledge_base' | 'manage_knowledge_base' | 'view_training'
    // Scrum Master
    | 'manage_registries' | 'run_diagnostics' | 'manage_themes';

// ── Role → Permission Matrix ─────────────────────────────────────────────────
// super_admin and scrum_master get ALL permissions (bypass). This matrix
// only defines explicit assignments for other roles.

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

export const ROLE_PERMISSIONS: Record<string, Permission[]> = {
    // ── Full Access ──────────────────────────────────────────────────────
    super_admin: ALL_PERMISSIONS,
    scrum_master: ALL_PERMISSIONS,

    // ── Admin ────────────────────────────────────────────────────────────
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

    // ── Manager Roles ────────────────────────────────────────────────────
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
    regional_manager: [
        'view_home', 'view_ops_home', 'view_finance_home',
        'view_users', 'view_schedule',
        'view_reports', 'view_earnings',
        'manage_compliance',
        'view_knowledge_base', 'view_training',
    ],
    operations_manager: [
        'view_home', 'view_ops_home',
        'view_users', 'view_schedule', 'manage_schedule', 'create_visits',
        'view_incidents', 'manage_incidents',
        'manage_logistics', 'manage_fleet',
        'manage_inventory',
        'view_knowledge_base', 'view_training',
    ],
    clinical_manager: [
        'view_home', 'view_clinical_home',
        'clinical_oversight', 'manage_care_plans', 'manage_assessments',
        'view_medical_records', 'manage_medications', 'manage_wound_care',
        'manage_telehealth',
        'view_knowledge_base', 'view_training',
    ],
    hr_manager: [
        'view_home', 'manage_users', 'view_users', 'create_users',
        'view_knowledge_base', 'view_training',
    ],
    finance_manager: [
        'view_home', 'view_finance_home',
        'view_reports', 'manage_billing', 'manage_invoices',
        'view_earnings', 'view_ledger', 'manage_payroll',
        'view_knowledge_base', 'view_training',
    ],
    marketing_manager: [
        'view_home', 'manage_leads', 'view_leads', 'manage_content',
        'view_knowledge_base', 'view_training',
    ],
    recruiting_manager: [
        'view_home', 'manage_users', 'view_users', 'create_users', 'manage_leads',
        'view_knowledge_base', 'view_training',
    ],

    // ── Finance Director ─────────────────────────────────────────────────
    finance_director: [
        'view_home', 'view_finance_home',
        'view_reports', 'manage_billing', 'manage_invoices',
        'view_ledger', 'manage_ledger', 'manage_payroll',
        'view_earnings', 'manage_reconciliation', 'manage_tax',
        'view_knowledge_base', 'view_training',
    ],

    // ── Coordinator ──────────────────────────────────────────────────────
    coordinator: [
        'view_home',
        'view_schedule', 'manage_schedule', 'create_visits',
        'manage_dispatch', 'manage_sos', 'manage_waitlist', 'manage_shift_swap',
        'manage_fleet',
        'view_incidents',
        'view_knowledge_base', 'view_training',
    ],

    // ── Staff ────────────────────────────────────────────────────────────
    staff: [
        'view_home',
        'view_users', 'manage_leads', 'view_leads',
        'view_schedule',
        'view_incidents',
        'view_knowledge_base', 'view_training',
    ],
    finance: [
        'view_home', 'view_finance_home',
        'view_reports', 'manage_billing',
        'view_earnings', 'approve_timesheets',
        'view_knowledge_base', 'view_training',
    ],
    hr: ['view_home', 'manage_users', 'view_users', 'view_knowledge_base', 'view_training'],
    compliance: ['view_home', 'manage_compliance', 'manage_incidents', 'view_reports', 'view_audit_logs', 'view_knowledge_base', 'view_training'],
    crm: ['view_home', 'manage_leads', 'view_leads', 'view_knowledge_base', 'view_training'],
    training: ['view_home', 'view_knowledge_base', 'view_training'],

    // ── RN ───────────────────────────────────────────────────────────────
    rn: [
        'view_home', 'view_clinical_home',
        'clinical_oversight', 'manage_care_plans', 'manage_assessments',
        'view_medical_records', 'manage_medications', 'manage_wound_care',
        'view_schedule',
        'manage_telehealth', 'manage_pharmacy',
        'clock_in_out',
        'view_knowledge_base', 'view_training',
    ],

    // ── PSW / Allied ─────────────────────────────────────────────────────
    psw: [
        'view_home', 'view_schedule',
        'view_open_shifts', 'manage_availability', 'submit_handover',
        'clock_in_out', 'view_own_earnings',
        'view_knowledge_base', 'view_training',
    ],
    rmt: ['view_home', 'view_schedule', 'view_open_shifts', 'manage_availability', 'clock_in_out', 'view_own_earnings', 'view_knowledge_base', 'view_training'],
    rpt: ['view_home', 'view_schedule', 'view_open_shifts', 'manage_availability', 'clock_in_out', 'view_own_earnings', 'view_knowledge_base', 'view_training'],
    rch: ['view_home', 'view_schedule', 'view_open_shifts', 'manage_availability', 'clock_in_out', 'view_own_earnings', 'view_knowledge_base', 'view_training'],
    allied: [
        'view_home', 'view_schedule',
        'clinical_oversight', 'view_medical_records',
        'view_knowledge_base', 'view_training',
    ],

    // ── Client ───────────────────────────────────────────────────────────
    client: [
        'view_home',
        'submit_feedback', 'request_booking',
        'view_own_medical', 'view_own_bookings', 'view_own_billing', 'view_family_portal',
        'view_knowledge_base', 'view_training',
    ],
};

// ── Helper Functions ─────────────────────────────────────────────────────────

/**
 * Check if a role has a specific permission.
 */
export function can(role: string, permission: Permission): boolean {
    const perms = ROLE_PERMISSIONS[role.toLowerCase()];
    return perms ? perms.includes(permission) : false;
}

/**
 * Check if a role has ANY of the given permissions.
 */
export function canAny(role: string, permissions: Permission[]): boolean {
    return permissions.some(p => can(role, p));
}

/**
 * Check if a role has ALL of the given permissions.
 */
export function canAll(role: string, permissions: Permission[]): boolean {
    return permissions.every(p => can(role, p));
}

/**
 * Get all permissions for a role.
 */
export function getPermissions(role: string): Permission[] {
    return ROLE_PERMISSIONS[role.toLowerCase()] || [];
}

/**
 * Get all roles that have a specific permission.
 */
export function getRolesWithPermission(permission: Permission): string[] {
    return Object.entries(ROLE_PERMISSIONS)
        .filter(([_, perms]) => perms.includes(permission))
        .map(([role]) => role);
}
