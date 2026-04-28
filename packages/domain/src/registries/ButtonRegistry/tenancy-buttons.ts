import type { ButtonDef } from '../button_registry';
import { ApiRegistry } from '../ApiRegistry';

const R = {
    ADM: 'admin', MGR: 'manager', COORD: 'coordinator', PSW: 'psw', RN: 'rn',
    CLIENT: 'client', STAFF: 'staff', RMT: 'rmt',
} as const;

const M = {
    OPS: 'OPERATIONS', CARE: 'CARE_DELIVERY', CLIN: 'CLINICAL',
    FIN: 'FINANCE', CLIENT: 'CLIENT', SUPER: 'SUPERVISION',
} as const;

const A = {
    API: 'API_TRIGGER', NAV: 'UI_NAVIGATION', MODAL: 'OPEN_MODAL',
    SIG: 'API_SIGNATURE', GEO: 'GEOLOCATION_STAMP', DISPATCH: 'API_DISPATCH',
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

// ── Tenancy Buttons (Manager, Coordinator, PSW, RN, Client, Staff, Allied) ──

export const TENANCY_BUTTONS: ButtonDef[] = [
    // Manager
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
    // Coordinator
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
    // PSW
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
    // RN
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
    // Client
    btn('btn-client-request-care',    'Book New Service',          R.CLIENT, M.CLIENT, T.P, A.NAV,   'Triggers the service booking flow.', { routeKey: 'CLIENT.REQUEST_BOOKING' }),
    btn('btn-client-pay-invoice',     'Pay Invoice',              R.CLIENT, M.CLIENT, T.P, A.API,   'Direct payment for outstanding invoices.', { api: ApiRegistry.TENANCY.CLIENT.INVOICE_PAY }),
    btn('btn-client-family-pay',      'Pay Invoice',              R.CLIENT, M.CLIENT, T.P, A.API,   'Initiate payment for care services.', { api: ApiRegistry.TENANCY.CLIENT.INVOICE_PAY }),
    btn('btn-client-star-rating',     'Submit Rating',            R.CLIENT, M.CLIENT, T.P, A.API,   'Submit star rating and comments for a care visit.', { api: ApiRegistry.TENANCY.CLIENT.FEEDBACK_SUBMIT }),
    btn('btn-client-support-chat',    'Chat with Nursing',        R.CLIENT, M.CLIENT, T.S, A.NAV,   'Direct real-time communication line to the clinical support team.', { api: ApiRegistry.TENANCY.CLIENT.SUPPORT }),
    btn('btn-client-view-careplan',   'Review Care Plan',         R.CLIENT, M.CLIENT, T.G, A.NAV,   'Provides look-only transparency into the active clinical care plan.'),
    btn('btn-client-family-hub',      'Enter Family Hub',         R.CLIENT, M.CLIENT, T.P, A.NAV,   'Opens the family engagement and care coordination center.', { routeKey: 'CLIENT.FAMILY_HUB' }),
    btn('btn-client-booking-request', 'Submit Service Request',   R.CLIENT, M.CLIENT, T.P, A.API,   'Submits a new service request for coordinator approval.', { api: ApiRegistry.CLIENT.BOOKING_REQUESTS }),
    btn('btn-client-visit-cancel',    'Cancel Request',           R.CLIENT, M.CLIENT, T.D, A.API,   'Initiates a cancellation request for a scheduled care visit.', { api: ApiRegistry.TENANCY.CLIENT.BOOKING_CANCEL(':id'), routeParams: [':id'] }),
    // Staff
    btn('btn-staff-task-add',         'Create New Task',           R.STAFF, M.OPS, T.P, A.NAV,   'Opens the task creation interface for staff.', { routeKey: 'STAFF.TASKS' }),
    btn('btn-staff-compliance-scan',  'Run Compliance Scan',       R.STAFF, M.OPS, T.S, A.API,   'Triggers a branch-wide compliance health check.', { api: ApiRegistry.TENANCY.STAFF.COMPLIANCE_SCAN }),
    // Allied Health
    btn('btn-allied-sign-visit',      'Sign Clinical Note',        R.RMT, M.CLIN, T.P, A.SIG,   'Clinical sign-off for Allied Health professionals.'),
    // Training Director
    btn('btn-td-training-hub',        'Enter Training Hub',        'training_director', M.OPS, T.P, A.NAV, 'Opens the centralized training and compliance hub.', { routeKey: 'TRAINING.HUB' }),
    btn('btn-td-cert-verify',         'Verify Certificate',        'training_director', M.OPS, T.S, A.MODAL, 'Launches the automated certificate verification tool.'),
    btn('btn-td-course-architect',    'Course Architect',         'training_director', M.OPS, T.S, A.NAV, 'Opens the interactive curriculum builder.'),
];
