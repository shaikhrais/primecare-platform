export const AUTH_METADATA = {
    REGISTER: {
        summary: 'Register User',
        description: 'Register a new user and create an initial tenant.',
        tags: ['Authentication'],
    },
    LOGIN: {
        summary: 'Login User',
        description: 'Authenticate user and set session cookies.',
        tags: ['Authentication'],
    },
    REFRESH: {
        summary: 'Refresh Token',
        description: 'Refresh the access token using the refresh token cookie.',
        tags: ['Authentication'],
    },
    LOGOUT: {
        summary: 'Logout User',
        description: 'Clear session cookies and logout.',
        tags: ['Authentication'],
    },
    WHOAMI: {
        summary: 'Current User Info',
        description: 'Get information about the currently authenticated user.',
        tags: ['Authentication'],
    },
    IMPERSONATE: {
        summary: 'Impersonate User',
        description: 'As an admin, impersonate another user.',
        tags: ['Authentication'],
    },
    SWITCH_ROLE: {
        summary: 'Switch User Role',
        description: 'Switch the active role for the session.',
        tags: ['Authentication'],
    },
};
