// Governance - Category: service | Purpose: ── Type-Safe BTN Constants ────────────────────────────────────────────────── Auto-generated from ButtonRegistry. Use...
// ── Type-Safe BTN Constants ──────────────────────────────────────────────────
// Auto-generated from ButtonRegistry. Use for compile-time safety + IDE autocomplete.
// Usage: getButtonById(BTN.PSW_CHECK_IN) instead of getButtonById('btn-psw-check-in')

export const BTN = {
    // Admin
    ADMIN_USER_INVITE: 'btn-admin-user-invite',
    ADMIN_REPORT_EXPORT: 'btn-admin-report-export',
    ADMIN_SETTINGS_SAVE: 'btn-admin-settings-save',
    ADMIN_CONTENT_PUBLISH: 'btn-admin-content-publish',
    ADMIN_SEARCH_REINDEX: 'btn-admin-search-reindex',
    ADMIN_UI_OVERRIDE: 'btn-admin-ui-override',
    // Scrum Master
    SM_AUTO_FIX: 'btn-sm-auto-fix',
    SM_FLUSH_AUDITS: 'btn-sm-flush-audits',
    SM_DB_RESEED: 'btn-sm-db-reseed',
    SM_UNIVERSAL_SWEEP: 'btn-sm-universal-sweep',
    SM_BUILD_DEPLOY: 'btn-sm-build-deploy',
    SM_SCAN_SECURITY: 'btn-sm-scan-security',
    SM_SUMMARY_REGISTRY: 'btn-sm-summary-registry',
    // Manager
    MGR_PAYROLL_VERIFY: 'btn-mgr-payroll-verify',
    MGR_TRAINING_CREATE: 'btn-mgr-training-create',
    MGR_SURVEY_NEW: 'btn-mgr-survey-new',
    MGR_EVALUATION_NEW: 'btn-mgr-evaluation-new',
    MGR_OPS_STATS: 'btn-mgr-ops-stats',
    MGR_COMPLIANCE_SYNC: 'btn-mgr-compliance-sync',
    MGR_FEEDBACK_TRIAGE: 'btn-mgr-feedback-triage',
    MGR_STAFF_ADD: 'btn-mgr-staff-add',
    MGR_AUDIT_ATTENDANCE: 'btn-mgr-audit-attendance',
    MGR_APPROVE_BILLING: 'btn-mgr-approve-billing',
    // Coordinator
    COORD_SOS_ACK: 'btn-coord-sos-ack',
    COORD_SOS_DISPATCH: 'btn-coord-sos-dispatch',
    COORD_OPTIMIZE: 'btn-coord-optimize',
    COORD_DISPATCH_CENTER: 'btn-coord-dispatch-center',
    COORD_SOS_CENTER: 'btn-coord-sos-center',
    COORD_MATCH_OVERRIDE: 'btn-coord-match-override',
    COORD_WAITLIST_SYNC: 'btn-coord-waitlist-sync',
    COORD_SOS_ACK_V2: 'btn-coord-sos-ack-v2',
    COORD_BROADCAST_SHIFT: 'btn-coord-broadcast-shift',
    COORD_MATCH_RUN: 'btn-coord-match-run',
    COORD_SHIFT_TRIAGE: 'btn-coord-shift-triage',
    COORD_GPS_PING: 'btn-coord-gps-ping',
    COORD_SOS_RESOLVED: 'btn-coord-sos-resolved',
    // PSW
    PSW_CHECK_IN: 'btn-psw-check-in',
    PSW_CHECK_OUT: 'btn-psw-check-out',
    PSW_HANDOVER_SUBMIT: 'btn-psw-handover-submit',
    PSW_AVAILABILITY_SYNC: 'btn-psw-availability-sync',
    PSW_PAYOUT_SYNC: 'btn-psw-payout-sync',
    PSW_VIEW_SCHEDULE: 'btn-psw-view-schedule',
    PSW_LIVE_VISIT: 'btn-psw-live-visit',
    PSW_DAILY_ENTRY: 'btn-psw-daily-entry',
    PSW_WELLNESS_PULSE: 'btn-psw-wellness-pulse',
    PSW_OFFER_ACCEPT: 'btn-psw-offer-accept',
    PSW_OFFER_DECLINE: 'btn-psw-offer-decline',
    PSW_INCIDENT_REPORT: 'btn-psw-incident-report',
    PSW_CLOCK_IN: 'btn-psw-clock-in',
    PSW_CLOCK_OUT: 'btn-psw-clock-out',
    // RN
    RN_ENTRY_VERIFY: 'btn-rn-entry-verify',
    RN_NEW_ASSESSMENT: 'btn-rn-new-assessment',
    RN_ASSESS_START_ADL: 'btn-rn-assess-start-adl',
    RN_ASSESS_START_MOBILITY: 'btn-rn-assess-start-mobility',
    RN_ASSESS_START_MENTAL: 'btn-rn-assess-start-mental',
    RN_ASSESS_SUBMIT: 'btn-rn-assess-submit',
    RN_RECON_SYNC: 'btn-rn-recon-sync',
    RN_CAREPLAN_SAVE: 'btn-rn-careplan-save',
    RN_SUPERVISION_LOG: 'btn-rn-supervision-log',
    RN_AUDIT_SIGN_OFF: 'btn-rn-audit-sign-off',
    RN_DAILY_REVIEW: 'btn-rn-daily-review',
    RN_CAREPLAN_VERIFY: 'btn-rn-careplan-verify',
    RN_SIGN_OFF: 'btn-rn-sign-off',
    // Client
    CLIENT_REQUEST_CARE: 'btn-client-request-care',
    CLIENT_PAY_INVOICE: 'btn-client-pay-invoice',
    CLIENT_FAMILY_PAY: 'btn-client-family-pay',
    CLIENT_STAR_RATING: 'btn-client-star-rating',
    CLIENT_SUPPORT_CHAT: 'btn-client-support-chat',
    CLIENT_VIEW_CAREPLAN: 'btn-client-view-careplan',
    CLIENT_FAMILY_HUB: 'btn-client-family-hub',
    CLIENT_BOOKING_REQUEST: 'btn-client-booking-request',
    CLIENT_VISIT_CANCEL: 'btn-client-visit-cancel',
    // Staff
    STAFF_TASK_ADD: 'btn-staff-task-add',
    STAFF_COMPLIANCE_SCAN: 'btn-staff-compliance-scan',
    // Allied
    ALLIED_SIGN_VISIT: 'btn-allied-sign-visit',
    // Superuser
    SUPERUSER_TENANT_NEW: 'btn-superuser-tenant-new',
    SUPERUSER_RISK_SCAN: 'btn-superuser-risk-scan',
    SUP_HEALTH_REFRESH: 'btn-sup-health-refresh',
    SUP_POLICY_PUSH: 'btn-sup-policy-push',
    // Operations
    ADM_ADMISSION_NEW: 'btn-adm-admission-new',
    ADM_AUTOMATION_TRIGGER: 'btn-adm-automation-trigger',
    ADM_LEADS_CONVERT: 'btn-adm-leads-convert',
    ADM_SCHEDULE_OPTIMIZE: 'btn-adm-schedule-optimize',
    ADM_BILLING_FINALIZE: 'btn-adm-billing-finalize',
    ADM_OPS_OPTIMIZE: 'btn-adm-ops-optimize',
    ADM_REGION_NEW: 'btn-adm-region-new',
    ADM_FHIR_EXPORT: 'btn-adm-fhir-export',
    // Marketing
    MKT_CAMPAIGN_NEW: 'btn-mkt-campaign-new',
    MKT_CRM_EXPORT: 'btn-mkt-crm-export',
    // HR
    HR_POST_ROLE: 'btn-hr-post-role',
    // Security
    SEC_THREAT_SCAN: 'btn-sec-threat-scan',
    SEC_SESSION_FLUSH: 'btn-sec-session-flush',
    // AI
    AI_INSIGHTS_REFRESH: 'btn-ai-insights-refresh',
    AI_AUTOPILOT_ENGAGE: 'btn-ai-autopilot-engage',
    // ERP
    ERP_INVENTORY_ADD: 'btn-erp-inventory-add',
    ERP_PO_CREATE: 'btn-erp-po-create',
    // Telehealth
    TELEHEALTH_SESSION_START: 'btn-telehealth-session-start',
    RPM_VITALS_VERIFY: 'btn-rpm-vitals-verify',
    // RCM
    RCM_CLAIM_SUBMIT: 'btn-rcm-claim-submit',
    RCM_REVENUE_SYNC: 'btn-rcm-revenue-sync',
    // Pharmacy
    PHARMACY_ORDER: 'btn-pharmacy-order',
    PHARMACY_MAR_SYNC: 'btn-pharmacy-mar-sync',
    // Reseller
    RESELLER_PROVISION: 'btn-reseller-provision',
    RESELLER_SUSPEND: 'btn-reseller-suspend',
    // Regional Director
    RD_OPS_STATS: 'btn-rd-ops-stats',
    RD_PL_EXPORT: 'btn-rd-pl-export',
    RD_AUDIT_REQ: 'btn-rd-audit-req',
    // Sovereign
    WALLET_DID_VERIFY: 'btn-wallet-did-verify',
    // Auth
    AUTH_OSM_LOGIN: 'btn-auth-osm-login',
} as const;

