import {test} from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import {build} from 'esbuild';
import {check, references, root} from './web_boundary.mjs';

test('all hosted web consumers use registered master gateways', () => {
  const result = check();
  assert.equal(result.changed.length, 0);
  assert.ok(result.masterImports > 100);
});

test('the parser detects import aliases, type imports and lazy/CommonJS connections', () => {
  const source = `
    import {ScreenManager as ExistingScreenManager} from 'one';
    export {ScreenManager as ExistingScreenManager} from 'two';
    const lazy = import('three'); const common = require('four');
    type Model = import('five').Model;
    import old = require('six');
    // import x from 'comment';
    const label = "import x from 'string'";
  `;
  assert.deepEqual(references(source, 'probe.ts').map(ref => ref.uri),
    ['one', 'two', 'three', 'four', 'five', 'six']);
});

test('direct private imports fail without changing their source or weakening the boundary', () => {
  const file = path.join(root, 'websites/typescript/src/master-boundary-negative-probe.ts');
  assert.equal(fs.existsSync(file), false);
  const original = `import {ScreenManager as OldName} from '../../../packages/primecare_ui/web/screen-manager.ts';\n`;
  try {
    fs.writeFileSync(file, original);
    assert.throws(() => check(), /direct internal import/);
    assert.equal(fs.readFileSync(file, 'utf8'), original);
  } finally { fs.rmSync(file, {force: true}); }
});

test('master exports retain canonical object and class identity under existing names', async () => {
  const result = await build({stdin: {contents: `
    import {ScreenManager as OldName} from './packages/primecare_master/web/primecare_ui/web/screen-manager.ts';
    import {ScreenManager} from './packages/primecare_ui/web/screen-manager.ts';
    import facade from './packages/primecare_master/web/shared/src/auth-mfa.json.ts';
    import original from './packages/shared/src/auth-mfa.json';
    export const sameClass = OldName === ScreenManager;
    export const sameCatalog = facade === original;
  `, resolveDir: root}, bundle: true, write: false, platform: 'node', format: 'esm'});
  const module = await import('data:text/javascript;base64,' + Buffer.from(result.outputFiles[0].contents).toString('base64'));
  assert.equal(module.sameClass, true);
  assert.equal(module.sameCatalog, true);
});
