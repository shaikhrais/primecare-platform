import { ApiRegistry } from './ApiRegistry';

// ── Types ────────────────────────────────────────────────────────────────────

export interface ButtonDef {
    id: string;
    label: string;
    role: string;
    module: string;
    type: 'primary' | 'secondary' | 'ghost' | 'danger';
    action: string;
    description: string;
    apiPath?: string;
    /** RouteRegistry key for UI_NAVIGATION buttons (dot-path like 'ADMIN.USERS_NEW') */
    routeKey?: string;
    /** Route parameter names this button's route requires (e.g. [':id']) */
    routeParams?: string[];
}

// ── Constants — eliminate string repetition ──────────────────────────────────

const R = {  // Roles
    ADM: 'admin', MGR: 'manager', COORD: 'coordinator', PSW: 'psw', RN: 'rn',
    CLIENT: 'client', STAFF: 'staff', SM: 'scrum_master', SU: 'super_admin',
    RES: 'reseller', MKT: 'marketing_manager', HR: 'hr_manager', 
    BILLING: 'billing_manager', OPS: 'operations_manager', RMT: 'rmt',
    RD: 'regional_manager', PUB: 'public',
} as const;

const M = {  // Modules
    ADM: 'ADMIN', OPS: 'OPERATIONS', CARE: 'CARE_DELIVERY', CLIN: 'CLINICAL',
    FIN: 'FINANCE', GOV: 'GOVERNANCE', PLAT: 'PLATFORM', MKT: 'MARKETING',
    HR: 'HR', SEC: 'SECURITY', ERP: 'ERP', TELE: 'TELEHEALTH', PHARM: 'PHARMACY',
    AI: 'AI', AUTO: 'AUTOMATION', INTEROP: 'INTEROP', SOV: 'SOVEREIGN',
    LEADS: 'LEADS', SCHED: 'SCHEDULE', INV: 'INVOICES', ADM_MISSION: 'ADMISSION',
    BUILDS: 'BUILDS', SCANS: 'SCANS', FRAN: 'FRANCHISE', CLIENT: 'CLIENT',
    SUPER: 'SUPERVISION',
} as const;

const A = {  // Actions
    API: 'API_TRIGGER', NAV: 'UI_NAVIGATION', MODAL: 'OPEN_MODAL',
    SIG: 'API_SIGNATURE', GEO: 'GEOLOCATION_STAMP', DISPATCH: 'API_DISPATCH',
    CI: 'CI_TRIGGER',
} as const;

const T = { P: 'primary', S: 'secondary', G: 'ghost', D: 'danger' } as const;

// ── Factory ── reduce boilerplate per entry ──────────────────────────────────

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

// ── Registry ─────────────────────────────────────────────────────────────────

