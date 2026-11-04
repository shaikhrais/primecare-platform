import {readFile} from 'node:fs/promises';
import pg from 'pg';
const pin=JSON.parse(await readFile(new URL('./production-pin.json',import.meta.url),'utf8'));
const table=n=>'"'+pin.schema+'"."'+pin.tablePrefix+n+'"';
const ids=['theme-migration-review','theme-migration-save','theme-migration-retry'];
async function update(db,{apply=false,readback=false}={}){
 await db.query('BEGIN');
 try{
  await db.query("SET LOCAL lock_timeout='5s'");
  await db.query('LOCK TABLE '+table('source_manifest')+','+table('screens')+' IN SHARE MODE');
  await db.query('LOCK TABLE '+table('screen_components')+' IN SHARE ROW EXCLUSIVE MODE');
  const manifest=(await db.query('SELECT manifest_sha256 FROM '+table('source_manifest'))).rows;
  if(manifest.length!==1||manifest[0].manifest_sha256!==pin.manifestSha256)throw Error('Authority mismatch');
  const host=(await db.query('SELECT id FROM '+table('screens')+" WHERE id=2534 AND screen_code='tenant_admin_command_center' AND route_path='/tenant-dashboard' AND active=1")).rows;
  if(host.length!==1)throw Error('Host mismatch');
  const rows=(await db.query('SELECT id,data_cy,component_code,component_type,file_path,implementation_status FROM '+table('screen_components')+' WHERE screen_id=2534 AND data_cy=ANY($1::text[]) ORDER BY data_cy',[ids])).rows;
  if(rows.length!==3||new Set(rows.map(r=>r.data_cy)).size!==3||rows.some(r=>r.component_code!=='themeWorkspace.'+r.data_cy||r.component_type!=='prime_button'||r.file_path!=='packages/primecare_ui/web/advanced-theme-tenant-control.ts'||!['registered-unimplemented','implemented-unverified'].includes(r.implementation_status)))throw Error('Control identity mismatch');
  if(readback&&rows.some(r=>r.implementation_status!=='implemented-unverified'))throw Error('Control readback mismatch');
  if(!readback)await db.query('UPDATE '+table('screen_components')+" SET implementation_status='implemented-unverified' WHERE screen_id=2534 AND data_cy=ANY($1::text[]) AND implementation_status='registered-unimplemented'",[ids]);
  await db.query(apply?'COMMIT':'ROLLBACK');
  return {controls:3,committed:apply,readback,runtimeActivated:false,humanReviewApproved:false};
 }catch(error){await db.query('ROLLBACK');throw error;}
}
let db;
try{
 if(process.env.RECORD_THEME_MIGRATION_IMPLEMENTATION!=='1')throw Error('Scoped implementation recording required');
 const raw=process.env.PRODUCTION_DATABASE_URL,url=new URL(raw);
 if(!['postgres:','postgresql:'].includes(url.protocol)||url.hostname!=='pooled.db.prisma.io'||url.pathname!=='/postgres')throw Error('Pinned production connection required');
 const connect=async()=>{const client=new pg.Client({connectionString:raw,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000});await client.connect();return client;};
 db=await connect();await update(db);const result=await update(db,{apply:true});await db.end();db=await connect();const readback=await update(db,{readback:true});
 console.log(JSON.stringify({result,readback}));
}catch{console.error('Theme migration implementation recording failed closed.');process.exitCode=1;}finally{if(db)await db.end();}
