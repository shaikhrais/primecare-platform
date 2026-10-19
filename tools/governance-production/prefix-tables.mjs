/** Rename only the complete, manifest-bound governance snapshot. No data or grant changes. */
import pg from 'pg';
import {resolve} from 'node:path';
import {pathToFileURL} from 'node:url';
import {govtTableName,GOVERNANCE_MANIFEST_TABLE} from './naming.mjs';
const q=s=>'"'+s.replaceAll('"','""')+'"';
const catalogSql="SELECT c.relname AS name,c.oid::text AS oid,c.relacl::text AS acl FROM pg_class c JOIN pg_namespace n ON n.oid=c.relnamespace WHERE n.nspname=$1 AND c.relkind IN ('r','p') ORDER BY c.relname";
const columnsSql="SELECT a.attrelid::text AS oid,a.attnum,a.attname,a.atttypid::text AS type_oid,a.atttypmod,a.attnotnull,a.attidentity,a.attgenerated FROM pg_attribute a JOIN pg_class c ON c.oid=a.attrelid JOIN pg_namespace n ON n.oid=c.relnamespace WHERE n.nspname=$1 AND a.attnum>0 AND NOT a.attisdropped ORDER BY a.attrelid,a.attnum";
export async function prefixGovernanceTables(db,{schema,expectedManifestHash,expectedSourceTables,expectedRows}){
 if(!/^[a-f0-9]{64}$/.test(expectedManifestHash)||schema!=='governance_'+expectedManifestHash.slice(0,24))throw Error('Exact governance snapshot identity required');
 let operation='begin';await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ');
 try{
  await db.query("SET LOCAL lock_timeout='10s'");await db.query("SET LOCAL statement_timeout='120s'");
  operation='advisory-lock';await db.query("SELECT pg_advisory_xact_lock(hashtext('primecare-governance-import'))");
  const before=(await db.query(catalogSql,[schema])).rows,byName=new Map(before.map(r=>[r.name,r]));
  const metadataNames=['_source_manifest',GOVERNANCE_MANIFEST_TABLE].filter(n=>byName.has(n));
  if(metadataNames.length!==1)throw Error('Missing or colliding governance manifest table');
  const metadata=metadataNames[0],records=(await db.query('SELECT manifest_sha256,manifest FROM '+q(schema)+'.'+q(metadata))).rows;
  if(records.length!==1||records[0].manifest_sha256!==expectedManifestHash)throw Error('Governance manifest identity mismatch');
  const m=records[0].manifest;
  if(m.format!=='primecare-governance-snapshot-v1'||m.tables.length!==expectedSourceTables||m.tables.reduce((s,t)=>s+t.rows,0)!==expectedRows)throw Error('Unexpected source inventory');
  const mappings=[{old:metadata,target:GOVERNANCE_MANIFEST_TABLE,rows:1},...m.tables.map(t=>({old:t.name,target:govtTableName(t.name),rows:t.rows}))];
  if(new Set(mappings.map(t=>t.target)).size!==mappings.length||before.length!==mappings.length)throw Error('Unexpected tables or prefix collision');
  const original=mappings.every(t=>byName.has(t.old)),prefixed=mappings.every(t=>byName.has(t.target));
  if(!original&&!prefixed)throw Error('Mixed or unexpected table naming; refusing partial migration');
  const sourceNames=mappings.map(t=>prefixed?t.target:t.old);
  operation='lock-governance-tables';await db.query('LOCK TABLE '+sourceNames.map(n=>q(schema)+'.'+q(n)).join(',')+' IN ACCESS EXCLUSIVE MODE');
  const columnsBefore=(await db.query(columnsSql,[schema])).rows;
  for(let i=0;i<mappings.length;i++){
   const t=mappings[i];operation='verify-source-count';const r=await db.query('SELECT count(*)::text AS count FROM '+q(schema)+'.'+q(sourceNames[i]));
   if(r.rows[0].count!==String(t.rows))throw Error('Source count differs from imported snapshot');
  }
  let renamed=0;
  if(!prefixed)for(const t of mappings){if(t.old===t.target)continue;operation='rename-governance-table';await db.query('ALTER TABLE '+q(schema)+'.'+q(t.old)+' RENAME TO '+q(t.target));renamed++;}
  operation='verify-renamed-tables';const after=(await db.query(catalogSql,[schema])).rows,afterNames=new Map(after.map(r=>[r.name,r]));
  if(after.length!==before.length)throw Error('Table inventory changed');
  for(let i=0;i<mappings.length;i++){
   const t=mappings[i],a=afterNames.get(t.target),b=byName.get(sourceNames[i]);
   if(!a||a.oid!==b.oid||a.acl!==b.acl)throw Error('Table identity or ACL changed');
   const r=await db.query('SELECT count(*)::text AS count FROM '+q(schema)+'.'+q(t.target));
   if(r.rows[0].count!==String(t.rows))throw Error('Renamed table count changed');
  }
  if(JSON.stringify(columnsBefore)!==JSON.stringify((await db.query(columnsSql,[schema])).rows))throw Error('Column definitions changed');
  await db.query('COMMIT');return {schema,manifestHash:expectedManifestHash,sourceTables:expectedSourceTables,metadataTables:1,tablesRenamed:renamed,totalPrefixedTables:after.length,rows:expectedRows,tableOidsPreserved:true,columnsPreserved:true,grantsPreserved:true,verified:true,alreadyPrefixed:prefixed};
 }catch(error){error.importOperation=operation;await db.query('ROLLBACK');throw error;}
}
if(process.argv[1]&&import.meta.url===pathToFileURL(resolve(process.argv[1])).href){
 let db;try{
  if(process.env.CONFIRM_GOVERNANCE_PREFIX!=='PREFIX_GOVERNANCE_TABLES_GOVT')throw Error('Explicit prefix confirmation required');
  const url=new URL(process.env.PRODUCTION_DATABASE_URL||'');if(!['postgres:','postgresql:'].includes(url.protocol)||url.hostname!=='pooled.db.prisma.io'||url.pathname!=='/postgres')throw Error('Unexpected production target');
  db=new pg.Client({connectionString:url.href,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000});await db.connect();
  console.log(JSON.stringify(await prefixGovernanceTables(db,{schema:'governance_68b0b02dd1215f58630d2c1a',expectedManifestHash:'68b0b02dd1215f58630d2c1aea3c5e1cfd488a9cbcfe5c96bea9dcfd89944c42',expectedSourceTables:334,expectedRows:490765})));
 }catch(error){console.error(JSON.stringify({error:'Governance prefix transaction failed; data and credentials withheld',operation:error.importOperation,code:error.code||error.name}));process.exitCode=1;}finally{if(db)await db.end();}
}
