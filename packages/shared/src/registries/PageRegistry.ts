// ──────────────────────────────────────────────────────────────────────────────
// PageRegistry — Master catalogue of EVERY page in the platform, classified
// by type. Sub-registries (DashboardRegistry, FormRegistry, ListRegistry, etc.)
// provide type-specific metadata. This is the single source of truth for all
// page discovery, navigation, and govquernance.
// ──────────────────────────────────────────────────────────────────────────────

// ── Page Type Definitions ────────────────────────────────────────────────────

export type PageType =
    | 'dashboard'    // KPI summary, stats cards, charts
    | 'form'         // Data entry / creation / editing
    | 'list'         // Table / grid / list of records
    | 'hub'          // Multi-panel feature center
    | 'wizard'       // Multi-step guided flow
    | 'detail'       // Single-record detail / viewer
    | 'settings'     // Configuration / preferences
    | 'report'       // Charts, exports, analytics
    | 'tool'         // Utility / DevOps / governance tool
    | 'portal'       // External-facing or role-specific portal
    | 'registry'     // Internal registry browser (FormRegistry, etc.)
    | 'error';       // 404, 401, 500 pages

export interface PageEntry {
    /** Global serial number (1, 2, 3, ...) — unique across ALL pages */
    srNo: number;
    /** Category-specific code (D1, D2 for dashboards, F1, F2 for forms, L1, L2 for lists, etc.) */
    categoryCode: string;
    /** Unique page identifier (dot-namespace) */
    id: string;
    /** Human-readable page title with embedded identity: "[#1 D1] Admin Dashboard" */
    label: string;
    /** Original label without identity prefix (for contexts that need the clean name) */
    originalLabel?: string;
    /** Frontend route */
    route: string;
    /** Page type classification */
    type: PageType;
    /** Which role/domain owns this page */
    owner: 'admin' | 'superuser' | 'manager' | 'staff' | 'psw' | 'rn' |
           'client' | 'coordinator' | 'allied' | 'scrum-master' | 'auth' | 'shared';
    /** Icon hint for UI */
    icon?: string;
    /** Brief description */
    description?: string;
    /** Reference to FormRegistry entry ID (if type === 'form') */
    formRegistryId?: string;
    /** Reference to DashboardRegistry entry (if type === 'dashboard') */
    dashboardRegistryId?: string;
}

/** Category code prefixes for each page type */
export const CATEGORY_PREFIXES: Record<PageType, string> = {
    dashboard: 'D',
    form:      'F',
    list:      'L',
    hub:       'H',
    wizard:    'W',
    detail:    'DT',
    settings:  'S',
    report:    'R',
    tool:      'T',
    portal:    'P',
    registry:  'G',
    error:     'E',
};

// ── DASHBOARD REGISTRY (Sub-Registry) ────────────────────────────────────────

export interface DashboardEntry {
    id: string;
    label: string;
    route: string;
    owner: PageEntry['owner'];
    /** API endpoints powering the dashboard stats */
    statsEndpoints: string[];
    /** Widget types displayed */
    widgets: ('kpi-card' | 'chart' | 'table' | 'map' | 'calendar' | 'feed' | 'alert-panel')[];
    icon?: string;
}

export const DashboardRegistry: DashboardEntry[] = [
    // ── Platform Dashboards ──
    { id: 'admin.dashboard', label: 'Admin Dashboard', route: '/platform/admin', owner: 'admin', statsEndpoints: ['/v1/admin/stats'], widgets: ['kpi-card', 'chart', 'table'], icon: '⚙️' },
    { id: 'admin.summary', label: 'Registry Summary', route: '/platform/admin/summary-dashboard', owner: 'admin', statsEndpoints: ['/v1/admin/stats'], widgets: ['kpi-card', 'chart'], icon: '📊' },
    { id: 'admin.finance', label: 'Finance Dashboard', route: '/platform/admin/finance/dashboard', owner: 'admin', statsEndpoints: ['/v1/admin/financial/reports/daily-summary'], widgets: ['kpi-card', 'chart', 'table'], icon: '💰' },
    { id: 'admin.evv', label: 'EVV Dashboard', route: '/platform/admin/evv', owner: 'admin', statsEndpoints: ['/v1/admin/evv', '/v1/admin/evv/compliance-summary'], widgets: ['kpi-card', 'chart', 'table'], icon: '📍' },
    { id: 'admin.ai', label: 'AI Dashboard', route: '/platform/admin/ai', owner: 'admin', statsEndpoints: ['/v1/ai/insights'], widgets: ['kpi-card', 'chart'], icon: '🤖' },
    { id: 'admin.cron', label: 'Cron Dashboard', route: '/platform/admin/cron-dashboard', owner: 'admin', statsEndpoints: ['/v1/admin/cron/compliance-sweep'], widgets: ['kpi-card', 'table'], icon: '⏰' },
    { id: 'admin.security', label: 'Security Dashboard', route: '/platform/admin/security', owner: 'admin', statsEndpoints: ['/v1/security/threats'], widgets: ['kpi-card', 'chart', 'alert-panel'], icon: '🛡️' },
    { id: 'superuser.dashboard', label: 'Superuser Dashboard', route: '/platform', owner: 'superuser', statsEndpoints: ['/v1/superuser/health/summary'], widgets: ['kpi-card', 'chart'], icon: '👑' },
    { id: 'scrum-master.dashboard', label: 'Scrum Master Dashboard', route: '/platform/scrum-master', owner: 'scrum-master', statsEndpoints: ['/v1/scrum-master/stats'], widgets: ['kpi-card', 'table'], icon: '🔧' },

    // ── Tenancy Dashboards ──
    { id: 'manager.dashboard', label: 'Manager Dashboard', route: '/tenancy/manager', owner: 'manager', statsEndpoints: ['/v1/manager/dashboard/kpi', '/v1/manager/dashboard/today'], widgets: ['kpi-card', 'chart', 'table', 'calendar'], icon: '📊' },
    { id: 'staff.dashboard', label: 'Staff Dashboard', route: '/tenancy/staff', owner: 'staff', statsEndpoints: ['/v1/staff/dashboard/stats'], widgets: ['kpi-card', 'table'], icon: '👥' },
    { id: 'psw.dashboard', label: 'PSW Dashboard', route: '/tenancy/psw', owner: 'psw', statsEndpoints: ['/v1/psw/dashboard/stats'], widgets: ['kpi-card', 'calendar', 'feed'], icon: '🩺' },
    { id: 'rn.dashboard', label: 'RN Dashboard', route: '/tenancy/rn', owner: 'rn', statsEndpoints: ['/v1/rn/dashboard/stats'], widgets: ['kpi-card', 'table', 'chart'], icon: '💉' },
    { id: 'coordinator.dashboard', label: 'Coordinator Dashboard', route: '/tenancy/coordinator', owner: 'coordinator', statsEndpoints: ['/v1/coordinator/dashboard/stats'], widgets: ['kpi-card', 'map', 'table'], icon: '📍' },
    { id: 'client.dashboard', label: 'Client Dashboard', route: '/tenancy/client', owner: 'client', statsEndpoints: ['/v1/client/dashboard/stats'], widgets: ['kpi-card', 'calendar', 'feed'], icon: '👤' },
    { id: 'allied.dashboard', label: 'Allied Health Dashboard', route: '/tenancy/allied-health', owner: 'allied', statsEndpoints: [], widgets: ['kpi-card', 'table'], icon: '🏥' },
];

