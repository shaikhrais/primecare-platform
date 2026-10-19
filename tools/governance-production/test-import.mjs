import assert from 'node:assert/strict';
import {PGlite} from '@electric-sql/pglite';
import {execFileSync} from 'node:child_process';
import {mkdtemp,readFile,writeFile} from 'node:fs/promises';
import {join} from 'node:path';
import {tmpdir} from 'node:os';
import {createHash} from 'node:crypto';
import {importGovernance} from './import.mjs';
const folder=await mkdtemp(join(tmpdir(),'governance-import-test-')),source=join(folder,'source.db'),out=join(folder,'export');
execFileSync('python3',['-c',`import sqlite3
c=sqlite3.connect(${JSON.stringify(source)})
c.executescript('CREATE TABLE sample(id INTEGER PRIMARY KEY, title TEXT, payload BLOB, score REAL, mixed); CREATE TABLE empty_table(code TEXT); CREATE VIEW sample_view AS SELECT id FROM sample;')
c.execute('INSERT INTO sample VALUES(?,?,?,?,?)',(1,'Français / Español ☃',bytes([0,255]),1.25,'abc'))
c.execute('INSERT INTO sample VALUES(?,?,?,?,?)',(2,None,None,-0.125,42))
c.commit()`]);
const receipt=JSON.parse(execFileSync('python3',['tools/governance-production/export.py',source,out],{encoding:'utf8'}));
const db=new PGlite();await db.query('CREATE TABLE public.business_data(id integer)');await db.query('INSERT INTO public.business_data VALUES(7)');
// PGlite is an embedded PostgreSQL runtime; advisory locks are not meaningful here.
const adapter={query:(sql,values)=>sql.includes('pg_advisory_xact_lock')?Promise.resolve({rows:[]}):db.query(sql,values)};
const result=await importGovernance(adapter,out,{expectedManifestHash:receipt.manifest_sha256});
assert.equal(result.rows,2);assert.equal(result.tables,2);assert.equal(result.verified,true);
assert.deepEqual((await db.query('SELECT * FROM public.business_data')).rows,[{id:7}]);
assert.equal((await db.query(`SELECT title FROM "${result.schema}".sample WHERE id=1`)).rows[0].title,'Français / Español ☃');
await assert.rejects(importGovernance(adapter,out,{expectedManifestHash:receipt.manifest_sha256}),/already exists/);
await assert.rejects(importGovernance(adapter,out,{expectedManifestHash:'0'.repeat(64)}),/manifest hash/);
const original=await readFile(join(out,'manifest.json'),'utf8');
const publicManifest=JSON.parse(original);publicManifest.test_variant='public-access-refusal';const publicBytes=JSON.stringify(publicManifest);await writeFile(join(out,'manifest.json'),publicBytes);
const publicHash=createHash('sha256').update(publicBytes).digest('hex');
await db.query('ALTER DEFAULT PRIVILEGES GRANT USAGE ON SCHEMAS TO PUBLIC');
await assert.rejects(importGovernance(adapter,out,{expectedManifestHash:publicHash}),/PUBLIC grants/);
assert.equal((await db.query('SELECT 1 FROM information_schema.schemata WHERE schema_name=$1',['governance_'+publicHash.slice(0,24)])).rows.length,0);
await db.query('ALTER DEFAULT PRIVILEGES REVOKE USAGE ON SCHEMAS FROM PUBLIC');await writeFile(join(out,'manifest.json'),original);
const manifest=JSON.parse(await readFile(join(out,'manifest.json'),'utf8'));manifest.tables.find(t=>t.name==='sample').sha256='0'.repeat(64);const changed=JSON.stringify(manifest);await writeFile(join(out,'manifest.json'),changed);
const changedHash=createHash('sha256').update(changed).digest('hex');
await assert.rejects(importGovernance(adapter,out,{expectedManifestHash:changedHash}),/hash mismatch/);
assert.equal((await db.query('SELECT 1 FROM information_schema.schemata WHERE schema_name=$1',['governance_'+changedHash.slice(0,24)])).rows.length,0);
assert.deepEqual((await db.query('SELECT * FROM public.business_data')).rows,[{id:7}]);
await db.close();console.log('Governance import passed typed Unicode/blob/null/mixed roundtrip, empty tables, source metadata, protected application data, duplicate refusal, exact manifest binding and transactional rollback.');
