export const RouteRegistry = {
    LOGIN: '/login',
    REGISTER: '/register',
    BUSINESS_ONBOARD: '/onboard-business',
    DASHBOARD: '/admin/dashboard',
    USERS: '/admin/users',
    USERS_NEW: '/admin/users/new',
    USERS_EDIT: (id: string) => `/admin/users/${id}/edit`,
    VISITS: '/admin/visits',

    EARNINGS: '/admin/earnings',
    SCHEDULE: '/admin/schedule',
    INCIDENTS: '/admin/incidents',
    INCIDENTS_NEW: '/admin/incidents/new',
    INCIDENTS_EDIT: (id: string) => `/admin/incidents/${id}/edit`,

    LEADS: '/admin/leads',
    LEADS_NEW: '/admin/leads/new',
    LEADS_EDIT: (id: string) => `/admin/leads/${id}/edit`,

    INVOICES_NEW: '/admin/invoices/new',
    INVOICES_EDIT: (id: string) => `/admin/invoices/${id}/edit`,

    TIMESHEETS: '/admin/timesheets',
    TIMESHEET_ADJUST: '/admin/timesheets/adjust',

    REPORTS: '/admin/reports',
    SERVICES: '/admin/services',
    SETTINGS: '/admin/settings',
    CONTENT: '/admin/content',
    AUDITS: '/admin/audits',
    SUPPORT: '/admin/support',
    ADMISSION: '/admin/admission',
    ONBOARDING: '/admin/onboarding',
    SETUP_WIZARD: '/admin/setup-wizard',
    WIZARD_HUB: '/admin/wizard-hub',
    STAFF_ONBOARDING: '/admin/wizards/staff-onboarding',
    CARE_PLAN_WIZARD: '/admin/wizards/care-plan',
    REVENUE_WIZARD: '/admin/wizards/revenue',
    BUSINESS_MODEL_WIZARD: '/admin/wizards/business-strategy',
    BUSINESS_STATUS: '/admin/business-status',

    PLATFORM: {
        DASHBOARD: '/platform/dashboard',
        AUDIT_LOGS: '/platform/audit-logs',
        TENANTS: '/platform/tenants',
    },

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
        TRAINING_MODULES: '/managers/training/modules',
        SURVEYS: '/managers/surveys',
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
        FEEDBACK: '/client/feedback',
    },

    PROFILE: '/profile',
    MESSAGING: '/messaging',
    CARE_PLANS: '/care-plans',

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
        client: '/client/dashboard',
        super_admin: '/platform/dashboard'
    } as Record<string, string>
} as const;