/** Union type of all valid button IDs */
export type ButtonId = typeof BTN[keyof typeof BTN];

/**
 * Maps MASTER_REGISTRY page codes (D1, F1, H18…) to PageActionRegistry IDs.
 * Use with ButtonsByPage: `ButtonsByPage[PAGE_CODE_TO_ID['D1']]`
 */
export const PAGE_CODE_TO_ID: Record<string, string> = {
    D1:  'admin.home',      D2:  'admin.summary',
    D7:  'manager.home',    D14: 'psw.home',
    D15: 'rn.home',         D8:  'client.home',
    D19: 'staff.home',      D18: 'allied.home',
    H18: 'coordinator.home', T39: 'coordinator.sos',
    H11: 'manager.training',     T22: 'manager.surveys',
    L13: 'manager.evaluations',  H12: 'manager.operations',
    L16: 'psw.schedule',         T61: 'psw.live-visit',
    R3:  'psw.earnings',
    T29: 'rn.care-plans',       L18: 'rn.assessments',
    T30: 'rn.daily-audit',
    L14: 'client.bookings',     H10: 'client.billing',
    F16: 'client.feedback',
    L3a: 'admin.users',         L3: 'admin.leads',
    L1:  'admin.schedule',      L5: 'admin.services',
    L2:  'admin.incidents',     L4: 'admin.timesheets',
    R1:  'admin.reports',       T10: 'admin.security',
    D3:  'admin.finance',       D5: 'admin.ai',
    H4:  'admin.erp',           H1: 'admin.telehealth',
    H2:  'admin.pharmacy',
    'D-SU':  'superuser.home',
    'D-SM':  'scrum-master.home',
};
