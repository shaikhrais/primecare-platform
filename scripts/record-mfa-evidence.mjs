import pg from 'pg';
import {readFileSync} from 'node:fs';
import {createHash} from 'node:crypto';
const pin=JSON.parse(readFileSync('tools/governance-production/production-pin.json'));
const definition=readFileSync('tools/governance-production/mfa-surface.json');
const expected={optInVariable:'RECORD_MFA_EVIDENCE',tables:['api_endpoints','screen_components','platform_hierarchy_policy'],endpointCode:'auth_mfa_verify',screenId:949,componentPrefix:'authMfa.',definitionSha256:createHash('sha256').update(definition).digest('hex'),reviewApprovals:false,productionReadyCredit:false,accountChanges:false};
if(JSON.stringify(pin.mfaEvidenceWriter)!==JSON.stringify(expected)||process.env.RECORD_MFA_EVIDENCE!=='1'||! /^[a-z0-9_]+$/.test(pin.schema))throw Error('Exact MFA evidence scope required');
const receipt=JSON.parse(readFileSync('test-results/live-mfa/receipt.json'));
if(receipt.passed!==true||receipt.source!==process.env.MFA_PRODUCER_SHA||receipt.results.length!==3||!['en','fr','es'].every(locale=>receipt.results.some(r=>r.locale===locale&&r.liveBrowser&&r.realGateway&&r.nativeDatabase&&r.noPrematureSession&&r.wrongCodeDenied&&r.enrolled&&r.replayDenied&&r.syntheticCleanup)))throw Error('Complete live MFA receipt required');
const db=new pg.Client({connectionString:process.env.PRODUCTION_DATABASE_URL,ssl:{rejectUnauthorized:true}});await db.connect();
const schema='"'+pin.schema+'"';
try{
 await db.query('BEGIN');const m=await db.query(`SELECT manifest_sha256 FROM ${schema}.govt_source_manifest`);if(m.rows.length!==1||m.rows[0].manifest_sha256!==pin.manifestSha256)throw Error('Governance authority mismatch');
 await db.query(`LOCK TABLE ${schema}.govt_api_endpoints,${schema}.govt_screen_components,${schema}.govt_platform_hierarchy_policy IN SHARE ROW EXCLUSIVE MODE`);
 const api=await db.query(`UPDATE ${schema}.govt_api_endpoints SET implementation_status='implemented-scoped-tested' WHERE endpoint_code='auth_mfa_verify' AND route_path='/v1/auth/mfa' AND http_method='POST' AND implementation_status IN ('registered-unimplemented','implemented-scoped-tested') RETURNING id`);if(api.rows.length!==1)throw Error('MFA endpoint metadata drift');
 const components=await db.query(`UPDATE ${schema}.govt_screen_components SET implementation_status='implemented-scoped-tested' WHERE screen_id=949 AND component_code LIKE 'authMfa.%' AND file_path='websites/typescript/src/auth-mfa.ts' AND implementation_status IN ('registered-unimplemented','implemented-scoped-tested') RETURNING component_code`);if(components.rows.length!==Object.keys(JSON.parse(definition).controls).length)throw Error('MFA component metadata drift');
 const id='mfa-live-evidence-v1:'+receipt.source;
 const proof={...receipt,scope:'Web Code Admin MFA enrollment and login',reviewApprovals:false,wholePlatformAuthVerified:false,producerRun:process.env.MFA_PRODUCER_RUN};
 const existing=await db.query(`SELECT definition FROM ${schema}.govt_platform_hierarchy_policy WHERE id=$1`,[id]);
 if(existing.rows.length===0)await db.query(`INSERT INTO ${schema}.govt_platform_hierarchy_policy(_primecare_import_row,id,definition,requirement) SELECT COALESCE(MAX(_primecare_import_row),-1)+1,$1,$2,$3 FROM ${schema}.govt_platform_hierarchy_policy`,[id,JSON.stringify(proof),'Source-bound live web MFA acceptance; independent reviews and whole-platform acceptance remain separate.']);
 else if(existing.rows.length!==1||JSON.stringify(JSON.parse(existing.rows[0].definition))!==JSON.stringify(proof))throw Error('Preserve existing MFA evidence record');
 await db.query('COMMIT');console.log('MFA_EVIDENCE_RECORDED '+JSON.stringify({apiId:api.rows[0].id,controls:components.rows.length,status:'implemented-scoped-tested',reviewApprovals:false,wholePlatformAuthVerified:false}));
}catch{await db.query('ROLLBACK');throw Error('MFA evidence registration failed; metadata preserved');}finally{await db.end();}
