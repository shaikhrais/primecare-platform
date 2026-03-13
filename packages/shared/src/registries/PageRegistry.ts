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
    // ── Manager Portal ──
    D7:  'apps/web-admin/src/app/routes/tenancy/manager/pages/dashboard/D7-ManagerDashboard.tsx',
    D9:  'apps/web-admin/src/app/routes/tenancy/manager/pages/finance/D9-BranchPL.tsx',
    D10: 'apps/web-admin/src/app/routes/tenancy/manager/pages/D10-RegionalStats.tsx',
    D11: 'apps/web-admin/src/app/routes/tenancy/marketing/D11-MarketingDashboard.tsx',
    D12: 'apps/web-admin/src/app/routes/tenancy/finance/D12-FinanceRegionalHub.tsx',
    D13: 'apps/web-admin/src/app/routes/tenancy/qa/D13-ClinicalQaDashboard.tsx',
    H11: 'apps/web-admin/src/app/routes/tenancy/manager/pages/training/H11-TrainingHub.tsx',
    H12: 'apps/web-admin/src/app/routes/tenancy/manager/pages/operations/H12-OperationsHub.tsx',
    H13: 'apps/web-admin/src/app/routes/tenancy/hr/H13-HrRecruitmentPortal.tsx',
    L13: 'apps/web-admin/src/app/routes/tenancy/manager/pages/evaluations/L13-Evaluations.tsx',
    T19: 'apps/web-admin/src/app/routes/tenancy/manager/pages/portfolio/T19-Portfolio.tsx',
    T20: 'apps/web-admin/src/app/routes/tenancy/manager/pages/daily-entry/T20-DailyEntry.tsx',
    T21: 'apps/web-admin/src/app/routes/tenancy/manager/pages/service-review/T21-ServiceReview.tsx',
    T22: 'apps/web-admin/src/app/routes/tenancy/manager/pages/surveys/T22-SurveyManager.tsx',
    T23: 'apps/web-admin/src/app/routes/tenancy/manager/pages/performance/T23-StaffRanker.tsx',
    T24: 'apps/web-admin/src/app/routes/tenancy/manager/pages/finance/T24-PayrollVerification.tsx',
    T25: 'apps/web-admin/src/app/routes/tenancy/manager/pages/compliance/T25-ComplianceSync.tsx',
    // ── PSW Portal ──
    D14: 'apps/web-admin/src/app/routes/tenancy/psw/pages/dashboard/D14-PswDashboard.tsx',
    F15: 'apps/web-admin/src/app/routes/tenancy/psw/pages/availability/F15-Availability.tsx',
    H14: 'apps/web-admin/src/app/routes/tenancy/psw/pages/credentials/H14-CredentialVault.tsx',
    H15: 'apps/web-admin/src/app/routes/tenancy/psw/pages/training/H15-PswTrainingHub.tsx',
    L16: 'apps/web-admin/src/app/routes/tenancy/psw/pages/schedule/L16-PswSchedule.tsx',
    L17: 'apps/web-admin/src/app/routes/tenancy/psw/pages/OpenShifts/L17-OpenShifts.tsx',
    R3:  'apps/web-admin/src/app/routes/tenancy/psw/pages/earnings/R3-PswEarnings.tsx',
    R4:  'apps/web-admin/src/app/routes/tenancy/psw/pages/payouts/R4-PayoutHistory.tsx',
    T26: 'apps/web-admin/src/app/routes/tenancy/psw/pages/shift-confirmation/T26-ShiftConfirmation.tsx',
    T27: 'apps/web-admin/src/app/routes/tenancy/psw/pages/feed/T27-ProviderSocial.tsx',
    T28: 'apps/web-admin/src/app/routes/tenancy/psw/pages/mileage/T28-MileageTracker.tsx',
    // ── RN Portal ──
    D15: 'apps/web-admin/src/app/routes/tenancy/rn/pages/dashboard/D15-RnDashboard.tsx',
    D16: 'apps/web-admin/src/app/routes/tenancy/rn/pages/mar/D16-MarDashboard.tsx',
    D17: 'apps/web-admin/src/app/routes/tenancy/rn/pages/wound-care/D17-WoundCareDashboard.tsx',
    H16: 'apps/web-admin/src/app/routes/tenancy/rn/pages/supervision/H16-SupervisionHub.tsx',
    L18: 'apps/web-admin/src/app/routes/tenancy/rn/pages/assessments/L18-AssessmentsHub.tsx',
    L19: 'apps/web-admin/src/app/routes/tenancy/rn/pages/rai/L19-RaiAssessments.tsx',
    T29: 'apps/web-admin/src/app/routes/tenancy/rn/pages/care-plans/T29-CarePlanManager.tsx',
    T30: 'apps/web-admin/src/app/routes/tenancy/rn/pages/audit/T30-EntryVerify.tsx',
    T31: 'apps/web-admin/src/app/routes/tenancy/rn/pages/mar/T31-MarClient.tsx',
    T32: 'apps/web-admin/src/app/routes/tenancy/rn/pages/wound-care/T32-WoundCareClient.tsx',
    T33: 'apps/web-admin/src/app/routes/tenancy/rn/pages/rai/T33-RaiAssessmentDetail.tsx',
    // ── Client Portal ──
    D8:  'apps/web-admin/src/app/routes/tenancy/client/pages/dashboard/D8-ClientDashboard.tsx',
    F17: 'apps/web-admin/src/app/routes/tenancy/client/pages/request-booking/F17-RequestBooking.tsx',
    H10: 'apps/web-admin/src/app/routes/tenancy/client/pages/billing/H10-BillingHub.tsx',
    H17: 'apps/web-admin/src/app/routes/tenancy/client/pages/engagement/H17-FamilyCareHub.tsx',
    L14: 'apps/web-admin/src/app/routes/tenancy/client/pages/bookings/L14-ClientBookings.tsx',
    R5:  'apps/web-admin/src/app/routes/tenancy/client/pages/medical/R5-MedicalSummary.tsx',
    P1:  'apps/web-admin/src/app/routes/tenancy/client/pages/family/P1-FamilyPortal.tsx',
    T34: 'apps/web-admin/src/app/routes/tenancy/client/pages/services/T34-CatalogBrowser.tsx',
    T35: 'apps/web-admin/src/app/routes/tenancy/client/pages/support/T35-ClientMessaging.tsx',
    T36: 'apps/web-admin/src/app/routes/tenancy/client/pages/team/T36-TeamRoster.tsx',
    T37: 'apps/web-admin/src/app/routes/tenancy/client/pages/support/T37-FeedbackLoop.tsx',
    // ── Coordinator Portal ──
    H18: 'apps/web-admin/src/app/routes/tenancy/coordinator/pages/hub/H18-CoordinatorHub.tsx',
    L20: 'apps/web-admin/src/app/routes/tenancy/coordinator/pages/waitlist/L20-WaitlistManager.tsx',
    T38: 'apps/web-admin/src/app/routes/tenancy/coordinator/pages/map/T38-DispatchMap.tsx',
    T39: 'apps/web-admin/src/app/routes/tenancy/coordinator/pages/sos/T39-SosCenter.tsx',
    T40: 'apps/web-admin/src/app/routes/tenancy/coordinator/pages/fleet/T40-FleetManagement.tsx',
    T41: 'apps/web-admin/src/app/routes/tenancy/coordinator/pages/shift-swap/T41-ShiftSwap.tsx',
    // ── Allied Health Portal ──
    D18: 'apps/web-admin/src/app/routes/tenancy/allied-health/D18-AlliedHealthDashboard.tsx',
    L21: 'apps/web-admin/src/app/routes/tenancy/allied-health/pages/treatments/L21-TreatmentList.tsx',
    T42: 'apps/web-admin/src/app/routes/tenancy/allied-health/pages/sign-off/T42-SignOff.tsx',
    // ── Staff Portal ──
    D19: 'apps/web-admin/src/app/routes/tenancy/staff/pages/dashboard/D19-StaffDashboard.tsx',
    T43: 'apps/web-admin/src/app/routes/tenancy/staff/pages/tasks/T43-TaskGrid.tsx',
    T44: 'apps/web-admin/src/app/routes/tenancy/staff/pages/messages/T44-MessageCenter.tsx',
    T45: 'apps/web-admin/src/app/routes/tenancy/staff/pages/operations/T45-IncidentPortal.tsx',
    T46: 'apps/web-admin/src/app/routes/tenancy/staff/pages/operations/T46-ComplianceMonitor.tsx',
    // ── Scrum Master ──
    T47: 'apps/web-admin/src/app/routes/tenancy/scrum-master/pages/T47-ResponseBotAudit.tsx',
    // ── Secondary Admin Pages ──
    L1:  'apps/web-admin/src/app/routes/platform/admin/pages/schedule/L1-Schedule.tsx',
    L22: 'apps/web-admin/src/app/routes/platform/admin/pages/evv/L22-EvvExceptions.tsx',
    F12: 'apps/web-admin/src/app/routes/platform/admin/pages/locations/F12-Locations.tsx',
    H19: 'apps/web-admin/src/app/routes/platform/admin/pages/setup/H19-WizardHub.tsx',
    H20: 'apps/web-admin/src/app/routes/tenancy/admin/pages/ops/H20-LogisticsHub.tsx',
    R6:  'apps/web-admin/src/app/routes/platform/admin/pages/authorizations/R6-AuthUtilization.tsx',
    R7:  'apps/web-admin/src/app/routes/platform/admin/pages/consent/R7-ConsentExpiring.tsx',
    R13: 'apps/web-admin/src/app/routes/platform/admin/pages/audit-export/R13-RegulatoryExport.tsx',
    T11: 'apps/web-admin/src/app/routes/platform/admin/pages/settings/T11-Settings.tsx',
    T12: 'apps/web-admin/src/app/routes/platform/admin/pages/setup/T12-BusinessStatus.tsx',
    T48: 'apps/web-admin/src/app/routes/platform/admin/pages/knowledge-base/T48-KBArticle.tsx',
    T49: 'apps/web-admin/src/app/routes/platform/admin/pages/authorizations/T49-AuthAlerts.tsx',
    T50: 'apps/web-admin/src/app/routes/platform/admin/pages/consent/T50-ConsentTemplates.tsx',
    T51: 'apps/web-admin/src/app/routes/platform/admin/pages/webhooks/T51-WebhookDeliveries.tsx',
    T52: 'apps/web-admin/src/app/routes/platform/admin/pages/ai/T52-PredictiveAnalytics.tsx',
    T53: 'apps/web-admin/src/app/routes/platform/admin/pages/ai/T53-ChurnRisk.tsx',
    T54: 'apps/web-admin/src/app/routes/platform/admin/pages/ai/T54-VisitOptimization.tsx',
    T55: 'apps/web-admin/src/app/routes/platform/admin/pages/ai/T55-SentimentAnalysis.tsx',
    T56: 'apps/web-admin/src/app/routes/platform/admin/pages/security/T56-PermissionGrid.tsx',
    T57: 'apps/web-admin/src/app/routes/platform/admin/pages/security/T57-SessionMonitor.tsx',
    T58: 'apps/web-admin/src/app/routes/platform/admin/pages/security/T58-ThreatDetection.tsx',
    T59: 'apps/web-admin/src/app/routes/platform/admin/pages/finance/reconciliation/T59-Reconciliation.tsx',
    T60: 'apps/web-admin/src/app/routes/tenancy/psw/pages/OpenShifts/T60-OpenOffers.tsx',
    T61: 'apps/web-admin/src/app/routes/tenancy/psw/pages/schedule/T61-LiveVisit.tsx',
    T62: 'apps/web-admin/src/app/routes/tenancy/psw/pages/schedule/T62-CheckInScreen.tsx',
    T63: 'apps/web-admin/src/app/routes/tenancy/rn/pages/schedule/T63-RnCheckInScreen.tsx',
    T64: 'apps/web-admin/src/app/routes/tenancy/admin/pages/ops/T64-RegionMapping.tsx',
    T65: 'apps/web-admin/src/app/routes/tenancy/admin/pages/ops/T65-RealtimeCapacity.tsx',
    // ── Final Pages ──
    L3:  'apps/web-admin/src/app/routes/platform/admin/pages/leads/L3-LeadList.tsx',
    L3a: 'apps/web-admin/src/app/routes/platform/admin/pages/users/L3a-UserList.tsx',
    F9:  'apps/web-admin/src/app/routes/platform/admin/pages/invoices/F9-InvoiceEntry.tsx',
    F9a: 'apps/web-admin/src/app/routes/platform/admin/pages/users/F9a-UserEntry.tsx',
    T66: 'apps/web-admin/src/app/routes/platform/admin/pages/leads/T66-LeadConversion.tsx',
    T67: 'apps/web-admin/src/app/routes/platform/admin/pages/ops/T67-SupplyDemand.tsx',
    // ── Registries (G1-G2) ──
    G1:  'apps/web-admin/src/app/routes/platform/admin/pages/form-registry/index.tsx',
    G2:  'apps/web-admin/src/app/routes/platform/admin/pages/page-registry/index.tsx',
};

