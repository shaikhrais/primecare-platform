import pg from 'pg';
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {verifyNativeContactDeployment} from './voice-contact-deployment-readback.mjs';
import {VapiCallReadClient} from '../packages/shared/src/communications/vapi-call-read.mjs';
const {Pool}=pg;
const report={step:3,readinessMeasured:false,liveCallVerified:false,liveOtpVerified:false,smsSent:false,businessActionsEnabled:false,toolsAttached:false,blockers:[]};
let pool;
try{
 report.stage='authority';
 const pin=JSON.parse(await readFile('tools/governance-production/production-pin.json','utf8'));
 if(!/^[a-z0-9_]+$/.test(pin.schema)||pin.sqliteFallback!==false)throw Error('Invalid authority');
 const url=new URL(process.env.PRODUCTION_DATABASE_URL??'');
 if(!['postgres:','postgresql:'].includes(url.protocol)||url.hostname!=='pooled.db.prisma.io'||url.pathname!=='/postgres')throw Error('Invalid authority');
 // Bind the parsed target explicitly; client URL flags cannot disable TLS checks.
 pool=new Pool({host:url.hostname,port:Number(url.port||5432),database:'postgres',user:decodeURIComponent(url.username),password:decodeURIComponent(url.password),ssl:{rejectUnauthorized:true},max:1,connectionTimeoutMillis:10000});
 const db=await pool.connect();
 try{
  await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');await db.query("SET LOCAL statement_timeout='15s'");
  const manifest=await db.query(`SELECT manifest_sha256 FROM "${pin.schema}"."govt_source_manifest"`);
  if(manifest.rows.length!==1||manifest.rows[0].manifest_sha256!==pin.manifestSha256)throw Error('Invalid authority');
  report.stage='database-inventory';
  const names=['communication_voice_verified_contacts','communication_voice_otp','communication_voice_otp_limits','communication_voice_tasks','communication_voice_confirmations','communication_voice_contact_challenges','users','tenants','auth_sessions'];
  const tables={};for(const name of names)tables[name]=(await db.query('SELECT to_regclass($1) IS NOT NULL AS present',['public.'+name])).rows[0]?.present===true;
  report.tables=tables;
  report.nativeSessionCreationTimeAvailable=(await db.query("SELECT EXISTS(SELECT 1 FROM information_schema.columns WHERE table_schema='public' AND table_name='auth_sessions' AND column_name='created_at' AND data_type='timestamp with time zone') AS present")).rows[0]?.present===true;
  if(!report.nativeSessionCreationTimeAvailable)report.blockers.push('missing_native_session_creation_time');
  for(const [name,present] of Object.entries(tables))if(!present)report.blockers.push('missing_table:'+name);
  if(tables.communication_voice_verified_contacts){
   const count=(await db.query('SELECT COUNT(*)::int AS count FROM public.communication_voice_verified_contacts WHERE revoked_at IS NULL')).rows[0]?.count;
   if(!Number.isSafeInteger(count)||count<0)throw Error('Invalid contact count');report.activeVerifiedContactCount=count;
   if(count===0)report.blockers.push('no_verified_voice_contacts');
  }
  const value=(alias,column)=>{const x=`to_jsonb(${alias})->'${column}'`;return `(CASE WHEN jsonb_typeof(${x}) IN ('string','number') THEN ${x}#>>'{}' WHEN jsonb_typeof(${x})='object' AND ${x}->>'t' IN ('text','integer') AND jsonb_typeof(${x}->'v')='string' THEN ${x}->>'v' ELSE NULL END)`;};
  const table=name=>`"${pin.schema}"."govt_${name}"`;
  report.stage='native-permission-inventory';
  const grants=await db.query(`SELECT ${value('a','route_path')} AS path,COUNT(DISTINCT ${value('a','id')})::int AS registration_count,
   COUNT(DISTINCT ${value('ap','id')}) FILTER(WHERE ${value('r','active')}='1' AND ${value('s','active')}='1' AND ${value('sp','can_view')}='1')::int AS grant_count
   FROM ${table('api_endpoints')} a
   LEFT JOIN ${table('api_permissions')} ap ON ${value('ap','api_id')}=${value('a','id')} AND ${value('ap','can_access')}='1' AND ${value('ap','permission_key')}='role_screen_permissions'
   LEFT JOIN ${table('roles')} r ON ${value('r','id')}=${value('ap','role_id')}
   LEFT JOIN ${table('screen_api_links')} l ON ${value('l','api_id')}=${value('a','id')}
   LEFT JOIN ${table('screens')} s ON ${value('s','id')}=${value('l','screen_id')} AND ${value('s','id')} IN ('234','331','559','578')
   LEFT JOIN ${table('role_screen_permissions')} sp ON ${value('sp','screen_id')}=${value('s','id')} AND ${value('sp','role_id')}=${value('r','id')}
   WHERE ${value('a','route_path')}=ANY($1::text[]) AND ${value('a','http_method')}='POST' AND ${value('a','service_name')}='governance' AND ${value('a','auth_required')}='1' AND ${value('a','permission_key')}='role_screen_permissions'
   GROUP BY ${value('a','route_path')}`, [['/v1/voice/otp/start','/v1/voice/otp/check','/v1/voice/contact/status','/v1/voice/contact/start','/v1/voice/contact/check']]);
  // Read metadata only: no user, session, phone or message content is selected.
  // Report exact portal/route ownership rather than treating OAuth consent as
  // a communication permission editor or assuming an administrator bypass.
  report.nativeContactRoleAccess=(await db.query(`SELECT
   ${value('r','role_code')} AS role,
   ${value('r','primary_app_code')} AS app,
   ${value('r','primary_app_url')} AS origin,
   ${value('r','post_login_route')} AS home,
   ${value('s','id')} AS screen_id,
   ${value('s','screen_code')} AS screen,
   ${value('sp','can_view')} AS can_view
   FROM ${table('roles')} r
   LEFT JOIN ${table('role_screen_permissions')} sp ON ${value('sp','role_id')}=${value('r','id')}
   LEFT JOIN ${table('screens')} s ON ${value('s','id')}=${value('sp','screen_id')} AND ${value('s','active')}='1'
   WHERE ${value('r','active')}='1' AND (
    ${value('r','role_code')}='code_admin' OR
    (${value('s','id')} IN ('234','331','559','578') AND ${value('sp','can_view')}='1'))
   ORDER BY ${value('r','role_code')},${value('s','id')}`)).rows;
  report.nativeContactCodeAdminApiAccess=(await db.query(`SELECT
   ${value('a','route_path')} AS path,
   ${value('ap','can_access')} AS can_access,
   ${value('ap','permission_key')} AS permission
   FROM ${table('roles')} r
   CROSS JOIN ${table('api_endpoints')} a
   LEFT JOIN ${table('api_permissions')} ap ON ${value('ap','role_id')}=${value('r','id')} AND ${value('ap','api_id')}=${value('a','id')}
   WHERE ${value('r','role_code')}='code_admin' AND ${value('r','active')}='1'
    AND ${value('a','id')} IN ('16535','16536','16537')
   ORDER BY ${value('a','route_path')}`)).rows;
  report.nativeOtpPermissions=grants.rows.filter(row=>row.path.startsWith('/v1/voice/otp/'));
  report.nativeContactPermissions=grants.rows.filter(row=>row.path.startsWith('/v1/voice/contact/'));
  for(const path of ['/v1/voice/contact/status','/v1/voice/contact/start','/v1/voice/contact/check']){const row=grants.rows.find(row=>row.path===path);if(!row||row.registration_count!==1||!Number.isSafeInteger(row.grant_count)||row.grant_count<1)report.blockers.push('native_contact_permission_not_ready:'+path);}
  for(const path of ['/v1/voice/otp/start','/v1/voice/otp/check']){const row=grants.rows.find(row=>row.path===path);if(!row||row.registration_count!==1||!Number.isSafeInteger(row.grant_count)||row.grant_count<1)report.blockers.push('native_permission_not_ready:'+path);}
 }finally{try{await db.query('ROLLBACK');}finally{db.release();}}
 report.stage='provider-negative-check';
 const vapi=new VapiCallReadClient({apiKey:process.env.VAPI_PRIVATE_API_KEY});
 try{await vapi.fetch('00000000-0000-4000-8000-000000000000');throw Error('Unknown call unexpectedly resolved');}catch(error){if(error?.code!=='resource_not_found')throw Error('Provider read check failed');report.unknownProviderCallRejected=true;}
 // Require fresh live denial/readback in addition to the saved deployment receipt.
 let nativeReceipt;try{nativeReceipt=JSON.parse(await readFile('docs/business/evidence/voice-contact-native-deployment-20261024.json','utf8'));}catch{}
 report.nativeContactBoundary=await verifyNativeContactDeployment(nativeReceipt);
 if(!report.nativeContactBoundary.boundaryVerified)report.blockers.push(report.nativeContactBoundary.deploymentRecorded?'native_contact_enrollment_boundary_not_verified':'native_contact_enrollment_not_deployed');
 report.blockers.push('private_pre_ai_pairing_delivery_not_connected','native_app_pairing_ui_not_connected','otp_runtime_not_deployed');
 report.stage='complete';report.readinessMeasured=true;report.ready=false;report.status='identity_activation_blocked';
}catch{report.status='identity_readiness_check_failed';process.exitCode=1;}
finally{await pool?.end();}
await mkdir('test-results/vapi',{recursive:true});await writeFile('test-results/vapi/identity-readiness.json',JSON.stringify(report,null,2)+'\n');console.log('VAPI_IDENTITY_READINESS '+JSON.stringify(report));
