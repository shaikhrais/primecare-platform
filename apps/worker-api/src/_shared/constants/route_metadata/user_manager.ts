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
};

export const MANAGER_METADATA = {
    STATS: {
        summary: 'Get Manager Dashboard Statistics',
        description: 'Retrieve comprehensive dashboard statistics for managers and admins.',
        tags: ['Manager Dashboard'],
    },
    PAYROLL_AUDIT: {
        summary: 'Run Payroll Audit',
        description: 'Retrieve payroll variance data and audit visit hours for branch-level financial oversight.',
        tags: ['Manager Finance'],
    },
};
