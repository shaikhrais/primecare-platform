import { test } from 'node:test';
import assert from 'node:assert/strict';
import { build } from 'esbuild';

const result = await build({ entryPoints: ['packages/domain/src/legacy-theme-migration.ts'], bundle: true, platform: 'node', format: 'esm', write: false });
const { prepareLegacyThemeMigration } = await import('data:text/javascript;base64,' + Buffer.from(result.outputFiles[0].text).toString('base64'));
test('migration retains the source and refuses unsupported identifiers', () => {
  const theme = { version: 1, name: 'Saved', preset: 'default', fontFamily: 'system', fontScale: 1, radius: 12, colors: { muted: '#123456', sidebar: '#14283f', topbar: '#ffffff' } };
  const source = { version: 1, active: theme, items: [{ id: '00000000-0000-4000-8000-000000000001', theme }] };
  const result = prepareLegacyThemeMigration(source);
  assert.deepEqual(result.original, source);
  assert.equal(result.candidate.items[0].id, source.items[0].id);
  assert.equal(result.candidate.items[0].theme.name, 'Saved');
  assert.ok(result.unmappedFields.includes('muted'));
  assert.equal(result.candidate.active.regions.navigation.background, '#14283f');
  assert.equal(result.candidate.active.regions.toolbar.background, '#ffffff');
  assert.throws(() => prepareLegacyThemeMigration({ ...source, items: [{ id: '------------------------------------', theme }] }));
});

test('all built-in presets migrate while preserving the original', async () => {
  const catalog = JSON.parse(await (await import('node:fs/promises')).readFile('scripts/primecare_presets.json', 'utf8'));
  for (const preset of Object.keys(catalog)) {
    const theme = { version: 1, name: preset, preset, fontFamily: 'system', fontScale: 1, radius: 12, colors: {} };
    const source = { version: 1, active: theme, items: [] };
    const result = prepareLegacyThemeMigration(source);
    assert.deepEqual(result.original, source, preset);
    assert.equal(result.candidate.active.name, preset);
    assert.equal(result.candidate.active.regions.main.mode, catalog[preset].mode);
  }
});
