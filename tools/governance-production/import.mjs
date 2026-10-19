/** Dedicated governance snapshot schema. Never changes public/application tables. */
import {readFile} from 'node:fs/promises';
import {createReadStream} from 'node:fs';
import {createInterface} from 'node:readline';
import {createHash} from 'node:crypto';
import {join,resolve,dirname} from 'node:path';
import {pathToFileURL} from 'node:url';
import {Client} from 'pg';
const hash=b=>createHash('sha256').update(b).digest('hex');
const q=s=>'"'+s.replaceAll('"','""')+'"';
function storage(c){const k=c.storage_types;return k.length===1?({integer:'bigint',real:'double precision',text:'text',blob:'bytea'}[k[0]]):'jsonb';}
function decode(c,type){if(type==='jsonb')return JSON.stringify(c);if(c.t==='null')return null;if(c.t==='blob')return Buffer.from(c.v,'hex');if(c.t==='real')return Buffer.from(c.v,'hex').readDoubleBE();return c.v;}
function encode(v,type){if(type==='jsonb')return {t:v.t,v:v.v};if(v===null)return {t:'null',v:null};if(type==='bigint')return {t:'integer',v:String(v)};if(type==='bytea')return {t:'blob',v:Buffer.from(v).toString('hex')};if(type==='double precision'){const b=Buffer.alloc(8);b.writeDoubleBE(v);return {t:'real',v:b.toString('hex')};}return {t:'text',v};}
export async function importGovernance(db,folder,{expectedManifestHash}={}){
 const raw=await readFile(join(folder,'manifest.json')),manifestHash=hash(raw),m=JSON.parse(raw);
 if(expectedManifestHash!==manifestHash)throw Error('Exact reviewed manifest hash required');
 if(m.format!=='primecare-governance-snapshot-v1'||!Array.isArray(m.tables))throw Error('Unsupported manifest');
 const schema='governance_'+manifestHash.slice(0,24),names=new Set();
 for(const t of m.tables){if(names.has(t.name)||Buffer.byteLength(t.name)>63||t.name==='_source_manifest')throw Error('Invalid or colliding table name');names.add(t.name);if(!/^\d{4}\.ndjson$/.test(t.file)||!Number.isSafeInteger(t.rows)||t.rows<0)throw Error('Invalid table manifest');const cols=new Set();for(const c of t.columns){if(cols.has(c.name)||c.name==='_primecare_import_row'||Buffer.byteLength(c.name)>63)throw Error('Invalid column');cols.add(c.name);if(c.storage_types.some(x=>!['integer','real','text','blob'].includes(x)))throw Error('Invalid storage type');}}
 await db.query('BEGIN');
 try{
  await db.query("SET LOCAL lock_timeout='10s'");await db.query("SET LOCAL statement_timeout='120s'");
  await db.query("SELECT pg_advisory_xact_lock(hashtext('primecare-governance-import'))");
  const exists=await db.query('SELECT 1 FROM information_schema.schemata WHERE schema_name=$1',[schema]);
  // Never replace an existing import, even one with the same manifest: reverify below.
  if(exists.rows.length)throw Error('Snapshot schema already exists; refusing overwrite');
  await db.query('CREATE SCHEMA '+q(schema));await db.query('REVOKE ALL ON SCHEMA '+q(schema)+' FROM PUBLIC');
  await db.query('CREATE TABLE '+q(schema)+'._source_manifest (manifest_sha256 text PRIMARY KEY, manifest jsonb NOT NULL, imported_at timestamptz NOT NULL DEFAULT now())');
  await db.query('INSERT INTO '+q(schema)+'._source_manifest VALUES($1,$2,now())',[manifestHash,JSON.stringify(m)]);
  for(const t of m.tables){
   const types=t.columns.map(storage),table=q(schema)+'.'+q(t.name);
   await db.query('CREATE TABLE '+table+' ('+q('_primecare_import_row')+' bigint PRIMARY KEY,'+t.columns.map((c,i)=>q(c.name)+' '+types[i]).join(',')+')');
   const digest=createHash('sha256');let count=0,batch=[];
   const flush=async()=>{if(!batch.length)return;const values=[],rows=batch.map(row=>'('+row.map(v=>{values.push(v);return '$'+values.length;}).join(',')+')');await db.query('INSERT INTO '+table+' VALUES '+rows.join(','),values);batch=[];};
   for await(const line of createInterface({input:createReadStream(join(folder,t.file)),crlfDelay:Infinity})){
    digest.update(line+'\n');const row=JSON.parse(line);if(row.length!==t.columns.length)throw Error('Row width mismatch');batch.push([count,...row.map((v,i)=>decode(v,types[i]))]);count++;
    if(batch.length>=Math.min(200,Math.floor(60000/(types.length+1))))await flush();
   }await flush();
   if(count!==t.rows||digest.digest('hex')!==t.sha256)throw Error('Source count/hash mismatch: '+t.name);
   const verify=createHash('sha256');let seen=0;
   while(seen<count){const r=await db.query('SELECT '+t.columns.map(c=>q(c.name)).join(',')+' FROM '+table+' WHERE '+q('_primecare_import_row')+'>=$1 ORDER BY '+q('_primecare_import_row')+' LIMIT 500',[seen]);if(!r.rows.length)throw Error('Missing persisted rows');for(const row of r.rows){verify.update(JSON.stringify(t.columns.map((c,i)=>encode(row[c.name],types[i])))+'\n');seen++;}}
   if(seen!==count||verify.digest('hex')!==t.sha256)throw Error('Database readback hash mismatch: '+t.name);
  }
  await db.query('COMMIT');return {schema,manifestHash,tables:m.tables.length,rows:m.tables.reduce((n,t)=>n+t.rows,0),verified:true};
 }catch(e){await db.query('ROLLBACK');throw e;}
}
if(process.argv[1]&&import.meta.url===pathToFileURL(resolve(process.argv[1])).href){
 let db;try{
  if(process.env.CONFIRM_GOVERNANCE_IMPORT!=='IMPORT_GOVERNANCE_SNAPSHOT')throw Error('Import confirmation required');
  const url=new URL(process.env.PRODUCTION_DATABASE_URL||'');if(url.protocol!=='postgresql:'&&url.protocol!=='postgres:')throw Error('Invalid database URL');
  if(url.hostname!=='pooled.db.prisma.io'||url.pathname!=='/postgres')throw Error('Unexpected production target');
  db=new Client({connectionString:url.href,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000});await db.connect();
  console.log(JSON.stringify(await importGovernance(db,resolve(process.argv[2]),{expectedManifestHash:process.env.GOVERNANCE_MANIFEST_SHA256})));
 }catch{console.error('Governance import failed; no credentials logged. Transaction rolls back on failure.');process.exitCode=1;}finally{if(db)await db.end();}
}
