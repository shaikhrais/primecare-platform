// ──────────────────────────────────────────────────────────────────────────────
// PageTemplate — Registry-driven page renderer.
//
// HOW IT WORKS:
// 1. PageSectionRegistry says WHAT sections a page has (data)
// 2. sections/ folder has HOW each section renders (templates)
// 3. PageTemplate reads the registry → picks the right template → renders
//
// ARCHITECTURE: Uses a COMPONENT MAP instead of a switch statement.
// Adding a new section type = 1 line in SECTION_MAP + 1 line in SectionData.
// ──────────────────────────────────────────────────────────────────────────────

import React from 'react';
import { getSectionsForPage, type PageSection, type SectionType } from 'prime-care-shared';
import { PageActionBar } from './PageActionBar';
import {
    SectionHeader,
    SectionKpiCards, type KpiCardItem,
    SectionTable, type TableColumn,
    SectionTabs, type TabItem,
    SectionCardGrid, type CardGridItem,
    SectionProgressList, type ProgressItem,
    SectionAlertPanel, type AlertItem,
    SectionChart, type ChartDataPoint,
    SectionForm, type FormField,
    SectionFeed, type FeedItem,
    SectionEmptyState,
    SectionActionBar, type ActionBarButton,
    SectionMap, type MapMarker,
    SectionCalendar, type CalendarEvent,
    SectionPlaceholder,
} from '../sections';

// ── Component Map (replaces switch statement) ────────────────────────────────
// Key = SectionType from PageSectionRegistry
// Value = { component, dataKey } — which component to render and which SectionData key to use

interface SectionMapEntry {
    component: React.ComponentType<any>;
    dataKey: keyof SectionData;
}

const SECTION_MAP: Partial<Record<SectionType, SectionMapEntry>> = {
    'kpi-cards':    { component: SectionKpiCards,    dataKey: 'kpiCards' },
    'stats':        { component: SectionKpiCards,    dataKey: 'kpiCards' },
    'table':        { component: SectionTable,       dataKey: 'table' },
    'chart':        { component: SectionChart,       dataKey: 'chart' },
    'form':         { component: SectionForm,        dataKey: 'form' },
    'feed':         { component: SectionFeed,        dataKey: 'feed' },
    'alert-panel':  { component: SectionAlertPanel,  dataKey: 'alerts' },
    'empty-state':  { component: SectionEmptyState,  dataKey: 'emptyState' },
    'map':          { component: SectionMap,         dataKey: 'map' },
    'calendar':     { component: SectionCalendar,    dataKey: 'calendar' },
};

// ── Data types for feeding sections ──────────────────────────────────────────

export interface SectionData {
    // Data Display
    kpiCards?: KpiCardItem[];
    table?: { columns: TableColumn[]; rows: Record<string, any>[]; emptyMsg?: string };
    cardGrid?: { items: CardGridItem[]; columns?: number };
    progressList?: { items: ProgressItem[] };
    // Visualization
    chart?: { data: ChartDataPoint[]; title?: string; type?: 'bar' | 'horizontal-bar' | 'donut'; height?: number };
    map?: { markers: MapMarker[]; title?: string; height?: number };
    calendar?: { events: CalendarEvent[]; title?: string };
    // Input
    form?: { fields: FormField[]; columns?: 1 | 2 | 3; submitLabel?: string; onSubmit?: () => void; title?: string };
    actionBar?: { buttons: ActionBarButton[]; align?: 'left' | 'right' | 'space-between' };
    // Feedback
    alerts?: AlertItem[];
    feed?: { items: FeedItem[]; title?: string; maxItems?: number };
    emptyState?: { icon?: string; title: string; description?: string; actionLabel?: string; onAction?: () => void };
    // Layout
    tabs?: { tabs: TabItem[]; activeTab: string; onTabChange: (id: string) => void };
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

        // 3. Skip header & action-bar (rendered in the header area)
        if (section.type === 'header' || section.type === 'action-bar') return null;

        const data = sectionData[section.id];

        // 4. Tabs — special case (needs its own rendering)
        if (section.type === 'tabs') {
            return data?.tabs ? <SectionTabs key={section.id} {...data.tabs} /> : null;
        }

        // 5. List/custom — multi-format: try cardGrid → progressList → table → chart → feed
        if (section.type === 'list' || section.type === 'custom') {
            if (data?.cardGrid) return <SectionCardGrid key={section.id} {...data.cardGrid} />;
            if (data?.progressList) return <SectionProgressList key={section.id} {...data.progressList} />;
            if (data?.table) return <SectionTable key={section.id} {...data.table} />;
            if (data?.chart) return <SectionChart key={section.id} {...data.chart} />;
            if (data?.feed) return <SectionFeed key={section.id} {...data.feed} />;
            if (data?.map) return <SectionMap key={section.id} {...data.map} />;
            if (data?.calendar) return <SectionCalendar key={section.id} {...data.calendar} />;
            return <SectionPlaceholder key={section.id} section={section} />;
        }

        // 6. Component Map lookup — 1 line per type, no switch needed
        const entry = SECTION_MAP[section.type];
        if (entry) {
            const sectionDataValue = data?.[entry.dataKey];
            if (sectionDataValue) {
                const Component = entry.component;
                // For kpiCards the data shape is an array, for others it's an object with spread props
                if (entry.dataKey === 'kpiCards') return <Component key={section.id} items={sectionDataValue} />;
                if (entry.dataKey === 'alerts') return <Component key={section.id} alerts={sectionDataValue} />;
                return <Component key={section.id} {...(sectionDataValue as any)} />;
            }
            return <SectionPlaceholder key={section.id} section={section} />;
        }

        // 7. Unknown type → placeholder
        return <SectionPlaceholder key={section.id} section={section} />;
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
