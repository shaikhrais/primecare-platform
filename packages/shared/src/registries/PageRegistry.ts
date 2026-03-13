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
    /** Associated page codes — pages in the same feature domain */
    associates?: string[];
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


// ── MASTER REGISTRY ─────────────────────────────────────────────────────────
// UNIFIED single source of truth: code → { file, associates, type, owner, label }
// Merges the old FILE_IDENTITY_MAP + FILE_ASSOCIATE_MAP into ONE record.
// Use: MASTER_REGISTRY['D4'].file        → '.../evv/D4-EvvDashboard.tsx'
//      MASTER_REGISTRY['D4'].associates  → ['L22', 'R8']
//      MASTER_REGISTRY['D4'].type        → 'dashboard'

export interface MasterEntry {
    /** Source file path (identity-named) */
    file: string;
    /** Human-readable label */
    label: string;
    /** Page type */
    type: PageType;
    /** Owner domain */
    owner: PageEntry['owner'];
    /** Associated page codes in the same feature domain */
    associates: string[];
}

export const MASTER_REGISTRY: Record<string, MasterEntry> = {
    // ── Auth Forms (F1–F5) ──
    F1:  { file: 'apps/web-admin/src/app/routes/auth/pages/login/F1-Login.tsx',                     label: 'Login',           type: 'form', owner: 'auth', associates: ['F2', 'F3'] },
    F2:  { file: 'apps/web-admin/src/app/routes/auth/pages/register/F2-Register.tsx',               label: 'Register',        type: 'form', owner: 'auth', associates: ['F1'] },
    F3:  { file: 'apps/web-admin/src/app/routes/auth/pages/forgot-password/F3-ForgotPassword.tsx',  label: 'Forgot Password', type: 'form', owner: 'auth', associates: ['F1', 'F4'] },
    F4:  { file: 'apps/web-admin/src/app/routes/auth/pages/reset-password/F4-ResetPassword.tsx',    label: 'Reset Password',  type: 'form', owner: 'auth', associates: ['F3'] },
    F5:  { file: 'apps/web-admin/src/app/routes/auth/pages/onboard-business/F5-BusinessOnboard.tsx',label: 'Business Onboard',type: 'form', owner: 'auth', associates: ['W1'] },
    // ── Admin Dashboards (D1–D6) ──
    D1:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/dashboard/D1-AdminDashboard.tsx',     label: 'Admin Dashboard',     type: 'dashboard', owner: 'admin', associates: ['D2', 'G1', 'G2'] },
    D2:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/dashboard/D2-RegistrySummary.tsx',    label: 'Registry Summary',    type: 'dashboard', owner: 'admin', associates: ['D1', 'G1', 'G2'] },
    D3:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/security/D3-AccountingDashboard.tsx', label: 'Accounting Dashboard',type: 'dashboard', owner: 'admin', associates: ['T17', 'T18', 'T59'] },
    D4:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/evv/D4-EvvDashboard.tsx',             label: 'EVV Dashboard',       type: 'dashboard', owner: 'admin', associates: ['L22', 'R8'] },
    D5:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/ai/D5-AiDashboard.tsx',               label: 'AI Dashboard',        type: 'dashboard', owner: 'admin', associates: ['T52', 'T53', 'T54', 'T55'] },
    D6:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/cron/D6-CronDashboard.tsx',           label: 'Cron Dashboard',      type: 'dashboard', owner: 'admin', associates: ['T7'] },
    // ── Admin Forms (F6–F12) ──
    F6:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/admission/F6-ClientAdmission.tsx',              label: 'Client Admission',     type: 'form', owner: 'admin', associates: ['F7'] },
    F7:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/onboarding/F7-StaffOnboarding.tsx',             label: 'Staff Onboarding',     type: 'form', owner: 'admin', associates: ['F6', 'W2'] },
    F8:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/timesheet-adjustment/F8-TimesheetAdjustment.tsx',label: 'Timesheet Adjustment', type: 'form', owner: 'admin', associates: ['L4'] },
    F9:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/invoices/F9-InvoiceEntry.tsx',                  label: 'Invoice Entry',        type: 'form', owner: 'admin', associates: ['H3'] },
    F9a: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/users/F9a-UserEntry.tsx',                       label: 'User Entry',           type: 'form', owner: 'admin', associates: ['L3a'] },
    F10: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/incidents/F10-IncidentEntry.tsx',               label: 'Incident Entry',       type: 'form', owner: 'admin', associates: ['L2'] },
    F11: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/leads/F11-LeadEntry.tsx',                       label: 'Lead Entry',           type: 'form', owner: 'admin', associates: ['L3', 'T66'] },
    F12: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/locations/F12-Locations.tsx',                   label: 'Locations',            type: 'form', owner: 'admin', associates: ['T64'] },
    // ── Admin Lists (L1–L15, L22) ──
    L1:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/schedule/L1-Schedule.tsx',                label: 'Schedule',           type: 'list', owner: 'admin', associates: ['L16'] },
    L2:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/incidents/L2-IncidentList.tsx',           label: 'Incident List',      type: 'list', owner: 'admin', associates: ['F10'] },
    L3:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/leads/L3-LeadList.tsx',                   label: 'Lead List',          type: 'list', owner: 'admin', associates: ['F11', 'T66'] },
    L3a: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/users/L3a-UserList.tsx',                  label: 'User List',          type: 'list', owner: 'admin', associates: ['F9a'] },
    L4:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/timesheets/L4-Timesheets.tsx',            label: 'Timesheets',         type: 'list', owner: 'admin', associates: ['F8'] },
    L5:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/services/L5-Services.tsx',                label: 'Services',           type: 'list', owner: 'admin', associates: ['T34'] },
    L6:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/audits/L6-AuditLogs.tsx',                 label: 'Audit Logs',         type: 'list', owner: 'admin', associates: ['R9', 'R10', 'R13'] },
    L7:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/authorizations/L7-AuthList.tsx',          label: 'Auth List',          type: 'list', owner: 'admin', associates: ['T49', 'R6'] },
    L8:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/consent/L8-ConsentList.tsx',              label: 'Consent List',       type: 'list', owner: 'admin', associates: ['T50', 'R7'] },
    L9:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/referrals/L9-ReferralList.tsx',           label: 'Referral List',      type: 'list', owner: 'admin', associates: ['R11'] },
    L10: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/claims/L10-ClaimsList.tsx',               label: 'Claims List',        type: 'list', owner: 'admin', associates: ['R12'] },
    L11: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/webhooks/L11-WebhookList.tsx',            label: 'Webhook List',       type: 'list', owner: 'admin', associates: ['T51'] },
    L12: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/booking-requests/L12-BookingRequestQueue.tsx', label: 'Booking Queue', type: 'list', owner: 'admin', associates: ['L14', 'F17'] },
    L15: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/customers/L15-CustomerList.tsx',          label: 'Customer List',      type: 'list', owner: 'admin', associates: ['T4'] },
    L22: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/evv/L22-EvvExceptions.tsx',               label: 'EVV Exceptions',     type: 'list', owner: 'admin', associates: ['D4', 'R8'] },
    // ── Admin Hubs (H1–H9, H19) ──
    H1:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/telehealth/H1-TelehealthCenter.tsx',  label: 'Telehealth Center', type: 'hub', owner: 'admin', associates: ['T8'] },
    H2:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/pharmacy/H2-PharmacyHub.tsx',         label: 'Pharmacy Hub',      type: 'hub', owner: 'admin', associates: ['H4'] },
    H3:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/rcm/H3-RevenueCycleHub.tsx',          label: 'Revenue Cycle Hub', type: 'hub', owner: 'admin', associates: ['F9'] },
    H4:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/erp/H4-SupplyChainHub.tsx',           label: 'Supply Chain Hub',  type: 'hub', owner: 'admin', associates: ['H20'] },
    H5:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/notifications/H5-NotificationsHub.tsx',label: 'Notifications Hub', type: 'hub', owner: 'admin', associates: ['H6'] },
    H6:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/documents/H6-DocumentCenter.tsx',     label: 'Document Center',   type: 'hub', owner: 'admin', associates: ['H5'] },
    H7:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/payroll/H7-PayrollHub.tsx',            label: 'Payroll Hub',       type: 'hub', owner: 'admin', associates: ['T24', 'D9'] },
    H8:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/knowledge-base/H8-KnowledgeBase.tsx', label: 'Knowledge Base',    type: 'hub', owner: 'admin', associates: ['T48'] },
    H9:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/reference-data/H9-ReferenceDataHub.tsx',label: 'Reference Data',   type: 'hub', owner: 'admin', associates: ['T11'] },
    H19: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/setup/H19-WizardHub.tsx',             label: 'Wizard Hub',        type: 'hub', owner: 'admin', associates: ['W1', 'W2', 'W3', 'W4', 'W5', 'T12'] },
    // ── Admin Wizards (W1–W5) ──
    W1:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/setup/W1-BusinessSetupWizard.tsx',    label: 'Business Setup',    type: 'wizard', owner: 'admin', associates: ['H19', 'T12'] },
    W2:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/setup/W2-StaffOnboardingWizard.tsx',  label: 'Staff Onboarding',  type: 'wizard', owner: 'admin', associates: ['H19', 'F7'] },
    W3:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/setup/W3-CarePlanWizard.tsx',         label: 'Care Plan',         type: 'wizard', owner: 'admin', associates: ['H19'] },
    W4:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/setup/W4-RevenueWizard.tsx',          label: 'Revenue',           type: 'wizard', owner: 'admin', associates: ['H19', 'H3'] },
    W5:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/setup/W5-BusinessModelWizard.tsx',    label: 'Business Model',    type: 'wizard', owner: 'admin', associates: ['H19'] },
    // ── Admin Reports (R1–R2, R6–R13) ──
    R1:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/reports/R1-ReportCenter.tsx',            label: 'Report Center',     type: 'report', owner: 'admin', associates: ['R2'] },
    R2:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/reports/R2-ExportPage.tsx',              label: 'Export Page',       type: 'report', owner: 'admin', associates: ['R1'] },
    R6:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/authorizations/R6-AuthUtilization.tsx', label: 'Auth Utilization',  type: 'report', owner: 'admin', associates: ['L7', 'T49'] },
    R7:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/consent/R7-ConsentExpiring.tsx',        label: 'Consent Expiring',  type: 'report', owner: 'admin', associates: ['L8', 'T50'] },
    R8:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/evv/R8-EvvExport.tsx',                  label: 'EVV Export',        type: 'report', owner: 'admin', associates: ['D4', 'L22'] },
    R9:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/audit-export/R9-AuditDownload.tsx',     label: 'Audit Download',    type: 'report', owner: 'admin', associates: ['L6', 'R10', 'R13'] },
    R10: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/audit-export/R10-ComplianceExport.tsx', label: 'Compliance Export', type: 'report', owner: 'admin', associates: ['L6', 'R9', 'R13'] },
    R11: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/referrals/R11-ReferralAnalytics.tsx',   label: 'Referral Analytics',type: 'report', owner: 'admin', associates: ['L9'] },
    R12: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/claims/R12-ClaimsEra.tsx',              label: 'Claims ERA',        type: 'report', owner: 'admin', associates: ['L10'] },
    R13: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/audit-export/R13-RegulatoryExport.tsx', label: 'Regulatory Export', type: 'report', owner: 'admin', associates: ['L6', 'R9', 'R10'] },
    // ── Admin Tools (T1–T18, T48–T59, T66–T67) ──
    T1:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/search/T1-SearchPage.tsx',              label: 'Search',            type: 'tool', owner: 'admin', associates: ['T2'] },
    T2:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/content/T2-ContentManager.tsx',         label: 'Content Manager',   type: 'tool', owner: 'admin', associates: ['T1', 'T3'] },
    T3:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/template-editor/T3-TemplateEditor.tsx', label: 'Template Editor',   type: 'tool', owner: 'admin', associates: ['T2'] },
    T4:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/role-editor/T4-RoleEditor.tsx',         label: 'Role Editor',       type: 'tool', owner: 'admin', associates: ['L15'] },
    T5:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/interoperability/T5-FHIRCenter.tsx',    label: 'FHIR Center',       type: 'tool', owner: 'admin', associates: ['T6'] },
    T6:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/sovereign/T6-SovereignWallet.tsx',      label: 'Sovereign Wallet',  type: 'tool', owner: 'admin', associates: ['T5'] },
    T7:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/automation/T7-AutoPilot.tsx',           label: 'AutoPilot',         type: 'tool', owner: 'admin', associates: ['D6'] },
    T8:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/clinical-assistant/T8-ClinicalAssistant.tsx', label: 'Clinical Assistant', type: 'tool', owner: 'admin', associates: ['H1', 'T9'] },
    T9:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/insights/T9-AiInsights.tsx',            label: 'AI Insights',       type: 'tool', owner: 'admin', associates: ['T8', 'D5'] },
    T10: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/security/T10-SecurityGovernance.tsx',   label: 'Security Gov',      type: 'tool', owner: 'admin', associates: ['T13', 'T14', 'T15', 'T16', 'T56', 'T57', 'T58'] },
    T11: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/settings/T11-Settings.tsx',             label: 'Settings',          type: 'tool', owner: 'admin', associates: ['D1'] },
    T12: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/setup/T12-BusinessStatus.tsx',          label: 'Business Status',   type: 'tool', owner: 'admin', associates: ['H19', 'W1'] },
    T13: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/security/T13-DeviceManagement.tsx',     label: 'Device Mgmt',       type: 'tool', owner: 'admin', associates: ['T10'] },
    T14: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/security/T14-ForensicTrails.tsx',       label: 'Forensic Trails',   type: 'tool', owner: 'admin', associates: ['T10'] },
    T15: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/security/T15-CorsSettings.tsx',         label: 'CORS Settings',     type: 'tool', owner: 'admin', associates: ['T10'] },
    T16: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/security/T16-IntegrityVerification.tsx',label: 'Integrity Verify',  type: 'tool', owner: 'admin', associates: ['T10'] },
    T17: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/security/T17-FinancialLedger.tsx',      label: 'Financial Ledger',  type: 'tool', owner: 'admin', associates: ['D3', 'T18', 'T59'] },
    T18: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/security/T18-TaxComplianceHub.tsx',     label: 'Tax Compliance',    type: 'tool', owner: 'admin', associates: ['D3', 'T17'] },
    T48: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/knowledge-base/T48-KBArticle.tsx',     label: 'KB Article',        type: 'tool', owner: 'admin', associates: ['H8'] },
    T49: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/authorizations/T49-AuthAlerts.tsx',     label: 'Auth Alerts',       type: 'tool', owner: 'admin', associates: ['L7', 'R6'] },
    T50: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/consent/T50-ConsentTemplates.tsx',      label: 'Consent Templates', type: 'tool', owner: 'admin', associates: ['L8', 'R7'] },
    T51: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/webhooks/T51-WebhookDeliveries.tsx',    label: 'Webhook Deliveries',type: 'tool', owner: 'admin', associates: ['L11'] },
    T52: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/ai/T52-PredictiveAnalytics.tsx',        label: 'Predictive Analytics',type: 'tool', owner: 'admin', associates: ['D5', 'T53', 'T54', 'T55'] },
    T53: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/ai/T53-ChurnRisk.tsx',                  label: 'Churn Risk',        type: 'tool', owner: 'admin', associates: ['D5', 'T52', 'T54', 'T55'] },
    T54: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/ai/T54-VisitOptimization.tsx',          label: 'Visit Optimization',type: 'tool', owner: 'admin', associates: ['D5', 'T52', 'T53', 'T55'] },
    T55: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/ai/T55-SentimentAnalysis.tsx',          label: 'Sentiment Analysis',type: 'tool', owner: 'admin', associates: ['D5', 'T52', 'T53', 'T54'] },
    T56: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/security/T56-PermissionGrid.tsx',       label: 'Permission Grid',   type: 'tool', owner: 'admin', associates: ['T10'] },
    T57: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/security/T57-SessionMonitor.tsx',       label: 'Session Monitor',   type: 'tool', owner: 'admin', associates: ['T10'] },
    T58: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/security/T58-ThreatDetection.tsx',      label: 'Threat Detection',  type: 'tool', owner: 'admin', associates: ['T10'] },
    T59: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/finance/reconciliation/T59-Reconciliation.tsx', label: 'Reconciliation', type: 'tool', owner: 'admin', associates: ['D3', 'T17'] },
    T66: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/leads/T66-LeadConversion.tsx',          label: 'Lead Conversion',   type: 'tool', owner: 'admin', associates: ['L3', 'F11'] },
    T67: { file: 'apps/web-admin/src/app/routes/platform/admin/pages/ops/T67-SupplyDemand.tsx',              label: 'Supply & Demand',   type: 'tool', owner: 'admin', associates: ['H20'] },
    // ── Manager Portal ──
    D7:  { file: 'apps/web-admin/src/app/routes/tenancy/manager/pages/dashboard/D7-ManagerDashboard.tsx', label: 'Manager Dashboard', type: 'dashboard', owner: 'manager', associates: ['H12', 'D9', 'D10', 'T19', 'L13', 'T21', 'H11', 'T22', 'T23', 'T25'] },
    D9:  { file: 'apps/web-admin/src/app/routes/tenancy/manager/pages/finance/D9-BranchPL.tsx',           label: 'Branch P&L',       type: 'dashboard', owner: 'manager', associates: ['H7', 'T24'] },
    D10: { file: 'apps/web-admin/src/app/routes/tenancy/manager/pages/D10-RegionalStats.tsx',             label: 'Regional Stats',   type: 'dashboard', owner: 'manager', associates: ['D7'] },
    D11: { file: 'apps/web-admin/src/app/routes/tenancy/marketing/D11-MarketingDashboard.tsx',            label: 'Marketing',        type: 'dashboard', owner: 'manager', associates: ['D7'] },
    D12: { file: 'apps/web-admin/src/app/routes/tenancy/finance/D12-FinanceRegionalHub.tsx',              label: 'Finance Regional', type: 'dashboard', owner: 'manager', associates: ['D7', 'D9'] },
    D13: { file: 'apps/web-admin/src/app/routes/tenancy/qa/D13-ClinicalQaDashboard.tsx',                  label: 'Clinical QA',      type: 'dashboard', owner: 'manager', associates: ['D15'] },
    H11: { file: 'apps/web-admin/src/app/routes/tenancy/manager/pages/training/H11-TrainingHub.tsx',      label: 'Training Hub',     type: 'hub', owner: 'manager', associates: ['D7'] },
    H12: { file: 'apps/web-admin/src/app/routes/tenancy/manager/pages/operations/H12-OperationsHub.tsx',  label: 'Operations Hub',   type: 'hub', owner: 'manager', associates: ['D7'] },
    H13: { file: 'apps/web-admin/src/app/routes/tenancy/hr/H13-HrRecruitmentPortal.tsx',                  label: 'HR Recruitment',   type: 'hub', owner: 'manager', associates: ['D7'] },
    L13: { file: 'apps/web-admin/src/app/routes/tenancy/manager/pages/evaluations/L13-Evaluations.tsx',   label: 'Evaluations',      type: 'list', owner: 'manager', associates: ['D7'] },
    T19: { file: 'apps/web-admin/src/app/routes/tenancy/manager/pages/portfolio/T19-Portfolio.tsx',        label: 'Portfolio',        type: 'tool', owner: 'manager', associates: ['D7'] },
    T20: { file: 'apps/web-admin/src/app/routes/tenancy/manager/pages/daily-entry/T20-DailyEntry.tsx',    label: 'Daily Entry',      type: 'tool', owner: 'manager', associates: ['D7'] },
    T21: { file: 'apps/web-admin/src/app/routes/tenancy/manager/pages/service-review/T21-ServiceReview.tsx',label: 'Service Review',  type: 'tool', owner: 'manager', associates: ['D7'] },
    T22: { file: 'apps/web-admin/src/app/routes/tenancy/manager/pages/surveys/T22-SurveyManager.tsx',     label: 'Survey Manager',   type: 'tool', owner: 'manager', associates: ['D7'] },
    T23: { file: 'apps/web-admin/src/app/routes/tenancy/manager/pages/performance/T23-StaffRanker.tsx',   label: 'Staff Ranker',     type: 'tool', owner: 'manager', associates: ['D7'] },
    T24: { file: 'apps/web-admin/src/app/routes/tenancy/manager/pages/finance/T24-PayrollVerification.tsx',label: 'Payroll Verify',   type: 'tool', owner: 'manager', associates: ['H7', 'D9'] },
    T25: { file: 'apps/web-admin/src/app/routes/tenancy/manager/pages/compliance/T25-ComplianceSync.tsx', label: 'Compliance Sync',  type: 'tool', owner: 'manager', associates: ['D7'] },
    // ── PSW Portal ──
    D14: { file: 'apps/web-admin/src/app/routes/tenancy/psw/pages/dashboard/D14-PswDashboard.tsx',              label: 'PSW Dashboard',    type: 'dashboard', owner: 'psw', associates: ['L16', 'F13', 'F14', 'F15', 'R3'] },
    F13: { file: 'apps/web-admin/src/app/routes/tenancy/psw/pages/handover/F13-ShiftHandover.tsx',              label: 'Shift Handover',   type: 'form', owner: 'psw', associates: ['D14'] },
    F14: { file: 'apps/web-admin/src/app/routes/tenancy/psw/pages/expenses/F14-ExpenseClaim.tsx',               label: 'Expense Claim',    type: 'form', owner: 'psw', associates: ['R4'] },
    F15: { file: 'apps/web-admin/src/app/routes/tenancy/psw/pages/availability/F15-Availability.tsx',           label: 'Availability',     type: 'form', owner: 'psw', associates: ['D14'] },
    H14: { file: 'apps/web-admin/src/app/routes/tenancy/psw/pages/credentials/H14-CredentialVault.tsx',         label: 'Credential Vault', type: 'hub', owner: 'psw', associates: ['H15'] },
    H15: { file: 'apps/web-admin/src/app/routes/tenancy/psw/pages/training/H15-PswTrainingHub.tsx',             label: 'PSW Training',     type: 'hub', owner: 'psw', associates: ['H14'] },
    L16: { file: 'apps/web-admin/src/app/routes/tenancy/psw/pages/schedule/L16-PswSchedule.tsx',                label: 'PSW Schedule',     type: 'list', owner: 'psw', associates: ['L17', 'T60', 'T61', 'T62'] },
    L17: { file: 'apps/web-admin/src/app/routes/tenancy/psw/pages/OpenShifts/L17-OpenShifts.tsx',               label: 'Open Shifts',      type: 'list', owner: 'psw', associates: ['L16', 'T60'] },
    R3:  { file: 'apps/web-admin/src/app/routes/tenancy/psw/pages/earnings/R3-PswEarnings.tsx',                 label: 'PSW Earnings',     type: 'report', owner: 'psw', associates: ['R4'] },
    R4:  { file: 'apps/web-admin/src/app/routes/tenancy/psw/pages/payouts/R4-PayoutHistory.tsx',                label: 'Payout History',   type: 'report', owner: 'psw', associates: ['F14', 'R3'] },
    T26: { file: 'apps/web-admin/src/app/routes/tenancy/psw/pages/shift-confirmation/T26-ShiftConfirmation.tsx',label: 'Shift Confirm',    type: 'tool', owner: 'psw', associates: ['D14'] },
    T27: { file: 'apps/web-admin/src/app/routes/tenancy/psw/pages/feed/T27-ProviderSocial.tsx',                 label: 'Provider Social',  type: 'tool', owner: 'psw', associates: ['D14'] },
    T28: { file: 'apps/web-admin/src/app/routes/tenancy/psw/pages/mileage/T28-MileageTracker.tsx',              label: 'Mileage Tracker',  type: 'tool', owner: 'psw', associates: ['D14'] },
    T60: { file: 'apps/web-admin/src/app/routes/tenancy/psw/pages/OpenShifts/T60-OpenOffers.tsx',               label: 'Open Offers',      type: 'tool', owner: 'psw', associates: ['L17', 'L16'] },
    T61: { file: 'apps/web-admin/src/app/routes/tenancy/psw/pages/schedule/T61-LiveVisit.tsx',                  label: 'Live Visit',       type: 'tool', owner: 'psw', associates: ['L16', 'T62'] },
    T62: { file: 'apps/web-admin/src/app/routes/tenancy/psw/pages/schedule/T62-CheckInScreen.tsx',              label: 'Check-In',         type: 'tool', owner: 'psw', associates: ['L16', 'T61'] },
    // ── RN Portal ──
    D15: { file: 'apps/web-admin/src/app/routes/tenancy/rn/pages/dashboard/D15-RnDashboard.tsx',         label: 'RN Dashboard',    type: 'dashboard', owner: 'rn', associates: ['T29', 'T30', 'H16', 'L18'] },
    D16: { file: 'apps/web-admin/src/app/routes/tenancy/rn/pages/mar/D16-MarDashboard.tsx',              label: 'MAR Dashboard',   type: 'dashboard', owner: 'rn', associates: ['T31'] },
    D17: { file: 'apps/web-admin/src/app/routes/tenancy/rn/pages/wound-care/D17-WoundCareDashboard.tsx', label: 'Wound Care',      type: 'dashboard', owner: 'rn', associates: ['T32'] },
    H16: { file: 'apps/web-admin/src/app/routes/tenancy/rn/pages/supervision/H16-SupervisionHub.tsx',    label: 'Supervision Hub', type: 'hub', owner: 'rn', associates: ['D15'] },
    L18: { file: 'apps/web-admin/src/app/routes/tenancy/rn/pages/assessments/L18-AssessmentsHub.tsx',    label: 'Assessments Hub', type: 'list', owner: 'rn', associates: ['D15'] },
    L19: { file: 'apps/web-admin/src/app/routes/tenancy/rn/pages/rai/L19-RaiAssessments.tsx',            label: 'RAI Assessments', type: 'list', owner: 'rn', associates: ['T33'] },
    T29: { file: 'apps/web-admin/src/app/routes/tenancy/rn/pages/care-plans/T29-CarePlanManager.tsx',    label: 'Care Plan Mgr',   type: 'tool', owner: 'rn', associates: ['D15'] },
    T30: { file: 'apps/web-admin/src/app/routes/tenancy/rn/pages/audit/T30-EntryVerify.tsx',             label: 'Entry Verify',    type: 'tool', owner: 'rn', associates: ['D15'] },
    T31: { file: 'apps/web-admin/src/app/routes/tenancy/rn/pages/mar/T31-MarClient.tsx',                 label: 'MAR Client',      type: 'tool', owner: 'rn', associates: ['D16'] },
    T32: { file: 'apps/web-admin/src/app/routes/tenancy/rn/pages/wound-care/T32-WoundCareClient.tsx',    label: 'Wound Client',    type: 'tool', owner: 'rn', associates: ['D17'] },
    T33: { file: 'apps/web-admin/src/app/routes/tenancy/rn/pages/rai/T33-RaiAssessmentDetail.tsx',       label: 'RAI Detail',      type: 'tool', owner: 'rn', associates: ['L19'] },
    T63: { file: 'apps/web-admin/src/app/routes/tenancy/rn/pages/schedule/T63-RnCheckInScreen.tsx',      label: 'RN Check-In',     type: 'tool', owner: 'rn', associates: ['D15'] },
    // ── Client Portal ──
    D8:  { file: 'apps/web-admin/src/app/routes/tenancy/client/pages/dashboard/D8-ClientDashboard.tsx',      label: 'Client Dashboard', type: 'dashboard', owner: 'client', associates: ['L14', 'H10', 'F16', 'F17', 'T34', 'T35', 'T36', 'T37', 'H17', 'R5', 'P1'] },
    F16: { file: 'apps/web-admin/src/app/routes/tenancy/client/pages/feedback/F16-SubmitFeedback.tsx',       label: 'Submit Feedback',  type: 'form', owner: 'client', associates: ['D8'] },
    F17: { file: 'apps/web-admin/src/app/routes/tenancy/client/pages/request-booking/F17-RequestBooking.tsx',label: 'Request Booking',  type: 'form', owner: 'client', associates: ['L12', 'L14'] },
    H10: { file: 'apps/web-admin/src/app/routes/tenancy/client/pages/billing/H10-BillingHub.tsx',            label: 'Billing Hub',      type: 'hub', owner: 'client', associates: ['D8'] },
    H17: { file: 'apps/web-admin/src/app/routes/tenancy/client/pages/engagement/H17-FamilyCareHub.tsx',      label: 'Family Care Hub',  type: 'hub', owner: 'client', associates: ['D8', 'P1'] },
    L14: { file: 'apps/web-admin/src/app/routes/tenancy/client/pages/bookings/L14-ClientBookings.tsx',       label: 'Client Bookings',  type: 'list', owner: 'client', associates: ['L12', 'F17'] },
    R5:  { file: 'apps/web-admin/src/app/routes/tenancy/client/pages/medical/R5-MedicalSummary.tsx',         label: 'Medical Summary',  type: 'report', owner: 'client', associates: ['D8'] },
    P1:  { file: 'apps/web-admin/src/app/routes/tenancy/client/pages/family/P1-FamilyPortal.tsx',            label: 'Family Portal',    type: 'portal', owner: 'client', associates: ['D8', 'H17'] },
    T34: { file: 'apps/web-admin/src/app/routes/tenancy/client/pages/services/T34-CatalogBrowser.tsx',       label: 'Catalog Browser',  type: 'tool', owner: 'client', associates: ['L5'] },
    T35: { file: 'apps/web-admin/src/app/routes/tenancy/client/pages/support/T35-ClientMessaging.tsx',       label: 'Client Messaging', type: 'tool', owner: 'client', associates: ['D8', 'T37'] },
    T36: { file: 'apps/web-admin/src/app/routes/tenancy/client/pages/team/T36-TeamRoster.tsx',               label: 'Team Roster',      type: 'tool', owner: 'client', associates: ['D8'] },
    T37: { file: 'apps/web-admin/src/app/routes/tenancy/client/pages/support/T37-FeedbackLoop.tsx',          label: 'Feedback Loop',    type: 'tool', owner: 'client', associates: ['D8', 'T35'] },
    // ── Coordinator Portal ──
    H18: { file: 'apps/web-admin/src/app/routes/tenancy/coordinator/pages/hub/H18-CoordinatorHub.tsx',       label: 'Coordinator Hub',  type: 'hub', owner: 'coordinator', associates: ['T38', 'T39', 'L20', 'T40', 'T41'] },
    L20: { file: 'apps/web-admin/src/app/routes/tenancy/coordinator/pages/waitlist/L20-WaitlistManager.tsx', label: 'Waitlist Manager', type: 'list', owner: 'coordinator', associates: ['H18'] },
    T38: { file: 'apps/web-admin/src/app/routes/tenancy/coordinator/pages/map/T38-DispatchMap.tsx',          label: 'Dispatch Map',     type: 'tool', owner: 'coordinator', associates: ['H18'] },
    T39: { file: 'apps/web-admin/src/app/routes/tenancy/coordinator/pages/sos/T39-SosCenter.tsx',            label: 'SOS Center',       type: 'tool', owner: 'coordinator', associates: ['H18'] },
    T40: { file: 'apps/web-admin/src/app/routes/tenancy/coordinator/pages/fleet/T40-FleetManagement.tsx',    label: 'Fleet Management', type: 'tool', owner: 'coordinator', associates: ['H18'] },
    T41: { file: 'apps/web-admin/src/app/routes/tenancy/coordinator/pages/shift-swap/T41-ShiftSwap.tsx',     label: 'Shift Swap',       type: 'tool', owner: 'coordinator', associates: ['H18'] },
    // ── Allied Health / Staff / Ops ──
    D18: { file: 'apps/web-admin/src/app/routes/tenancy/allied-health/D18-AlliedHealthDashboard.tsx',               label: 'Allied Health',     type: 'dashboard', owner: 'allied', associates: ['L21', 'T42'] },
    L21: { file: 'apps/web-admin/src/app/routes/tenancy/allied-health/pages/treatments/L21-TreatmentList.tsx',      label: 'Treatment List',    type: 'list', owner: 'allied', associates: ['D18', 'T42'] },
    T42: { file: 'apps/web-admin/src/app/routes/tenancy/allied-health/pages/sign-off/T42-SignOff.tsx',              label: 'Sign Off',          type: 'tool', owner: 'allied', associates: ['D18', 'L21'] },
    D19: { file: 'apps/web-admin/src/app/routes/tenancy/staff/pages/dashboard/D19-StaffDashboard.tsx',              label: 'Staff Dashboard',   type: 'dashboard', owner: 'staff', associates: ['T43', 'T44', 'T45', 'T46'] },
    T43: { file: 'apps/web-admin/src/app/routes/tenancy/staff/pages/tasks/T43-TaskGrid.tsx',                        label: 'Task Grid',         type: 'tool', owner: 'staff', associates: ['D19'] },
    T44: { file: 'apps/web-admin/src/app/routes/tenancy/staff/pages/messages/T44-MessageCenter.tsx',                label: 'Message Center',    type: 'tool', owner: 'staff', associates: ['D19'] },
    T45: { file: 'apps/web-admin/src/app/routes/tenancy/staff/pages/operations/T45-IncidentPortal.tsx',             label: 'Incident Portal',   type: 'tool', owner: 'staff', associates: ['D19'] },
    T46: { file: 'apps/web-admin/src/app/routes/tenancy/staff/pages/operations/T46-ComplianceMonitor.tsx',          label: 'Compliance Monitor',type: 'tool', owner: 'staff', associates: ['D19'] },
    H20: { file: 'apps/web-admin/src/app/routes/tenancy/admin/pages/ops/H20-LogisticsHub.tsx',                      label: 'Logistics Hub',     type: 'hub', owner: 'admin', associates: ['T64', 'T65', 'T67', 'H4'] },
    T64: { file: 'apps/web-admin/src/app/routes/tenancy/admin/pages/ops/T64-RegionMapping.tsx',                     label: 'Region Mapping',    type: 'tool', owner: 'admin', associates: ['H20', 'T65'] },
    T65: { file: 'apps/web-admin/src/app/routes/tenancy/admin/pages/ops/T65-RealtimeCapacity.tsx',                  label: 'Realtime Capacity', type: 'tool', owner: 'admin', associates: ['H20', 'T64'] },
    // ── Scrum Master / Registries ──
    T47: { file: 'apps/web-admin/src/app/routes/tenancy/scrum-master/pages/T47-ResponseBotAudit.tsx', label: 'Response Bot Audit', type: 'tool', owner: 'scrum-master', associates: ['T7'] },
    G1:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/form-registry/index.tsx',        label: 'Form Registry',     type: 'registry', owner: 'admin', associates: ['G2', 'D2'] },
    G2:  { file: 'apps/web-admin/src/app/routes/platform/admin/pages/page-registry/index.tsx',        label: 'Page Registry',     type: 'registry', owner: 'admin', associates: ['G1', 'D2'] },
};