// ── LIST REGISTRY (Sub-Registry) ─────────────────────────────────────────────

export interface ListEntry {
    id: string;
    label: string;
    route: string;
    owner: PageEntry['owner'];
    /** API endpoint that powers the list */
    fetchEndpoint: string;
    /** Columns displayed */
    columns: string[];
    /** Supports search? */
    searchable: boolean;
    /** Supports filters? */
    filterable: boolean;
}

export const ListRegistry: ListEntry[] = [
    { id: 'admin.users', label: 'User List', route: '/platform/admin/users', owner: 'admin', fetchEndpoint: '/v1/admin/users', columns: ['name', 'email', 'role', 'status'], searchable: true, filterable: true },
    { id: 'admin.incidents', label: 'Incident List', route: '/platform/admin/incidents', owner: 'admin', fetchEndpoint: '/v1/admin/incidents', columns: ['title', 'severity', 'status', 'date'], searchable: true, filterable: true },
    { id: 'admin.leads', label: 'Leads Pipeline', route: '/platform/admin/leads', owner: 'admin', fetchEndpoint: '/v1/admin/leads', columns: ['name', 'source', 'status', 'date'], searchable: true, filterable: true },
    { id: 'admin.timesheets', label: 'Timesheets', route: '/platform/admin/timesheets', owner: 'admin', fetchEndpoint: '/v1/admin/timesheets', columns: ['psw', 'date', 'hours', 'status'], searchable: true, filterable: true },
    { id: 'admin.services', label: 'Services', route: '/platform/admin/services', owner: 'admin', fetchEndpoint: '/v1/admin/services', columns: ['name', 'rate', 'category', 'status'], searchable: true, filterable: false },
    { id: 'admin.audits', label: 'Audit Logs', route: '/platform/admin/audits', owner: 'admin', fetchEndpoint: '/v1/superuser/audit-logs', columns: ['action', 'user', 'resource', 'timestamp'], searchable: true, filterable: true },
    { id: 'admin.authorizations', label: 'Authorizations', route: '/platform/admin/authorizations', owner: 'admin', fetchEndpoint: '/v1/admin/authorizations', columns: ['client', 'service', 'units', 'expiry'], searchable: true, filterable: true },
    { id: 'admin.consent', label: 'Consent Records', route: '/platform/admin/consent', owner: 'admin', fetchEndpoint: '/v1/admin/consent/templates', columns: ['client', 'type', 'status', 'expiry'], searchable: true, filterable: true },
    { id: 'admin.referrals', label: 'Referrals', route: '/platform/admin/referrals', owner: 'admin', fetchEndpoint: '/v1/admin/referrals', columns: ['name', 'source', 'status', 'date'], searchable: true, filterable: true },
    { id: 'admin.claims', label: 'Claims', route: '/platform/admin/claims', owner: 'admin', fetchEndpoint: '/v1/admin/claims', columns: ['claimId', 'client', 'amount', 'status'], searchable: true, filterable: true },
    { id: 'admin.webhooks', label: 'Webhooks', route: '/platform/admin/webhooks', owner: 'admin', fetchEndpoint: '/v1/admin/webhooks', columns: ['url', 'events', 'status', 'lastDelivery'], searchable: false, filterable: true },
    { id: 'admin.booking-requests', label: 'Booking Requests', route: '/platform/admin/booking-requests', owner: 'admin', fetchEndpoint: '/v1/admin/booking-requests', columns: ['client', 'service', 'date', 'status'], searchable: true, filterable: true },
    { id: 'superuser.tenants', label: 'Tenants', route: '/platform/tenants', owner: 'superuser', fetchEndpoint: '/v1/superuser/tenants', columns: ['name', 'slug', 'plan', 'status'], searchable: true, filterable: true },
    { id: 'superuser.audit-logs', label: 'Platform Audit Logs', route: '/platform/audit-logs', owner: 'superuser', fetchEndpoint: '/v1/superuser/audit-logs', columns: ['action', 'tenant', 'user', 'timestamp'], searchable: true, filterable: true },
    { id: 'admin.customers', label: 'Customers', route: '/platform/admin/customers', owner: 'admin', fetchEndpoint: '/v1/staff/customers', columns: ['name', 'email', 'phone', 'status'], searchable: true, filterable: true },
    // Client / PSW lists
    { id: 'client.bookings', label: 'My Bookings', route: '/tenancy/client/bookings', owner: 'client', fetchEndpoint: '/v1/client/bookings', columns: ['date', 'service', 'provider', 'status'], searchable: false, filterable: true },
    { id: 'psw.schedule', label: 'Visit Schedule', route: '/tenancy/psw/schedule', owner: 'psw', fetchEndpoint: '/v1/psw/schedule/visits', columns: ['date', 'client', 'time', 'status'], searchable: false, filterable: true },
    { id: 'staff.customers', label: 'Staff Customers', route: '/tenancy/staff/customers', owner: 'staff', fetchEndpoint: '/v1/staff/customers', columns: ['name', 'email', 'status'], searchable: true, filterable: false },
    { id: 'staff.tasks', label: 'Task Grid', route: '/tenancy/staff/tasks', owner: 'staff', fetchEndpoint: '/v1/staff/tasks/grid', columns: ['title', 'assignee', 'priority', 'due'], searchable: true, filterable: true },
];

