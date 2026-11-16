// Synthetic fixture validation only. This module is not imported by the product.
const LOCALES = ['en', 'fr', 'es'];
const ROUTE_PREFIX = '/offices/corporate/roles/ceo';
const SUFFIXES = Object.freeze({
  'TSK-COR-701-01': '/dashboard', 'TSK-COR-707-01': '/enterprise-overview',
  'TSK-COR-708-01': '/franchise-overview', 'TSK-COR-709-01': '/region-performance',
  'TSK-COR-710-01': '/revenue-summary', 'TSK-COR-711-01': '/strategic-kpis',
  'TSK-COR-712-01': '/growth-pipeline', 'TSK-COR-713-01': '/leadership-reports',
  'TSK-COR-714-01': '/alerts-and-risks', 'TSK-COR-715-01': '/organization-map',
  'TSK-COR-716-01': '/approvals', 'TSK-COR-717-01': '/reports',
});
const GROUPS = [
  ['access', ['701']],
  ['performance', ['701', '707', '708', '709', '710', '711']],
  ['risk', ['712', '713', '714', '715']],
  ['reporting', ['716', '717']],
];
function requireValue(ok, context) {
  if (!ok) throw new Error('Invalid CEO training draft: ' + context);
}
function exactKeys(value, keys, context) {
  requireValue(value !== null && typeof value === 'object' && !Array.isArray(value), context);
  requireValue(Object.keys(value).length === keys.length &&
    keys.every(key => Object.hasOwn(value, key)), context);
}
function equalList(actual, expected, context) {
  requireValue(Array.isArray(actual) && actual.length === expected.length &&
    expected.every((item, i) => actual[i] === item), context);
}
function draftText(value, context) {
  requireValue(typeof value === 'string' && value === value.trim() &&
    value.length > 0 && value.length <= 800 && !/[<>\u0000-\u001f\u007f]/u.test(value), context);
  return value;
}
/** Return only presentation copy; no route, grant, task command, media or progress config. */
export function readOnlyCatalog(draft, verifiedReviewSourceCommit) {
  exactKeys(draft, ['schemaVersion', 'draftOnly', 'role', 'sourceCommit',
    'routePrefixForReferenceOnly', 'defaultLocale', 'localesUnderReview', 'taskGroups', 'tasks', 'copy'], 'top-level fields');
  requireValue(draft.schemaVersion === 1 && draft.draftOnly === true && draft.role === 'ceo',
    'draft identity');
  requireValue(typeof verifiedReviewSourceCommit === 'string' &&
    /^[a-f0-9]{40}$/.test(verifiedReviewSourceCommit) &&
    draft.sourceCommit === verifiedReviewSourceCommit, 'review source commit');
  requireValue(draft.routePrefixForReferenceOnly === ROUTE_PREFIX && draft.defaultLocale === 'en',
    'route reference and default locale');
  equalList(draft.localesUnderReview, LOCALES, 'locales');
  exactKeys(draft.tasks, Object.keys(SUFFIXES), '12 known wiki tasks');
  for (const [id, suffix] of Object.entries(SUFFIXES)) {
    const task = draft.tasks[id];
    exactKeys(task, ['routeSuffix', 'sourceStatus'], id);
    requireValue(task.routeSuffix === suffix, id + ' source route');
    draftText(task.sourceStatus, id + ' status note');
  }
  requireValue(Array.isArray(draft.taskGroups) && draft.taskGroups.length === GROUPS.length, 'four task groups');
  GROUPS.forEach(([id, taskIds], index) => {
    const group = draft.taskGroups[index];
    exactKeys(group, ['id', 'wikiTaskIds', 'exercise'], id);
    requireValue(group.id === id && group.exercise === (id === 'access' ?
      'source-backed-navigation-when-available' : 'synthetic-read-only'), id + ' delivery scope');
    equalList(group.wikiTaskIds, taskIds.map(task => 'TSK-COR-' + task + '-01'), id + ' wiki coverage');
  });
  exactKeys(draft.copy, LOCALES, 'copy locales');
  const locales = Object.fromEntries(LOCALES.map(locale => {
    const copy = draft.copy[locale];
    exactKeys(copy, ['title', 'boundary', ...GROUPS.map(group => group[0])], locale + ' copy fields');
    const lessons = GROUPS.map(([id]) => {
      exactKeys(copy[id], ['title', 'objective', 'success'], locale + '/' + id);
      return Object.freeze({id, title: draftText(copy[id].title, locale + '/' + id + ' title'),
        objective: draftText(copy[id].objective, locale + '/' + id + ' objective'),
        success: draftText(copy[id].success, locale + '/' + id + ' outcome')});
    });
    return [locale, Object.freeze({title: draftText(copy.title, locale + ' title'),
      boundary: draftText(copy.boundary, locale + ' boundary'), lessons: Object.freeze(lessons)})];
  }));
  return Object.freeze({draftOnly: true, mode: 'read-only', locales: Object.freeze(locales)});
}
