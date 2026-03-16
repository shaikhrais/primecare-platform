// ──────────────────────────────────────────────────────────────────────────────
// PageSectionRegistry — Catalogue of sections within every page.
// Enables: content administration, development verification, mock tracking.
//
// Data is split into sub-files under ./PageSectionRegistry/
// This skeleton contains types, aggregate, and lookup helpers only.
// ──────────────────────────────────────────────────────────────────────────────

// ── Section Type Definitions ─────────────────────────────────────────────────

export type SectionStatus = 'built' | 'mocked' | 'planned' | 'deprecated';

export type SectionType =
    | 'header' | 'stats' | 'kpi-cards' | 'chart' | 'table'
    | 'list' | 'form' | 'tabs' | 'modal' | 'action-bar' | 'feed'
    | 'alert-panel' | 'map' | 'calendar' | 'wizard-step' | 'chat'
    | 'empty-state' | 'skeleton' | 'custom';

export interface PageSection {
    id: string;
    label: string;
    type: SectionType;
    status: SectionStatus;
    component?: string;
    dataCy?: string;
    apiEndpoint?: string;
    description?: string;
}

export interface PageSections {
    pageId: string;
    label: string;
    sections: PageSection[];
}

// ── Import sub-files ─────────────────────────────────────────────────────────

import { ADMIN_SECTIONS } from './PageSectionRegistry/admin-sections';
import { TENANCY_SECTIONS } from './PageSectionRegistry/tenancy-sections';
import { PREMIUM_SECTIONS } from './PageSectionRegistry/premium-sections';

// ── Aggregate ────────────────────────────────────────────────────────────────

export const PageSectionRegistry: Record<string, PageSections> = {
    ...ADMIN_SECTIONS,
    ...TENANCY_SECTIONS,
    ...PREMIUM_SECTIONS,
};

// ── Lookup Helpers ───────────────────────────────────────────────────────────

export const getSectionsForPage = (pageId: string): PageSection[] =>
    PageSectionRegistry[pageId]?.sections ?? [];

export const getSectionsByStatus = (status: SectionStatus): { pageId: string; section: PageSection }[] =>
    Object.entries(PageSectionRegistry).flatMap(([pageId, ps]) =>
        ps.sections.filter(s => s.status === status).map(section => ({ pageId, section }))
    );

export const getSectionsByType = (type: SectionType): { pageId: string; section: PageSection }[] =>
    Object.entries(PageSectionRegistry).flatMap(([pageId, ps]) =>
        ps.sections.filter(s => s.type === type).map(section => ({ pageId, section }))
    );

export const getPageCompletionStats = (): { pageId: string; label: string; total: number; built: number; mocked: number; planned: number; pct: number }[] =>
    Object.entries(PageSectionRegistry).map(([pageId, ps]) => {
        const total = ps.sections.length;
        const built = ps.sections.filter(s => s.status === 'built').length;
        const mocked = ps.sections.filter(s => s.status === 'mocked').length;
        const planned = ps.sections.filter(s => s.status === 'planned').length;
        return { pageId, label: ps.label, total, built, mocked, planned, pct: total ? Math.round((built / total) * 100) : 0 };
    });

export const getMockedSections = (): { pageId: string; section: PageSection }[] =>
    getSectionsByStatus('mocked');

export const getPlannedSections = (): { pageId: string; section: PageSection }[] =>
    getSectionsByStatus('planned');

export const PAGE_SECTION_COUNT = Object.values(PageSectionRegistry)
    .reduce((acc, ps) => acc + ps.sections.length, 0);

export const PAGE_SECTION_REGISTRY_COUNT = Object.keys(PageSectionRegistry).length;