// ── HUB REGISTRY (Sub-Registry) ──────────────────────────────────────────────

export interface HubEntry {
    id: string;
    label: string;
    route: string;
    owner: PageEntry['owner'];
    description: string;
    /** Sub-sections within the hub */
    sections: string[];
}

export const HubRegistry: HubEntry[] = [
    { id: 'admin.telehealth', label: 'Telehealth Center', route: '/platform/admin/telehealth/center', owner: 'admin', description: 'Video visits, vital signs, session management', sections: ['Sessions', 'Alerts', 'Vitals'] },
    { id: 'admin.pharmacy', label: 'Pharmacy Hub', route: '/platform/admin/pharmacy/hub', owner: 'admin', description: 'Prescriptions, orders, MAR, barcode verification', sections: ['Prescriptions', 'Orders', 'MAR', 'Barcode'] },
    { id: 'admin.rcm', label: 'Revenue Cycle Hub', route: '/platform/admin/rcm/claims', owner: 'admin', description: 'Claims processing, revenue sync', sections: ['Claims', 'Revenue'] },
    { id: 'admin.erp', label: 'Supply Chain Hub', route: '/platform/admin/erp/inventory', owner: 'admin', description: 'Inventory, suppliers, purchase orders', sections: ['Inventory', 'Procurement'] },
    { id: 'admin.notifications', label: 'Notifications Hub', route: '/platform/admin/notifications', owner: 'admin', description: 'Broadcast, family, read status', sections: ['Inbox', 'Broadcast', 'Family'] },
    { id: 'admin.documents', label: 'Document Center', route: '/platform/admin/documents', owner: 'admin', description: 'Upload, download, verify documents', sections: ['Library', 'Upload', 'Verification'] },
    { id: 'admin.payroll', label: 'Payroll Hub', route: '/platform/admin/payroll', owner: 'admin', description: 'Pending approvals, batch runs, summaries', sections: ['Pending', 'Batch', 'Summary'] },
    { id: 'admin.knowledge-base', label: 'Knowledge Base', route: '/platform/admin/knowledge-base', owner: 'admin', description: 'Articles, guides, reference material', sections: ['Articles', 'Search'] },
    { id: 'admin.reference-data', label: 'Reference Data Hub', route: '/platform/admin/reference-data', owner: 'admin', description: 'Insurance providers, billing codes', sections: ['Insurance', 'Billing Codes'] },
    { id: 'admin.logistics', label: 'Logistics Hub', route: '/platform/admin/ops/logistics', owner: 'admin', description: 'Route optimization, fleet management', sections: ['Routes', 'Fleet', 'Dispatch'] },
    { id: 'coordinator.hub', label: 'Coordinator Hub', route: '/tenancy/coordinator/hub', owner: 'coordinator', description: 'Dispatch, matching, scheduling', sections: ['Dispatch', 'Matching', 'Schedule'] },
    { id: 'client.family', label: 'Family Hub', route: '/tenancy/client/family-hub', owner: 'client', description: 'Family members, feed, messaging', sections: ['Members', 'Feed', 'Messages'] },
    { id: 'coordinator.sos', label: 'SOS Center', route: '/tenancy/coordinator/sos-center', owner: 'coordinator', description: 'Emergency response, dispatch, acknowledgment', sections: ['Active', 'Dispatch', 'History'] },
    { id: 'superuser.governance', label: 'Governance Hub', route: '/platform/governance', owner: 'superuser', description: 'Platform governance, policies, risk', sections: ['Policies', 'Risk', 'SLA'] },
];

// ── WIZARD REGISTRY (Sub-Registry) ───────────────────────────────────────────

export interface WizardEntry {
    id: string;
    label: string;
    route: string;
    owner: PageEntry['owner'];
    steps: string[];
    formRegistryId?: string;
}

