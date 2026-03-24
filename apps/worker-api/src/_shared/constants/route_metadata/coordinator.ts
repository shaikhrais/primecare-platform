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
    HOME_STATS: {
        summary: 'Get Coordinator Home Statistics',
        description: 'Retrieve operational statistics for the coordinator dispatcher hub.',
        tags: ['Coordinator Home'],
    },
    SOS_DISPATCH: {
        summary: 'Dispatch Emergency Replacement',
        description: 'Dispatches a new PSW to a visit that has an active SOS alert.',
        tags: ['Coordinator Dispatch'],
    },
    DISPATCH_MAP: {
        summary: 'Get Live Dispatch Map',
        description: 'Retrieve real-time GPS coordinates and statuses for field caregivers and clients.',
        tags: ['Coordinator Logistics'],
    },
    MATCHING_ENGINE: {
        summary: 'Run AI Shift Match',
        description: 'Triggers the AI matching engine to propose best-fit caregivers for open visits.',
        tags: ['Coordinator Logistics'],
    },
    MASTER_SCHEDULE: {
        summary: 'Get Master Schedule',
        description: 'Retrieve a unified master schedule of all visits, assignments, and field statuses for logistics oversight.',
        tags: ['Coordinator Logistics'],
    },
    SHIFT_BROADCAST: {
        summary: 'Broadcast Shift Offer',
        description: 'Broadcast a shift offer to multiple qualified caregivers simultaneously.',
        tags: ['Coordinator Dispatch'],
    },
};
