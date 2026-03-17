// ── Sections — Standardized page section templates ───────────────────────────
// Each file exports a reusable section component.
// PageSectionRegistry defines WHAT sections a page has (data).
// These components define HOW each section type renders (UI).
// PageTemplate reads the registry → picks the right component → renders.

// ── Data Display ─────────────────────────────────────────────────────────────
export { SectionKpiCards, type KpiCardItem } from './SectionKpiCards';
export { SectionTable, type TableColumn } from './SectionTable';
export { SectionCardGrid, type CardGridItem } from './SectionCardGrid';
export { SectionProgressList, type ProgressItem } from './SectionProgressList';

// ── Visualization ────────────────────────────────────────────────────────────
export { SectionChart, type ChartDataPoint } from './SectionChart';
export { SectionMap, type MapMarker } from './SectionMap';
export { SectionCalendar, type CalendarEvent } from './SectionCalendar';

// ── Input ────────────────────────────────────────────────────────────────────
export { SectionForm, type FormField } from './SectionForm';
export { SectionActionBar, type ActionBarButton } from './SectionActionBar';
export { SectionFilters, type FilterOption } from './SectionFilters';

// ── Feedback ─────────────────────────────────────────────────────────────────
export { SectionAlertPanel, type AlertItem } from './SectionAlertPanel';
export { SectionFeed, type FeedItem } from './SectionFeed';
export { SectionEmptyState } from './SectionEmptyState';
export { SectionStatusCards, type StatusCardItem } from './SectionStatusCards';

// ── Layout ───────────────────────────────────────────────────────────────────
export { SectionHeader } from './SectionHeader';
export { SectionTabs, type TabItem } from './SectionTabs';
export { SectionBanner, type SectionBannerProps } from './SectionBanner';

// ── Fallback ─────────────────────────────────────────────────────────────────
export { SectionPlaceholder } from './SectionPlaceholder';
