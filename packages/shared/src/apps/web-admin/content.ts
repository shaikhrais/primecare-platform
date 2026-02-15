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
    },
    SCHEDULE: {
        TITLE: 'Shift Scheduling',
        SUBTITLE: 'Manage client visits and caregiver assignments',
        ACTIONS: {
            CREATE: '+ Create Visit Request',
            ASSIGN: 'Assign Caregiver',
            CONFIRM_ASSIGN: 'Confirm Assignment',
            CANCEL_VISIT: 'Cancel Visit',
            CLOSE: 'Close',
            EDIT: 'Edit Visit'
        },
        MODAL: {
            SELECT_PSW: 'Select Caregiver',
            CHOOSE_WORKER: 'Choose a worker...',
            CONFIRM_DELETE: 'Are you sure you want to cancel this visit?'
        },
        MESSAGES: {
            SUCCESS_ASSIGN: 'Shift assigned successfully',
            ERROR_ASSIGN: 'Failed to assign shift',
            SUCCESS_CANCEL: 'Visit cancelled successfully',
            ERROR_DELETE: 'Failed to cancel visit',
            ERROR_UPDATE: 'Failed to update status'
        }
    }
} as const;
