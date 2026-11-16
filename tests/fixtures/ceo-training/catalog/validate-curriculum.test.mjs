import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {test} from 'node:test';
import {readOnlyCatalog} from './validate-curriculum.mjs';
const SOURCE = 'ef3d1adf78dffa6178e64f2495f4f35ff8b1a7e7';
const draft = JSON.parse(readFileSync(new URL('./curriculum.v1.draft.json', import.meta.url), 'utf8'));
test('review draft covers 12 known wiki tasks, with four read-only lessons in each language', () => {
  const result = readOnlyCatalog(draft, SOURCE);
  assert.deepEqual(Object.keys(result.locales), ['en', 'fr', 'es']);
  assert.equal(result.draftOnly, true);
  assert.equal(result.mode, 'read-only');
  const ids = ['access', 'performance', 'risk', 'reporting'];
  for (const [locale, copy] of Object.entries(result.locales)) {
    assert.deepEqual(copy.lessons.map(row => row.id), ids);
    assert.equal(copy.title, draft.copy[locale].title);
    assert.equal(copy.boundary, draft.copy[locale].boundary);
    assert.deepEqual(Object.keys(copy.lessons[0]), ['id', 'title', 'objective', 'success']);
  }
  assert.notEqual(result.locales.fr.title, result.locales.en.title);
  assert.equal(Object.isFrozen(result.locales.es.lessons[3]), true);
});
const bad = [
  ['tries to mark draft approved', x => x.draftOnly = false],
  ['wrong role', x => x.role = 'tenant_admin'],
  ['permission or route write marker', x => x.grants = ['ceo']],
  ['missing task', x => delete x.tasks['TSK-COR-709-01']],
  ['external route', x => x.tasks['TSK-COR-717-01'].routeSuffix = 'https://outside.invalid/'],
  ['unknown task in group', x => x.taskGroups[0].wikiTaskIds.push('TSK-COR-999-01')],
  ['duplicate group', x => x.taskGroups[2] = x.taskGroups[1]],
  ['interactive action', x => x.taskGroups[3].exercise = 'approve'],
  ['missing translated lesson', x => delete x.copy.fr.reporting],
  ['missing translated locale', x => delete x.copy.es],
  ['unapproved quiz answers', x => x.copy.en.access.correct = 1],
  ['unapproved media', x => x.copy.en.access.video = 'recording.mp4'],
  ['markup instead of plain text', x => x.copy.en.access.title = '<strong>Sample</strong>'],
];
for (const [label, mutate] of bad) test('rejects ' + label, () => {
  const changed = structuredClone(draft);
  mutate(changed);
  assert.throws(() => readOnlyCatalog(changed, SOURCE), /Invalid CEO training draft:/);
});
test('rejects unrelated reviewed source build', () => {
  assert.throws(() => readOnlyCatalog(draft, 'b'.repeat(40)), /review source commit/);
});
