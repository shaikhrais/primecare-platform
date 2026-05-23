// Governance - Category: service | Purpose: Manager Coordinator PSW
import type { PageActions } from '../page_action_registry';

export const TENANCY_ACTIONS: Record<string, PageActions> = {
    // Manager
    'manager.home': { primary: 'btn-mgr-payroll-verify', actions: ['btn-mgr-ops-stats', 'btn-mgr-compliance-sync', 'btn-mgr-feedback-triage'] },
    'manager.training': { primary: 'btn-mgr-training-create', actions: [] },
    'manager.surveys': { primary: 'btn-mgr-survey-new', actions: [] },
    'manager.evaluations': { primary: 'btn-mgr-evaluation-new', actions: [] },
    'manager.operations': { primary: 'btn-mgr-staff-add', actions: ['btn-mgr-audit-attendance', 'btn-mgr-approve-billing'] },
    // Coordinator
    'coordinator.home': {
        primary: 'btn-coord-dispatch-center',
        actions: ['btn-coord-sos-center', 'btn-coord-optimize', 'btn-coord-broadcast-shift', 'btn-coord-match-run', 'btn-coord-waitlist-sync', 'btn-coord-shift-triage'],
    },
    'coordinator.sos': { primary: 'btn-coord-sos-ack-v2', actions: ['btn-coord-sos-dispatch', 'btn-coord-sos-resolved'] },
    // PSW
    'psw.home': { primary: 'btn-psw-view-schedule', actions: ['btn-psw-live-visit', 'btn-psw-wellness-pulse', 'btn-psw-clock-in'] },
    'psw.schedule': { primary: 'btn-psw-check-in', actions: ['btn-psw-check-out', 'btn-psw-offer-accept', 'btn-psw-offer-decline'] },
    'psw.live-visit': { primary: 'btn-psw-check-in', actions: ['btn-psw-check-out', 'btn-psw-daily-entry', 'btn-psw-handover-submit', 'btn-psw-incident-report'] },
    'psw.earnings': { primary: 'btn-psw-payout-sync', actions: [] },
    // RN
    'rn.home': { primary: 'btn-rn-new-assessment', actions: ['btn-rn-audit-sign-off', 'btn-rn-recon-sync', 'btn-rn-supervision-log'] },
    'rn.care-plans': { primary: 'btn-rn-careplan-save', actions: ['btn-rn-careplan-verify'] },
    'rn.assessments': { primary: 'btn-rn-assess-start-adl', actions: ['btn-rn-assess-start-mobility', 'btn-rn-assess-start-mental', 'btn-rn-assess-submit'] },
    'rn.daily-audit': { primary: 'btn-rn-entry-verify', actions: ['btn-rn-daily-review'] },
    // Client
    'client.home': { primary: 'btn-client-request-care', actions: ['btn-client-family-hub', 'btn-client-support-chat', 'btn-client-view-careplan'] },
    'client.bookings': { primary: 'btn-client-booking-request', actions: ['btn-client-visit-cancel'] },
    'client.billing': { primary: 'btn-client-pay-invoice', actions: [] },
    'client.feedback': { primary: 'btn-client-star-rating', actions: [] },
    // Staff
    'staff.home': { primary: 'btn-staff-task-add', actions: ['btn-staff-compliance-scan'] },
    // Allied Health
    'allied.home': { primary: 'btn-allied-sign-visit', actions: [] },
    // Premium Pages
    'manager.gamification': { primary: 'lnk-mgr-gamification', actions: [] },
    'manager.iot-monitoring': { primary: 'lnk-mgr-iot', actions: [] },
    'manager.document-signing': { primary: 'lnk-mgr-doc-signing', actions: [] },
    'manager.sms-hub': { primary: 'lnk-mgr-sms-hub', actions: [] },
    'manager.performance-reviews': { primary: 'lnk-mgr-perf-reviews', actions: [] },
    'manager.training-academy': { primary: 'lnk-mgr-training-academy', actions: [] },
    'psw.guide': { primary: 'lnk-psw-guide', actions: [] },
};
