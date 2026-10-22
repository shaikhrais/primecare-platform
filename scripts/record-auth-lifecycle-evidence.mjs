import pg from 'pg';
import {pathToFileURL} from 'node:url';
import {readFileSync} from 'node:fs';
import {createHash} from 'node:crypto';
import assert from 'node:assert/strict';
import {validateAuthLifecycleReceipt} from './validate-auth-lifecycle-receipt.mjs';
const basePin=JSON.parse(readFileSync('tools/governance-production/production-pin.json'));
const definitions=Object.fromEntries(['mfa-native-surface','auth-lifecycle-surface','auth-elevation-surface'].map(name=>[name,readFileSync('tools/governance-production/'+name+'.json')]));
const expected={optInVariable:'RECORD_AUTH_LIFECYCLE_EVIDENCE',tables:['api_endpoints','screen_components','platform_hierarchy_policy'],
 definitionHashes:Object.fromEntries(Object.entries(definitions).map(([name,bytes])=>[name,createHash('sha256').update(bytes).digest('hex')])),
 apiCount:11,reviewApprovals:false,productionReadyCredit:false,accountChanges:false,roleGrants:false};
export async function recordAuthLifecycleEvidence(db,{pin=basePin,receipt,source,producerRun}){
assert.deepEqual(pin.authLifecycleEvidenceWriter,expected);
if(!/^[a-z][a-z0-9_]+$/.test(pin.schema)||!/^\d+$/.test(producerRun??''))throw Error('Exact lifecycle evidence scope required');
const validation=validateAuthLifecycleReceipt(receipt,source);
const native=JSON.parse(definitions['mfa-native-surface']),lifecycle=JSON.parse(definitions['auth-lifecycle-surface']),elevation=JSON.parse(definitions['auth-elevation-surface']);
let stage='begin';
try{
 await db.query('BEGIN');await db.query("SET LOCAL lock_timeout='10s'");await db.query("SET LOCAL statement_timeout='120s'");
 const schema='"'+pin.schema+'"';
 stage='authority';
 const manifest=(await db.query(`SELECT manifest_sha256 FROM ${schema}.govt_source_manifest`)).rows;
 if(manifest.length!==1||manifest[0].manifest_sha256!==pin.manifestSha256)throw Error('Authority mismatch');
 await db.query(`LOCK TABLE ${schema}.govt_api_endpoints,${schema}.govt_screen_components,${schema}.govt_platform_hierarchy_policy IN SHARE ROW EXCLUSIVE MODE`);
 const account=(await db.query(`SELECT id,route_path,active FROM ${schema}.govt_screens WHERE screen_code='AUTHENTICATED_ACCOUNT'`)).rows;
 if(account.length!==1||account[0].route_path!=='/success'||account[0].active!==1)throw Error('Account surface mismatch');
 stage='apis';
 let apis=0;
 for(const e of [...lifecycle.endpoints,...elevation.endpoints]){
  const result=await db.query(`UPDATE ${schema}.govt_api_endpoints SET implementation_status='implemented-scoped-tested'
   WHERE endpoint_code=$1 AND route_path=$2 AND http_method=$3 AND permission_key=$4 AND auth_required=$5
   AND implementation_status IN ('registered-unimplemented','implemented-scoped-tested') RETURNING id`,[e.code,e.route,e.method??'POST',e.permission,e.authenticated??1]);
  if(result.rows.length!==1)throw Error('API metadata mismatch');apis++;
 }
 stage='controls';
 const controls=[...Object.keys(native.controls).map(name=>({screen:949,code:'authMfa.native.'+name,file:'packages/primecare_ui/lib/src/features/auth/mfa_form.dart'})),
  ...Object.keys(lifecycle.controls).map(name=>({screen:949,code:'authLifecycle.'+name,file:lifecycle.file})),
  {screen:account[0].id,code:lifecycle.managementEntry.componentCode,file:lifecycle.managementEntry.file},
  ...Object.entries(elevation.controls).map(([name,c])=>({screen:c.screen==='mfa'?949:account[0].id,code:'authElevation.'+name,file:c.file}))];
 for(const c of controls){
  const result=await db.query(`UPDATE ${schema}.govt_screen_components SET implementation_status='implemented-scoped-tested'
   WHERE screen_id=$1 AND component_code=$2 AND file_path=$3
   AND implementation_status IN ('registered-unimplemented','implemented-scoped-tested') RETURNING component_code`,[c.screen,c.code,c.file]);
  if(result.rows.length!==1)throw Error('Component metadata mismatch');
 }
 stage='immutable-proof';
 const id='auth-lifecycle-live-evidence-v1:'+receipt.source+':'+producerRun;
 const proof={...receipt,validation,producerRun:producerRun,scope:'Native Flutter MFA recovery replacement and approved aggregate-only tenant support',
  reviewApprovals:false,wholePlatformAuthVerified:false,physicalDevicesVerified:false,inboxDeliveryVerified:false,productionReady:false};
 const prior=(await db.query(`SELECT definition FROM ${schema}.govt_platform_hierarchy_policy WHERE id=$1`,[id])).rows;
 if(!prior.length)await db.query(`INSERT INTO ${schema}.govt_platform_hierarchy_policy(_primecare_import_row,id,definition,requirement)
  SELECT COALESCE(MAX(_primecare_import_row),-1)+1,$1,$2,$3 FROM ${schema}.govt_platform_hierarchy_policy`,[id,JSON.stringify(proof),'Source-bound scoped engineering evidence; independent reviews and physical-device acceptance remain separate.']);
 else{if(prior.length!==1)throw Error('Ambiguous evidence');assert.deepEqual(JSON.parse(prior[0].definition),proof);}
 await db.query('COMMIT');return {source:receipt.source,apis,controls:controls.length,independentApprovals:false,wholePlatformAuthVerified:false};
}catch{await db.query('ROLLBACK');throw Error('Lifecycle evidence failed at '+stage+'; governance transaction rolled back');}
}

if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href){
 if(process.env.RECORD_AUTH_LIFECYCLE_EVIDENCE!=='1')throw Error('Explicit lifecycle evidence write required');
 const receipt=JSON.parse(readFileSync('test-results/live-flutter-mfa/receipt.json'));
 const db=new pg.Client({connectionString:process.env.PRODUCTION_DATABASE_URL,ssl:{rejectUnauthorized:true}});await db.connect();
 try{const result=await recordAuthLifecycleEvidence(db,{receipt,source:process.env.AUTH_LIFECYCLE_PRODUCER_SHA,producerRun:process.env.AUTH_LIFECYCLE_PRODUCER_RUN});console.log('AUTH_LIFECYCLE_EVIDENCE '+JSON.stringify(result));}finally{await db.end();}
}
