// Round 2 (G1-G15) + Round 3 (G16-G27) domain feature content strings

export const domainFeaturesContentR2R3 = {
    // ──── Round 2 Domain Features (G1–G15) ────

    // G1 — Notifications
    NOTIFICATIONS_PAGE_TITLE: 'Notification Engine',
    NOTIFICATIONS_PAGE_DESCRIPTION: 'Real-time alerts, compliance warnings, SOS signals, and system messages.',
    NOTIFICATIONS_BROADCAST_TITLE: 'Broadcast Admin Message',
    NOTIFICATIONS_EMPTY: 'No notifications at this time.',

    // G2 — Document Management
    DOCUMENTS_PAGE_TITLE: 'Document Management Center',
    DOCUMENTS_PAGE_DESCRIPTION: 'Upload, verify, and manage PSW credentials, certifications, and compliance documents.',
    DOCUMENTS_UPLOAD_TITLE: 'Upload Document',
    DOCUMENTS_EMPTY: 'No documents uploaded yet.',

    // G3 — Payroll
    PAYROLL_PAGE_TITLE: 'Payroll Batch Processing',
    PAYROLL_PAGE_DESCRIPTION: 'Approve timesheets in bulk, run payroll batches, and generate payouts for all providers.',
    PAYROLL_PENDING_TITLE: 'Pending Timesheets',
    PAYROLL_EMPTY: 'No pending timesheets for this pay period.',

    // G4 — Shift Swap
    SHIFT_SWAP_PAGE_TITLE: 'Shift Swap Workflow',
    SHIFT_SWAP_PAGE_DESCRIPTION: 'PSW-initiated shift swap requests with coordinator approval.',
    SHIFT_SWAP_EMPTY: 'No pending shift swap requests.',

    // G5 — Discharge
    DISCHARGE_PAGE_TITLE: 'Client Discharge & Care Transition',
    DISCHARGE_PAGE_DESCRIPTION: 'Manage client discharge, readmission, and care transition workflows.',
    DISCHARGE_EMPTY: 'No discharge records found.',

    // G6 — Fleet GPS
    FLEET_PAGE_TITLE: 'Fleet GPS Tracking',
    FLEET_PAGE_DESCRIPTION: 'Live PSW positions, ETA calculations, and heartbeat monitoring.',
    FLEET_EMPTY: 'No active fleet positions.',

    // G7 — Booking Requests
    BOOKING_REQUESTS_PAGE_TITLE: 'Booking Request Approval Queue',
    BOOKING_REQUESTS_PAGE_DESCRIPTION: 'Review client self-service booking requests. Approve to auto-create visits, or reject with reason.',
    BOOKING_REQUESTS_EMPTY: 'No pending booking requests.',

    // G8 — Messaging
    MESSAGING_PAGE_TITLE: 'Messaging Hub',
    MESSAGING_PAGE_DESCRIPTION: 'Threaded internal messaging for care coordination and team communication.',
    MESSAGING_EMPTY: 'No message threads yet.',

    // G9 — Training
    TRAINING_PAGE_TITLE: 'Training & Professional Development',
    TRAINING_PAGE_DESCRIPTION: 'Assign, track, and complete mandatory and optional training modules.',
    TRAINING_COMPLIANCE_TITLE: 'Training Compliance Home',
    TRAINING_EMPTY: 'No training modules assigned.',

    // G10 — Insurance Providers
    INSURANCE_PAGE_TITLE: 'Insurance Provider Directory',
    INSURANCE_PAGE_DESCRIPTION: 'Manage insurance provider contacts and payer codes for claims processing.',
    INSURANCE_EMPTY: 'No insurance providers configured.',

    // G11 — Billing Codes
    BILLING_CODES_PAGE_TITLE: 'Billing Code Directory',
    BILLING_CODES_PAGE_DESCRIPTION: 'Service billing codes with unit rates used across invoicing and claims.',
    BILLING_CODES_EMPTY: 'No billing codes configured.',

    // G12 — Allied Health
    ALLIED_HEALTH_PAGE_TITLE: 'Allied Health Home',
    ALLIED_HEALTH_PAGE_DESCRIPTION: 'Treatment assignments, clinical sign-offs, and allied health professional workflows.',
    ALLIED_HEALTH_EMPTY: 'No treatments assigned.',

    // G13 — FHIR Interop
    FHIR_PAGE_TITLE: 'FHIR Interoperability Hub',
    FHIR_PAGE_DESCRIPTION: 'Export/import HL7 FHIR R4 bundles, validate clinical data, and review sync logs.',
    FHIR_EMPTY: 'No FHIR sync activity.',

    // G14-15 — Scheduled Jobs
    CRON_PAGE_TITLE: 'Scheduled Jobs Home',
    CRON_PAGE_DESCRIPTION: 'Monitor automated cron tasks: compliance sweeps, training reminders, authorization monitoring, and inventory alerts.',
    CRON_EMPTY: 'No scheduled jobs configured.',

    // ──── Round 3 Domain Features (G16–G27) ────

    // G16 — Client Billing
    CLIENT_BILLING_PAGE_TITLE: 'My Billing & Invoices',
    CLIENT_BILLING_PAGE_DESCRIPTION: 'View your invoices, payment history, and outstanding balances.',
    CLIENT_BILLING_EMPTY: 'No invoices found.',

    // G17 — Client Feedback
    CLIENT_FEEDBACK_PAGE_TITLE: 'Satisfaction & Feedback',
    CLIENT_FEEDBACK_PAGE_DESCRIPTION: 'Rate your recent care visits and help us maintain premium care standards.',
    CLIENT_FEEDBACK_EMPTY: 'No feedback surveys available.',

    // G18 — Client Booking Request
    CLIENT_BOOKING_REQUEST_TITLE: 'Request a Booking',
    CLIENT_BOOKING_REQUEST_DESCRIPTION: 'Submit a new care service request and track its approval status.',

    // G19 — Care Team
    CLIENT_CARE_TEAM_TITLE: 'My Care Team',
    CLIENT_CARE_TEAM_DESCRIPTION: 'View your assigned caregivers, nurses, and coordinator contact details.',
    CLIENT_CARE_TEAM_EMPTY: 'No care team members assigned yet.',

    // G20 — SOS
    SOS_PAGE_TITLE: 'SOS Emergency Center',
    SOS_PAGE_DESCRIPTION: 'Monitor and acknowledge PSW emergency SOS alerts in real-time.',
    SOS_EMPTY: 'No active SOS alerts.',

    // G21 — Waitlist
    WAITLIST_PAGE_TITLE: 'Client Waitlist Management',
    WAITLIST_PAGE_DESCRIPTION: 'Prioritize and manage client waitlist entries for service assignment.',
    WAITLIST_EMPTY: 'Waitlist is empty.',

    // G26 — Shared Training
    SHARED_TRAINING_PAGE_TITLE: 'Training Catalog',
    SHARED_TRAINING_PAGE_DESCRIPTION: 'Browse available training modules and track your completion progress.',

    // G27 — Medical Summary
    MEDICAL_SUMMARY_TITLE: 'My Medical Summary',
    MEDICAL_SUMMARY_DESCRIPTION: 'View your clinical profile, conditions, and allergy information.',
} as const;
