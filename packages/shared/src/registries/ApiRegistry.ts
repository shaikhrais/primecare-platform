const TENANCY = {
    MANAGER: {
        DASHBOARD_KPI: '/v1/manager/dashboard/kpi',
        DASHBOARD_TODAY: '/v1/manager/dashboard/today',
        DASHBOARD_STATS: '/v1/manager/dashboard/stats',
    },
    CLIENT: {
        BOOKINGS: '/v1/client/bookings',
        INVOICES: '/v1/client/invoices',
        SERVICES: '/v1/client/services',
        DASHBOARD_STATS: '/v1/client/dashboard/stats',
    },
    PSW: {
        VISITS: '/v1/psw/schedule/visits',
        CHECK_IN: (id: string) => `/v1/psw/schedule/visits/${id}/check-in`,
        CHECK_OUT: (id: string) => `/v1/psw/schedule/visits/${id}/check-out`,
        PAYOUT_REQUEST: '/v1/psw/schedule/payouts/request',
        DASHBOARD_STATS: '/v1/psw/dashboard/stats',
    },
    RN: {
        DASHBOARD_STATS: '/v1/rn/dashboard/stats',
    },
    STAFF: {
        CUSTOMERS: '/v1/staff/customers',
        TICKETS: '/v1/staff/tickets',
        DASHBOARD_STATS: '/v1/staff/dashboard/stats',
    },
} as const;

const PLATFORM = {
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
        INCIDENTS: '/v1/admin/incidents',
        TIMESHEETS: '/v1/admin/timesheets',
        INVOICES: '/v1/admin/invoices',
        CLIENTS: '/v1/admin/clients',
        SETTINGS_BUSINESS_MODEL: '/v1/admin/settings/business-model',
        SETTINGS_LOGO: '/v1/admin/settings/logo',
    },
    SYSTEM: {
        NOTIFICATIONS: '/v1/system/notifications',
        MARK_READ: (id: string) => `/v1/system/notifications/${id}/read`,
        PLATFORM_STATS: '/v1/system/platform/stats',
    },
    SUPERUSER: {
        TENANTS: '/v1/superuser/tenants',
        AUDIT_LOGS: '/v1/superuser/audit-logs',
    }
} as const;

export const ApiRegistry = {
    AUTH: {
        LOGIN: '/v1/auth/login',
        REGISTER: '/v1/auth/register',
        FORGOT_PASSWORD: '/v1/auth/forgot-password',
        RESET_PASSWORD: '/v1/auth/reset-password',
        LOGOUT: '/v1/auth/logout',
        SWITCH_ROLE: '/v1/auth/switch-role',
        REFRESH: '/v1/auth/refresh',
        IMPERSONATE: '/v1/auth/impersonate',
    },
    USER: {
        PROFILE: '/v1/user/profile',
    },
    ...PLATFORM,
    TENANCY,

    // Legacy mapping
    MANAGER: TENANCY.MANAGER,
    CLIENT: TENANCY.CLIENT,
    PSW: TENANCY.PSW,
    RN: TENANCY.RN,
    STAFF: TENANCY.STAFF,
    SYSTEM: PLATFORM.SYSTEM,

    PUBLIC: {
        LEADS: '/v1/public/leads',
        SERVICES: '/v1/public/services',
        BLOG: '/v1/public/blog',
    },
    SUPPORT: {
        CHAT_HISTORY: '/v1/support/chat',
        TICKETS: '/v1/support/tickets',
    }
} as const;
