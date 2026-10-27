import pg from 'pg';
import {readFile,mkdir,writeFile} from 'node:fs/promises';
const pin=JSON.parse(await readFile('tools/governance-production/production-pin.json','utf8'));
if(!/^governance_[a-f0-9]+$/.test(pin.schema))throw Error('pinned_schema_required');
const unwrap=v=>v&&typeof v==='object'&&!Array.isArray(v)&&Object.hasOwn(v,'v')?v.v:v;
const db=new pg.Client({connectionString:process.env.PRODUCTION_DATABASE_URL});
const report={source:process.env.GITHUB_SHA,readOnly:true,authority:pin.schema,candidates:[],bindingsEnabled:false};
try{
 await db.connect();await db.query('BEGIN READ ONLY');await db.query("SET LOCAL statement_timeout='15s'");
 const rows=(await db.query(`SELECT to_jsonb(a) AS row FROM "${pin.schema}".govt_api_endpoints a`)).rows;
 for(const {row} of rows){const path=unwrap(row.route_path);if(typeof path!=='string'||!/(vapi|lead|appointment|booking|consultation|proposal|onboarding|callback|suppression|consent|service.catalog|availability)/i.test(path))continue;
  report.candidates.push(Object.fromEntries(['id','endpoint_code','route_path','http_method','service_name','implementation_status','permission_key','auth_required'].map(k=>[k,unwrap(row[k])??null])));
 }
 await db.query('ROLLBACK');
 report.status='metadata_candidates_require_runtime_and_identity_review';
}finally{await db.end();}
await mkdir('test-results/vapi',{recursive:true});await writeFile('test-results/vapi/api-bindings.json',JSON.stringify(report,null,2)+'\n');
console.log('VAPI_API_BINDINGS '+JSON.stringify(report));
