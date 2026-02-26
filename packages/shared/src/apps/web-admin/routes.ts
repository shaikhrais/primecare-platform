export const RouteRegistry = {
    LOGIN: '/login',
    REGISTER: '/register',
    DASHBOARD: '/admin/dashboard',
    USERS: '/admin/users',
    USERS_NEW: '/admin/users/new',
    USERS_EDIT: (id: string) => `/admin/users/${id}/edit`,
    VISITS: '/admin/visits',

    EARNINGS: '/admin/earnings',
    SCHEDULE: '/admin/schedule',
    INCIDENTS: '/admin/incidents',
    TIMESHEETS: '/admin/timesheets',
    LEADS: '/admin/leads',
    SERVICES: '/admin/services',
    SETTINGS: '/admin/settings',
    CONTENT: '/admin/content',
    AUDITS: '/admin/audits',
    SUPPORT: '/admin/support',
    ADMISSION: '/admin/admission',
    ONBOARDING: '/admin/onboarding',

    MANAGER: {
        DASHBOARD: '/managers/dashboard',
        PORTFOLIO: '/managers/portfolio',
        MARKETING: '/managers/marketing',
        OPERATIONS: '/managers/operations',
        CLINICAL: '/managers/clinical',
        REGIONAL: '/managers/regional',
        RECRUITING: '/managers/recruiting',
        COORDINATOR: '/managers/coordinator',
        CRM: '/managers/crm',
        TRAINING: '/managers/training',
        DAILY_ENTRY: '/managers/daily-entry',
        EVALUATIONS: '/managers/evaluations',
        SERVICE_REVIEW: '/managers/service-review',
    },

    STAFF: {
        DASHBOARD: '/staff/dashboard',
        CUSTOMERS: '/staff/customers',
    },

    PSW: {
        DASHBOARD: '/psw/dashboard',
        SCHEDULE: '/psw/schedule',
        OPEN_SHIFTS: '/psw/open-shifts',
        EARNINGS: '/psw/earnings',
        PROFILE: '/psw/profile',
    },

    RN: {
        DASHBOARD: '/rn/dashboard',
    },

    CLIENT: {
        DASHBOARD: '/client/dashboard',
        BOOKINGS: '/client/bookings',
        BILLING: '/client/billing',
    },

    ROLE_DASHBOARDS: {
        admin: '/admin/dashboard',
        manager: '/managers/dashboard',
        marketing_manager: '/managers/marketing',
        operations_manager: '/managers/operations',
        clinical_manager: '/managers/clinical',
        regional_manager: '/managers/regional',
        recruiting_manager: '/managers/recruiting',
        coordinator: '/managers/coordinator',
        crm: '/managers/crm',
        training: '/managers/training',
        staff: '/staff/dashboard',
        finance: '/staff/dashboard',
        hr: '/staff/dashboard',
        compliance: '/staff/dashboard',
        rn: '/rn/dashboard',
        psw: '/psw/dashboard',
        rmt: '/psw/dashboard',
        rpt: '/psw/dashboard',
        rch: '/psw/dashboard',
        client: '/client/dashboard'
    } as Record<string, string>
} as const;
