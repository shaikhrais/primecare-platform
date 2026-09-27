// Governance - Category: service | Purpose: ── Shared Constants ─────────────────────────────────────────────────────────
import type { ButtonDef } from '../button_registry';
import { ApiRegistry } from '../ApiRegistry';

// ── Shared Constants ─────────────────────────────────────────────────────────

const R = {
    ADM: 'admin', MGR: 'manager', COORD: 'coordinator', PSW: 'psw', RN: 'rn',
    CLIENT: 'client', STAFF: 'staff', SM: 'scrum_master', SU: 'super_admin',
    RES: 'reseller', MKT: 'marketing_manager', HR: 'hr_manager',
    BILLING: 'billing_manager', OPS: 'operations_manager', RMT: 'rmt',
    RD: 'regional_manager', PUB: 'public',
} as const;

const M = {
    ADM: 'ADMIN', OPS: 'OPERATIONS', CARE: 'CARE_DELIVERY', CLIN: 'CLINICAL',
    FIN: 'FINANCE', GOV: 'GOVERNANCE', PLAT: 'PLATFORM', MKT: 'MARKETING',
    HR: 'HR', SEC: 'SECURITY', ERP: 'ERP', TELE: 'TELEHEALTH', PHARM: 'PHARMACY',
    AI: 'AI', AUTO: 'AUTOMATION', INTEROP: 'INTEROP', SOV: 'SOVEREIGN',
    LEADS: 'LEADS', SCHED: 'SCHEDULE', INV: 'INVOICES', ADM_MISSION: 'ADMISSION',
    BUILDS: 'BUILDS', SCANS: 'SCANS', FRAN: 'FRANCHISE', CLIENT: 'CLIENT',
    SUPER: 'SUPERVISION',
} as const;

const A = {
    API: 'API_TRIGGER', NAV: 'UI_NAVIGATION', MODAL: 'OPEN_MODAL',
    SIG: 'API_SIGNATURE', GEO: 'GEOLOCATION_STAMP', DISPATCH: 'API_DISPATCH',
    CI: 'CI_TRIGGER',
} as const;

const T = { P: 'primary', S: 'secondary', G: 'ghost', D: 'danger' } as const;

function btn(
    id: string, label: string, role: string, module: string,
    type: 'primary' | 'secondary' | 'ghost' | 'danger',
    action: string, description: string,
    opts?: { api?: string; routeKey?: string; routeParams?: string[] }
): ButtonDef {
    return {
        id, label, role, module, type, action, description,
        ...(opts?.api && { apiPath: opts.api }),
        ...(opts?.routeKey && { routeKey: opts.routeKey }),
        ...(opts?.routeParams && { routeParams: opts.routeParams }),
    };
}

// ── Platform Buttons (Admin, Scrum Master, Superuser) ────────────────────────

export const PLATFORM_BUTTONS: ButtonDef[] = [
    // Admin
    btn('btn-admin-user-invite',      'Invite User',              R.ADM, M.ADM,  T.P, A.MODAL, 'Triggers the global user invitation dialog.'),
    btn('btn-admin-report-export',    'Generate Global Export',   R.ADM, M.ADM,  T.S, A.API,   'Triggers a full-platform data export for auditing.', { api: ApiRegistry.ADMIN.REPORTS }),
    btn('btn-admin-settings-save',    'Commit Platform Specs',    R.ADM, M.ADM,  T.P, A.API,   'Saves platform-wide business configuration to the core ledger.', { api: ApiRegistry.ADMIN.SETTINGS_COMMIT }),
    btn('btn-admin-content-publish',  'Publish UI Updates',       R.ADM, M.ADM,  T.P, A.API,   'Pushes all local content registry changes to production.', { api: ApiRegistry.ADMIN.CONTENT_PUBLISH }),
    btn('btn-admin-search-reindex',   'Rebuild Search Index',     R.ADM, M.ADM,  T.S, A.API,   'Triggers a full-platform search index reconstruction.', { api: ApiRegistry.ADMIN.SEARCH_REINDEX }),
    btn('btn-admin-ui-override',      'Commit UI Overrides',      R.ADM, M.GOV,  T.P, A.API,   'Finalizes and deploys all local text and label overrides to production.', { api: ApiRegistry.PLATFORM.ADMIN.UI_OVERRIDE_COMMIT }),
    // Scrum Master
    btn('btn-sm-auto-fix',            'Launch Auto-Fixer',        R.SM, M.GOV,    T.P, A.API,   'Executes the autonomous registry repair engine.', { api: ApiRegistry.SCRUM_MASTER.AUTO_FIX }),
    btn('btn-sm-flush-audits',        'Flush Forensic Logs',      R.SM, M.GOV,    T.D, A.API,   'Purges historical forensic logs based on retention policy.', { api: ApiRegistry.SCRUM_MASTER.LOG_FLUSH }),
    btn('btn-sm-db-reseed',           'Execute QA Re-seed',       R.SM, M.GOV,    T.S, A.API,   'Triggers the autonomous 7-week QA data generation engine.', { api: ApiRegistry.SCRUM_MASTER.DB_RESEED }),
    btn('btn-sm-universal-sweep',     'Start Universal Sweep',    R.SM, M.GOV,    T.P, A.API,   'Triggers the Response Bot for a platform-wide heartbeat check.', { api: ApiRegistry.SCRUM_MASTER.UNIVERSAL_SWEEP }),
    btn('btn-sm-build-deploy',        'Deploy Staging',           R.SM, M.BUILDS, T.P, A.CI,    'Triggers a manual CI/CD deployment.'),
    btn('btn-sm-scan-security',       'Full Security Scan',       R.SM, M.SCANS,  T.D, A.API,   'Triggers a platform-wide vulnerability audit.', { api: ApiRegistry.PLATFORM.SCRUM_MASTER.SECURITY_SCAN }),
    btn('btn-sm-summary-registry',    'Registry Intelligence Hub',R.SM, M.GOV,    T.P, A.NAV,   'Accesses the consolidated platform KPIs and registry-driven insights.'),
    // Superuser
    btn('btn-superuser-tenant-new',   'Provision New Tenant',      R.SU, M.PLAT, T.P, A.MODAL, 'Initializes a new multi-tenant environment.', { routeKey: 'SUPERUSER.TENANTS' }),
    btn('btn-superuser-risk-scan',    'Run Risk Surveillance',     R.SU, M.PLAT, T.D, A.API,   'Triggers platform-wide anomaly detection.', { api: ApiRegistry.PLATFORM.SUPERUSER.RISK_SCAN }),
    btn('btn-sup-health-refresh',     'Refresh Global Health',     R.SU, M.GOV,  T.P, A.API,   'Triggers a platform-wide infrastructure health check.', { api: ApiRegistry.PLATFORM.SUPERUSER.PLATFORM_HEALTH }),
    btn('btn-sup-policy-push',        'Deploy System Policy',      R.SU, M.GOV,  T.S, A.API,   'Enforces new core policies across all active tenants.', { api: ApiRegistry.PLATFORM.SUPERUSER.POLICY_ENGINE }),
];
