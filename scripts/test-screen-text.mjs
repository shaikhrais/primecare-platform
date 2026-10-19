import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {mkdtemp,readFile,writeFile} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {createRequire} from 'node:module';
const require=createRequire(import.meta.url),directory=await mkdtemp(join(tmpdir(),'screen-text-'));
const file=join(directory,'screen.cjs');
await build({entryPoints:['cloudflare/workers/src/screen-text.ts'],bundle:true,platform:'node',format:'cjs',outfile:file,external:['pg']});
await writeFile(file,(await readFile(file,'utf8')).replaceAll('require("pg")',`require(${JSON.stringify(require.resolve('pg'))})`));
const {validateScreenText,screenTextDefaults}=require(file);
test('every registered screen has en/fr/es parity and validates',()=>{
 for(const [screen,locales] of Object.entries(screenTextDefaults))assert.deepEqual(validateScreenText(screen,{version:0,locales}),{version:0,locales});
});
test('catalog editing rejects altered keys, languages, parameters, versions and control characters',()=>{
 const screen='admin_reality_check';const valid={version:0,locales:structuredClone(screenTextDefaults[screen])};
 const reject=patch=>{const value=structuredClone(valid);patch(value);assert.throws(()=>validateScreenText(screen,value));};
 reject(v=>v.version=-1);reject(v=>v.version='1');reject(v=>v.version=1.5);
 reject(v=>v.extra='ignored');reject(v=>delete v.locales.fr);reject(v=>v.locales.ar={});
 reject(v=>delete v.locales.es.title);reject(v=>v.locales.fr.unregistered='New');
 reject(v=>v.locales.fr.title='');reject(v=>v.locales.en.title='x'.repeat(2001));
 reject(v=>v.locales.es.title='bad\u0000');reject(v=>v.locales.es.items='Missing count');
 reject(v=>v.locales.en.title='{injected}');
 assert.throws(()=>validateScreenText('constructor',valid));assert.throws(()=>validateScreenText('unknown',valid));
});
test('text with markup stays data; payload includes no executable content fields',()=>{
 const valid={version:1,locales:structuredClone(screenTextDefaults.admin_reality_check)};
 valid.locales.en.title='<script>alert(1)</script>';
 assert.equal(validateScreenText('admin_reality_check',valid).locales.en.title,valid.locales.en.title);
});
