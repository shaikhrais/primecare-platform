// ── Sections — Standardized page section templates ───────────────────────────
// Each file exports a reusable section component.
// PageSectionRegistry defines WHAT sections a page has.
// These components define HOW each section renders.
// PageTemplate reads the registry and picks the right component.

export { SectionHeader } from './SectionHeader';
export { SectionKpiCards, type KpiCardItem } from './SectionKpiCards';
export { SectionTable, type TableColumn } from './SectionTable';
export { SectionTabs, type TabItem } from './SectionTabs';
export { SectionCardGrid, type CardGridItem } from './SectionCardGrid';
export { SectionProgressList, type ProgressItem } from './SectionProgressList';
export { SectionAlertPanel, type AlertItem } from './SectionAlertPanel';
export { SectionPlaceholder } from './SectionPlaceholder';
