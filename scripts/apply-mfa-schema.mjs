import pg from 'pg';
import {readFileSync} from 'node:fs';
import {createHash} from 'node:crypto';
const pin=JSON.parse(readFileSync('tools/governance-production/production-pin.json'));
const sql=readFileSync('packages/database/migrations/20261025_auth_mfa.sql','utf8');
const expected={optInVariable:'APPLY_MFA_SCHEMA',tables:['auth_mfa_credentials','auth_mfa_challenges','auth_mfa_audit'],migrationSha256:createHash('sha256').update(sql).digest('hex'),accountAssignments:false,credentialWrites:false};
if(JSON.stringify(pin.mfaSchemaWriter)!==JSON.stringify(expected)||process.env.APPLY_MFA_SCHEMA!=='1'||! /^[a-z0-9_]+$/.test(pin.schema))throw Error('Exact MFA schema scope required');
const columns={auth_mfa_credentials:{user_id:'text',tenant_id:'text',envelope:'jsonb',enabled:'boolean',last_counter:'bigint',created_at:'timestamp with time zone',enabled_at:'timestamp with time zone'},auth_mfa_challenges:{token_hash:'text',user_id:'text',tenant_id:'text',role:'text',password_version:'text',purpose:'text',attempts:'integer',expires_at:'timestamp with time zone',created_at:'timestamp with time zone'},auth_mfa_audit:{id:'text',user_id:'text',tenant_id:'text',action:'text',created_at:'timestamp with time zone'}};
const db=new pg.Client({connectionString:process.env.PRODUCTION_DATABASE_URL,ssl:{rejectUnauthorized:true}});await db.connect();
try{
 await db.query('BEGIN');await db.query('SET LOCAL search_path TO public');await db.query("SET LOCAL lock_timeout='10s'");
 const m=await db.query(`SELECT manifest_sha256 FROM "${pin.schema}".govt_source_manifest`);if(m.rows.length!==1||m.rows[0].manifest_sha256!==pin.manifestSha256)throw Error('Governance authority mismatch');
 const p=await db.query(`SELECT definition FROM "${pin.schema}".govt_platform_hierarchy_policy WHERE id='mfa-auth-policy-v1'`);
 const equal=(a,b)=>a&&typeof a==='object'&&b&&typeof b==='object'?Object.keys(a).length===Object.keys(b).length&&Object.keys(a).every(k=>Object.hasOwn(b,k)&&equal(a[k],b[k])):a===b;
 if(p.rows.length!==1||!equal(JSON.parse(p.rows[0].definition),JSON.parse(readFileSync('tools/governance-production/mfa-registration.json'))))throw Error('MFA policy differs');
 const api=await db.query(`SELECT route_path,http_method,permission_key FROM "${pin.schema}".govt_api_endpoints WHERE endpoint_code='auth_mfa_verify'`);if(api.rows.length!==1||api.rows[0].route_path!=='/v1/auth/mfa'||api.rows[0].http_method!=='POST'||api.rows[0].permission_key!=='password_verified_mfa_challenge')throw Error('Registered MFA endpoint required');
 await db.query("SELECT pg_advisory_xact_lock(hashtext('auth-mfa-schema-v1'))");
 await db.query(sql);
 for(const [table,expectedColumns]of Object.entries(columns)){
  const result=await db.query('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=$1 AND table_name=$2',['public',table]);const actual=Object.fromEntries(result.rows.map(r=>[r.column_name,r.data_type]));if(Object.keys(actual).length!==Object.keys(expectedColumns).length||Object.entries(expectedColumns).some(([k,v])=>actual[k]!==v))throw Error('MFA schema drift');
  const pk=await db.query("SELECT count(*)::int AS n FROM pg_constraint WHERE conrelid=to_regclass($1) AND contype='p'",['public.'+table]);if(pk.rows[0].n!==1)throw Error('MFA identity constraint missing');
 }
 await db.query(process.env.MFA_SCHEMA_DRY_RUN==='1'?'ROLLBACK':'COMMIT');console.log('MFA_SCHEMA '+JSON.stringify({validated:true,dryRun:process.env.MFA_SCHEMA_DRY_RUN==='1',tables:Object.keys(columns),accountChanges:0}));
}catch{await db.query('ROLLBACK');throw Error('MFA schema application failed; no account or credential changes applied');}finally{await db.end();}
