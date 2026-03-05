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
    TEAM_ROSTER: {
        summary: 'Get Care Team Roster',
        description: 'Retrieve the profiles and satisfaction ratings of caregivers assigned to the client.',
        tags: ['Client Relationship'],
    },
    FEEDBACK_SUBMIT: {
        summary: 'Submit Care Feedback',
        description: 'Rate a recent visit and provide clinical or personal feedback for quality assurance.',
        tags: ['Client Relationship'],
    },
    FAMILY_FEED: {
        summary: 'Retrieve Family Engagement Feed',
        description: 'Get a timeline of recent care notifications and visit updates for family members.',
        tags: ['Client Engagement'],
    },
    INVOICE_PAY: {
        summary: 'Initiate Invoice Payment',
        description: 'Start the payment process for a specific client invoice.',
        tags: ['Client Services'],
    },
    BOOKING_REQUESTS: {
        summary: 'Submit Service Booking Request',
        description: 'Create a new service request that requires coordinator approval.',
        tags: ['Client Bookings'],
    },
};
