import pg from 'pg';
import {readFileSync} from 'node:fs';
const pin=JSON.parse(readFileSync(new URL('../tools/governance-production/production-pin.json',import.meta.url)));
if(!/^[a-z_0-9]+$/.test(pin.schema))throw Error('Invalid pinned schema');
const db=new pg.Client({connectionString:process.env.PRODUCTION_DATABASE_URL,ssl:{rejectUnauthorized:true}});
await db.connect();
try {
 await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
 const m=await db.query(`SELECT manifest_sha256 FROM "${pin.schema}".govt_source_manifest`);
 if(m.rows.length!==1||m.rows[0].manifest_sha256!==pin.manifestSha256)throw Error('Governance authority mismatch');
 const names=await db.query('SELECT table_name FROM information_schema.tables WHERE table_schema=$1',[pin.schema]);
 console.log('MFA_GOVERNANCE_TABLES '+JSON.stringify(names.rows.map(x=>x.table_name).filter(x=>/auth|mfa|permission|api_endpoint|screen|language/.test(x))));
 for(const table of ['govt_auth_route_registry','govt_api_endpoints']) {
  const rows=await db.query(`SELECT row_to_json(t) AS record FROM "${pin.schema}"."${table}" t WHERE row_to_json(t)::text ~* '(mfa|multi.factor|totp|webauthn|passkey)'`);
  console.log('MFA_REGISTRATION '+JSON.stringify({table,records:rows.rows.map(x=>x.record)}));
 }
 await db.query('ROLLBACK');
}finally{await db.end();}
