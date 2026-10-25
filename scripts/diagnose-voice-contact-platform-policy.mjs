/** Protected administrative metadata diagnosis only. No native authentication,
 * sessions, contacts, SMS, provider requests, grants or business writes. */
import pg from 'pg';
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {PostgresRegisteredCommunicationEndpointPolicy} from '../cloudflare/workers/src/business-tasks/endpoint-policy.ts';
const report={scope:'read-only-code-admin-contact-policy',authenticatedUserVerified:false,smsSent:false,providerWrites:false,businessDataWrites:false,permissionWrites:false,events:[]};
const category=error=>/^[0-9A-Z]{5}$/.test(error?.code??'')?'postgres_'+error.code:/timeout/i.test(error?.message??'')?'client_timeout':'policy_or_connection_unavailable';
let pool;
try{
 const pin=JSON.parse(await readFile('tools/governance-production/production-pin.json','utf8'));
 const url=new URL(process.env.PRODUCTION_DATABASE_URL??'');
 if(pin.sqliteFallback!==false||pin.schema!=='governance_68b0b02dd1215f58630d2c1a'||!['postgres:','postgresql:'].includes(url.protocol)||url.hostname!=='pooled.db.prisma.io'||url.pathname!=='/postgres')throw Error('Invalid authority');
 pool=new pg.Pool({host:url.hostname,port:Number(url.port||5432),database:'postgres',user:decodeURIComponent(url.username),password:decodeURIComponent(url.password),ssl:{rejectUnauthorized:true},max:2,connectionTimeoutMillis:5000,query_timeout:10000});
 let actor;const reader=await pool.connect();
 try{
  await reader.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');await reader.query("SET LOCAL statement_timeout='10s'");
  const manifest=await reader.query(`SELECT manifest_sha256 FROM "${pin.schema}".govt_source_manifest`);
  if(manifest.rows.length!==1||manifest.rows[0].manifest_sha256!==pin.manifestSha256)throw Error('Invalid authority');
  const users=(await reader.query("SELECT u.id::text,u.tenant_id::text,LOWER(u.status)='active' AS active,LOWER(t.status)='active' AS tenant_active FROM public.users u LEFT JOIN public.tenants t ON t.id=u.tenant_id WHERE u.roles='code_admin' LIMIT 2")).rows;
  report.accountCount=users.length;
  if(users.length!==1||typeof users[0].id!=='string'||typeof users[0].tenant_id!=='string')throw Error('Unique tenant-bound account required');
  report.activeAccount=users[0].active===true;report.activeTenant=users[0].tenant_active===true;
  actor={id:users[0].id,tenantId:users[0].tenant_id};
 }finally{try{await reader.query('ROLLBACK');}finally{reader.release();}}
 const port={async connect(){const client=await pool.connect();return {async query(sql,values){const start=performance.now(),stage=sql.startsWith('SELECT DISTINCT')?'permission':sql.startsWith('SELECT manifest')?'manifest':sql.startsWith('BEGIN')?'begin':sql.startsWith('ROLLBACK')?'rollback':'timeout';try{const result=await client.query(sql,values);report.events.push({stage,milliseconds:Math.round(performance.now()-start),rows:result.rows.length});return result;}catch(error){report.events.push({stage,milliseconds:Math.round(performance.now()-start),category:category(error)});throw error;}},release(){client.release();}};}};
 class ReadOnlyProbe extends PostgresRegisteredCommunicationEndpointPolicy {read(apiId){return this.authorizeRegistered(actor,apiId,'POST','/v1/voice/contact/status','VOICE_CONTACT_STATUS');}}
 const probe=new ReadOnlyProbe(port);report.probes=[];
 for(const apiId of [null,16535]){const start=performance.now();try{await probe.read(apiId);report.probes.push({kind:apiId===null?'http-metadata':'service-metadata',allowed:true,milliseconds:Math.round(performance.now()-start)});}catch(error){report.probes.push({kind:apiId===null?'http-metadata':'service-metadata',allowed:false,milliseconds:Math.round(performance.now()-start),category:category(error)});}}
 report.complete=true;
}catch(error){report.complete=false;report.category=category(error);process.exitCode=1;}
finally{await pool?.end();}
await mkdir('test-results/voice-contact-policy',{recursive:true});await writeFile('test-results/voice-contact-policy/report.json',JSON.stringify(report,null,2)+'\n');console.log('VOICE_CONTACT_POLICY_DIAGNOSTIC '+JSON.stringify(report));
