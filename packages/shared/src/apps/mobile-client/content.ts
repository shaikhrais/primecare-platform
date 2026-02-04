export const ContentRegistry = {
    APP: {
        NAME: 'PrimeCare Client',
        TAGLINE: 'Book reliable home care services',
    },
    AUTH: {
        LOGIN: {
            BUTTON: 'Sign In',
            EMAIL_LABEL: 'Email Address',
            EMAIL_PLACEHOLDER: 'Enter your email',
            PASSWORD_LABEL: 'Password',
            PASSWORD_PLACEHOLDER: 'Enter your password',
            REGISTER_LINK: 'Need an account? Sign Up',
        },
        REGISTER: {
            BUTTON: 'Create Account',
            TITLE: 'Create Account',
            SUBTITLE: 'Join PrimeCare today',
            EMAIL_LABEL: 'Email Address',
            PASSWORD_LABEL: 'Password',
            CONFIRM_PASSWORD_LABEL: 'Confirm Password',
            LOGIN_LINK: 'Already have an account? Sign In',
        },
        ERRORS: {
            VALIDATION_MISSING: 'Please fill in all fields.',
            VALIDATION_EMAIL: 'Please enter a valid email address.',
            SERVER_ERROR: 'Server error. Please try again.',
            TIMEOUT: 'Connection timed out.',
            NETWORK: 'Network error. Check your connection.',
        },
    },
    DASHBOARD: {
        HEADER: 'My Services',
        BOOK_BUTTON: 'Request New Service',
        EMPTY_VISITS: 'No upcoming visits.',
    },
    BOOKING: {
        TITLE: 'Book a Service',
        SELECT_SERVICE: 'Select a Service',
        SELECT_DATE: 'Requested Start Date (YYYY-MM-DD HH:MM)',
        BUTTON: 'Confirm Booking',
        SUCCESS: 'Booking request sent successfully!',
    }
} as const;
