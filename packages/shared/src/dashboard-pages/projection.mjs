/** Read-only B16 presentation. This validates an already authorized response; it grants no access. */
const fields = Object.freeze({
  project: Object.freeze(['open', 'review', 'blocked', 'overdue', 'completed']),
  analytics: Object.freeze(['staff', 'clients', 'visits', 'requests', 'time', 'care', 'plans'])
});
export const dashboardFamilies = Object.freeze(['project', 'analytics', 'finance', 'crypto']);
export function projectDashboard(family, raw, expected) {
  if (!dashboardFamilies.includes(family)) throw Error('invalid_family');
  if (!expected || !['live', 'demo'].includes(expected.dataset) ||
      ![expected.userId, expected.tenantId, expected.role].every(x => typeof x === 'string' && x.length > 0)) throw Error('invalid_scope');
  if (!raw || raw.dataset !== expected.dataset || raw.synthetic !== (expected.dataset === 'demo') ||
      raw.identity?.userId !== expected.userId || raw.identity?.role !== expected.role ||
      raw.organization?.id !== expected.tenantId) throw Error('scope_changed');
  const base = {family, dataset: expected.dataset, synthetic: raw.synthetic, sourceApiId: 16578};
  if (!fields[family]) return {...base, status: 'unavailable', metrics: []};
  if (!Array.isArray(raw.allowedViews) || !raw.allowedViews.includes(family === 'analytics' ? 'operations' : 'tasks'))
    return {...base, status: 'denied', metrics: []};
  const values = family === 'project' ? raw.taskStats : raw.stats;
  const metrics = fields[family].map(key => {
    const value = values?.[key];
    if (!Number.isSafeInteger(value) || value < 0) throw Error('invalid_count');
    return {key, value, sourceField: (family === 'project' ? 'taskStats.' : 'stats.') + key};
  });
  // Counts can overlap (blocked and overdue are subsets of open). Never sum or make a pie chart.
  return {...base, status: 'ready', metrics};
}