export const ButtonRegistry: ButtonDef[] = [

    // ── Admin ────────────────────────────────────────────────────────────────
    btn('btn-admin-user-invite',      'Invite User',              R.ADM, M.ADM,  T.P, A.MODAL, 'Triggers the global user invitation dialog.'),
    btn('btn-admin-report-export',    'Generate Global Export',   R.ADM, M.ADM,  T.S, A.API,   'Triggers a full-platform data export for auditing.', { api: ApiRegistry.ADMIN.REPORTS }),
    btn('btn-admin-settings-save',    'Commit Platform Specs',    R.ADM, M.ADM,  T.P, A.API,   'Saves platform-wide business configuration to the core ledger.', { api: ApiRegistry.ADMIN.SETTINGS_COMMIT }),
    btn('btn-admin-content-publish',  'Publish UI Updates',       R.ADM, M.ADM,  T.P, A.API,   'Pushes all local content registry changes to production.', { api: ApiRegistry.ADMIN.CONTENT_PUBLISH }),
    btn('btn-admin-search-reindex',   'Rebuild Search Index',     R.ADM, M.ADM,  T.S, A.API,   'Triggers a full-platform search index reconstruction.', { api: ApiRegistry.ADMIN.SEARCH_REINDEX }),
    btn('btn-admin-ui-override',      'Commit UI Overrides',      R.ADM, M.GOV,  T.P, A.API,   'Finalizes and deploys all local text and label overrides to production.', { api: ApiRegistry.PLATFORM.ADMIN.UI_OVERRIDE_COMMIT }),

    // ── Scrum Master ─────────────────────────────────────────────────────────
    btn('btn-sm-auto-fix',            'Launch Auto-Fixer',        R.SM, M.GOV,    T.P, A.API,   'Executes the autonomous registry repair engine.', { api: ApiRegistry.SCRUM_MASTER.AUTO_FIX }),
    btn('btn-sm-flush-audits',        'Flush Forensic Logs',      R.SM, M.GOV,    T.D, A.API,   'Purges historical forensic logs based on retention policy.', { api: ApiRegistry.SCRUM_MASTER.LOG_FLUSH }),
    btn('btn-sm-db-reseed',           'Execute QA Re-seed',       R.SM, M.GOV,    T.S, A.API,   'Triggers the autonomous 7-week QA data generation engine.', { api: ApiRegistry.SCRUM_MASTER.DB_RESEED }),
    btn('btn-sm-universal-sweep',     'Start Universal Sweep',    R.SM, M.GOV,    T.P, A.API,   'Triggers the Response Bot for a platform-wide heartbeat check.', { api: ApiRegistry.SCRUM_MASTER.UNIVERSAL_SWEEP }),
    btn('btn-sm-build-deploy',        'Deploy Staging',           R.SM, M.BUILDS, T.P, A.CI,    'Triggers a manual CI/CD deployment.'),
    btn('btn-sm-scan-security',       'Full Security Scan',       R.SM, M.SCANS,  T.D, A.API,   'Triggers a platform-wide vulnerability audit.', { api: ApiRegistry.PLATFORM.SCRUM_MASTER.SECURITY_SCAN }),
    btn('btn-sm-summary-registry',    'Registry Intelligence Hub',R.SM, M.GOV,    T.P, A.NAV,   'Accesses the consolidated platform KPIs and registry-driven insights.'),

    // ── Manager ──────────────────────────────────────────────────────────────
    btn('btn-mgr-payroll-verify',     'Verify Weekly Payroll',    R.MGR, M.OPS,  T.P, A.API,   'Finalizes and locks the regional payroll records.', { api: ApiRegistry.TENANCY.MANAGER.PAYROLL_AUDIT }),
    btn('btn-mgr-training-create',    'Create Training Module',   R.MGR, M.OPS,  T.P, A.MODAL, 'Initializes a new clinical training module.'),
    btn('btn-mgr-survey-new',         'New Satisfaction Survey',  R.MGR, M.OPS,  T.P, A.MODAL, 'Launches a new survey for staff or clients.'),
    btn('btn-mgr-evaluation-new',     'New Performance Eval',     R.MGR, M.OPS,  T.P, A.MODAL, 'Starts a staff performance review process.'),
    btn('btn-mgr-ops-stats',          'Refresh Ops Stats',        R.MGR, M.OPS,  T.S, A.API,   'Triggers a recalculation of regional operational metrics.', { api: ApiRegistry.TENANCY.MANAGER.OPS_STATS }),
    btn('btn-mgr-compliance-sync',    'Sync Branch Compliance',   R.MGR, M.OPS,  T.P, A.API,   'Executes a branch-wide compliance synchronization audit.', { api: ApiRegistry.TENANCY.MANAGER.COMPLIANCE_SYNC }),
    btn('btn-mgr-feedback-triage',    'Triage Feedback',          R.MGR, M.OPS,  T.P, A.MODAL, 'Launches the feedback triage interface for operational resolution.'),
    btn('btn-mgr-staff-add',          'Add New Staff',            R.MGR, M.OPS,  T.P, A.MODAL, 'Initializes the staff onboarding and profile creation flow.', { api: ApiRegistry.TENANCY.MANAGER.STAFF_ADD }),
    btn('btn-mgr-audit-attendance',   'Audit Attendance',         R.MGR, M.OPS,  T.S, A.API,   'Triggers a branch-wide audit of staff clock-in compliance.', { api: ApiRegistry.TENANCY.MANAGER.AUDIT_ATTENDANCE }),
    btn('btn-mgr-approve-billing',    'Approve Branch Billing',   R.MGR, M.FIN,  T.P, A.API,   'Formal manager approval of all pending branch invoices.', { api: '/v1/manager/billing/batch-approve' }),

    // ── Coordinator ──────────────────────────────────────────────────────────
    btn('btn-coord-sos-ack',          'Respond to SOS',           R.COORD, M.OPS, T.D, A.DISPATCH, 'Immediate coordinator acknowledgement of a field SOS.', { api: ApiRegistry.TENANCY.COORDINATOR.SOS_DISPATCH }),
    btn('btn-coord-sos-dispatch',     'Dispatch Hero',            R.COORD, M.OPS, T.P, A.MODAL, 'Emergency dispatch for SOS alerts.'),
    btn('btn-coord-optimize',         'Optimize Routes',          R.COORD, M.OPS, T.S, A.API,   'Runs AI route optimization for the current shift.', { api: ApiRegistry.PLATFORM.ADMIN.OPERATIONS.OPTIMIZE_LOGISTICS }),
    btn('btn-coord-dispatch-center',  'Enter Dispatch Center',    R.COORD, M.OPS, T.P, A.NAV,   'Opens the real-time coordinator dispatch hub.', { routeKey: 'COORDINATOR.HUB' }),
    btn('btn-coord-sos-center',       'Open SOS Center',          R.COORD, M.OPS, T.D, A.NAV,   'Opens the emergency SOS response center.', { routeKey: 'COORDINATOR.SOS' }),
    btn('btn-coord-match-override',   'Override PSW Match',       R.COORD, M.OPS, T.P, A.API,   'Manually override a PSW assignment for a specific visit.', { api: ApiRegistry.TENANCY.COORDINATOR.MATCH_OVERRIDE }),
    btn('btn-coord-waitlist-sync',    'Sync Waitlist',            R.COORD, M.OPS, T.S, A.API,   'Synchronize waitlist priorities for client inflow.', { api: ApiRegistry.TENANCY.COORDINATOR.WAITLIST_SYNC }),
    btn('btn-coord-sos-ack-v2',       'Acknowledge SOS',          R.COORD, M.OPS, T.D, A.API,   'Formal coordinator acknowledgement of an SOS alert.', { api: ApiRegistry.TENANCY.COORDINATOR.SOS_ACK }),
    btn('btn-coord-broadcast-shift',  'Broadcast Shift Offer',    R.COORD, M.OPS, T.P, A.API,   'Simultaneously offer a shift to multiple qualified caregivers.', { api: ApiRegistry.TENANCY.COORDINATOR.SHIFT_BROADCAST }),
    btn('btn-coord-match-run',        'Run AI Matching',          R.COORD, M.OPS, T.S, A.API,   'Triggers the AI engine to propose best-fit caregivers for open visits.', { api: ApiRegistry.TENANCY.COORDINATOR.MATCHING_RUN }),
    btn('btn-coord-shift-triage',     'Triage Alerts',            R.COORD, M.OPS, T.D, A.NAV,   'Navigates to the real-time shift triage and no-show buffer.', { api: ApiRegistry.TENANCY.COORDINATOR.SHIFT_TRIAGE }),
    btn('btn-coord-gps-ping',         'Ping Location',            R.COORD, M.OPS, T.G, A.API,   'Requests a manual location refresh from a caregiver\'s mobile device.', { api: ApiRegistry.TENANCY.COORDINATOR.GPS_PING(':id'), routeParams: [':id'] }),
    btn('btn-coord-sos-resolved',     'Resolve SOS',              R.COORD, M.OPS, T.P, A.API,   'Final resolution step for coordinator SOS management.', { api: ApiRegistry.TENANCY.COORDINATOR.SOS_ACK }),

    // ── PSW ──────────────────────────────────────────────────────────────────
    btn('btn-psw-check-in',           'Check-in Now',             R.PSW, M.CARE, T.P, A.GEO,   'Geofenced visit start for PSWs.', { api: ApiRegistry.TENANCY.PSW.CHECK_IN(':id'), routeParams: [':id'] }),
    btn('btn-psw-check-out',          'Complete Visit',           R.PSW, M.CARE, T.S, A.GEO,   'Finalizes a patient visit with a timestamp.', { api: ApiRegistry.TENANCY.PSW.CHECK_OUT(':id'), routeParams: [':id'] }),
    btn('btn-psw-handover-submit',    'Complete Handover',        R.PSW, M.CARE, T.P, A.API,   'Submit shift handover notes for the next provider.', { api: ApiRegistry.TENANCY.PSW.HANDOVER_SUBMIT }),
    btn('btn-psw-availability-sync',  'Sync Availability',        R.PSW, M.CARE, T.P, A.API,   'Synchronize date-specific availability overrides to the ledger.', { api: ApiRegistry.TENANCY.PSW.AVAILABILITY_SYNC }),
    btn('btn-psw-payout-sync',        'Sync to Bank',             R.PSW, M.FIN,  T.P, A.API,   'Request earnings payout to verified bank account.', { api: ApiRegistry.TENANCY.PSW.PAYOUT_HISTORY }),
    btn('btn-psw-view-schedule',      'View Today\'s Schedule',   R.PSW, M.CARE, T.P, A.NAV,   'Navigates to the current shift schedule.', { routeKey: 'PSW.SCHEDULE' }),
    btn('btn-psw-live-visit',         'Enter Visit Center',       R.PSW, M.CARE, T.P, A.NAV,   'Opens the live visit management center.', { routeKey: 'PSW.LIVE_VISIT' }),
    btn('btn-psw-daily-entry',        'Track ADLs',               R.PSW, M.CARE, T.S, A.API,   'Triggers the ADL/Clinical daily entry submission.', { api: ApiRegistry.TENANCY.PSW.DAILY_ENTRY_SUBMIT }),
    btn('btn-psw-wellness-pulse',     'Report Status',            R.PSW, M.CARE, T.G, A.MODAL, 'Allows PSWs to report their daily sentiment and wellbeing.', { api: ApiRegistry.TENANCY.PSW.WELLNESS_PULSE }),
    btn('btn-psw-offer-accept',       'Accept Offer',             R.PSW, M.CARE, T.P, A.API,   'Formal acceptance of an open shift offer.', { api: ApiRegistry.TENANCY.PSW.OFFER_ACCEPT(':id'), routeParams: [':id'] }),
    btn('btn-psw-offer-decline',      'Decline Offer',            R.PSW, M.CARE, T.S, A.API,   'Decline an open shift offer.', { api: ApiRegistry.TENANCY.PSW.OFFER_DECLINE(':id'), routeParams: [':id'] }),
    btn('btn-psw-incident-report',    'Report Incident',          R.PSW, M.CARE, T.D, A.MODAL, 'Launches the emergency incident reporting wizard for field visits.', { api: ApiRegistry.TENANCY.PSW.INCIDENT_REPORT }),
    btn('btn-psw-clock-in',           'Clock In',                 R.PSW, M.CARE, T.P, A.GEO,   'Day-to-day clock-in for field caregivers.', { api: ApiRegistry.TENANCY.PSW.CHECK_IN(':id'), routeParams: [':id'] }),
    btn('btn-psw-clock-out',          'Clock Out',                R.PSW, M.CARE, T.S, A.GEO,   'Day-to-day clock-out for field caregivers.', { api: ApiRegistry.TENANCY.PSW.CHECK_OUT(':id'), routeParams: [':id'] }),

    // ── RN ───────────────────────────────────────────────────────────────────
    btn('btn-rn-entry-verify',        'Sign & Verify Entry',      R.RN, M.CLIN, T.P, A.SIG,   'RN clinical verification of a visit daily entry.', { api: ApiRegistry.TENANCY.RN.DAILY_REVIEW(':id'), routeParams: [':id'] }),
    btn('btn-rn-new-assessment',      'Start New Assessment',     R.RN, M.CLIN, T.P, A.MODAL, 'Opens the clinical assessment entry wizard.'),
    btn('btn-rn-assess-start-adl',    'Start ADL Audit',          R.RN, M.CLIN, T.P, A.NAV,   'Initializes a new ADL assessment flow.'),
    btn('btn-rn-assess-start-mobility','Start Mobility Audit',    R.RN, M.CLIN, T.S, A.NAV,   'Initializes a new Mobility/Fall Risk audit.'),
    btn('btn-rn-assess-start-mental', 'Start Cognitive Audit',    R.RN, M.CLIN, T.S, A.NAV,   'Initializes a new Mental Health/Cognitive mapping.'),
    btn('btn-rn-assess-submit',       'Sign & Lock Assessment',   R.RN, M.CLIN, T.P, A.API,   'Finalizes a structured clinical assessment.', { api: ApiRegistry.TENANCY.RN.CLINICAL_ASSESS }),
    btn('btn-rn-recon-sync',          'Sync Medication Ledger',   R.RN, M.CLIN, T.P, A.API,   'Triggers a real-time medication reconciliation sync.', { api: ApiRegistry.TENANCY.RN.RECON_SYNC }),
    btn('btn-rn-careplan-save',       'Finalize Care Plan',       R.RN, M.CLIN, T.P, A.API,   'Commits the structured care plan to the clinical ledger.', { api: ApiRegistry.TENANCY.RN.CARE_PLANS }),
    btn('btn-rn-supervision-log',     'Log Supervision Session',  R.RN, M.SUPER, T.P, A.API,  'Records a PSW supervision and competency check.', { api: ApiRegistry.TENANCY.RN.RN_SUPERVISION }),
    btn('btn-rn-audit-sign-off',      'Clinical Sign-off',        R.RN, M.CLIN, T.P, A.SIG,   'RN professional sign-off for clinical visit accuracy.', { api: ApiRegistry.TENANCY.RN.DAILY_AUDIT_SIGN_OFF }),
    btn('btn-rn-daily-review',        'Verify Entry',             R.RN, M.CLIN, T.P, A.SIG,   'RN verification of a daily clinical entry.', { api: ApiRegistry.TENANCY.RN.DAILY_REVIEW(':id'), routeParams: [':id'] }),
    btn('btn-rn-careplan-verify',     'Verify Care Plan',         R.RN, M.CLIN, T.P, A.SIG,   'RN professional verification and locking of a client care plan.', { api: ApiRegistry.TENANCY.RN.CAREPLAN_VERIFY(':id'), routeParams: [':id'] }),
    btn('btn-rn-sign-off',            'Approve Visit',            R.RN, M.CLIN, T.P, A.SIG,   'RN clinical sign-off for a completed visit.', { api: ApiRegistry.TENANCY.RN.DAILY_AUDIT_SIGN_OFF }),

    // ── Client ───────────────────────────────────────────────────────────────
    btn('btn-client-request-care',    'Book New Service',          R.CLIENT, M.CLIENT, T.P, A.NAV,   'Triggers the service booking flow.', { routeKey: 'CLIENT.REQUEST_BOOKING' }),
    btn('btn-client-pay-invoice',     'Pay Invoice',              R.CLIENT, M.CLIENT, T.P, A.API,   'Direct payment for outstanding invoices.', { api: ApiRegistry.TENANCY.CLIENT.INVOICE_PAY }),
    btn('btn-client-family-pay',      'Pay Invoice',              R.CLIENT, M.CLIENT, T.P, A.API,   'Initiate payment for care services.', { api: ApiRegistry.TENANCY.CLIENT.INVOICE_PAY }),
    btn('btn-client-star-rating',     'Submit Rating',            R.CLIENT, M.CLIENT, T.P, A.API,   'Submit star rating and comments for a care visit.', { api: ApiRegistry.TENANCY.CLIENT.FEEDBACK_SUBMIT }),
    btn('btn-client-support-chat',    'Chat with Nursing',        R.CLIENT, M.CLIENT, T.S, A.NAV,   'Direct real-time communication line to the clinical support team.', { api: ApiRegistry.TENANCY.CLIENT.SUPPORT }),
    btn('btn-client-view-careplan',   'Review Care Plan',         R.CLIENT, M.CLIENT, T.G, A.NAV,   'Provides look-only transparency into the active clinical care plan.'),
    btn('btn-client-family-hub',      'Enter Family Hub',         R.CLIENT, M.CLIENT, T.P, A.NAV,   'Opens the family engagement and care coordination center.', { routeKey: 'CLIENT.FAMILY_HUB' }),
    btn('btn-client-booking-request', 'Submit Service Request',   R.CLIENT, M.CLIENT, T.P, A.API,   'Submits a new service request for coordinator approval.', { api: ApiRegistry.CLIENT.BOOKING_REQUESTS }),
    btn('btn-client-visit-cancel',    'Cancel Request',           R.CLIENT, M.CLIENT, T.D, A.API,   'Initiates a cancellation request for a scheduled care visit.', { api: ApiRegistry.TENANCY.CLIENT.BOOKING_CANCEL(':id'), routeParams: [':id'] }),

    // ── Staff ────────────────────────────────────────────────────────────────
    btn('btn-staff-task-add',         'Create New Task',           R.STAFF, M.OPS, T.P, A.NAV,   'Opens the task creation interface for staff.', { routeKey: 'STAFF.TASKS' }),
    btn('btn-staff-compliance-scan',  'Run Compliance Scan',       R.STAFF, M.OPS, T.S, A.API,   'Triggers a branch-wide compliance health check.', { api: ApiRegistry.TENANCY.STAFF.COMPLIANCE_SCAN }),

    // ── Allied Health ────────────────────────────────────────────────────────
    btn('btn-allied-sign-visit',      'Sign Clinical Note',        R.RMT, M.CLIN, T.P, A.SIG,   'Clinical sign-off for Allied Health professionals.'),

    // ── Superuser ────────────────────────────────────────────────────────────
    btn('btn-superuser-tenant-new',   'Provision New Tenant',      R.SU, M.PLAT, T.P, A.MODAL, 'Initializes a new multi-tenant environment.', { routeKey: 'SUPERUSER.TENANTS' }),
    btn('btn-superuser-risk-scan',    'Run Risk Surveillance',     R.SU, M.PLAT, T.D, A.API,   'Triggers platform-wide anomaly detection.', { api: ApiRegistry.PLATFORM.SUPERUSER.RISK_SCAN }),
    btn('btn-sup-health-refresh',     'Refresh Global Health',     R.SU, M.GOV,  T.P, A.API,   'Triggers a platform-wide infrastructure health check.', { api: ApiRegistry.PLATFORM.SUPERUSER.PLATFORM_HEALTH }),
    btn('btn-sup-policy-push',        'Deploy System Policy',      R.SU, M.GOV,  T.S, A.API,   'Enforces new core policies across all active tenants.', { api: ApiRegistry.PLATFORM.SUPERUSER.POLICY_ENGINE }),

    // ── Admin Operations ─────────────────────────────────────────────────────
    btn('btn-adm-admission-new',      'New Admission',             R.ADM, M.ADM_MISSION, T.P, A.MODAL, 'Starts the clinical admission intake.'),
    btn('btn-adm-automation-trigger', 'Launch Autopilot',          R.ADM, M.AUTO, T.P, A.API,   'Triggers clinical autopilot routines.', { api: ApiRegistry.PLATFORM.AI.AUTOPILOT_ENGAGE }),
    btn('btn-adm-leads-convert',      'Convert Lead',              R.ADM, M.LEADS,T.P, A.API,   'Converts a business lead to a customer.', { api: ApiRegistry.ADMIN.LEADS_CONVERT(':id'), routeParams: [':id'] }),
    btn('btn-adm-schedule-optimize',  'AI Shift Match',            R.ADM, M.SCHED,T.P, A.API,   'Runs AI matching for unassigned shifts.', { api: ApiRegistry.PLATFORM.AI.AI_OPTIMIZE }),
    btn('btn-adm-billing-finalize',   'Lock Master Ledger',        R.ADM, M.INV,  T.D, A.API,   'Finalizes global billing state.', { api: ApiRegistry.TENANCY.MANAGER.BILLING_FINALIZE }),
    btn('btn-adm-ops-optimize',       'Optimize Logistics',        R.ADM, M.OPS,  T.P, A.API,   'Triggers AI logistics optimization.', { api: ApiRegistry.ADMIN.OPERATIONS.LOGISTICS_HUB }),
    btn('btn-adm-region-new',         'Define New Region',         R.ADM, M.OPS,  T.S, A.MODAL, 'Creates a new operational geographic region.'),
    btn('btn-adm-fhir-export',        'Export FHIR Record',        R.ADM, M.INTEROP,T.P,A.API,   'Generates an HL7 FHIR R4 clinical JSON.', { api: ApiRegistry.PLATFORM.INTEROP.FHIR_EXPORT(':id'), routeParams: [':id'] }),

    // ── Marketing ────────────────────────────────────────────────────────────
    btn('btn-mkt-campaign-new',       'New Campaign',              R.MKT, M.MKT, T.P, A.MODAL, 'Launches the campaign creation wizard.'),
    btn('btn-mkt-crm-export',         'Export CRM Data',           R.MKT, M.MKT, T.S, A.API,   'Exports the current CRM lead pipeline.', { api: ApiRegistry.ADMIN.REPORTS }),
    btn('btn-hr-post-role',           'Post Core Role',            R.HR,  M.HR,  T.P, A.MODAL, 'Initializes a new job posting for recruitment.'),

    // ── Security ─────────────────────────────────────────────────────────────
    btn('btn-sec-threat-scan',        'Scan for Threats',          R.ADM, M.SEC, T.D, A.API,   'Triggers a real-time platform threat detection sweep.', { api: ApiRegistry.PLATFORM.SECURITY.THREAT_DETECTION }),
    btn('btn-sec-session-flush',      'Flush Suspicious Sessions', R.ADM, M.SEC, T.S, A.API,   'Terminates all sessions flagged with anomalous behavior.', { api: ApiRegistry.PLATFORM.SECURITY.SESSIONS }),

    // ── AI ────────────────────────────────────────────────────────────────────
    btn('btn-ai-insights-refresh',    'Recalculate Insights',      R.ADM, M.AI,  T.S, A.API,   'Triggers a full AI analytics refresh.', { api: ApiRegistry.AI.INSIGHTS_REFRESH }),
    btn('btn-ai-autopilot-engage',    'Engage Auto-Pilot',         R.ADM, M.AUTO,T.P, A.API,   'Initializes autonomous shift matchmaking.', { api: ApiRegistry.AI.AUTOPILOT_ENGAGE }),

    // ── ERP ──────────────────────────────────────────────────────────────────
    btn('btn-erp-inventory-add',      'Register Stock Item',       R.ADM, M.ERP, T.P, A.MODAL, 'Adds new inventory unit to the systemic registry.'),
    btn('btn-erp-po-create',          'Generate Purchase Order',   R.OPS, M.ERP, T.P, A.MODAL, 'Initiates procurement request for external suppliers.'),

    // ── Telehealth ───────────────────────────────────────────────────────────
    btn('btn-telehealth-session-start','Start Virtual Visit',      R.RN,    M.TELE, T.P, A.NAV, 'Launches the real-time encrypted video consultation gateway.', { routeKey: 'ADMIN.TELEHEALTH.CENTER', api: ApiRegistry.PLATFORM.ADMIN.TELEHEALTH.CREATE_SESSION }),
    btn('btn-rpm-vitals-verify',      'Verify Remote Vitals',      R.COORD, M.TELE, T.S, A.API, 'Acknowledges and logs incoming remote patient monitoring data.', { api: ApiRegistry.PLATFORM.ADMIN.TELEHEALTH.VITAL_SIGN_PUSH }),

    // ── RCM ──────────────────────────────────────────────────────────────────
    btn('btn-rcm-claim-submit',       'Submit Insurance Claim',    R.BILLING,M.FIN,T.P, A.API,  'Transmits clinical documentation to insurance clearinghouses.', { api: ApiRegistry.PLATFORM.ADMIN.RCM.SUBMIT_CLAIM }),
    btn('btn-rcm-revenue-sync',       'Sync Revenue Ledger',       R.ADM,   M.FIN,T.S, A.API,  'Reconciles bank deposits with adjudicated insurance claims.', { api: ApiRegistry.PLATFORM.ADMIN.RCM.REVENUE_SYNC }),

    // ── Pharmacy ─────────────────────────────────────────────────────────────
    btn('btn-pharmacy-order',         'Order Medication',           R.RN,    M.PHARM,T.P,A.MODAL,'Transmits e-prescription request to integrated pharmacy partner.', { api: ApiRegistry.PLATFORM.ADMIN.PHARMACY.ORDER_DRUGS }),
    btn('btn-pharmacy-mar-sync',      'Sync MAR Records',          R.COORD, M.PHARM,T.S,A.API,  'Synchronizes Medication Administration Records with the clinical ledger.', { api: ApiRegistry.PLATFORM.ADMIN.PHARMACY.MAR_SYNC }),

    // ── Reseller ─────────────────────────────────────────────────────────────
    btn('btn-reseller-provision',     'Spawn Child Agency',         R.RES, M.FRAN, T.P, A.MODAL, 'Initializes a new white-label agency under the reseller.', { api: ApiRegistry.PLATFORM.ADMIN.RESELLER.PROVISION }),
    btn('btn-reseller-suspend',       'Suspend Franchise',         R.RES, M.FRAN, T.D, A.API,   'Temporarily revokes access for a child agency.', { api: ApiRegistry.PLATFORM.ADMIN.RESELLER.SUSPEND(':id'), routeParams: [':id'] }),

    // ── Regional Director ────────────────────────────────────────────────────
    btn('btn-rd-ops-stats',           'Refresh Regional Stats',    R.RD, M.OPS,  T.S, A.API,   'Triggers a recalculation of regional operational metrics.', { api: ApiRegistry.TENANCY.MANAGER.OPS_STATS }),
    btn('btn-rd-pl-export',           'Regional P&L Export',       R.RD, M.FIN,  T.S, A.API,   'Exports regional financial performance data.', { api: ApiRegistry.PLATFORM.ADMIN.REGIONAL.PL_EXPORT }),
    btn('btn-rd-audit-req',           'Strategic Audit Request',   R.RD, M.GOV,  T.P, A.API,   'Triggers a comprehensive strategic audit of the region.', { api: ApiRegistry.PLATFORM.ADMIN.REGIONAL.AUDIT_REQUEST }),

    // ── Sovereign / Auth ─────────────────────────────────────────────────────
    btn('btn-wallet-did-verify',      'Authorize Secure Access',   R.CLIENT,M.SOV,T.P, A.API,   'Authenticates via Decentralized Identity (DID).', { api: ApiRegistry.PLATFORM.INTEROP.DID_VERIFY }),
    btn('btn-auth-osm-login',         'Sign in with OpenStreetMap',R.PUB, M.ADM,  T.S, A.API,   'Initializes secure identity verification via OpenStreetMap OAuth.', { api: '/v1/auth/osm' }),
];

