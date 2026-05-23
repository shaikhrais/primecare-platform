// Governance - Category: service | Purpose: Core implementation file for the Api platform logic.
export const ApiRegistry = {
    AUTH: {
        LOGIN: '/v1/auth/login',
    },
    ADMIN: {
        USERS: '/v1/admin/users',
        PSW_APPROVE: (id: string) => `/v1/admin/psw/approve/${id}`,
        VISITS_UNASSIGNED: '/v1/admin/visits/unassigned',
        HOME_STATS: '/v1/admin/home/stats',
        SEARCH: '/v1/admin/search',
        REPORTS: '/v1/admin/reports/export',
    },
    CLIENT: {
        BOOKINGS: '/v1/client/bookings',
    },
    PSW: {
        SCHEDULE: '/v1/psw/schedule',
    },
    SUPERUSER: {
        TENANTS: '/v1/superuser/tenants',
        GOVERNANCE: '/v1/superuser/governance',
    },
    AI: {
        INSIGHTS: '/v1/ai/insights',
        PREDICTIVE: '/v1/ai/predictive',
        CHURN: '/v1/ai/churn',
        OPTIMIZATION: '/v1/ai/optimization',
    },
    SECURITY: {
        THREATS: '/v1/security/threats',
        SESSIONS: '/v1/security/sessions',
        PERMISSIONS: '/v1/security/permissions',
        AUDIT_LOGS: '/v1/security/audits',
    },
    OPS: {
        CAPACITY: '/v1/ops/capacity',
        REGIONS: '/v1/ops/regions',
        LOGISTICS: '/v1/ops/logistics',
    },
} as const;