export const WizardRegistry: WizardEntry[] = [
    { id: 'admin.setup-wizard', label: 'Business Setup Wizard', route: '/platform/admin/setup-wizard', owner: 'admin', steps: ['Business Info', 'Services', 'Users', 'Settings'] },
    { id: 'admin.staff-onboarding', label: 'Staff Onboarding Wizard', route: '/platform/admin/wizards/staff-onboarding', owner: 'admin', steps: ['Personal Info', 'Role', 'Certifications', 'Review'], formRegistryId: 'admin.wizard.staff-onboarding' },
    { id: 'admin.care-plan', label: 'Care Plan Wizard', route: '/platform/admin/wizards/care-plan', owner: 'admin', steps: ['Client', 'Service', 'Goals', 'Schedule'], formRegistryId: 'admin.wizard.care-plan' },
    { id: 'admin.revenue', label: 'Revenue Wizard', route: '/platform/admin/wizards/revenue', owner: 'admin', steps: ['Sources', 'Projections', 'Review'] },
    { id: 'admin.business-model', label: 'Business Model Wizard', route: '/platform/admin/wizards/business-strategy', owner: 'admin', steps: ['Strategy', 'Markets', 'Pricing', 'Review'] },
];

// ── REPORT REGISTRY (Sub-Registry) ───────────────────────────────────────────

export interface ReportEntry {
    id: string;
    label: string;
    route: string;
    owner: PageEntry['owner'];
    fetchEndpoint: string;
    exportFormats: ('pdf' | 'csv' | 'xlsx')[];
}

export const ReportRegistry: ReportEntry[] = [
    { id: 'admin.reports', label: 'Report Center', route: '/platform/admin/reports', owner: 'admin', fetchEndpoint: '/v1/admin/reports/export', exportFormats: ['pdf', 'csv'] },
    { id: 'admin.report-export', label: 'Export Page', route: '/platform/admin/reports/export', owner: 'admin', fetchEndpoint: '/v1/admin/reports/export', exportFormats: ['pdf', 'csv', 'xlsx'] },
    { id: 'admin.trading', label: 'Trading Account', route: '/platform/admin/finance/trading', owner: 'admin', fetchEndpoint: '/v1/admin/financial/reports/trading-account', exportFormats: ['pdf', 'csv'] },
    { id: 'admin.profit-loss', label: 'Profit & Loss', route: '/platform/admin/finance/p-and-l', owner: 'admin', fetchEndpoint: '/v1/admin/financial/reports/p-and-l', exportFormats: ['pdf', 'xlsx'] },
    { id: 'admin.balance-sheet', label: 'Balance Sheet', route: '/platform/admin/finance/balance-sheet', owner: 'admin', fetchEndpoint: '/v1/admin/financial/reports/balance-sheet', exportFormats: ['pdf', 'xlsx'] },
    { id: 'admin.reconciliation', label: 'Financial Reconciliation', route: '/platform/admin/finance/reconciliation', owner: 'admin', fetchEndpoint: '/v1/admin/financial/reconcile', exportFormats: ['csv'] },
    { id: 'admin.evv-export', label: 'EVV Export', route: '/platform/admin/evv/export', owner: 'admin', fetchEndpoint: '/v1/admin/evv/export', exportFormats: ['csv', 'xlsx'] },
    { id: 'admin.audit-download', label: 'Audit Download', route: '/platform/admin/audit-export', owner: 'admin', fetchEndpoint: '/v1/admin/audit-export/download', exportFormats: ['pdf', 'csv'] },
    { id: 'admin.compliance-export', label: 'Compliance Export', route: '/platform/admin/audit-export/compliance', owner: 'admin', fetchEndpoint: '/v1/admin/audit-export/compliance-dashboard', exportFormats: ['pdf'] },
    { id: 'admin.regulatory', label: 'Regulatory Report', route: '/platform/admin/audit-export/regulatory', owner: 'admin', fetchEndpoint: '/v1/admin/audit-export/regulatory-report', exportFormats: ['pdf'] },
    { id: 'admin.referral-analytics', label: 'Referral Analytics', route: '/platform/admin/referrals/analytics', owner: 'admin', fetchEndpoint: '/v1/admin/referrals/analytics', exportFormats: ['csv'] },
    { id: 'admin.claims-era', label: 'Claims ERA', route: '/platform/admin/claims/era', owner: 'admin', fetchEndpoint: '/v1/admin/claims/era', exportFormats: ['csv'] },
];

// ── TOOL REGISTRY (Sub-Registry) ─────────────────────────────────────────────

export interface ToolEntry {
    id: string;
    label: string;
    route: string;
    owner: PageEntry['owner'];
    description: string;
}

