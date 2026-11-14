/** Read existing PC10 business and native identity/settings links; no provider or business-row access. */
import {readFile} from 'node:fs/promises';import pg from 'pg';
const pin=JSON.parse(await readFile(new URL('./production-pin.json',import.meta.url)));
const raw=process.env.PRODUCTION_DATABASE_URL,url=new URL(raw??'');
if(!['postgres:','postgresql:'].includes(url.protocol)||url.hostname!=='pooled.db.prisma.io'||url.pathname!=='/postgres')throw Error('Pinned read-only connection required');
const db=new pg.Client({connectionString:raw,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000});
const table=name=>'"'+pin.schema+'"."'+pin.tablePrefix+name+'"';
// Exact existing read-self and shortcut APIs: inspect their approved host links too.
const nativeApiIds=[16402,777];
const pattern='(academy|course|training|learn|commerce|purchase|inventory|help|knowledge|article|finance|ledger|invoice|pricing|product|market|authored)|/(ai|chat|chatbot|assistant)([/-]|$)';
function schemaSummary(value){if(value==null)return {present:false};try{const schema=typeof value==='string'?JSON.parse(value):value;const names=new Set();const visit=(node,depth=0)=>{if(!node||typeof node!=='object'||depth>8)return;for(const key of Object.keys(node.properties??{}))names.add(key);for(const branch of [...(node.oneOf??[]),...(node.anyOf??[]),...(node.allOf??[])])visit(branch,depth+1);};visit(schema);return {present:true,properties:[...names].sort(),type:schema.type??null};}catch{return {present:true,malformed:true};}}
try{
 await db.connect();await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');await db.query("SET LOCAL statement_timeout='20s'");
 const manifest=(await db.query('SELECT manifest_sha256 FROM '+table('source_manifest'))).rows;if(manifest.length!==1||manifest[0].manifest_sha256!==pin.manifestSha256)throw Error('Production authority mismatch');
 const endpoints=(await db.query('SELECT id,http_method,route_path,service_name,auth_required,permission_key,rate_limit_key,implementation_status,request_schema,response_schema FROM '+table('api_endpoints')+' WHERE route_path ~* $1 OR id=ANY($2::bigint[]) ORDER BY id LIMIT 201',[pattern,nativeApiIds])).rows;
 if(endpoints.length>200)throw Error('API discovery exceeds bounded scope; refine categories');
 const screens=(await db.query('SELECT id,screen_code,active FROM '+table('screens')+' WHERE screen_code ~* $1 ORDER BY id LIMIT 201',[pattern])).rows;if(screens.length>200)throw Error('Screen discovery exceeds bounded scope');
 const ids=endpoints.map(e=>String(e.id));
 const links=ids.length?(await db.query('SELECT l.api_id,s.id AS screen_id,s.screen_code,s.active FROM '+table('screen_api_links')+' l JOIN '+table('screens')+' s ON s.id=l.screen_id WHERE l.api_id=ANY($1::bigint[]) ORDER BY l.api_id,s.id',[ids])).rows:[];
 const grants=ids.length?(await db.query('SELECT p.api_id,r.id AS role_id,r.role_code,r.active,p.can_access,p.permission_key FROM '+table('api_permissions')+' p JOIN '+table('roles')+' r ON r.id=p.role_id WHERE p.api_id=ANY($1::bigint[]) AND p.can_access=1 ORDER BY p.api_id,r.id',[ids])).rows:[];
 const workflowPattern='(academy|course|training|commerce|purchase|help|knowledge|article|finance|ledger|invoice|payment|chat)';
 const definitions=(await db.query('SELECT flow_id,title,flow_kind,actor_roles_json,definition_status,verification_status,test_status,blocker_json FROM '+table('virtual_workflow_definitions')+" WHERE title ~* $1 OR flow_id ~* $1 ORDER BY CASE WHEN flow_kind='action_journey' THEN 1 ELSE 0 END,flow_id LIMIT 51",[workflowPattern])).rows;
 const selected=definitions.slice(0,50),flowIds=selected.map(row=>row.flow_id);
 const steps=flowIds.length?(await db.query('SELECT flow_id,step_order,action_text,expected_text,api_method,api_path FROM '+table('virtual_workflow_steps')+' WHERE flow_id=ANY($1::text[]) ORDER BY flow_id,step_order LIMIT 1001',[flowIds])).rows:[];
 const sourceLinks=flowIds.length?(await db.query('SELECT flow_id,source_table,source_key,source_key_columns,reference_status FROM '+table('virtual_workflow_source_links')+' WHERE flow_id=ANY($1::text[]) ORDER BY flow_id,source_table,source_key LIMIT 1001',[flowIds])).rows:[];
 const workflowSpecifications={sourceLinks:sourceLinks.slice(0,1000),sourceLinksTruncated:sourceLinks.length>1000,definitions:selected,definitionsTruncated:definitions.length>50,steps:steps.slice(0,1000),stepsTruncated:steps.length>1000,authoritativeContractsInferred:false};
 await db.query('ROLLBACK');
 console.log('PC10_BUSINESS_CONTRACT_DISCOVERY '+JSON.stringify({workflowSpecifications,selectedExistingApiIds:nativeApiIds,manifestSha256:pin.manifestSha256,endpoints:endpoints.map(({request_schema,response_schema,...e})=>({...e,request:schemaSummary(request_schema),response:schemaSummary(response_schema),links:links.filter(l=>String(l.api_id)===String(e.id)),grantCount:grants.filter(g=>String(g.api_id)===String(e.id)).length,roles:grants.filter(g=>String(g.api_id)===String(e.id)).map(g=>[Number(g.role_id),g.role_code,Number(g.active),g.permission_key===e.permission_key])})),screens,writes:0,businessRowsRead:0,providerActions:0,authorityInferred:false}));
}finally{await db.end();}
