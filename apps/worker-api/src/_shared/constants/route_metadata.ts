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
    SYSTEM: {
        VOICE: {
            summary: 'Upload Voice Note',
            description: 'Upload a voice note (audio file) for a specific user.',
            tags: ['System Voice'],
        },
        STORAGE_UPLOAD: {
            summary: 'Upload File',
            description: 'Upload a file to the documentation bucket.',
            tags: ['System Storage'],
        },
        STORAGE_GET: {
            summary: 'Get File',
            description: 'Retrieve a file from the documentation bucket by its key.',
            tags: ['System Storage'],
        },
        PAYMENT_INTENT: {
            summary: 'Create Payment Intent',
            description: 'Create a Stripe payment intent for a given amount and currency.',
            tags: ['System Payments'],
        },
        REGISTER_DEVICE: {
            summary: 'Register Device for Push',
            description: 'Register a device token for push notifications.',
            tags: ['System Notifications'],
        },
        LIST_NOTIFICATIONS: {
            summary: 'List Notifications',
            description: 'Retrieve a list of notifications for the authenticated user.',
            tags: ['System Notifications'],
        },
        READ_NOTIFICATION: {
            summary: 'Mark Notification as Read',
            description: 'Mark a specific notification as read for the authenticated user.',
            tags: ['System Notifications'],
        },
    },
    STAFF: {
        SUPPORT_LIST: {
            summary: 'List Support Tickets',
            description: 'Retrieve a list of all support message threads.',
            tags: ['Staff Support'],
        },
        SUPPORT_MESSAGES: {
            summary: 'Get Ticket Messages',
            description: 'Retrieve all messages for a specific support thread.',
            tags: ['Staff Support'],
        },
        SUPPORT_REPLY: {
            summary: 'Reply to Ticket',
            description: 'Send a reply within a specific support thread.',
            tags: ['Staff Support'],
        },
        SCHEDULING_CREATE: {
            summary: 'Create Visit (Staff)',
            description: 'Allows staff to create a new visit (open shift) for a client.',
            tags: ['Staff Scheduling'],
        },
    },
    RN: {
        SUPERVISION_OVERVIEW: {
            summary: 'Get PSW Supervision Overview',
            description: 'Retrieve performance, logs, and incident overview for a specific PSW for supervision purposes.',
            tags: ['RN Supervision'],
        },
        DASHBOARD_STATS: {
            summary: 'Get RN Dashboard Statistics',
            description: 'Retrieve various clinical and operational statistics for the RN dashboard.',
            tags: ['RN Dashboard'],
        },
        DAILY_REVIEW: {
            summary: 'Review Daily Entry',
            description: 'Allows an RN to review and sign off on a daily entry.',
            tags: ['RN Daily Review'],
        },
    },
    PSW_EXTRA: {
        INCIDENTS_REPORT: {
            summary: 'Report Incident',
            description: 'Report an incident that occurred during or after a visit.',
            tags: ['PSW Incidents'],
        },
        DASHBOARD_STATS: {
            summary: 'Get PSW Dashboard Statistics',
            description: 'Retrieve earnings, reliability, and shift distribution stats for the authenticated PSW.',
            tags: ['PSW Dashboard'],
        },
        DAILY_ENTRY_CREATE: {
            summary: 'Create/Submit Daily Entry',
            description: 'Submit an ADL/Medication entry for a client visit.',
            tags: ['PSW Daily Entries'],
        },
        DAILY_ENTRY_HISTORY: {
            summary: 'Get Daily Entry History',
            description: 'Retrieve history of daily entries for a specific client.',
            tags: ['PSW Daily Entries'],
        },
    },
    CLIENT: {
        INVOICES: {
            summary: 'List Client Invoices',
            description: 'Retrieve a list of all invoices for the authenticated client.',
            tags: ['Client Services'],
        },
        SERVICES: {
            summary: 'List Available Services',
            description: 'Retrieve a list of all available services for the current tenant.',
            tags: ['Client Services'],
        },
        CARE_PLAN_CREATE: {
            summary: 'Create Care Plan',
            description: 'Create a new care plan for a specific client.',
            tags: ['Client Care Plan'],
        },
        CARE_PLAN_UPDATE: {
            summary: 'Update Care Plan',
            description: 'Update an existing care plan for a specific client.',
            tags: ['Client Care Plan'],
        },
        GET_PROFILE: {
            summary: 'Get Client Profile',
            description: 'Retrieve the profile details for the authenticated client.',
            tags: ['Client Dashboard'],
        },
        UPDATE_PROFILE: {
            summary: 'Update Client Profile',
            description: 'Update the profile details for the authenticated client.',
            tags: ['Client Dashboard'],
        },
        STATS: {
            summary: 'Get Client Dashboard Statistics',
            description: 'Retrieve budget, wellness, and care continuity stats for the authenticated client.',
            tags: ['Client Dashboard'],
        },
        LIST_BOOKINGS: {
            summary: 'List Client Bookings',
            description: 'Retrieve a list of all bookings for the authenticated client.',
            tags: ['Client Bookings'],
        },
        CREATE_BOOKING: {
            summary: 'Create Booking',
            description: 'Create a new service booking for the authenticated client.',
            tags: ['Client Bookings'],
        },
        UPDATE_BOOKING: {
            summary: 'Update Booking',
            description: 'Update an existing booking.',
            tags: ['Client Bookings'],
        },
    },
    ADMIN_EXTRA: {
        LEADS_LIST: {
            summary: 'List All Leads',
            description: 'Retrieve a list of all marketing leads.',
            tags: ['Admin Leads'],
        },
        LEADS_UPDATE: {
            summary: 'Update Lead Status',
            description: 'Update the status of a specific marketing lead.',
            tags: ['Admin Leads'],
        },
        USERS_LIST: {
            summary: 'List All Users',
            description: 'Retrieve a list of all users in the system.',
            tags: ['Admin Users'],
        },
        USERS_VERIFY: {
            summary: 'Verify User',
            description: 'Mark a user as verified.',
            tags: ['Admin Users'],
        },
        USERS_ROLES: {
            summary: 'Update User Roles',
            description: 'Update the roles assigned to a specific user.',
            tags: ['Admin Users'],
        },
        USERS_ELEVATE: {
            summary: 'Elevate User to Super User',
            description: 'Grant all available roles to a user.',
            tags: ['Admin Users'],
        },
        TIMESHEETS_LIST: {
            summary: 'List All Timesheets',
            description: 'Retrieve a list of all timesheets with PSW and item details.',
            tags: ['Admin Timesheets'],
        },
        TIMESHEETS_UPDATE: {
            summary: 'Update Timesheet Status',
            description: 'Update the status of a specific timesheet and log the review.',
            tags: ['Admin Timesheets'],
        },
    },
};