// ── Derived: ButtonGroups — role → module → buttons ─────────────────────────

type NestedGroups = Record<string, Record<string, ButtonDef[]>>;

function buildButtonGroups(): NestedGroups {
    const groups: NestedGroups = {};
    for (const b of ButtonRegistry) {
        (groups[b.role] ??= {})[b.module] ??= [];
        groups[b.role][b.module].push(b);
    }
    return groups;
}

/** Buttons grouped by role → module. Usage: `ButtonGroups.admin.ADMIN` */
export const ButtonGroups: NestedGroups = buildButtonGroups();

// ── Derived: ButtonsByPage — PageActionRegistry key → buttons ────────────────
// Auto-derived by resolving PageActionRegistry (page.id → btn IDs) into actual
// ButtonDef[] arrays. Keys are PageActionRegistry page IDs like 'admin.dashboard'.

import { PageActionRegistry } from './PageActionRegistry';

function buildButtonsByPage(): Record<string, ButtonDef[]> {
    const idx = new Map(ButtonRegistry.map(b => [b.id, b]));
    const result: Record<string, ButtonDef[]> = {};
    for (const [pageId, pa] of Object.entries(PageActionRegistry)) {
        const btns: ButtonDef[] = [];
        if (pa.primary) { const b = idx.get(pa.primary); if (b) btns.push(b); }
        for (const id of pa.actions) { const b = idx.get(id); if (b) btns.push(b); }
        if (btns.length) result[pageId] = btns;
    }
    return result;
}

