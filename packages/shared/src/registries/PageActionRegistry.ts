// ──────────────────────────────────────────────────────────────────────────────
// PageActionRegistry — Maps each page to its action buttons.
// Single source of truth: "which buttons appear on which page?"
// ──────────────────────────────────────────────────────────────────────────────

export interface PageActions {
    /** The primary CTA button for this page */
    primary?: string;
    /** Secondary/utility action buttons */
    actions: string[];
}

/**
 * Maps PageEntry.id → { primary, actions[] } where values are ButtonDef.id strings.
 * 
 * Usage:
 *   import { PageActionRegistry } from 'prime-care-shared';
 *   const actions = PageActionRegistry['admin.dashboard'];
 *   // { primary: 'btn-admin-user-invite', actions: [...] }
 */
export const PageActionRegistry: Record<string, PageActions> = {

    // ── Admin Pages ──────────────────────────────────────────────────────────

    'admin.dashboard': {
        primary: 'btn-admin-user-invite',
        actions: [
            'btn-admin-ui-override',
            'btn-admin-report-export',
            'btn-admin-settings-save',
            'btn-admin-content-publish',
            'btn-admin-search-reindex',
            'btn-superuser-tenant-new',
            'btn-reseller-suspend',
            'btn-adm-automation-trigger',
            'btn-adm-ops-optimize',
        ],
    },

    'admin.summary': {
        actions: ['btn-sm-summary-registry', 'btn-ai-insights-refresh'],
    },

    'admin.users': {
        primary: 'btn-admin-user-invite',
        actions: ['btn-admin-report-export'],
    },

    'admin.leads': {
        primary: 'btn-adm-leads-convert',
        actions: ['btn-mkt-crm-export'],
    },

    'admin.schedule': {
        primary: 'btn-adm-schedule-optimize',
        actions: [],
    },

    'admin.services': {
        actions: ['btn-admin-settings-save'],
    },

    'admin.incidents': {
        primary: 'btn-adm-admission-new',
        actions: [],
    },

    'admin.timesheets': {
        primary: 'btn-mgr-payroll-verify',
        actions: [],
    },

    'admin.reports': {
        primary: 'btn-admin-report-export',
        actions: ['btn-adm-fhir-export'],
    },

    'admin.security': {
        primary: 'btn-sec-threat-scan',
        actions: ['btn-sec-session-flush', 'btn-sm-scan-security'],
    },

    'admin.finance': {
        primary: 'btn-adm-billing-finalize',
        actions: ['btn-rcm-revenue-sync', 'btn-rcm-claim-submit'],
    },

    'admin.ai': {
        primary: 'btn-ai-autopilot-engage',
        actions: ['btn-ai-insights-refresh'],
    },

    'admin.erp': {
        primary: 'btn-erp-inventory-add',
        actions: ['btn-erp-po-create'],
    },

    'admin.telehealth': {
        primary: 'btn-telehealth-session-start',
        actions: ['btn-rpm-vitals-verify'],
    },

    'admin.pharmacy': {
        primary: 'btn-pharmacy-order',
        actions: ['btn-pharmacy-mar-sync'],
    },

    // ── Superuser Pages ──────────────────────────────────────────────────────

    'superuser.dashboard': {
        primary: 'btn-sup-health-refresh',
        actions: ['btn-sup-policy-push', 'btn-superuser-risk-scan', 'btn-superuser-tenant-new'],
    },

    // ── Scrum Master Pages ───────────────────────────────────────────────────

    'scrum-master.dashboard': {
        primary: 'btn-sm-universal-sweep',
        actions: ['btn-sm-auto-fix', 'btn-sm-flush-audits', 'btn-sm-db-reseed', 'btn-sm-build-deploy', 'btn-sm-scan-security'],
    },

    // ── Manager Pages ────────────────────────────────────────────────────────

    'manager.dashboard': {
        primary: 'btn-mgr-payroll-verify',
        actions: ['btn-mgr-ops-stats', 'btn-mgr-compliance-sync', 'btn-mgr-feedback-triage'],
    },

    'manager.training': {
        primary: 'btn-mgr-training-create',
        actions: [],
    },

    'manager.surveys': {
        primary: 'btn-mgr-survey-new',
        actions: [],
    },

    'manager.evaluations': {
        primary: 'btn-mgr-evaluation-new',
        actions: [],
    },

    'manager.operations': {
        primary: 'btn-mgr-staff-add',
        actions: ['btn-mgr-audit-attendance', 'btn-mgr-approve-billing'],
    },

    // ── Coordinator Pages ────────────────────────────────────────────────────

    'coordinator.dashboard': {
        primary: 'btn-coord-dispatch-center',
        actions: [
            'btn-coord-sos-center',
            'btn-coord-optimize',
            'btn-coord-broadcast-shift',
            'btn-coord-match-run',
            'btn-coord-waitlist-sync',
            'btn-coord-shift-triage',
        ],
    },

    'coordinator.sos': {
        primary: 'btn-coord-sos-ack-v2',
        actions: ['btn-coord-sos-dispatch', 'btn-coord-sos-resolved'],
    },

    // ── PSW Pages ────────────────────────────────────────────────────────────

    'psw.dashboard': {
        primary: 'btn-psw-view-schedule',
        actions: ['btn-psw-live-visit', 'btn-psw-wellness-pulse', 'btn-psw-clock-in'],
    },

    'psw.schedule': {
        primary: 'btn-psw-check-in',
        actions: ['btn-psw-check-out', 'btn-psw-offer-accept', 'btn-psw-offer-decline'],
    },

    'psw.live-visit': {
        primary: 'btn-psw-check-in',
        actions: ['btn-psw-check-out', 'btn-psw-daily-entry', 'btn-psw-handover-submit', 'btn-psw-incident-report'],
    },

    'psw.earnings': {
        primary: 'btn-psw-payout-sync',
        actions: [],
    },

    // ── RN Pages ─────────────────────────────────────────────────────────────

    'rn.dashboard': {
        primary: 'btn-rn-new-assessment',
        actions: ['btn-rn-audit-sign-off', 'btn-rn-recon-sync', 'btn-rn-supervision-log'],
    },

    'rn.care-plans': {
        primary: 'btn-rn-careplan-save',
        actions: ['btn-rn-careplan-verify'],
    },

    'rn.assessments': {
        primary: 'btn-rn-assess-start-adl',
        actions: ['btn-rn-assess-start-mobility', 'btn-rn-assess-start-mental', 'btn-rn-assess-submit'],
    },

    'rn.daily-audit': {
        primary: 'btn-rn-entry-verify',
        actions: ['btn-rn-daily-review'],
    },

    // ── Client Pages ─────────────────────────────────────────────────────────

    'client.dashboard': {
        primary: 'btn-client-request-care',
        actions: ['btn-client-family-hub', 'btn-client-support-chat', 'btn-client-view-careplan'],
    },

    'client.bookings': {
        primary: 'btn-client-booking-request',
        actions: ['btn-client-visit-cancel'],
    },

    'client.billing': {
        primary: 'btn-client-pay-invoice',
        actions: [],
    },

    'client.feedback': {
        primary: 'btn-client-star-rating',
        actions: [],
    },

    // ── Staff Pages ──────────────────────────────────────────────────────────

    'staff.dashboard': {
        primary: 'btn-staff-task-add',
        actions: ['btn-staff-compliance-scan'],
    },

    // ── Allied Health ────────────────────────────────────────────────────────

    'allied.dashboard': {
        primary: 'btn-allied-sign-visit',
        actions: [],
    },
};
