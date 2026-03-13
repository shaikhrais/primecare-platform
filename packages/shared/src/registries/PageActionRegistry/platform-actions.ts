import type { PageActions } from '../PageActionRegistry';

export const PLATFORM_ACTIONS: Record<string, PageActions> = {
    // Admin Pages
    'admin.dashboard': {
        primary: 'btn-admin-user-invite',
        actions: [
            'btn-admin-ui-override', 'btn-admin-report-export', 'btn-admin-settings-save',
            'btn-admin-content-publish', 'btn-admin-search-reindex', 'btn-superuser-tenant-new',
            'btn-reseller-suspend', 'btn-adm-automation-trigger', 'btn-adm-ops-optimize',
        ],
    },
    'admin.summary': { actions: ['btn-sm-summary-registry', 'btn-ai-insights-refresh'] },
    'admin.users': { primary: 'btn-admin-user-invite', actions: ['btn-admin-report-export'] },
    'admin.leads': { primary: 'btn-adm-leads-convert', actions: ['btn-mkt-crm-export'] },
    'admin.schedule': { primary: 'btn-adm-schedule-optimize', actions: [] },
    'admin.services': { actions: ['btn-admin-settings-save'] },
    'admin.incidents': { primary: 'btn-adm-admission-new', actions: [] },
    'admin.timesheets': { primary: 'btn-mgr-payroll-verify', actions: [] },
    'admin.reports': { primary: 'btn-admin-report-export', actions: ['btn-adm-fhir-export'] },
    'admin.security': { primary: 'btn-sec-threat-scan', actions: ['btn-sec-session-flush', 'btn-sm-scan-security'] },
    'admin.finance': { primary: 'btn-adm-billing-finalize', actions: ['btn-rcm-revenue-sync', 'btn-rcm-claim-submit'] },
    'admin.ai': { primary: 'btn-ai-autopilot-engage', actions: ['btn-ai-insights-refresh'] },
    'admin.erp': { primary: 'btn-erp-inventory-add', actions: ['btn-erp-po-create'] },
    'admin.telehealth': { primary: 'btn-telehealth-session-start', actions: ['btn-rpm-vitals-verify'] },
    'admin.pharmacy': { primary: 'btn-pharmacy-order', actions: ['btn-pharmacy-mar-sync'] },
    // Superuser
    'superuser.dashboard': { primary: 'btn-sup-health-refresh', actions: ['btn-sup-policy-push', 'btn-superuser-risk-scan', 'btn-superuser-tenant-new'] },
    // Scrum Master
    'scrum-master.dashboard': { primary: 'btn-sm-universal-sweep', actions: ['btn-sm-auto-fix', 'btn-sm-flush-audits', 'btn-sm-db-reseed', 'btn-sm-build-deploy', 'btn-sm-scan-security'] },
};
