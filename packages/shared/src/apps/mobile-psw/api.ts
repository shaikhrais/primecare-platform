export const ApiRegistry = {
    AUTH: {
        LOGIN: '/v1/auth/login',
        REGISTER: '/v1/auth/register',
    },
    CLIENT: {
        PROFILE: '/v1/client/profile',
        BOOKINGS: '/v1/client/bookings',
        INVOICES: '/v1/client/invoices',
    },
    PSW: {
        PROFILE: '/v1/psw/profile',
        VISITS: '/v1/psw/visits',
        CHECK_IN: (id: string) => `/v1/psw/visits/${id}/check-in`,
        CHECK_OUT: (id: string) => `/v1/psw/visits/${id}/check-out`,
    },
    PUBLIC: {
        LEADS: '/v1/public/leads',
        SERVICES: '/v1/public/services',
        BLOG: '/v1/public/blog',
    },
} as const;
