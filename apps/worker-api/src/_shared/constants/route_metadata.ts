export const ROUTE_METADATA = {
    ADMIN_VISITS: {
        LIST: {
            summary: 'List All Visits',
            description: 'Retrieve a list of all visits with client, psw, and service details.',
            tags: ['Admin Visits'],
        },
        CREATE: {
            summary: 'Create Visit',
            description: 'Create a new visit for a client.',
            tags: ['Admin Visits'],
        },
        UPDATE: {
            summary: 'Update Visit',
            description: 'Update visit details or status.',
            tags: ['Admin Visits'],
        },
        DELETE: {
            summary: 'Delete Visit',
            description: 'Remove a visit from the system.',
            tags: ['Admin Visits'],
        },
        POST_SHIFT: {
            summary: 'Post Shift',
            description: 'Move a visit status from draft/requested to posted.',
            tags: ['Admin Visits'],
        },
        OFFER_SHIFT: {
            summary: 'Offer Shift to PSWs',
            description: 'Offer a visit to a list of PSWs.',
            tags: ['Admin Visits'],
        },
        SUGGEST_PSWS: {
            summary: 'Suggest PSWs',
            description: 'Get a list of suggested PSWs for a visit based on availability and skills.',
            tags: ['Admin Visits'],
        },
        ASSIGN_PSW: {
            summary: 'Assign PSW',
            description: 'Manually assign a PSW to a visit.',
            tags: ['Admin Visits'],
        },
        CANCEL_VISIT: {
            summary: 'Cancel Visit',
            description: 'Cancel a visit and apply cancellation policy.',
            tags: ['Admin Visits'],
        },
    },
    AUTH: {
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
    },
    USER: {
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
    },
    MANAGER: {
        STATS: {
            summary: 'Get Manager Dashboard Statistics',
            description: 'Retrieve comprehensive dashboard statistics for managers and admins.',
            tags: ['Manager Dashboard'],
        },
    },
    PSW_SCHEDULE: {
        CHECK_IN: {
            summary: 'Visit Check-In',
            description: 'Perform a check-in for a specific visit, including GPS verification.',
            tags: ['PSW Schedule'],
        },
        CHECK_OUT: {
            summary: 'Visit Check-Out',
            description: 'Perform a check-out for a specific visit.',
            tags: ['PSW Schedule'],
        },
        LIST_VISITS: {
            summary: 'List PSW Visits',
            description: 'Retrieve scheduled visits for the authenticated PSW.',
            tags: ['PSW Schedule'],
        },
        LIST_OFFERS: {
            summary: 'Get Offered Shifts',
            description: 'Retrieve a list of shifts offered to the authenticated PSW.',
            tags: ['PSW Schedule'],
        },
        ACCEPT_OFFER: {
            summary: 'Accept Shift Offer',
            description: 'Accept an offered shift and mark the visit as scheduled.',
            tags: ['PSW Schedule'],
        },
        DECLINE_OFFER: {
            summary: 'Decline Shift Offer',
            description: 'Decline an offered shift.',
            tags: ['PSW Schedule'],
        },
        UPDATE_AVAILABILITY: {
            summary: 'Update Availability',
            description: 'Update the structural availability for the PSW.',
            tags: ['PSW Schedule'],
        },
        REPORT_NO_SHOW: {
            summary: 'Report Client No-Show',
            description: 'Report that a client was not present for a visit. Requires a check-in and 15 minute wait.',
            tags: ['PSW Schedule'],
        },
    },
};