export const ToolRegistry: ToolEntry[] = [
    { id: 'admin.search', label: 'Global Search', route: '/platform/admin/search', owner: 'admin', description: 'Platform-wide search' },
    { id: 'admin.content', label: 'Content Manager', route: '/platform/admin/content', owner: 'admin', description: 'CMS & content publishing' },
    { id: 'admin.template-editor', label: 'Template Editor', route: '/platform/admin/template-editor', owner: 'admin', description: 'Edit email & notification templates' },
    { id: 'admin.role-editor', label: 'Role Editor', route: '/platform/admin/role-editor', owner: 'admin', description: 'RBAC role configuration' },
    { id: 'admin.interop', label: 'FHIR Center', route: '/platform/admin/interop', owner: 'admin', description: 'HL7 FHIR data exchange' },
    { id: 'admin.sovereign', label: 'Sovereign Wallet', route: '/platform/admin/sovereign', owner: 'admin', description: 'Decentralized identity management' },
    { id: 'admin.autopilot', label: 'Clinical AutoPilot', route: '/platform/admin/automation/clinical-autopilot', owner: 'admin', description: 'AI-powered clinical automation' },
    { id: 'admin.clinical-assistant', label: 'Clinical Assistant', route: '/platform/admin/clinical-assistant', owner: 'admin', description: 'AI clinical decision support' },
    { id: 'admin.ai-insights', label: 'AI Insights', route: '/platform/admin/insights', owner: 'admin', description: 'AI-powered platform insights' },
    // Security tools
    { id: 'admin.permission-grid', label: 'Permission Grid', route: '/platform/admin/security/permissions', owner: 'admin', description: 'Visual RBAC permission matrix' },
    { id: 'admin.session-monitor', label: 'Session Monitor', route: '/platform/admin/security/sessions', owner: 'admin', description: 'Active session monitoring' },
    { id: 'admin.threat-detection', label: 'Threat Detection', route: '/platform/admin/security/threats', owner: 'admin', description: 'Security threat monitoring' },
    { id: 'admin.device-registry', label: 'Device Registry', route: '/platform/admin/security/devices', owner: 'admin', description: 'Registered device management' },
    { id: 'admin.forensic-trails', label: 'Forensic Trails', route: '/platform/admin/security/forensic', owner: 'admin', description: 'Deep forensic audit trails' },
    { id: 'admin.cors-settings', label: 'CORS Settings', route: '/platform/admin/security/cors', owner: 'admin', description: 'Cross-origin policy configuration' },
    { id: 'admin.integrity-scan', label: 'Integrity Verification', route: '/platform/admin/security/integrity', owner: 'admin', description: 'Integrity hash verification' },
    { id: 'admin.financial-ledger', label: 'Financial Ledger', route: '/platform/admin/security/ledger', owner: 'admin', description: 'Double-entry accounting ledger' },
    { id: 'admin.tax-hub', label: 'Tax Compliance', route: '/platform/admin/security/tax-hub', owner: 'admin', description: 'HST/GST remittance management' },
    // Scrum Master tools
    { id: 'sm.api-endpoints', label: 'API Endpoints', route: '/platform/scrum-master/api-endpoints', owner: 'scrum-master', description: 'API registry & health' },
    { id: 'sm.pages', label: 'Page Catalog', route: '/platform/scrum-master/pages', owner: 'scrum-master', description: 'Frontend page registry' },
    { id: 'sm.components', label: 'Component Catalog', route: '/platform/scrum-master/components', owner: 'scrum-master', description: 'UI component registry' },
    { id: 'sm.role-flows', label: 'Role Flows', route: '/platform/scrum-master/role-flows', owner: 'scrum-master', description: 'Role-based user journey mapping' },
    { id: 'sm.monitoring', label: 'Monitoring', route: '/platform/scrum-master/monitoring', owner: 'scrum-master', description: 'Live monitoring dashboard' },
    { id: 'sm.env-audit', label: 'Environment Audit', route: '/platform/scrum-master/env-audit', owner: 'scrum-master', description: 'Environment variable audit' },
    { id: 'sm.registry-check', label: 'Registry Check', route: '/platform/scrum-master/registry-check', owner: 'scrum-master', description: 'Registry health check' },
    { id: 'sm.database-schema', label: 'Database Schema', route: '/platform/scrum-master/database-schema', owner: 'scrum-master', description: 'Schema viewer & migration tool' },
    { id: 'sm.theme-center', label: 'Theme Center', route: '/platform/scrum-master/theme-center', owner: 'scrum-master', description: 'Design system & theme tokens' },
    { id: 'sm.performance', label: 'Performance', route: '/platform/scrum-master/performance', owner: 'scrum-master', description: 'Performance profiling' },
    { id: 'sm.build-health', label: 'Build Health', route: '/platform/scrum-master/builds', owner: 'scrum-master', description: 'CI/CD build status' },
    { id: 'sm.security-scans', label: 'Security Scans', route: '/platform/scrum-master/security-scans', owner: 'scrum-master', description: 'Automated security scanning' },
    { id: 'sm.localization', label: 'Localization', route: '/platform/scrum-master/locales', owner: 'scrum-master', description: 'i18n translation management' },
    { id: 'sm.interaction-audit', label: 'Interaction Audit', route: '/platform/scrum-master/interaction-audit', owner: 'scrum-master', description: 'Interactive element audit' },
    { id: 'sm.auto-fix', label: 'Auto-Fix', route: '/platform/scrum-master/auto-fix', owner: 'scrum-master', description: 'Automated issue resolution' },
    { id: 'sm.impersonate', label: 'Impersonate User', route: '/platform/scrum-master/impersonate', owner: 'scrum-master', description: 'User impersonation for debugging' },
    { id: 'sm.response-bot', label: 'Response Bot', route: '/platform/scrum-master/response-bot', owner: 'scrum-master', description: 'Automated response validation' },
    // Coordinator tools
    { id: 'coordinator.dispatch-map', label: 'Dispatch Map', route: '/tenancy/coordinator/dispatch-map', owner: 'coordinator', description: 'Real-time dispatch map' },
    { id: 'coordinator.fleet', label: 'Fleet Tracker', route: '/tenancy/coordinator/fleet', owner: 'coordinator', description: 'Fleet GPS tracking' },
    { id: 'coordinator.shift-swap', label: 'Shift Swap', route: '/tenancy/coordinator/shift-swap', owner: 'coordinator', description: 'Shift swap request management' },
];

// ── AUTH & ERROR PAGES ───────────────────────────────────────────────────────

type RawPage = Omit<PageEntry, 'srNo' | 'categoryCode'>;

