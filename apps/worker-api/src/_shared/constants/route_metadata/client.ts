export const CLIENT_METADATA = {
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
};
