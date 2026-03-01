export const ADMIN_METADATA = {
    VISITS: {
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
        SURGE_SHIFT: {
            summary: 'Apply Surge Pricing',
            description: 'Activate surge pricing and set a multiplier for an unfilled shift.',
            tags: ['Admin Visits'],
        },
    },
    EXTRA: {
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
        USERS_CREATE: {
            summary: 'Create New User',
            description: 'Register a new user with specific roles and profile.',
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
