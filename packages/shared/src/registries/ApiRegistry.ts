export const ApiRegistry = {
    AUTH: {
        LOGIN: '/v1/auth/login',
        REGISTER: '/v1/auth/register',
        FORGOT_PASSWORD: '/v1/auth/forgot-password',
        RESET_PASSWORD: '/v1/auth/reset-password',
    },
    USER: {
        PROFILE: '/v1/user/profile',
    },
    ADMIN: {
        USERS: '/v1/admin/users',
        USERS_VERIFY: (id: string) => `/v1/admin/users/${id}/verify`,
        PSW_APPROVE: (id: string) => `/v1/admin/psw/approve/${id}`,
        STATS: '/v1/admin/stats',
        SERVICES: '/v1/admin/services',
        CAMPAIGNS: '/v1/admin/marketing/campaigns',
        LEADS: '/v1/admin/leads',
        LEADS_UPDATE: (id: string) => `/v1/admin/leads/${id}`,
        VISITS: '/v1/admin/visits',
        VISITS_ASSIGN: '/v1/admin/visits/assign',
        VISITS_UNASSIGNED: '/v1/admin/visits/unassigned',
        VISITS_UPDATE: (id: string) => `/v1/admin/visits/${id}`,
    },
    PUBLIC: {
        LEADS: '/v1/public/leads',
        SERVICES: '/v1/public/services',
        BLOG: '/v1/public/blog',
    },
    CLIENT: {
        BOOKINGS: '/v1/client/bookings',
    },
    PSW: {
        VISITS: '/v1/psw/visits',
        CHECK_IN: (id: string) => `/v1/psw/visits/${id}/check-in`,
        CHECK_OUT: (id: string) => `/v1/psw/visits/${id}/check-out`,
    },
    STAFF: {
        CUSTOMERS: '/v1/staff/customers',
        TICKETS: '/v1/staff/tickets',
    },
    SUPPORT: {
        CHAT_HISTORY: '/v1/support/chat',
        TICKETS: '/v1/support/tickets',
    }
} as const;