// ── FILE ASSOCIATE MAP ─────────────────────────────────────────────────────
// Links identity codes to their related pages within the same feature domain.
// Use: FILE_ASSOCIATE_MAP['D4'] → ['L22', 'R8'] (EVV Dashboard → EVV Exceptions + EVV Export)
export const FILE_ASSOCIATE_MAP: Record<string, string[]> = {
    // ── Dashboard & Registry Hub ──
    D1:  ['D2', 'G1', 'G2'],           // Admin Dashboard ↔ Registry Summary ↔ Registries
    D2:  ['D1', 'G1', 'G2'],           // Registry Summary ↔ Admin Dashboard
    G1:  ['G2', 'D2'],                 // Form Registry ↔ Page Registry
    G2:  ['G1', 'D2'],                 // Page Registry ↔ Form Registry

    // ── Incidents ──
    L2:  ['F10'],                      // Incident List ↔ Incident Entry
    F10: ['L2'],                       // Incident Entry ↔ Incident List

    // ── Leads ──
    L3:  ['F11', 'T66'],               // Lead List ↔ Lead Entry ↔ Lead Conversion
    F11: ['L3', 'T66'],                // Lead Entry ↔ Lead List ↔ Lead Conversion
    T66: ['L3', 'F11'],                // Lead Conversion ↔ Lead List ↔ Lead Entry

    // ── Users / Staff ──
    L3a: ['F9a'],                      // User List ↔ User Entry
    F9a: ['L3a'],                      // User Entry ↔ User List

    // ── Timesheets ──
    L4:  ['F8'],                       // Timesheets ↔ Timesheet Adjustment
    F8:  ['L4'],                       // Timesheet Adjustment ↔ Timesheets

    // ── Services ──
    L5:  ['T34'],                      // Services ↔ Catalog Browser (client view)
    T34: ['L5'],                       // Catalog Browser ↔ Services

    // ── Audits ──
    L6:  ['R9', 'R10', 'R13'],         // Audit Logs ↔ Audit Download ↔ Compliance Export ↔ Regulatory
    R9:  ['L6', 'R10', 'R13'],         // Audit Download ↔ Audit Logs
    R10: ['L6', 'R9', 'R13'],          // Compliance Export ↔ Audit Logs
    R13: ['L6', 'R9', 'R10'],          // Regulatory Export ↔ Audit Logs

    // ── Authorizations ──
    L7:  ['T49', 'R6'],                // Auth List ↔ Auth Alerts ↔ Auth Utilization
    T49: ['L7', 'R6'],                 // Auth Alerts ↔ Auth List
    R6:  ['L7', 'T49'],                // Auth Utilization ↔ Auth List

    // ── Consent ──
    L8:  ['T50', 'R7'],                // Consent List ↔ Consent Templates ↔ Consent Expiring
    T50: ['L8', 'R7'],                 // Consent Templates ↔ Consent List
    R7:  ['L8', 'T50'],                // Consent Expiring ↔ Consent List

    // ── Referrals ──
    L9:  ['R11'],                      // Referral List ↔ Referral Analytics
    R11: ['L9'],                       // Referral Analytics ↔ Referral List

    // ── Claims ──
    L10: ['R12'],                      // Claims List ↔ Claims ERA
    R12: ['L10'],                      // Claims ERA ↔ Claims List

    // ── Webhooks ──
    L11: ['T51'],                      // Webhook List ↔ Webhook Deliveries
    T51: ['L11'],                      // Webhook Deliveries ↔ Webhook List

    // ── Booking Requests ──
    L12: ['L14', 'F17'],               // Booking Queue ↔ Client Bookings ↔ Request Booking
    L14: ['L12', 'F17'],               // Client Bookings ↔ Booking Queue
    F17: ['L12', 'L14'],               // Request Booking ↔ Booking Queue

    // ── EVV ──
    D4:  ['L22', 'R8'],                // EVV Dashboard ↔ EVV Exceptions ↔ EVV Export
    L22: ['D4', 'R8'],                 // EVV Exceptions ↔ EVV Dashboard
    R8:  ['D4', 'L22'],                // EVV Export ↔ EVV Dashboard

    // ── AI ──
    D5:  ['T52', 'T53', 'T54', 'T55'], // AI Dashboard ↔ Predictive ↔ Churn ↔ Visit ↔ Sentiment
    T52: ['D5', 'T53', 'T54', 'T55'],  // Predictive Analytics → AI family
    T53: ['D5', 'T52', 'T54', 'T55'],  // Churn Risk → AI family
    T54: ['D5', 'T52', 'T53', 'T55'],  // Visit Optimization → AI family
    T55: ['D5', 'T52', 'T53', 'T54'],  // Sentiment Analysis → AI family

    // ── Security / Governance ──
    T10: ['T13', 'T14', 'T15', 'T16', 'T56', 'T57', 'T58'], // Security Governance → full security suite
    T13: ['T10'],                      // Device Management ↔ Security Governance
    T14: ['T10'],                      // Forensic Trails ↔ Security Governance
    T15: ['T10'],                      // CORS Settings ↔ Security Governance
    T16: ['T10'],                      // Integrity Verification ↔ Security Governance
    T56: ['T10'],                      // Permission Grid ↔ Security Governance
    T57: ['T10'],                      // Session Monitor ↔ Security Governance
    T58: ['T10'],                      // Threat Detection ↔ Security Governance

    // ── Finance / Accounting ──
    D3:  ['T17', 'T18', 'T59'],        // Accounting Dashboard ↔ Ledger ↔ Tax ↔ Reconciliation
    T17: ['D3', 'T18', 'T59'],         // Financial Ledger ↔ Accounting
    T18: ['D3', 'T17'],                // Tax Compliance ↔ Accounting
    T59: ['D3', 'T17'],                // Reconciliation ↔ Accounting

    // ── Admission / Onboarding ──
    F6:  ['F7'],                       // Client Admission ↔ Staff Onboarding
    F7:  ['F6'],                       // Staff Onboarding ↔ Client Admission

    // ── Invoices ──
    F9:  ['H3'],                       // Invoice Entry ↔ Revenue Cycle Hub
    H3:  ['F9'],                       // Revenue Cycle Hub ↔ Invoice Entry

    // ── Expenses / Payouts (PSW) ──
    F14: ['R4'],                       // Expense Claim ↔ Payout History
    R4:  ['F14', 'R3'],                // Payout History ↔ Expense Claim ↔ Earnings
    R3:  ['R4'],                       // PSW Earnings ↔ Payout History

    // ── Telehealth ──
    H1:  ['T8'],                       // Telehealth Center ↔ Clinical Assistant
    T8:  ['H1', 'T9'],                 // Clinical Assistant ↔ Telehealth ↔ AI Insights
    T9:  ['T8', 'D5'],                 // AI Insights ↔ Clinical Assistant ↔ AI Dashboard

    // ── Knowledge Base ──
    H8:  ['T48'],                      // Knowledge Base ↔ KB Article
    T48: ['H8'],                       // KB Article ↔ Knowledge Base

    // ── Setup / Wizards ──
    H19: ['W1', 'W2', 'W3', 'W4', 'W5', 'T12'], // Wizard Hub ↔ all wizards
    W1:  ['H19', 'T12'],               // Business Setup ↔ Wizard Hub ↔ Business Status
    W2:  ['H19', 'F7'],                // Staff Onboarding Wizard ↔ Wizard Hub ↔ Staff Onboarding
    W3:  ['H19'],                      // Care Plan Wizard ↔ Wizard Hub
    W4:  ['H19', 'H3'],                // Revenue Wizard ↔ Wizard Hub ↔ Revenue Cycle
    W5:  ['H19'],                      // Business Model Wizard ↔ Wizard Hub
    T12: ['H19', 'W1'],                // Business Status ↔ Wizard Hub

    // ── Reports / Exports ──
    R1:  ['R2'],                       // Report Center ↔ Export Page
    R2:  ['R1'],                       // Export Page ↔ Report Center

    // ── Search / Content ──
    T1:  ['T2'],                       // Search ↔ Content Manager
    T2:  ['T1', 'T3'],                 // Content Manager ↔ Search ↔ Template Editor
    T3:  ['T2'],                       // Template Editor ↔ Content Manager

    // ── Roles / Customers ──
    T4:  ['L15'],                      // Role Editor ↔ Customer List
    L15: ['T4'],                       // Customer List ↔ Role Editor

    // ── FHIR / Sovereign / Interop ──
    T5:  ['T6'],                       // FHIR Center ↔ Sovereign Wallet
    T6:  ['T5'],                       // Sovereign Wallet ↔ FHIR Center

    // ── Automation / Cron ──
    T7:  ['D6'],                       // AutoPilot ↔ Cron Dashboard
    D6:  ['T7'],                       // Cron Dashboard ↔ AutoPilot

    // ── Notifications / Documents ──
    H5:  ['H6'],                       // Notifications Hub ↔ Document Center
    H6:  ['H5'],                       // Document Center ↔ Notifications Hub

    // ── Payroll ──
    H7:  ['T24', 'D9'],                // Payroll Hub ↔ Payroll Verification ↔ Branch P&L
    T24: ['H7', 'D9'],                 // Payroll Verification ↔ Payroll Hub
    D9:  ['H7', 'T24'],                // Branch P&L ↔ Payroll Hub

    // ── Ops / Logistics ──
    H20: ['T64', 'T65', 'T67', 'H4'], // Logistics Hub ↔ Region Mapping ↔ Capacity ↔ Supply
    T64: ['H20', 'T65'],               // Region Mapping ↔ Logistics Hub
    T65: ['H20', 'T64'],               // Realtime Capacity ↔ Logistics Hub
    T67: ['H20'],                      // Supply & Demand ↔ Logistics Hub
    H4:  ['H20'],                      // Supply Chain Hub ↔ Logistics Hub

    // ── PSW Schedule ──
    L16: ['L17', 'T60', 'T61', 'T62'], // PSW Schedule ↔ Open Shifts ↔ Offers ↔ Live Visit ↔ Check-In
    L17: ['L16', 'T60'],               // Open Shifts ↔ Schedule ↔ Open Offers
    T60: ['L17', 'L16'],               // Open Offers ↔ Open Shifts
    T61: ['L16', 'T62'],               // Live Visit ↔ Schedule ↔ Check-In
    T62: ['L16', 'T61'],               // Check-In Screen ↔ Schedule ↔ Live Visit

    // ── PSW Dashboard & Support ──
    D14: ['L16', 'F13', 'F14', 'F15', 'R3'], // PSW Dashboard ↔ Schedule ↔ Handover ↔ Expenses ↔ Availability ↔ Earnings
    F13: ['D14'],                      // Shift Handover ↔ PSW Dashboard
    F15: ['D14'],                      // Availability ↔ PSW Dashboard
    T26: ['D14'],                      // Shift Confirmation ↔ PSW Dashboard
    H14: ['H15'],                      // Credential Vault ↔ PSW Training Hub
    H15: ['H14'],                      // PSW Training Hub ↔ Credential Vault
    T27: ['D14'],                      // Provider Social ↔ PSW Dashboard
    T28: ['D14'],                      // Mileage Tracker ↔ PSW Dashboard

    // ── RN Portal ──
    D15: ['T29', 'T30', 'H16', 'L18'], // RN Dashboard ↔ Care Plans ↔ Entry Verify ↔ Supervision ↔ Assessments
    T29: ['D15'],                      // Care Plan Manager ↔ RN Dashboard
    T30: ['D15'],                      // Entry Verify ↔ RN Dashboard
    H16: ['D15'],                      // Supervision Hub ↔ RN Dashboard
    L18: ['D15'],                      // Assessments Hub ↔ RN Dashboard
    T63: ['D15'],                      // RN Check-In ↔ RN Dashboard
    D16: ['T31'],                      // MAR Dashboard ↔ MAR Client
    T31: ['D16'],                      // MAR Client ↔ MAR Dashboard
    D17: ['T32'],                      // Wound Care Dashboard ↔ Wound Care Client
    T32: ['D17'],                      // Wound Care Client ↔ Wound Care Dashboard
    L19: ['T33'],                      // RAI Assessments ↔ RAI Assessment Detail
    T33: ['L19'],                      // RAI Assessment Detail ↔ RAI Assessments

    // ── Client Portal ──
    D8:  ['L14', 'H10', 'F16', 'F17', 'T34', 'T35', 'T36', 'T37', 'H17', 'R5', 'P1'],
    H10: ['D8'],                       // Billing Hub ↔ Client Dashboard
    F16: ['D8'],                       // Submit Feedback ↔ Client Dashboard
    T35: ['D8', 'T37'],                // Client Messaging ↔ Client Dashboard ↔ Feedback Loop
    T36: ['D8'],                       // Team Roster ↔ Client Dashboard
    T37: ['D8', 'T35'],                // Feedback Loop ↔ Client Dashboard ↔ Client Messaging
    H17: ['D8', 'P1'],                 // Family Care Hub ↔ Client Dashboard ↔ Family Portal
    R5:  ['D8'],                       // Medical Summary ↔ Client Dashboard
    P1:  ['D8', 'H17'],                // Family Portal ↔ Client Dashboard ↔ Family Care Hub

    // ── Coordinator Portal ──
    H18: ['T38', 'T39', 'L20', 'T40', 'T41'], // Coordinator Hub ↔ all coordinator tools
    T38: ['H18'],                      // Dispatch Map ↔ Coordinator Hub
    T39: ['H18'],                      // SOS Center ↔ Coordinator Hub
    L20: ['H18'],                      // Waitlist Manager ↔ Coordinator Hub
    T40: ['H18'],                      // Fleet Management ↔ Coordinator Hub
    T41: ['H18'],                      // Shift Swap ↔ Coordinator Hub

    // ── Allied Health ──
    D18: ['L21', 'T42'],               // Allied Health Dashboard ↔ Treatments ↔ Sign Off
    L21: ['D18', 'T42'],               // Treatment List ↔ Dashboard ↔ Sign Off
    T42: ['D18', 'L21'],               // Sign Off ↔ Dashboard ↔ Treatment List

    // ── Staff Portal ──
    D19: ['T43', 'T44', 'T45', 'T46'], // Staff Dashboard ↔ all staff tools
    T43: ['D19'],                      // Task Grid ↔ Staff Dashboard
    T44: ['D19'],                      // Message Center ↔ Staff Dashboard
    T45: ['D19'],                      // Incident Portal ↔ Staff Dashboard
    T46: ['D19'],                      // Compliance Monitor ↔ Staff Dashboard

    // ── Manager Portal ──
    D7:  ['H12', 'D10', 'T25', 'D9', 'T19', 'L13', 'T21', 'H11', 'T22', 'T23'],
    H12: ['D7'],                       // Operations Hub ↔ Manager Dashboard
    D10: ['D7'],                       // Regional Stats ↔ Manager Dashboard
    T25: ['D7'],                       // Compliance Sync ↔ Manager Dashboard
    T19: ['D7'],                       // Portfolio ↔ Manager Dashboard
    T20: ['D7'],                       // Daily Entry ↔ Manager Dashboard
    L13: ['D7'],                       // Evaluations ↔ Manager Dashboard
    T21: ['D7'],                       // Service Review ↔ Manager Dashboard
    H11: ['D7'],                       // Training Hub ↔ Manager Dashboard
    T22: ['D7'],                       // Survey Manager ↔ Manager Dashboard
    T23: ['D7'],                       // Staff Ranker ↔ Manager Dashboard

    // ── Marketing / HR / Finance / QA ──
    D11: ['D7'],                       // Marketing Dashboard ↔ Manager Dashboard
    H13: ['D7'],                       // HR Recruitment ↔ Manager Dashboard
    D12: ['D7', 'D9'],                 // Finance Regional Hub ↔ Manager ↔ Branch P&L
    D13: ['D15'],                      // Clinical QA ↔ RN Dashboard

    // ── Scrum Master ──
    T47: ['T7'],                       // Response Bot Audit ↔ AutoPilot

    // ── Auth Forms ──
    F1:  ['F2', 'F3'],                 // Login ↔ Register ↔ Forgot Password
    F2:  ['F1'],                       // Register ↔ Login
    F3:  ['F1', 'F4'],                 // Forgot Password ↔ Login ↔ Reset Password
    F4:  ['F3'],                       // Reset Password ↔ Forgot Password
    F5:  ['W1'],                       // Business Onboard ↔ Business Setup Wizard

    // ── Schedule / Locations ──
    L1:  ['L16'],                      // Admin Schedule ↔ PSW Schedule
    F12: ['T64'],                      // Locations ↔ Region Mapping
    T11: ['D1'],                       // Settings ↔ Admin Dashboard

    // ── Pharmacy / Reference ──
    H2:  ['H4'],                       // Pharmacy Hub ↔ Supply Chain Hub
    H9:  ['T11'],                      // Reference Data Hub ↔ Settings
};
