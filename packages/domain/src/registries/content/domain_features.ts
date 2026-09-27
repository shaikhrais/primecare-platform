// Governance - Category: service | Purpose: Round 1 domain feature content (F1-F18) F1 — EVV F2 — RAI-HC / OASIS F3 — Authorizations
import { domainFeaturesContentR2R3 } from './domain_features_r2r3';

// Round 1 domain feature content (F1-F18)
export const domainFeaturesContent = {
    // F1 — EVV
    EVV_PAGE_TITLE: 'Electronic Visit Verification',
    EVV_PAGE_DESCRIPTION: 'Monitor EVV compliance, review exceptions, and export data for provincial aggregators.',
    EVV_EXCEPTIONS_TITLE: 'EVV Exceptions',
    EVV_COMPLIANCE_TITLE: 'EVV Compliance Summary',
    EVV_EXPORT_TITLE: 'EVV Data Export',
    EVV_EMPTY: 'No EVV records found for the selected period.',

    // F2 — RAI-HC / OASIS
    RAI_PAGE_TITLE: 'Clinical Assessments (RAI-HC)',
    RAI_PAGE_DESCRIPTION: 'Standardized assessment instruments with auto-scoring and CAP triggers.',
    RAI_TEMPLATES_TITLE: 'Assessment Templates',
    RAI_HISTORY_TITLE: 'Assessment History',
    RAI_CAPS_TITLE: 'Clinical Assessment Protocols',
    RAI_EMPTY: 'No assessments on file for this client.',

    // F3 — Authorizations
    AUTH_MGMT_PAGE_TITLE: 'Service Authorizations',
    AUTH_MGMT_PAGE_DESCRIPTION: 'Track approved hours, utilization, and expiry alerts per client.',
    AUTH_ALERTS_TITLE: 'Authorization Alerts',
    AUTH_UTILIZATION_TITLE: 'Utilization Breakdown',
    AUTH_EMPTY: 'No active authorizations.',

    // F5 — eMAR
    MAR_PAGE_TITLE: 'Electronic MAR',
    MAR_PAGE_DESCRIPTION: 'Medication schedules, administration records, and RN review queue.',
    MAR_SCHEDULE_TITLE: 'Medication Schedule',
    MAR_HISTORY_TITLE: 'Administration History',
    MAR_REVIEW_TITLE: 'RN Review Queue',
    MAR_EMPTY: 'No medications scheduled for this client.',

    // F6 — Mileage
    MILEAGE_PAGE_TITLE: 'Mileage Tracking',
    MILEAGE_PAGE_DESCRIPTION: 'Travel distance between visits with CRA-rate reimbursement calculation.',
    MILEAGE_SUMMARY_TITLE: 'Mileage Summary',
    MILEAGE_EMPTY: 'No mileage records for this period.',

    // F7 — Referrals
    REFERRALS_PAGE_TITLE: 'Referral Intake',
    REFERRALS_PAGE_DESCRIPTION: 'Clinical referral pipeline from hospitals, CCACs, and LHINs.',
    REFERRALS_ANALYTICS_TITLE: 'Referral Analytics',
    REFERRALS_EMPTY: 'No referrals in the system.',

    // F8 — Consent
    CONSENT_PAGE_TITLE: 'Digital Consent Forms',
    CONSENT_PAGE_DESCRIPTION: 'Manage signed consents, track expiry, and maintain PHIPA compliance.',
    CONSENT_TEMPLATES_TITLE: 'Consent Templates',
    CONSENT_EXPIRING_TITLE: 'Expiring Consents',
    CONSENT_EMPTY: 'No consent forms on file.',

    // F9 — Family Portal
    FAMILY_PAGE_TITLE: 'Family Portal',
    FAMILY_PAGE_DESCRIPTION: 'Family member access to care feed, visit logs, and coordinator messaging.',
    FAMILY_MEMBERS_TITLE: 'Family Members',
    FAMILY_FEED_TITLE: 'Care Feed',
    FAMILY_EMPTY: 'No family members linked to this client.',

    // F10 — Claims
    CLAIMS_PAGE_TITLE: 'Claims Management',
    CLAIMS_PAGE_DESCRIPTION: 'Scrub, submit, and track insurance claims with ERA/EOB processing.',
    CLAIMS_SCRUB_TITLE: 'Claim Scrubber',
    CLAIMS_ERA_TITLE: 'ERA / EOB Summary',
    CLAIMS_EMPTY: 'No claims submitted.',

    // F11 — Wound Care
    WOUND_PAGE_TITLE: 'Wound Care Tracking',
    WOUND_PAGE_DESCRIPTION: 'PUSH tool assessments, photo documentation, and healing progress.',
    WOUND_PROGRESS_TITLE: 'Healing Progress',
    WOUND_CHRONIC_TITLE: 'Chronic Condition Home',
    WOUND_EMPTY: 'No wound assessments recorded.',

    // F13 — Webhooks
    WEBHOOKS_PAGE_TITLE: 'Webhook Management',
    WEBHOOKS_PAGE_DESCRIPTION: 'Register endpoints, view delivery logs, and test webhook integrations.',
    WEBHOOKS_DELIVERIES_TITLE: 'Delivery Log',
    WEBHOOKS_EMPTY: 'No webhooks registered.',

    // F14 — Performance Reviews
    REVIEWS_PAGE_TITLE: 'Performance Reviews',
    REVIEWS_PAGE_DESCRIPTION: 'Staff evaluations with KPI tracking, goal setting, and review cycles.',
    REVIEWS_KPI_TITLE: 'PSW KPI Home',
    REVIEWS_EMPTY: 'No reviews on file.',

    // F15 — Audit Export
    AUDIT_EXPORT_PAGE_TITLE: 'Audit Export & Compliance',
    AUDIT_EXPORT_PAGE_DESCRIPTION: 'Download audit logs, view PHIPA compliance scores, and generate regulatory reports.',
    AUDIT_COMPLIANCE_TITLE: 'PHIPA Compliance Home',
    AUDIT_REGULATORY_TITLE: 'MOHLTC Regulatory Report',
    AUDIT_EMPTY: 'No audit records for the selected period.',

    // F16-18 — Stubs
    AI_PREDICTIONS_TITLE: 'AI Predictions',
    AI_PREDICTIONS_DESCRIPTION: 'Machine learning predictions for fall risk, readmission, and churn.',
    IOT_VITALS_TITLE: 'IoT Vitals',
    IOT_VITALS_DESCRIPTION: 'Live vital sign data from connected health monitors.',
    TELEHEALTH_SESSION_TITLE: 'Telehealth Sessions',
    TELEHEALTH_SESSION_DESCRIPTION: 'Video visit sessions with clients and care teams.',

    // Round 2+3 merged from sub-file
    ...domainFeaturesContentR2R3,
} as const;