// ── Backward compatibility (derived from MASTER_REGISTRY) ────────────────────
/** @deprecated Use MASTER_REGISTRY[code].file instead */
export const FILE_IDENTITY_MAP: Record<string, string> = Object.fromEntries(
    Object.entries(MASTER_REGISTRY).map(([code, entry]) => [code, entry.file])
);
/** @deprecated Use MASTER_REGISTRY[code].associates instead */
export const FILE_ASSOCIATE_MAP: Record<string, string[]> = Object.fromEntries(
    Object.entries(MASTER_REGISTRY).map(([code, entry]) => [code, entry.associates])
);

// ── MASTER REGISTRY HELPERS ──────────────────────────────────────────────────
export const getMasterEntry = (code: string): MasterEntry | undefined => MASTER_REGISTRY[code];

export const getAssociates = (code: string): { code: string; label: string; type: PageType }[] => {
    const entry = MASTER_REGISTRY[code];
    if (!entry) return [];
    return entry.associates.filter(c => MASTER_REGISTRY[c]).map(c => ({ code: c, label: MASTER_REGISTRY[c].label, type: MASTER_REGISTRY[c].type }));
};

export const getMasterByType = (type: PageType): { code: string; entry: MasterEntry }[] =>
    Object.entries(MASTER_REGISTRY).filter(([, e]) => e.type === type).map(([code, entry]) => ({ code, entry }));

export const getMasterByOwner = (owner: PageEntry['owner']): { code: string; entry: MasterEntry }[] =>
    Object.entries(MASTER_REGISTRY).filter(([, e]) => e.owner === owner).map(([code, entry]) => ({ code, entry }));

export const MASTER_REGISTRY_COUNT = Object.keys(MASTER_REGISTRY).length;
