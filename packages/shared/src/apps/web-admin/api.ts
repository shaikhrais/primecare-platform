export const ApiRegistry = {
    AUTH: {
        LOGIN: '/v1/auth/login',
    },
    ADMIN: {
        USERS: '/v1/admin/users',
        PSW_APPROVE: (id: string) => `/v1/admin/psw/approve/${id}`,
        VISITS_UNASSIGNED: '/v1/admin/visits/unassigned',
        DASHBOARD_STATS: '/v1/admin/dashboard/stats',
    },
    CLIENT: {
        BOOKINGS: '/v1/client/bookings',
    },
    PSW: {
        SCHEDULE: '/v1/psw/schedule',
    },
    SUPERUSER: {
        TENANTS: '/v1/superuser/tenants',
    },
} as const;
