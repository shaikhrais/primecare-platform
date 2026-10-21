import pg from 'pg';
import {readFileSync} from 'node:fs';
const pin=JSON.parse(readFileSync(new URL('../tools/governance-production/production-pin.json',import.meta.url)));
if(!/^[a-z_0-9]+$/.test(pin.schema))throw Error('Invalid pinned schema');
const db=new pg.Client({connectionString:process.env.PRODUCTION_DATABASE_URL,ssl:{rejectUnauthorized:true}});
await db.connect();
try {
 await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
 const m=await db.query(`SELECT manifest,manifest_sha256 FROM "${pin.schema}".govt_source_manifest`);
 if(m.rows.length!==1||m.rows[0].manifest_sha256!==pin.manifestSha256)throw Error('Governance authority mismatch');
 const names=await db.query('SELECT table_name FROM information_schema.tables WHERE table_schema=$1',[pin.schema]);
 for(const table of ['api_endpoints','screens','screen_components','screen_required_elements','screen_api_links','language_resources','language_resource_values'])console.log('MFA_SCHEMA '+JSON.stringify(m.rows[0].manifest.tables.find(t=>t.name===table)));
 const screens=await db.query(`SELECT row_to_json(t) AS record FROM "${pin.schema}".govt_screens t WHERE route_path='/mfa' OR screen_code='mfa'`);
 console.log('MFA_SCREENS '+JSON.stringify(screens.rows));
 console.log('MFA_GOVERNANCE_TABLES '+JSON.stringify(names.rows.map(x=>x.table_name).filter(x=>/auth|mfa|permission|api_endpoint|screen|language/.test(x))));
 for(const table of ['govt_auth_route_registry','govt_api_endpoints']) {
  const rows=await db.query(`SELECT row_to_json(t) AS record FROM "${pin.schema}"."${table}" t WHERE row_to_json(t)::text ~* '(mfa|multi.factor|totp|webauthn|passkey)'`);
  console.log('MFA_REGISTRATION '+JSON.stringify({table,records:rows.rows.map(x=>x.record)}));
 }
 const login=await db.query(`SELECT id,route_path,http_method,request_schema,response_schema,service_name,auth_required,permission_key,rate_limit_key FROM "${pin.schema}".govt_api_endpoints WHERE route_path='/v1/auth/login' AND http_method='POST'`);console.log('MFA_LOGIN_CONTRACT '+JSON.stringify(login.rows));
 await db.query('ROLLBACK');
}finally{await db.end();}