/**
 * Page-keyed button map. Keys are PageActionRegistry IDs ('admin.dashboard', 'psw.schedule', etc.)
 *
 * Usage:
 *   ButtonsByPage['admin.dashboard'] → [btn-admin-user-invite, btn-admin-ui-override, ...]
 *   ButtonsByPage['coordinator.dashboard'] → [btn-coord-dispatch-center, ...]
 *   ButtonsByPage['psw.live-visit'] → [btn-psw-check-in, btn-psw-check-out, ...]
 *
 * To look up by MASTER_REGISTRY code (D1, H18…), use PAGE_CODE_TO_ID first:
 *   ButtonsByPage[PAGE_CODE_TO_ID['D1']] → Admin Dashboard buttons
 */
export const ButtonsByPage: Record<string, ButtonDef[]> = buildButtonsByPage();

/**
 * Maps MASTER_REGISTRY page codes (D1, F1, H18…) to PageActionRegistry IDs.
 * Use with ButtonsByPage: `ButtonsByPage[PAGE_CODE_TO_ID['D1']]`
 */
export const PAGE_CODE_TO_ID: Record<string, string> = {
    // Dashboards
    D1:  'admin.dashboard',      D2:  'admin.summary',
    D7:  'manager.dashboard',    D14: 'psw.dashboard',
    D15: 'rn.dashboard',         D8:  'client.dashboard',
    D19: 'staff.dashboard',      D18: 'allied.dashboard',
    // Hubs / Tools / Lists
    H18: 'coordinator.dashboard', T39: 'coordinator.sos',
    H11: 'manager.training',     T22: 'manager.surveys',
    L13: 'manager.evaluations',  H12: 'manager.operations',
    // PSW
    L16: 'psw.schedule',         T61: 'psw.live-visit',
    R3:  'psw.earnings',
    // RN
    T29: 'rn.care-plans',       L18: 'rn.assessments',
    T30: 'rn.daily-audit',
    // Client
    L14: 'client.bookings',     H10: 'client.billing',
    F16: 'client.feedback',
    // Admin sub-pages
    L3a: 'admin.users',         L3: 'admin.leads',
    L1:  'admin.schedule',      L5: 'admin.services',
    L2:  'admin.incidents',     L4: 'admin.timesheets',
    R1:  'admin.reports',       T10: 'admin.security',
    D3:  'admin.finance',       D5: 'admin.ai',
    H4:  'admin.erp',           H1: 'admin.telehealth',
    H2:  'admin.pharmacy',
    // Platform
    'D-SU':  'superuser.dashboard',
    'D-SM':  'scrum-master.dashboard',
};

// ── Lookup Helpers ───────────────────────────────────────────────────────────

/** Get all buttons assigned to a MASTER_REGISTRY page code (D1, F1, T3…) */
export function getButtonsForPage(code: string): ButtonDef[] {
    return ButtonsByPage[code] ?? [];
}

/** Get all buttons belonging to a specific role */
export function getButtonsByRole(role: string): ButtonDef[] {
    return ButtonRegistry.filter(b => b.role === role);
}

/** Get all buttons belonging to a specific module */
export function getButtonsByModule(module: string): ButtonDef[] {
    return ButtonRegistry.filter(b => b.module === module);
}

/** Get a single button by ID */
export function getButtonById(id: string): ButtonDef | undefined {
    return ButtonRegistry.find(b => b.id === id);
}

/** Total button count */
export const BUTTON_REGISTRY_COUNT = ButtonRegistry.length;
