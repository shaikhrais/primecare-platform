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
    PUBLIC: {
        SERVICES: '/v1/public/services',
    },
} as const;
