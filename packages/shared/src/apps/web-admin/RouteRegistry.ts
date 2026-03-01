const TENANCY = {
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
    CARE_PLANS: '/care-plans',
} as const;

const PLATFORM = {
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

    SUPERUSER: {
        DASHBOARD: '/platform/dashboard',
        AUDIT_LOGS: '/platform/audit-logs',
        TENANTS: '/platform/tenants',
    }
} as const;

const AUTH = {
    LOGIN: '/login',
    REGISTER: '/register',
    BUSINESS_ONBOARD: '/onboard-business',
} as const;

export const RouteRegistry = {
    ...AUTH,
    ...PLATFORM,
    TENANCY,
    PLATFORM: {
        ...PLATFORM.SUPERUSER,
        ...PLATFORM,
    },

    // Legacy mapping (flattened for easy access)
    MANAGER: TENANCY.MANAGER,
    STAFF: TENANCY.STAFF,
    PSW: TENANCY.PSW,
    RN: TENANCY.RN,
    CLIENT: TENANCY.CLIENT,

    PROFILE: '/profile',
    MESSAGING: '/messaging',

    ROLE_DASHBOARDS: {
        admin: PLATFORM.DASHBOARD,
        manager: TENANCY.MANAGER.DASHBOARD,
        marketing_manager: TENANCY.MANAGER.MARKETING,
        operations_manager: TENANCY.MANAGER.OPERATIONS,
        clinical_manager: TENANCY.MANAGER.CLINICAL,
        regional_manager: TENANCY.MANAGER.REGIONAL,
        recruiting_manager: TENANCY.MANAGER.RECRUITING,
        coordinator: TENANCY.MANAGER.COORDINATOR,
        crm: TENANCY.MANAGER.CRM,
        training: TENANCY.MANAGER.TRAINING,
        staff: TENANCY.STAFF.DASHBOARD,
        finance: TENANCY.STAFF.DASHBOARD,
        hr: TENANCY.STAFF.DASHBOARD,
        compliance: TENANCY.STAFF.DASHBOARD,
        rn: TENANCY.RN.DASHBOARD,
        psw: TENANCY.PSW.DASHBOARD,
        rmt: TENANCY.PSW.DASHBOARD,
        rpt: TENANCY.PSW.DASHBOARD,
        rch: TENANCY.PSW.DASHBOARD,
        client: TENANCY.CLIENT.DASHBOARD,
        super_admin: '/platform/dashboard'
    } as Record<string, string>
} as const;
