// ──────────────────────────────────────────────────────────────────────────────
// PageTemplate — Registry-driven page renderer.
//
// HOW IT WORKS:
// 1. PageSectionRegistry says WHAT sections a page has (data)
// 2. sections/ folder has HOW each section renders (templates)
// 3. PageTemplate reads the registry → picks the right template → renders
//
// BEFORE (200 lines):
//   export default function GamificationHub() {
//       return <div>...200 lines of JSX...</div>
//   }
//
// AFTER (20 lines):
//   export default function GamificationHub() {
//       return <PageTemplate pageId="H25" title="..." sectionData={{...}} />
//   }
// ──────────────────────────────────────────────────────────────────────────────

import React from 'react';
import { getSectionsForPage, type PageSection } from 'prime-care-shared';
import { PageActionBar } from './PageActionBar';
import {
    SectionHeader,
    SectionKpiCards, type KpiCardItem,
    SectionTable, type TableColumn,
    SectionTabs, type TabItem,
    SectionCardGrid, type CardGridItem,
    SectionProgressList, type ProgressItem,
    SectionAlertPanel, type AlertItem,
    SectionPlaceholder,
} from '../sections';

// ── Data types for feeding sections ──────────────────────────────────────────

export interface SectionData {
    kpiCards?: KpiCardItem[];
    table?: { columns: TableColumn[]; rows: Record<string, any>[]; emptyMsg?: string };
    cardGrid?: { items: CardGridItem[]; columns?: number };
    tabs?: { tabs: TabItem[]; activeTab: string; onTabChange: (id: string) => void };
    progressList?: { items: ProgressItem[] };
    alerts?: AlertItem[];
}

export interface PageTemplateProps {
    /** Master-registry page code (e.g. 'H25', 'D14') */
    pageId: string;
    /** Page title */
    title: string;
    subtitle?: string;
    /** PageActionRegistry page key (e.g. 'manager.gamification') */
    actionPageId?: string;
    isLive?: boolean;
    lastUpdated?: Date;
    /** Section data keyed by section.id */
    sectionData?: Record<string, SectionData>;
    /** Custom JSX overrides keyed by section.id */
    overrides?: Record<string, React.ReactNode>;
    /** Action bar event handlers */
    actionHandlers?: Record<string, () => void>;
}

export function PageTemplate({
    pageId, title, subtitle, actionPageId,
    isLive, lastUpdated,
    sectionData = {}, overrides = {}, actionHandlers = {},
}: PageTemplateProps) {
    const sections = getSectionsForPage(pageId);

    const renderSection = (section: PageSection) => {
        // 1. Custom override wins
        if (overrides[section.id]) return <div key={section.id}>{overrides[section.id]}</div>;

        // 2. Planned/deprecated → placeholder
        if (section.status === 'planned' || section.status === 'deprecated') {
            return <SectionPlaceholder key={section.id} section={section} />;
        }

        // 3. Skip header & action-bar (rendered above)
        if (section.type === 'header' || section.type === 'action-bar') return null;

        const data = sectionData[section.id];

        // 4. Auto-render by type using section templates
        switch (section.type) {
            case 'kpi-cards':
            case 'stats':
                return data?.kpiCards
                    ? <SectionKpiCards key={section.id} items={data.kpiCards} />
                    : <SectionPlaceholder key={section.id} section={section} />;
            case 'table':
                return data?.table
                    ? <SectionTable key={section.id} {...data.table} />
                    : <SectionPlaceholder key={section.id} section={section} />;
            case 'tabs':
                return data?.tabs
                    ? <SectionTabs key={section.id} {...data.tabs} />
                    : null;
            case 'list':
            case 'custom':
                if (data?.cardGrid) return <SectionCardGrid key={section.id} {...data.cardGrid} />;
                if (data?.progressList) return <SectionProgressList key={section.id} {...data.progressList} />;
                if (data?.table) return <SectionTable key={section.id} {...data.table} />;
                return <SectionPlaceholder key={section.id} section={section} />;
            case 'alert-panel':
                return data?.alerts
                    ? <SectionAlertPanel key={section.id} alerts={data.alerts} />
                    : <SectionPlaceholder key={section.id} section={section} />;
            default:
                return <SectionPlaceholder key={section.id} section={section} />;
        }
    };

    return (
        <div data-cy="page.container" role="main" aria-label={title}
            style={{ padding: '24px', maxWidth: '1400px', margin: '0 auto' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', flexWrap: 'wrap', gap: '16px' }}>
                <SectionHeader title={title} subtitle={subtitle} isLive={isLive} lastUpdated={lastUpdated} />
                {actionPageId && <PageActionBar pageId={actionPageId} size="sm" handlers={actionHandlers} />}
            </div>
            {sections.map(renderSection)}
        </div>
    );
}
