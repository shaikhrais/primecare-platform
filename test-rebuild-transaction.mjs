import {Client} from 'pg';
import {rebuild} from './scripts/rebuild-production-database.mjs';
import {readFileSync} from 'node:fs';
import assert from 'node:assert/strict';
const manifest=JSON.parse(readFileSync('rebuild-evidence/manifest.json','utf8'));
const db=new Client({connectionString:process.env.DATABASE_URL});
await db.connect();
try {
 const input={email:'ceo@example.test',tenant:'tenant-hq',password:'Disposable-rebuild-test-123!',origins:['https://example.test']};
 const result=await rebuild(db,manifest,input);
 assert.equal(result.rebuilt,true);
 const old=await db.query('SELECT count(*)::int AS count FROM '+result.backupSchema+'.users');
 assert.equal(old.rows[0].count,1);
 const before=(await db.query('SELECT id FROM public.users')).rows;
 const broken=structuredClone(manifest);
 broken.columns[0].udt_name='invalid-type';
 await assert.rejects(rebuild(db,broken,input));
 assert.deepEqual((await db.query('SELECT id FROM public.users')).rows,before);
 const archives=await db.query("SELECT count(*)::int AS count FROM pg_namespace WHERE nspname LIKE 'primecare_backup_%'");
 assert.equal(archives.rows[0].count,1);
 console.log('Transactional rebuild, retained original data, and failure rollback verified.');
}finally {await db.end();}
