/** Internal admin-tool protocol. All production queries run in a read-only snapshot. */
import {readFile} from 'node:fs/promises';
import {createInterface} from 'node:readline';
import pg from 'pg';
const pin=JSON.parse(await readFile(new URL('./production-pin.json',import.meta.url),'utf8'));
let db,close,phase='configuration';
try{
 const fixtureIndex=process.argv.indexOf('--fixture');
 if(fixtureIndex>=0){
  if(process.env.GOVERNANCE_ALLOW_TEST_FIXTURE!=='1'||process.env.NODE_ENV!=='test')throw Error('Explicit isolated fixture mode required');
  const {PGlite}=await import('@electric-sql/pglite');const embedded=new PGlite();close=()=>embedded.close();
  const f=JSON.parse(await readFile(process.argv[fixtureIndex+1],'utf8'));for(const s of f.setup)await embedded.exec(s);
  db={query:async(arg,values)=>{if(typeof arg==='string')return embedded.query(arg,values);const r=await embedded.query(arg.text,arg.values);return {fields:r.fields,rows:r.rows.map(row=>r.fields.map(field=>row[field.name]))};}};
 }else{
  const primary=process.env.GOVERNANCE_DATABASE_URL,existing=process.env.PRODUCTION_DATABASE_URL;
  if(primary&&existing&&primary!==existing)throw Error('Conflicting governance database configuration');
  const u=new URL(primary||existing||'');if(!['postgres:','postgresql:'].includes(u.protocol)||u.hostname!=='pooled.db.prisma.io'||u.pathname!=='/postgres')throw Error('Unexpected governance database target');
  db=new pg.Client({connectionString:u.href,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000});close=()=>db.end();await db.connect();
 }
 phase='read-only-snapshot';await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');await db.query("SET LOCAL statement_timeout='120s'");
 const result=await db.query('SELECT manifest_sha256,manifest FROM "'+pin.schema+'"."'+pin.manifestTable+'"');
 if(result.rows.length!==1||result.rows[0].manifest_sha256!==pin.manifestSha256)throw Error('Production governance manifest mismatch');
 process.stdout.write(JSON.stringify({ready:true,pin,manifest:result.rows[0].manifest})+'\n');
 for await(const line of createInterface({input:process.stdin,crlfDelay:Infinity})){
  const request=JSON.parse(line);
  if(request.op==='close')break;
  if(request.op!=='query')throw Error('Only read queries are supported');
  try{
   const r=await db.query({text:request.sql,values:request.parameters||[],rowMode:'array'});
   process.stdout.write(JSON.stringify({ok:true,fields:r.fields.map(f=>({name:f.name,type:f.dataTypeID})),rows:r.rows})+'\n');
  }catch(error){process.stdout.write(JSON.stringify({ok:false,code:error.code||error.name})+'\n');break;}
 }
 await db.query('ROLLBACK');
}catch(error){process.stdout.write(JSON.stringify({ready:false,phase,code:error.code||error.name})+'\n');process.exitCode=1;}
finally{if(close)await close();}
