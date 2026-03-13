// ──────────────────────────────────────────────────────────────────────────────
// PageRegistry — Master catalogue of EVERY page in the platform, classified
// by type. Sub-registries (DashboardRegistry, FormRegistry, ListRegistry, etc.)
// provide type-specific metadata. This is the single source of truth for all
// page discovery, navigation, and governance.
//
// Data is split into sub-files under ./PageRegistry/
// This skeleton contains types, build logic, and lookup helpers only.
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

// ── Sub-Registry Type Definitions ────────────────────────────────────────────

export interface DashboardEntry {
    id: string;
    label: string;
    route: string;
    owner: PageEntry['owner'];
    statsEndpoints: string[];
    widgets: ('kpi-card' | 'chart' | 'table' | 'map' | 'calendar' | 'feed' | 'alert-panel')[];
    icon?: string;
}

export interface ListEntry {
    id: string;
    label: string;
    route: string;
    owner: PageEntry['owner'];
    fetchEndpoint: string;
    columns: string[];
    searchable: boolean;
    filterable: boolean;
}

export interface HubEntry {
    id: string;
    label: string;
    route: string;
    owner: PageEntry['owner'];
    description: string;
    sections: string[];
}

export interface WizardEntry {
    id: string;
    label: string;
    route: string;
    owner: PageEntry['owner'];
    steps: string[];
    formRegistryId?: string;
}

export interface ReportEntry {
    id: string;
    label: string;
    route: string;
    owner: PageEntry['owner'];
    fetchEndpoint: string;
    exportFormats: ('pdf' | 'csv' | 'xlsx')[];
}

export interface ToolEntry {
    id: string;
    label: string;
    route: string;
    owner: PageEntry['owner'];
    description: string;
}

export interface MasterEntry {
    file: string;
    label: string;
    type: PageType;
    owner: PageEntry['owner'];
    associates: string[];
}

// ── Import sub-registry data ─────────────────────────────────────────────────

import { DashboardRegistry } from './PageRegistry/dashboards';
import { ListRegistry } from './PageRegistry/lists';
import { HubRegistry } from './PageRegistry/hubs';
import { WizardRegistry, ReportRegistry } from './PageRegistry/wizards-reports';
import { ToolRegistry } from './PageRegistry/tools';
import { MASTER_REGISTRY } from './PageRegistry/master-registry';

// Re-export sub-registries for backward compatibility
export { DashboardRegistry, ListRegistry, HubRegistry, WizardRegistry, ReportRegistry, ToolRegistry, MASTER_REGISTRY };

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
    const raw: RawPage[] = [];

    raw.push(...AUTH_PAGES);
    raw.push(...ERROR_PAGES);

    DashboardRegistry.forEach(d => raw.push({
        id: `page.${d.id}`, label: d.label, route: d.route, type: 'dashboard',
        owner: d.owner, icon: d.icon, dashboardRegistryId: d.id,
    } as RawPage));

    ListRegistry.forEach(l => raw.push({
        id: `page.${l.id}`, label: l.label, route: l.route, type: 'list', owner: l.owner,
    } as RawPage));

    HubRegistry.forEach(h => raw.push({
        id: `page.${h.id}`, label: h.label, route: h.route, type: 'hub',
        owner: h.owner, description: h.description,
    } as RawPage));

    WizardRegistry.forEach(w => raw.push({
        id: `page.${w.id}`, label: w.label, route: w.route, type: 'wizard',
        owner: w.owner, formRegistryId: w.formRegistryId,
    } as RawPage));

    ReportRegistry.forEach(r => raw.push({
        id: `page.${r.id}`, label: r.label, route: r.route, type: 'report', owner: r.owner,
    } as RawPage));

    ToolRegistry.forEach(t => raw.push({
        id: `page.${t.id}`, label: t.label, route: t.route, type: 'tool',
        owner: t.owner, description: t.description,
    } as RawPage));

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

    raw.push(
        { id: 'page.shared.profile', label: 'Profile', route: '/profile', type: 'form', owner: 'shared', formRegistryId: 'shared.profile' } as RawPage,
        { id: 'page.shared.messaging', label: 'Messaging', route: '/messaging', type: 'tool', owner: 'shared' } as RawPage,
        { id: 'page.shared.support', label: 'Support', route: '/support', type: 'hub', owner: 'shared' } as RawPage,
        { id: 'page.shared.learn', label: 'Learning Center', route: '/learn', type: 'portal', owner: 'shared' } as RawPage,
    );

    raw.push(
        { id: 'page.admin.form-registry', label: 'Form Registry', route: '/platform/admin/form-registry', type: 'registry', owner: 'admin', icon: '📋' } as RawPage,
        { id: 'page.admin.page-registry', label: 'Page Registry', route: '/platform/admin/page-registry', type: 'registry', owner: 'admin', icon: '📖' } as RawPage,
    );

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