const AUTH_PAGES: RawPage[] = [
    { id: 'auth.login', label: 'Login', route: '/login', type: 'form', owner: 'auth', formRegistryId: 'auth.login', icon: '🔐' },
    { id: 'auth.register', label: 'Register', route: '/register', type: 'form', owner: 'auth', formRegistryId: 'auth.register', icon: '📝' },
    { id: 'auth.forgot-password', label: 'Forgot Password', route: '/forgot-password', type: 'form', owner: 'auth', formRegistryId: 'auth.forgot-password', icon: '🔑' },
    { id: 'auth.reset-password', label: 'Reset Password', route: '/reset-password', type: 'form', owner: 'auth', formRegistryId: 'auth.reset-password', icon: '🔑' },
    { id: 'auth.onboard-business', label: 'Onboard Business', route: '/onboard-business', type: 'form', owner: 'auth', formRegistryId: 'auth.onboard-business', icon: '🏢' },
];

const ERROR_PAGES: RawPage[] = [
    { id: 'error.404', label: 'Not Found', route: '/shared/404', type: 'error', owner: 'shared', icon: '🚫' },
    { id: 'error.401', label: 'Unauthorized', route: '/shared/401', type: 'error', owner: 'shared', icon: '🔒' },
    { id: 'error.500', label: 'Server Error', route: '/shared/500', type: 'error', owner: 'shared', icon: '💥' },
];

// ── MASTER PAGE REGISTRY (Aggregated + Serial Numbered) ─────────────────────

function buildPageEntries(): PageEntry[] {
    // Collect raw entries first (without srNo / categoryCode)
    const raw: RawPage[] = [];

    // Auth
    raw.push(...AUTH_PAGES);

    // Errors
    raw.push(...ERROR_PAGES);

    // Dashboards → PageEntry
    DashboardRegistry.forEach(d => raw.push({
        id: `page.${d.id}`, label: d.label, route: d.route, type: 'dashboard',
        owner: d.owner, icon: d.icon, dashboardRegistryId: d.id,
    } as RawPage));

    // Lists → PageEntry
    ListRegistry.forEach(l => raw.push({
        id: `page.${l.id}`, label: l.label, route: l.route, type: 'list', owner: l.owner,
    } as RawPage));

    // Hubs → PageEntry
    HubRegistry.forEach(h => raw.push({
        id: `page.${h.id}`, label: h.label, route: h.route, type: 'hub',
        owner: h.owner, description: h.description,
    } as RawPage));

    // Wizards → PageEntry
    WizardRegistry.forEach(w => raw.push({
        id: `page.${w.id}`, label: w.label, route: w.route, type: 'wizard',
        owner: w.owner, formRegistryId: w.formRegistryId,
    } as RawPage));

    // Reports → PageEntry
    ReportRegistry.forEach(r => raw.push({
        id: `page.${r.id}`, label: r.label, route: r.route, type: 'report', owner: r.owner,
    } as RawPage));

    // Tools → PageEntry
    ToolRegistry.forEach(t => raw.push({
        id: `page.${t.id}`, label: t.label, route: t.route, type: 'tool',
        owner: t.owner, description: t.description,
    } as RawPage));

    // Form pages (from FormRegistry — referenced by ID, not duplicated)
    const formPageIds = [
        { id: 'admin.admission', label: 'Client Admission', route: '/platform/admin/admission', owner: 'admin' as const },
        { id: 'admin.onboarding', label: 'Staff Onboarding', route: '/platform/admin/onboarding', owner: 'admin' as const },
        { id: 'admin.timesheet-adjust', label: 'Timesheet Adjustment', route: '/platform/admin/timesheets/adjust', owner: 'admin' as const },
        { id: 'admin.user-entry', label: 'Create / Edit User', route: '/platform/admin/users/new', owner: 'admin' as const },
        { id: 'admin.incident-entry', label: 'Create Incident', route: '/platform/admin/incidents/new', owner: 'admin' as const },
        { id: 'admin.lead-entry', label: 'Create Lead', route: '/platform/admin/leads/new', owner: 'admin' as const },
        { id: 'admin.locations', label: 'Location Form', route: '/platform/admin/locations', owner: 'admin' as const },
        { id: 'psw.handover', label: 'Shift Handover', route: '/tenancy/psw/handover', owner: 'psw' as const },
        { id: 'psw.expenses', label: 'Expense Claim', route: '/tenancy/psw/expenses', owner: 'psw' as const },
        { id: 'psw.availability', label: 'Availability', route: '/tenancy/psw/availability', owner: 'psw' as const },
        { id: 'client.feedback', label: 'Submit Feedback', route: '/tenancy/client/feedback', owner: 'client' as const },
        { id: 'client.booking-request', label: 'Request Booking', route: '/tenancy/client/request-booking', owner: 'client' as const },
    ];
    formPageIds.forEach(f => raw.push({
        id: `page.${f.id}`, label: f.label, route: f.route, type: 'form',
        owner: f.owner, formRegistryId: f.id,
    } as RawPage));

    // Shared pages
    raw.push(
        { id: 'page.shared.profile', label: 'Profile', route: '/profile', type: 'form', owner: 'shared', formRegistryId: 'shared.profile' } as RawPage,
        { id: 'page.shared.messaging', label: 'Messaging', route: '/messaging', type: 'tool', owner: 'shared' } as RawPage,
        { id: 'page.shared.support', label: 'Support', route: '/support', type: 'hub', owner: 'shared' } as RawPage,
        { id: 'page.shared.learn', label: 'Learning Center', route: '/learn', type: 'portal', owner: 'shared' } as RawPage,
    );

    // Registry pages
    raw.push(
        { id: 'page.admin.form-registry', label: 'Form Registry', route: '/platform/admin/form-registry', type: 'registry', owner: 'admin', icon: '📋' } as RawPage,
        { id: 'page.admin.page-registry', label: 'Page Registry', route: '/platform/admin/page-registry', type: 'registry', owner: 'admin', icon: '📖' } as RawPage,
    );

    // ── Assign srNo (global 1,2,3...) and categoryCode (D1,F1,L1...) ─────
    // Embed them directly into label as new identity: "[#1 D1] Admin Dashboard"
    const categoryCounters: Record<string, number> = {};
    const pages: PageEntry[] = raw.map((entry, index) => {
        const prefix = CATEGORY_PREFIXES[entry.type] || 'X';
        categoryCounters[prefix] = (categoryCounters[prefix] || 0) + 1;
        const srNo = index + 1;
        const categoryCode = `${prefix}${categoryCounters[prefix]}`;
        return {
            ...entry,
            srNo,
            categoryCode,
            originalLabel: entry.label,
            label: `[#${srNo} ${categoryCode}] ${entry.label}`,
        } as PageEntry;
    });

    return pages;
}

