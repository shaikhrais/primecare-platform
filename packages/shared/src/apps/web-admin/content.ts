export const ContentRegistry = {
    APP: {
        NAME: 'PrimeCare Admin',
        TAGLINE: 'Platform Management Portal',
    },
    AUTH: {
        LOGIN_TITLE: 'Admin Login',
        LOGIN_TITLE_PSW: 'Caregiver Login',
        LOGIN_TITLE_CLIENT: 'Family Portal Login',
        EMAIL_LABEL: 'Email Address',
        PASSWORD_LABEL: 'Password',
        BUTTON: 'Login to Dashboard',
        BUTTON_PSW: 'Sign In as Caregiver',
        BUTTON_CLIENT: 'Sign In to Family Hub',
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
