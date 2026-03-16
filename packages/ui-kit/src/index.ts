/**
 * @primecare/ui-kit — Shared Presentational Components
 *
 * Pure, app-agnostic UI primitives extracted from web-admin.
 * These components have zero app-level dependencies (no router,
 * no API client, no registries) — only React.
 *
 * Usage:
 *   import { StatusBadge, DataCard, AsyncView } from '@primecare/ui-kit';
 */

// Design System
export { StatusBadge } from './StatusBadge';
export { DataCard } from './DataCard';
export { LoadingSkeleton } from './LoadingSkeleton';

// UI Primitives
export { AsyncView } from './AsyncView';
export { Toast } from './Toast';
export type { ToastType } from './Toast';
export { LiveIndicator } from './LiveIndicator';

// Skeleton system
export {
    SkeletonBox,
    SkeletonCircle,
    StatCardSkeleton,
    DashboardSkeleton,
    TableSkeleton,
    CardGridSkeleton,
    MapSkeleton,
    InlineRowSkeleton,
} from './Skeleton';

// Layout
export { default as EmptyState } from './EmptyState';
