export const ContentRegistry = {
    APP: {
        NAME: 'PrimeCare',
        TAGLINE: 'Compassionate Care, Professional Service',
    },
    AUTH: {
        LOGIN_TITLE: 'Sign in to your account',
        LOGIN_TITLE_CLIENT: 'Client Portal Login',
        LOGIN_TITLE_STAFF: 'Staff Portal Login',
        BUTTON: 'Sign in',
        BUTTON_CLIENT: 'Sign In as Client',
        BUTTON_PSW: 'Sign In as Caregiver',
        BUTTON_STAFF: 'Sign In as Staff',
        EMAIL_LABEL: 'Email address',
        PASSWORD_LABEL: 'Password',
        FORGOT_PASSWORD: 'Forgot password?',
    },
    ADMIN_DASHBOARD: {
        STATS: {
            TOTAL_USERS: 'Total Users',
            NEW_INQUIRIES: 'New Inquiries',
            PENDING_VISITS: 'Pending Visits',
            TOTAL_VISITS: 'Total Care Visits',
        },
        TITLES: {
            WELCOME: 'Welcome back, Admin',
            SUBTITLE: "Here is what's happening today at PrimeCare.",
            QUICK_ACTIONS: 'Quick Actions',
            OPERATIONAL_STATUS: 'Operational Status',
        }
    },
    CLIENT_DASHBOARD: {
        TITLE: 'My Care Hub',
        SUBTITLE: 'Welcome back to your family care portal.',
        BUTTON_REQUEST: 'Request New Care',
        MODAL_TITLE: 'Request New Care',
        MODAL_SUBTITLE: 'Please select your care type and preferred time.',
    },
    PSW_DASHBOARD: {
        TITLE: 'My Work Schedule',
        SUBTITLE: 'Stay updated on your upcoming assigned care visits.',
        BUTTON_FULL_SCHEDULE: 'View Full Schedule',
        SECTION_SHIFTS: 'Shift Schedule',
        NO_SHIFTS: 'You have no shifts scheduled at this time.',
    },
    USERS: {
        TITLE: 'Users & Healthcare Workers',
        APPROVE_BTN: 'Approve',
        ROLE: 'Role',
        STATUS: 'Status',
        INVITE_BTN: 'Invite User',
        INVITE_PROMPT: 'Enter email to invite:',
        INVITE_SUCCESS: (email: string) => `Invitation sent to ${email}`,
        VERIFY_BTN: 'Verify Certs',
        EDIT_BTN: 'Edit',
        MESSAGES: {
            LOADING: 'Retrieving secure user registry...',
            EMPTY: 'No users found in the registry.',
            ERROR_VERIFY: 'Failed to approve worker',
        }
    },
    LEADS: {
        TITLE: 'Lead Inquiries',
        ACTIONS: {
            EXPORT: 'Export CSV',
            REFRESH: 'Refresh',
            REFRESHING: 'Refreshing...',
            MARK_CONTACTED: 'Mark Contacted',
            CONVERT: 'Convert',
            CLOSE: 'Close',
        },
        MESSAGES: {
            LOADING: 'Loading leads repository...',
            EMPTY: 'No leads found.',
            ERROR: 'Failed to fetch leads',
            ERROR_UPDATE: 'Failed to update status',
        }
    },
    SCHEDULE: {
        TITLE: 'Visit Schedule',
        SUBTITLE: 'Coordinate care visits and assign PSWs to client requests.',
        ACTIONS: {
            CREATE: '+ Create Visit Request',
            ASSIGN: 'Assign Caregiver',
            CONFIRM_ASSIGN: 'Confirm Assignment',
            CANCEL_VISIT: 'Cancel Visit',
            CLOSE: 'Close',
        },
        MODAL: {
            SELECT_PSW: 'Select Verified PSW',
            CHOOSE_WORKER: '-- Choose a worker --',
            CONFIRM_DELETE: 'Are you sure you want to cancel this visit?',
        },
        MESSAGES: {
            SUCCESS_ASSIGN: 'PSW assigned successfully!',
            SUCCESS_CANCEL: 'Visit cancelled',
            ERROR_ASSIGN: 'Assignment failed',
            ERROR_DELETE: 'Failed to delete visit',
            ERROR_UPDATE: 'Status update failed',
        }
    },
    SETTINGS: {
        TITLE: 'System Settings',
        SUBTITLE: 'Configure global parameters and administrative preferences.',
        NOTIFICATIONS: {
            TITLE: 'General Notifications',
            EMAIL_ALERTS: 'Email Alerts for New Leads',
            EMAIL_DESC: 'Notify administrators when a new inquiry is submitted.',
        },
        SCHEDULING: {
            TITLE: 'Booking & Scheduling',
            AUTO_ASSIGN: 'Automatic PSW Assignment',
            AUTO_DESC: 'Experimental: Match best worker automatically for nursing visits.',
            GRACE_PERIOD: 'Late Check-in Grace Period',
            GRACE_DESC: 'Minutes allowed after scheduled start before alert is triggered.',
        },
        ACTIONS: {
            RESET: 'Reset to Defaults',
            SAVE: 'Save Settings',
            SUCCESS_SAVE: 'Settings saved successfully!',
        }
    },
    ROLES: {
        ADMIN: 'Administrator',
        STAFF: 'Staff Member',
        PSW: 'Personal Support Worker',
        CLIENT: 'Client',
    }
} as const;
