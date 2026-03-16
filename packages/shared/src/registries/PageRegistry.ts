// ──────────────────────────────────────────────────────────────────────────────
// PageRegistry — Master catalogue of EVERY page in the platform, classified
// by type. This skeleton contains types, re-exports, and lookup helpers only.
//
// Data is split into sub-files under ./PageRegistry/
// ──────────────────────────────────────────────────────────────────────────────

// ── Page Type Definitions ────────────────────────────────────────────────────

export type PageType =
    | 'dashboard' | 'form' | 'list' | 'hub' | 'wizard'
    | 'detail' | 'settings' | 'report' | 'tool' | 'portal'
    | 'registry' | 'error';

export interface PageEntry {
    srNo: number;
    categoryCode: string;
    id: string;
    label: string;
    originalLabel?: string;
    route: string;
    type: PageType;
    owner: 'admin' | 'superuser' | 'manager' | 'staff' | 'psw' | 'rn' |
           'client' | 'coordinator' | 'allied' | 'scrum-master' | 'auth' | 'shared';
    icon?: string;
    description?: string;
    formRegistryId?: string;
    dashboardRegistryId?: string;
    associates?: string[];
}

export const CATEGORY_PREFIXES: Record<PageType, string> = {
    dashboard: 'D', form: 'F', list: 'L', hub: 'H', wizard: 'W',
    detail: 'DT', settings: 'S', report: 'R', tool: 'T', portal: 'P',
    registry: 'G', error: 'E',
};

// ── Sub-Registry Types ───────────────────────────────────────────────────────

export interface DashboardEntry {
    id: string; label: string; route: string; owner: PageEntry['owner'];
    statsEndpoints: string[];
    widgets: ('kpi-card' | 'chart' | 'table' | 'map' | 'calendar' | 'feed' | 'alert-panel')[];
    icon?: string;
}

export interface ListEntry {
    id: string; label: string; route: string; owner: PageEntry['owner'];
    fetchEndpoint: string; columns: string[]; searchable: boolean; filterable: boolean;
}

export interface HubEntry {
    id: string; label: string; route: string; owner: PageEntry['owner'];
    description: string; sections: string[];
}

export interface WizardEntry {
    id: string; label: string; route: string; owner: PageEntry['owner'];
    steps: string[]; formRegistryId?: string;
}

export interface ReportEntry {
    id: string; label: string; route: string; owner: PageEntry['owner'];
    fetchEndpoint: string; exportFormats: ('pdf' | 'csv' | 'xlsx')[];
}

export interface ToolEntry {
    id: string; label: string; route: string; owner: PageEntry['owner'];
    description: string;
}

export interface MasterEntry {
    file: string; label: string; type: PageType; owner: PageEntry['owner'];
    associates: string[];
}

// ── Import + Re-export sub-registries ────────────────────────────────────────

import { DashboardRegistry } from './PageRegistry/dashboards';
import { ListRegistry } from './PageRegistry/lists';
import { HubRegistry } from './PageRegistry/hubs';
import { WizardRegistry, ReportRegistry } from './PageRegistry/wizards-reports';
import { ToolRegistry } from './PageRegistry/tools';
import { MASTER_REGISTRY } from './PageRegistry/master-registry';
import { buildPageEntries } from './PageRegistry/page-builder';

export { DashboardRegistry, ListRegistry, HubRegistry, WizardRegistry, ReportRegistry, ToolRegistry, MASTER_REGISTRY };

// ── Aggregate ────────────────────────────────────────────────────────────────

export const PageRegistry: PageEntry[] = buildPageEntries();

// ── Lookup Helpers ───────────────────────────────────────────────────────────

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
        srNo: p.srNo, categoryCode: p.categoryCode, label: p.label,
        type: p.type, owner: p.owner, route: p.route, id: p.id,
    }));

export const PAGE_REGISTRY_COUNT = PageRegistry.length;

// ── MASTER REGISTRY Helpers ──────────────────────────────────────────────────

export const FILE_IDENTITY_MAP: Record<string, string> = Object.fromEntries(
    Object.entries(MASTER_REGISTRY).map(([code, entry]) => [code, entry.file])
);
export const FILE_ASSOCIATE_MAP: Record<string, string[]> = Object.fromEntries(
    Object.entries(MASTER_REGISTRY).map(([code, entry]) => [code, entry.associates])
);

export const getMasterEntry = (code: string): MasterEntry | undefined => MASTER_REGISTRY[code];

export const getAssociates = (code: string): { code: string; label: string; type: PageType }[] => {
    const entry = MASTER_REGISTRY[code];
    if (!entry) return [];
    return entry.associates.filter(c => MASTER_REGISTRY[c]).map(c => ({
        code: c, label: MASTER_REGISTRY[c]!.label, type: MASTER_REGISTRY[c]!.type,
    }));
};

export const getMasterByType = (type: PageType): { code: string; entry: MasterEntry }[] =>
    Object.entries(MASTER_REGISTRY).filter(([, e]) => e.type === type).map(([code, entry]) => ({ code, entry }));

export const getMasterByOwner = (owner: PageEntry['owner']): { code: string; entry: MasterEntry }[] =>
    Object.entries(MASTER_REGISTRY).filter(([, e]) => e.owner === owner).map(([code, entry]) => ({ code, entry }));

export const MASTER_REGISTRY_COUNT = Object.keys(MASTER_REGISTRY).length;
