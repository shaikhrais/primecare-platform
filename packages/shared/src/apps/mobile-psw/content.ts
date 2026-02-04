export const ContentRegistry = {
    APP: {
        NAME: 'PrimeCare PSW',
        TAGLINE: 'Sign in to access your visits',
    },
    DASHBOARD: {
        WELCOME: 'Welcome to PSW Dashboard',
        HEADER_TITLE: 'My Visits',
    },
    ERROR_BOUNDARY: {
        TITLE: '⚠️ Error Occurred',
        SUBTITLE: 'Something went wrong in the application.',
        BUTTON_RESTART: 'Restart Application',
    },
    AUTH: {
        LOGIN: {
            BUTTON: 'Sign In',
            EMAIL_LABEL: 'Email Address',
            EMAIL_PLACEHOLDER: 'Enter your email',
            PASSWORD_LABEL: 'Password',
            PASSWORD_PLACEHOLDER: 'Enter your password',
        },
        ERRORS: {
            VALIDATION_MISSING: 'Please enter both email and password.',
            VALIDATION_EMAIL: 'Please enter a valid email address.',
            SERVER_ERROR: 'Server is currently unavailable. Please try again later.',
            RATE_LIMIT: 'Too many attempts. Please wait a moment before trying again.',
            INVALID_RESPONSE: 'Received an invalid response from the server.',
            TIMEOUT: 'Connection timed out. Please check your internet.',
            NETWORK: 'Unable to connect. Please check your internet connection.',
            UNKNOWN: 'An unexpected error occurred. Please try again.',
        },
    },
} as const;
