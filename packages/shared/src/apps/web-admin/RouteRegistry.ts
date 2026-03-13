// ──────────────────────────────────────────────────────────────────────────────
// RouteRegistry — Central route map for the web-admin app.
// Data split into sub-files under ./RouteRegistry/
// ──────────────────────────────────────────────────────────────────────────────

import { TENANCY_ROUTES } from './RouteRegistry/tenancy-routes';
import { PLATFORM_ROUTES } from './RouteRegistry/platform-routes';

const AUTH = {
    LOGIN: '/login',
    REGISTER: '/register',
    FORGOT_PASSWORD: '/forgot-password',
    RESET_PASSWORD: '/reset-password',
    BUSINESS_ONBOARD: '/onboard-business',
} as const;

const SHARED = {
    PROFILE: '/profile',
    MESSAGING: '/messaging',
    SUPPORT: '/support',
    SUPPORT_TICKETS_NEW: '/support/tickets/new',
    VISITS_DETAILS: (id: string) => `/visits/${id}`,
    VISITS_COMPLETE: (id: string) => `/visits/${id}/complete`,
    LEARN: '/learn',
    KNOWLEDGE_BASE: '/knowledge-base',
    KNOWLEDGE_BASE_ARTICLE: (slug: string) => `/knowledge-base/${slug}`,
    NOT_FOUND: '/shared/404',
    UNAUTHORIZED: '/shared/401',
    SERVER_ERROR: '/shared/500',
} as const;

export const RouteRegistry = {
    ...AUTH,
    ...SHARED,

    // Role-specific namespaces (Standard Access)
    ADMIN: PLATFORM_ROUTES.ADMIN,
    SUPERUSER: PLATFORM_ROUTES.SUPERUSER,
    MANAGER: TENANCY_ROUTES.MANAGER,
    STAFF: TENANCY_ROUTES.STAFF,
    PSW: TENANCY_ROUTES.PSW,
    RN: TENANCY_ROUTES.RN,
    CLIENT: TENANCY_ROUTES.CLIENT,
    COORDINATOR: TENANCY_ROUTES.COORDINATOR,
    ALLIED: TENANCY_ROUTES.ALLIED,
    CARE_PLANS: TENANCY_ROUTES.CARE_PLANS,
    SCRUM_MASTER: PLATFORM_ROUTES.SCRUM_MASTER,

    ROLE_DASHBOARDS: {
        admin: PLATFORM_ROUTES.ADMIN.DASHBOARD,
        reseller: PLATFORM_ROUTES.ADMIN.DASHBOARD,
        manager: TENANCY_ROUTES.MANAGER.DASHBOARD,
        marketing_manager: TENANCY_ROUTES.MANAGER.MARKETING,
        operations_manager: TENANCY_ROUTES.MANAGER.OPERATIONS,
        clinical_manager: TENANCY_ROUTES.MANAGER.CLINICAL,
        regional_manager: TENANCY_ROUTES.MANAGER.REGIONAL_STATS,
        recruiting_manager: TENANCY_ROUTES.MANAGER.RECRUITING,
        coordinator: TENANCY_ROUTES.COORDINATOR.DASHBOARD,
        crm: TENANCY_ROUTES.MANAGER.DASHBOARD,
        training: TENANCY_ROUTES.MANAGER.TRAINING,
        staff: TENANCY_ROUTES.STAFF.DASHBOARD,
        finance: TENANCY_ROUTES.STAFF.DASHBOARD,
        hr: TENANCY_ROUTES.STAFF.DASHBOARD,
        compliance: TENANCY_ROUTES.STAFF.DASHBOARD,
        rn: TENANCY_ROUTES.RN.DASHBOARD,
        psw: TENANCY_ROUTES.PSW.DASHBOARD,
        rmt: TENANCY_ROUTES.ALLIED.DASHBOARD,
        rpt: TENANCY_ROUTES.ALLIED.DASHBOARD,
        rch: TENANCY_ROUTES.ALLIED.DASHBOARD,
        client: TENANCY_ROUTES.CLIENT.DASHBOARD,
        super_admin: PLATFORM_ROUTES.SUPERUSER.DASHBOARD,
        scrum_master: PLATFORM_ROUTES.SCRUM_MASTER.DASHBOARD,
        finance_director: PLATFORM_ROUTES.ADMIN.FINANCE.DASHBOARD
    } as Record<string, string>,

    ROLE_EDITOR: PLATFORM_ROUTES.ADMIN.ROLE_EDITOR,
    LOCATIONS: PLATFORM_ROUTES.ADMIN.LOCATIONS,
    PRIVATE_MARKETPLACE: PLATFORM_ROUTES.ADMIN.PRIVATE_MARKETPLACE,
    TENANTS: PLATFORM_ROUTES.SUPERUSER.TENANTS,
} as const;
