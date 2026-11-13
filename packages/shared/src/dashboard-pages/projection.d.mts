export type DashboardFamily = 'project' | 'analytics' | 'finance' | 'crypto';
export type DashboardScope = {dataset: 'live' | 'demo'; userId: string; tenantId: string; role: string};
export type TaskMetricKey = 'open' | 'review' | 'blocked' | 'overdue' | 'completed';
export type AnalyticsMetricKey = 'staff' | 'clients' | 'visits' | 'requests' | 'time' | 'care' | 'plans';
export type DashboardMetric = {
  key: TaskMetricKey | AnalyticsMetricKey;
  value: number | null;
  sourceField: `taskStats.${TaskMetricKey}` | `stats.${AnalyticsMetricKey}`;
};
export type DashboardProjection = {
  family: DashboardFamily;
  dataset: 'live' | 'demo';
  synthetic: boolean;
  sourceApiId: 16578;
  status: 'ready' | 'denied' | 'unavailable';
  metrics: DashboardMetric[];
};
export const dashboardFamilies: readonly DashboardFamily[];
/** Unknown response bytes and string families are validated by the existing runtime implementation. */
export function projectDashboard(family: string, raw: unknown, expected: DashboardScope): DashboardProjection;
export function validateDashboardResponseScope(raw: unknown, expected: DashboardScope): void;
