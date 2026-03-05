export const STAFF_METADATA = {
    SUPPORT_LIST: {
        summary: 'List Support Tickets',
        description: 'Retrieve a list of all support message threads.',
        tags: ['Staff Support'],
    },
    SUPPORT_MESSAGES: {
        summary: 'Get Ticket Messages',
        description: 'Retrieve all messages for a specific support thread.',
        tags: ['Staff Support'],
    },
    SUPPORT_REPLY: {
        summary: 'Reply to Ticket',
        description: 'Send a reply within a specific support thread.',
        tags: ['Staff Support'],
    },
    SCHEDULING_CREATE: {
        summary: 'Create Visit (Staff)',
        description: 'Allows staff to create a new visit (open shift) for a client.',
        tags: ['Staff Scheduling'],
    },
    DASHBOARD_STATS: {
        summary: 'Get Staff Dashboard Statistics',
        description: 'Retrieve various operational statistics for the staff coordinator dashboard.',
        tags: ['Staff Dashboard'],
    },
    TASKS: {
        summary: 'List Staff Tasks',
        description: 'Retrieve a list of all operational tasks for the staff team.',
        tags: ['Staff Operations'],
    },
    INCIDENT_SUBMIT: {
        summary: 'Submit Incident Report',
        description: 'Log a new clinical or operational incident for branch tracking and triage.',
        tags: ['Staff Operations'],
    },
    COMPLIANCE_SCAN: {
        summary: 'Scan Branch Compliance',
        description: 'Initiate a compliance scan of caregiver documents and registry statuses.',
        tags: ['Staff Operations'],
    },
    MESSAGES: {
        summary: 'Staff Message Hub',
        description: 'Unified view of all operational communication threads for the staff team.',
        tags: ['Staff Support'],
    },
};

export const RN_METADATA = {
    SUPERVISION_OVERVIEW: {
        summary: 'Get PSW Supervision Overview',
        description: 'Retrieve performance, logs, and incident overview for a specific PSW for supervision purposes.',
        tags: ['RN Supervision'],
    },
    DASHBOARD_STATS: {
        summary: 'Get RN Dashboard Statistics',
        description: 'Retrieve various clinical and operational statistics for the RN dashboard.',
        tags: ['RN Dashboard'],
    },
    DAILY_REVIEW: {
        summary: 'Review Daily Entry',
        description: 'Allows an RN to review and sign off on a daily entry.',
        tags: ['RN Daily Review'],
    },
    CARE_PLAN_LIST: {
        summary: 'List Care Plans',
        description: 'Retrieve a list of clinical care plans for clients.',
        tags: ['RN Clinical'],
    },
    CARE_PLAN_REVIEW: {
        summary: 'Review/Update Care Plan',
        description: 'Update the clinical goals and interventions for a care plan.',
        tags: ['RN Clinical'],
    },
    CLINICAL_ASSESS: {
        summary: 'Submit Clinical Assessment',
        description: 'Allows an RN to record a structured clinical assessment for a client.',
        tags: ['RN Clinical'],
    },
    MEDICATION_RECON: {
        summary: 'Sync Medication Reconciliation',
        description: 'Records a medication reconciliation log to ensure MAR accuracy.',
        tags: ['RN Clinical'],
    },
    SUPERVISION_LOG: {
        summary: 'Record Supervision Log',
        description: 'Logs RN supervision of PSW competencies and feedback.',
        tags: ['RN Supervision'],
    },
    DAILY_AUDIT_SIGN_OFF: {
        summary: 'Professional Clinical Sign-off',
        description: 'Allows an RN to formally sign off on a completed visit encounter for clinical accuracy.',
        tags: ['RN Clinical Audit'],
    },
};