export const PageRegistry: PageEntry[] = buildPageEntries();

// ── LOOKUP HELPERS ───────────────────────────────────────────────────────────

export const getPageById = (id: string): PageEntry | undefined =>
    PageRegistry.find(p => p.id === id);

export const getPageBySrNo = (srNo: number): PageEntry | undefined =>
    PageRegistry.find(p => p.srNo === srNo);

export const getPageByCategoryCode = (code: string): PageEntry | undefined =>
    PageRegistry.find(p => p.categoryCode === code);

export const getPagesByType = (type: PageType): PageEntry[] =>
    PageRegistry.filter(p => p.type === type);

export const getPagesByOwner = (owner: PageEntry['owner']): PageEntry[] =>
    PageRegistry.filter(p => p.owner === owner);

export const getPageTypeStats = (): Record<PageType, number> => {
    const stats = {} as Record<PageType, number>;
    PageRegistry.forEach(p => { stats[p.type] = (stats[p.type] || 0) + 1; });
    return stats;
};

/** Returns the full master list formatted as: SrNo | CategoryCode | Label | Type | Owner | Route */
export const getMasterList = (): { srNo: number; categoryCode: string; label: string; type: PageType; owner: string; route: string; id: string }[] =>
    PageRegistry.map(p => ({
        srNo: p.srNo,
        categoryCode: p.categoryCode,
        label: p.label,
        type: p.type,
        owner: p.owner,
        route: p.route,
        id: p.id,
    }));

export const PAGE_REGISTRY_COUNT = PageRegistry.length;

