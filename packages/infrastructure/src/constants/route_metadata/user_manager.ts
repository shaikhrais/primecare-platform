// Governance - Category: service | Purpose: Core implementation file for the User Manager platform logic.
export const USER_METADATA = {
    GET_PROFILE: {
        summary: 'Get User Profile',
        description: 'Retrieve the detailed profile for the current user and active role.',
        tags: ['User Profile'],
    },
    UPDATE_PROFILE: {
        summary: 'Update User Profile',
        description: 'Update user profile information.',
        tags: ['User Profile'],
    },
    UPDATE_PREFERENCES: {
        summary: 'Update User Preferences',
        description: 'Update user preferences such as language.',
        tags: ['User Preferences'],
    },
};

export const MANAGER_METADATA = {
    STATS: {
        summary: 'Get Manager Home Statistics',
        description: 'Retrieve comprehensive home statistics for managers and admins.',
        tags: ['Manager Home'],
    },
    PAYROLL_AUDIT: {
        summary: 'Run Payroll Audit',
        description: 'Retrieve payroll variance data and audit visit hours for branch-level financial oversight.',
        tags: ['Manager Finance'],
    },
    OPS_STATS: {
        summary: 'Get Regional Ops Stats',
        description: 'Retrieve detailed performance metrics and branch KPIs for regional oversight.',
        tags: ['Manager Operations'],
    },
    BRANCH_HEALTH: {
        summary: 'Get Branch Health Status',
        description: 'Retrieve real-time health alerts and operational status for the branch.',
        tags: ['Manager Operations'],
    },
    COMPLIANCE_SYNC: {
        summary: 'Sync Branch Compliance',
        description: 'Synchronize and audit compliance records for the regional branch.',
        tags: ['Manager Operations'],
    },
    FEEDBACK_TRIAGE: {
        summary: 'Triage Feedback',
        description: 'Review and triage caregiver or client feedback for operational resolution.',
        tags: ['Manager Operations'],
    },
};
