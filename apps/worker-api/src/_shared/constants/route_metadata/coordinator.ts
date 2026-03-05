export const COORDINATOR_METADATA = {
    MATCH_OVERRIDE: {
        summary: 'Override PSW Match',
        description: 'Manually override a PSW assignment for a specific visit.',
        tags: ['Coordinator Logistics'],
    },
    WAITLIST_SYNC: {
        summary: 'Sync Waitlist Priorities',
        description: 'Update and synchronize waitlist entry priorities for client inflow.',
        tags: ['Coordinator Logistics'],
    },
    SOS_ACK: {
        summary: 'Acknowledge SOS Alert',
        description: 'Record an acknowledgement for a high-priority SOS emergency alert.',
        tags: ['Coordinator Logistics'],
    },
    DASHBOARD_STATS: {
        summary: 'Get Coordinator Dashboard Statistics',
        description: 'Retrieve operational statistics for the coordinator dispatcher hub.',
        tags: ['Coordinator Dashboard'],
    },
};