// ── FILE IDENTITY MAP ────────────────────────────────────────────────────────
// Maps category codes → source file paths for quick identification.
// Use: FILE_IDENTITY_MAP['F6'] → 'apps/web-admin/.../admission/index.tsx'
export const FILE_IDENTITY_MAP: Record<string, string> = {
    // ── Dashboards (D1-D6) ──
    D1:  'apps/web-admin/src/app/routes/platform/admin/pages/dashboard/D1-AdminDashboard.tsx',
    D2:  'apps/web-admin/src/app/routes/platform/admin/pages/dashboard/D2-RegistrySummary.tsx',
    D3:  'apps/web-admin/src/app/routes/platform/admin/pages/security/D3-AccountingDashboard.tsx',
    D4:  'apps/web-admin/src/app/routes/platform/admin/pages/evv/D4-EvvDashboard.tsx',
    D5:  'apps/web-admin/src/app/routes/platform/admin/pages/ai/D5-AiDashboard.tsx',
    D6:  'apps/web-admin/src/app/routes/platform/admin/pages/cron/D6-CronDashboard.tsx',
    // ── Forms (F1-F18) ──
    F1:  'apps/web-admin/src/app/routes/auth/Login.tsx',
    F2:  'apps/web-admin/src/app/routes/auth/Register.tsx',
    F3:  'apps/web-admin/src/app/routes/auth/ForgotPassword.tsx',
    F4:  'apps/web-admin/src/app/routes/auth/ResetPassword.tsx',
    F5:  'apps/web-admin/src/app/routes/auth/BusinessOnboard.tsx',
    F6:  'apps/web-admin/src/app/routes/platform/admin/pages/admission/F6-ClientAdmission.tsx',
    F7:  'apps/web-admin/src/app/routes/platform/admin/pages/onboarding/F7-StaffOnboarding.tsx',
    F8:  'apps/web-admin/src/app/routes/platform/admin/pages/timesheet-adjustment/F8-TimesheetAdjustment.tsx',
    F10: 'apps/web-admin/src/app/routes/platform/admin/pages/incidents/F10-IncidentEntry.tsx',
    F11: 'apps/web-admin/src/app/routes/platform/admin/pages/leads/F11-LeadEntry.tsx',
    F13: 'apps/web-admin/src/app/routes/tenancy/psw/pages/handover/F13-ShiftHandover.tsx',
    F14: 'apps/web-admin/src/app/routes/tenancy/psw/pages/expenses/F14-ExpenseClaim.tsx',
    F16: 'apps/web-admin/src/app/routes/tenancy/client/pages/feedback/F16-SubmitFeedback.tsx',
    // ── Lists (L2-L15) ──
    L2:  'apps/web-admin/src/app/routes/platform/admin/pages/incidents/L2-IncidentList.tsx',
    L4:  'apps/web-admin/src/app/routes/platform/admin/pages/timesheets/L4-Timesheets.tsx',
    L5:  'apps/web-admin/src/app/routes/platform/admin/pages/services/L5-Services.tsx',
    L6:  'apps/web-admin/src/app/routes/platform/admin/pages/audits/L6-AuditLogs.tsx',
    L7:  'apps/web-admin/src/app/routes/platform/admin/pages/authorizations/L7-AuthList.tsx',
    L8:  'apps/web-admin/src/app/routes/platform/admin/pages/consent/L8-ConsentList.tsx',
    L9:  'apps/web-admin/src/app/routes/platform/admin/pages/referrals/L9-ReferralList.tsx',
    L10: 'apps/web-admin/src/app/routes/platform/admin/pages/claims/L10-ClaimsList.tsx',
    L11: 'apps/web-admin/src/app/routes/platform/admin/pages/webhooks/L11-WebhookList.tsx',
    L12: 'apps/web-admin/src/app/routes/platform/admin/pages/booking-requests/L12-BookingRequestQueue.tsx',
    L15: 'apps/web-admin/src/app/routes/platform/admin/pages/customers/L15-CustomerList.tsx',
    // ── Hubs (H1-H9) ──
    H1:  'apps/web-admin/src/app/routes/platform/admin/pages/telehealth/H1-TelehealthCenter.tsx',
    H2:  'apps/web-admin/src/app/routes/platform/admin/pages/pharmacy/H2-PharmacyHub.tsx',
    H3:  'apps/web-admin/src/app/routes/platform/admin/pages/rcm/H3-RevenueCycleHub.tsx',
    H4:  'apps/web-admin/src/app/routes/platform/admin/pages/erp/H4-SupplyChainHub.tsx',
    H5:  'apps/web-admin/src/app/routes/platform/admin/pages/notifications/H5-NotificationsHub.tsx',
    H6:  'apps/web-admin/src/app/routes/platform/admin/pages/documents/H6-DocumentCenter.tsx',
    H7:  'apps/web-admin/src/app/routes/platform/admin/pages/payroll/H7-PayrollHub.tsx',
    H8:  'apps/web-admin/src/app/routes/platform/admin/pages/knowledge-base/H8-KnowledgeBase.tsx',
    H9:  'apps/web-admin/src/app/routes/platform/admin/pages/reference-data/H9-ReferenceDataHub.tsx',
    // ── Wizards (W1-W5) ──
    W1:  'apps/web-admin/src/app/routes/platform/admin/pages/setup/W1-BusinessSetupWizard.tsx',
    W2:  'apps/web-admin/src/app/routes/platform/admin/pages/setup/W2-StaffOnboardingWizard.tsx',
    W3:  'apps/web-admin/src/app/routes/platform/admin/pages/setup/W3-CarePlanWizard.tsx',
    W4:  'apps/web-admin/src/app/routes/platform/admin/pages/setup/W4-RevenueWizard.tsx',
    W5:  'apps/web-admin/src/app/routes/platform/admin/pages/setup/W5-BusinessModelWizard.tsx',
    // ── Reports (R1-R12) ──
    R1:  'apps/web-admin/src/app/routes/platform/admin/pages/reports/R1-ReportCenter.tsx',
    R2:  'apps/web-admin/src/app/routes/platform/admin/pages/reports/R2-ExportPage.tsx',
    R8:  'apps/web-admin/src/app/routes/platform/admin/pages/evv/R8-EvvExport.tsx',
    R9:  'apps/web-admin/src/app/routes/platform/admin/pages/audit-export/R9-AuditDownload.tsx',
    R10: 'apps/web-admin/src/app/routes/platform/admin/pages/audit-export/R10-ComplianceExport.tsx',
    R11: 'apps/web-admin/src/app/routes/platform/admin/pages/referrals/R11-ReferralAnalytics.tsx',
    R12: 'apps/web-admin/src/app/routes/platform/admin/pages/claims/R12-ClaimsEra.tsx',
    // ── Tools (T1-T18) ──
    T1:  'apps/web-admin/src/app/routes/platform/admin/pages/search/T1-SearchPage.tsx',
    T2:  'apps/web-admin/src/app/routes/platform/admin/pages/content/T2-ContentManager.tsx',
    T3:  'apps/web-admin/src/app/routes/platform/admin/pages/template-editor/T3-TemplateEditor.tsx',
    T4:  'apps/web-admin/src/app/routes/platform/admin/pages/role-editor/T4-RoleEditor.tsx',
    T5:  'apps/web-admin/src/app/routes/platform/admin/pages/interoperability/T5-FHIRCenter.tsx',
    T6:  'apps/web-admin/src/app/routes/platform/admin/pages/sovereign/T6-SovereignWallet.tsx',
    T7:  'apps/web-admin/src/app/routes/platform/admin/pages/automation/T7-AutoPilot.tsx',
    T8:  'apps/web-admin/src/app/routes/platform/admin/pages/clinical-assistant/T8-ClinicalAssistant.tsx',
    T9:  'apps/web-admin/src/app/routes/platform/admin/pages/insights/T9-AiInsights.tsx',
    T10: 'apps/web-admin/src/app/routes/platform/admin/pages/security/T10-SecurityGovernance.tsx',
    T13: 'apps/web-admin/src/app/routes/platform/admin/pages/security/T13-DeviceManagement.tsx',
    T14: 'apps/web-admin/src/app/routes/platform/admin/pages/security/T14-ForensicTrails.tsx',
    T15: 'apps/web-admin/src/app/routes/platform/admin/pages/security/T15-CorsSettings.tsx',
    T16: 'apps/web-admin/src/app/routes/platform/admin/pages/security/T16-IntegrityVerification.tsx',
    T17: 'apps/web-admin/src/app/routes/platform/admin/pages/security/T17-FinancialLedger.tsx',
    T18: 'apps/web-admin/src/app/routes/platform/admin/pages/security/T18-TaxComplianceHub.tsx',
    // ── Registries (G1-G2) ──
    G1:  'apps/web-admin/src/app/routes/platform/admin/pages/form-registry/index.tsx',
    G2:  'apps/web-admin/src/app/routes/platform/admin/pages/page-registry/index.tsx',
};
