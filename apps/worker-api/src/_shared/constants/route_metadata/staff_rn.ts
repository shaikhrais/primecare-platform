export const STAFF_METADATA = {
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
    DASHBOARD_STATS: {
        summary: 'Get Staff Dashboard Statistics',
        description: 'Retrieve various operational statistics for the staff coordinator dashboard.',
        tags: ['Staff Dashboard'],
    },
};

export const RN_METADATA = {
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
};
