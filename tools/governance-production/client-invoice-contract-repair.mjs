/** One existing API response-schema repair. No account, invoice, role or permission writes. */
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {pathToFileURL} from 'node:url';
import pg from 'pg';
const root=new URL('../../',import.meta.url),definitionPath=new URL('./client-invoice-contract-repair.json',import.meta.url);
const digest=bytes=>createHash('sha256').update(bytes).digest('hex');
const stable=v=>JSON.stringify(v&&typeof v==='object'?Array.isArray(v)?v.map(x=>JSON.parse(stable(x))):Object.fromEntries(Object.keys(v).sort().map(k=>[k,JSON.parse(stable(v[k]))])):v);
const equal=(a,b)=>stable(a)===stable(b);
export const definition=JSON.parse(await readFile(definitionPath,'utf8'));
const pin=JSON.parse(await readFile(new URL('./production-pin.json',import.meta.url),'utf8'));
const table=name=>'"'+pin.schema+'"."'+pin.tablePrefix+name+'"';
export function expectedScope(hash){return {optInVariable:'CLIENT_INVOICE_SCHEMA_WRITES',definitionSha256:hash,tables:['api_endpoints'],apiIds:[16432],columns:['response_schema'],schemaChanges:false,businessDataWrites:false,roleGrants:false,runtimeActivation:false};}
export async function checkDefinition(){
 const bytes=await readFile(definitionPath),d=definition;
 if(!equal(pin.clientInvoiceApiWriter,expectedScope(digest(bytes))))throw Error('exact invoice schema pin required');
 const doc=await readFile(new URL(d.source,root)),runtime=await readFile(new URL(d.runtimeSource,root));
 if(digest(doc)!==d.sourceSha256||digest(runtime)!==d.runtimeSha256||!equal(JSON.parse(doc).paths[d.path].get.responses['200'].content['application/json'].schema,d.after))throw Error('invoice canonical source differs');
 if(d.apiId!==16432||d.screenId!==665||d.roleId!==13||d.linkId!==4330||d.method!=='GET'||d.path!=='/v1/client/invoices'||d.service!=='client'||d.permission!=='authenticated_client_profile_owner'||d.grants!==false||d.runtimeActivation!==false||!equal(d.fields,['response_schema']))throw Error('invoice definition differs');
 const a=structuredClone(d.after),b=structuredClone(d.before);
 for(const k of ['status','currency','subtotal','tax','total']){if(!equal(a.properties.invoices.items.properties[k].type,['string','null']))throw Error('nullable invoice field required');a.properties.invoices.items.properties[k]=b.properties.invoices.items.properties[k];}
 if(a.properties.pagination.properties.total.minimum!==0||Object.hasOwn(b.properties.pagination.properties.total,'minimum'))throw Error('count constraint differs');
 delete a.properties.pagination.properties.total.minimum;
 if(!equal(a,b))throw Error('unrelated response change');
 return digest(bytes);
}
export function targetSchema(row){
 const d=definition;
 if(!row||row.id!==16432||row.http_method!=='GET'||row.route_path!==d.path||row.service_name!==d.service||row.auth_required!==1||row.permission_key!==d.permission||row.implementation_status!=='implemented'||!equal(JSON.parse(row.request_schema),d.requestSchema))throw Error('invoice endpoint identity differs');
 const old=JSON.parse(row.response_schema);
 if(!equal(old,d.before)&&!equal(old,d.after))throw Error('invoice response contract drift');
 return JSON.stringify(d.after);
}
async function authority(db){
 const m=(await db.query('SELECT manifest_sha256 FROM '+table('source_manifest'))).rows;
 if(m.length!==1||m[0].manifest_sha256!==pin.manifestSha256)throw Error('invoice manifest differs');
 const host=(await db.query('SELECT s.screen_code,s.route_path,s.actual_file_path,r.role_code FROM '+table('screens')+' s JOIN '+table('role_screen_permissions')+' p ON p.screen_id=s.id JOIN '+table('roles')+' r ON r.id=p.role_id WHERE s.id=665 AND s.active=1 AND p.role_id=13 AND p.can_view=1 AND r.active=1')).rows;
 if(host.length!==1||!equal(host[0],{screen_code:'client_profile',route_path:'/clinic/client-profile',actual_file_path:'packages/primecare_ui/lib/src/features/workspace/governed_workspace_screen.dart',role_code:'guest'}))throw Error('invoice host authority differs');
 const links=(await db.query('SELECT id FROM '+table('screen_api_links')+' WHERE screen_id=665 AND api_id=16432')).rows;
 if(links.length!==1||String(links[0].id)!=='4330')throw Error('invoice host link differs');
}
const state=async(db,locked=false)=>{const r=(await db.query('SELECT to_jsonb(a)-\'_primecare_import_row\' AS metadata FROM '+table('api_endpoints')+' a WHERE id=16432'+(locked?' FOR UPDATE OF a':''))).rows;if(r.length!==1)throw Error('invoice endpoint cardinality');return r[0].metadata;};
export async function repair(db,{apply=false}={}){
 await checkDefinition();await db.query('BEGIN');
 try{
  await db.query("SET LOCAL lock_timeout='10s'");await db.query("SET LOCAL statement_timeout='120s'");await authority(db);
  const before=await state(db,true),target=targetSchema(before);let changed=false;
  if(!equal(JSON.parse(before.response_schema),definition.after)){
   const r=await db.query('UPDATE '+table('api_endpoints')+' SET response_schema=$1 WHERE id=16432 AND response_schema=$2',[target,before.response_schema]);
   if(r.rowCount!==1)throw Error('invoice schema compare-and-set failed');changed=true;
  }
  const after=await state(db);targetSchema(after);
  if(!equal(JSON.parse(after.response_schema),definition.after)||!equal({...before,response_schema:after.response_schema},after))throw Error('invoice unrelated endpoint drift');
  await db.query(apply?'COMMIT':'ROLLBACK');return {apiId:16432,changed,committed:apply,columns:['response_schema'],roleGrants:0,businessRowsRead:0,schemaChanges:false,runtimeActivated:false};
 }catch(error){await db.query('ROLLBACK');throw error;}
}
async function connect(){const raw=process.env.PRODUCTION_DATABASE_URL;if(!raw)throw Error('connection');const u=new URL(raw);if(!['postgres:','postgresql:'].includes(u.protocol)||u.hostname!=='pooled.db.prisma.io'||u.pathname!=='/postgres'||process.env.GOVERNANCE_DATABASE_URL&&process.env.GOVERNANCE_DATABASE_URL!==raw)throw Error('pinned invoice connection required');const db=new pg.Client({connectionString:raw,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000});await db.connect();return db;}
async function main(){
 if(process.argv.slice(2).length!==1||!['--dry-run','--apply'].includes(process.argv[2])||process.env.CLIENT_INVOICE_SCHEMA_WRITES!=='1')throw Error('explicit invoice schema scope required');
 let db=await connect(),result;try{result=await repair(db,{apply:process.argv[2]==='--apply'});}finally{await db.end();}
 if(result.committed){db=await connect();try{await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');await authority(db);const row=await state(db);targetSchema(row);if(!equal(JSON.parse(row.response_schema),definition.after))throw Error('independent invoice schema readback differs');await db.query('ROLLBACK');result.independentReadback=true;}finally{await db.end();}}
 await mkdir('test-results/client-invoice-registration',{recursive:true});await writeFile('test-results/client-invoice-registration/schema'+(result.committed?'-apply':'-dry-run')+'.json',JSON.stringify(result,null,2)+'\n');console.log('CLIENT_INVOICE_SCHEMA_REPAIR '+JSON.stringify(result));
}
if(import.meta.url===pathToFileURL(process.argv[1]??'').href)main().catch(()=>{console.error('Exact invoice contract repair failed closed; no unrelated mutation permitted.');process.exitCode=1;});
