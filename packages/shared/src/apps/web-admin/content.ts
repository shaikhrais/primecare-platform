export const ContentRegistry = {
    APP: {
        NAME: 'PrimeCare Admin',
        TAGLINE: 'Platform Management Portal',
    },
    AUTH: {
        LOGIN_TITLE: 'Admin Login',
        EMAIL_LABEL: 'Email Address',
        PASSWORD_LABEL: 'Password',
        BUTTON: 'Login to Dashboard',
    },
    DASHBOARD: {
        TITLE: 'Overview',
        STATS: {
            USERS: 'Total Users',
            PSWS: 'Pending PSWs',
            VISITS: 'Unassigned Visits',
        },
    },
    USERS: {
        TITLE: 'User Management',
        APPROVE_BTN: 'Approve',
        ROLE: 'Role',
        STATUS: 'Status',
    }
} as const;
