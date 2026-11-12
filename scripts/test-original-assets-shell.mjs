import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';

const result = await build({stdin:{contents:"export * from './packages/primecare_ui/web/icons'; export * from './packages/primecare_ui/web/original-assets';",resolveDir:process.cwd()},bundle:true,format:'esm',platform:'node',write:false});
const api = await import('data:text/javascript;base64,' + Buffer.from(result.outputFiles[0].text).toString('base64'));

test('caller mutation cannot retire or rewrite the shared shell icon catalogue', () => {
  const names = [...api.shellIconNames];
  const before = names.map(name => api.shellIcon(name));
  try {
    const changed = Reflect.set(api.shellIconNames, 'length', 0);
    const stillRenders = names.every((name, index) => {
      try { return api.shellIcon(name) === before[index]; }
      catch { return false; }
    });
    assert.equal(stillRenders, true, 'caller mutation must not disable existing shell controls');
    assert.equal(changed, false);
    assert.equal(Reflect.set(api.shellIconNames, 0, 'constructor'), false);
    assert.equal(Reflect.deleteProperty(api.shellIconNames, 0), false);
    assert.deepEqual([...api.shellIconNames], names);
  } finally {
    if (!Object.isFrozen(api.shellIconNames)) api.shellIconNames.splice(0, api.shellIconNames.length, ...names);
  }
});

test('unknown and prototype-like navigation destinations retain the dashboard fallback', () => {
  const fallback = api.navigationIcon('unknown');
  for (const key of ['', '__proto__', 'constructor', 'toString', 'hasOwnProperty', '<script>']) {
    assert.equal(api.navigationIcon(key), fallback, key);
  }
  assert.ok(api.navigationIcon('appearance').includes(api.primeCareIconPaths.theme));
});

test('shell RTL mirrors directional original geometry without changing the SVG contract', () => {
  const ltr = api.shellIcon('logout');
  const rtl = api.shellIcon('logout', {rtl:true});
  assert.ok(!ltr.includes('transform='));
  assert.ok(rtl.includes('<g transform="translate(24 0) scale(-1 1)">'));
  assert.ok(rtl.includes(api.primeCareIconPaths.logout));
  for (const svg of [ltr, rtl]) {
    assert.ok(svg.includes('class="media-icon shell-icon"'));
    assert.ok(svg.includes('stroke="currentColor"'));
    assert.ok(svg.includes('aria-hidden="true"'));
    assert.ok(svg.includes('focusable="false"'));
    assert.ok(!svg.includes('role="img"'));
  }
});

test('all existing shell aliases remain compatible and non-directional icons do not mirror', () => {
  for (const key of api.shellIconNames) {
    assert.equal(api.shellIcon(key), api.shellIcon(key, {rtl:false}));
    assert.ok(!api.shellIcon(key, {rtl:true}).includes('undefined'));
  }
  for (const key of ['phone', 'palette', 'chevron-down']) {
    assert.equal(api.shellIcon(key, {rtl:true}), api.shellIcon(key));
  }
  assert.throws(() => api.shellIcon('constructor'));
  assert.throws(() => api.shellIcon('unknown', {rtl:true}));
});
