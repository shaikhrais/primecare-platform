export const ApiRegistry = {
    AUTH: {
        LOGIN: '/v1/auth/login',
    },
    ADMIN: {
        USERS: '/v1/admin/users',
        PSW_APPROVE: (id: string) => `/v1/admin/psw/approve/${id}`,
        VISITS_UNASSIGNED: '/v1/admin/visits/unassigned',
    },
} as const;
