export const PSW_METADATA = {
    SCHEDULE: {
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
        LIST_MARKETPLACE: {
            summary: 'Get Marketplace Extends',
            description: 'Retrieve a list of unassigned open shifts in the marketplace.',
            tags: ['PSW Schedule'],
        },
        ACCEPT_MARKETPLACE: {
            summary: 'Accept Marketplace Shift',
            description: 'Accept an open shift from the marketplace and self-assign it.',
            tags: ['PSW Schedule'],
        },
    },
    EXTRA: {
        INCIDENTS_REPORT: {
            summary: 'Report Incident',
            description: 'Report an incident that occurred during or after a visit.',
            tags: ['PSW Incidents'],
        },
        HOME_STATS: {
            summary: 'Get PSW Home Statistics',
            description: 'Retrieve earnings, reliability, and shift distribution stats for the authenticated PSW.',
            tags: ['PSW Home'],
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
        HANDOVER_SUBMIT: {
            summary: 'Submit Shift Handover',
            description: 'Submit notes and concerns for the next shift provider.',
            tags: ['PSW Handover'],
        },
        AVAILABILITY_OVERRIDE_SYNC: {
            summary: 'Sync Availability Overrides',
            description: 'Update specific date availability overrides for the PSW.',
            tags: ['PSW Availability'],
        },
        PAYOUT_HISTORY: {
            summary: 'Get Payout History',
            description: 'Retrieve history of processed and pending payouts.',
            tags: ['PSW Payouts'],
        },
        WELLNESS_PULSE: {
            summary: 'Submit Wellness Pulse',
            description: 'Allows a PSW to report their current wellbeing and sentiment.',
            tags: ['PSW Wellness'],
        },
    },
};
