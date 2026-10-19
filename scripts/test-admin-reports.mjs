import {build} from 'esbuild';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {mkdtemp,readFile,writeFile} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {execFileSync} from 'node:child_process';
import {createRequire} from 'node:module';
const dir=await mkdtemp(join(tmpdir(),'primecare-reports-'));
await build({entryPoints:['cloudflare/workers/src/reporting.ts','cloudflare/workers/src/service.ts','cloudflare/workers/src/gateway.ts'],bundle:true,platform:'node',format:'cjs',outdir:dir,outExtension:{'.js':'.cjs'},plugins:[{name:'db',setup(b){b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));b.onLoad({filter:/.*/,namespace:'fixture'},()=>({contents:'export class Client {async connect(){} async end(){} async query(sql,values){return globalThis.__reportQuery(sql,values)}}',loader:'js'}));}}]});
const {reporting,ReportService,ReportPolicy,PdfReportRenderer,parseReportRequest,parseReportEmail,ReportDeliveryService}=createRequire(import.meta.url)(join(dir,'reporting.cjs'));
const registry=JSON.parse(await readFile('cloudflare/workers/src/report-registry.json','utf8'));
const workspace=JSON.parse(await readFile('cloudflare/workers/src/workspace-registry.json','utf8'));
let sent=[];const env={SERVICE_NAME:'governance',DB_URL:'fixture',EMAIL_FROM:'reports@example.com',EMAIL:{send:async m=>{sent.push(m);return {messageId:'mail-1'};}}};
const body={to:'outside@example.net',confirmed:true};
function fixture(role='ceo',tenant='tenant-a') {
 const queries=[],deliveries=new Map();sent=[];env.EMAIL.send=async m=>{sent.push(m);return {messageId:'mail-1'};};let quota=0;
 globalThis.__reportQuery=async(sql,v)=>{
  queries.push({sql,v});
  if(sql.includes('WHERE s.token_hash=$1'))return {rows:role?[{id:'actor',roles:role,tenant_id:tenant}]:[]};
  if(sql.startsWith('SELECT request_hash,state'))return {rows:deliveries.has(v[2])?[deliveries.get(v[2])]:[]};
  if(sql.includes('COUNT(*)::int AS count FROM report_delivery'))return {rows:[{count:quota}]};
  if(sql.startsWith('INSERT INTO report_delivery')){assert.equal(tenant,v[1]);deliveries.set(v[2],{request_hash:v[3],state:'sending',id:'delivery-1'});quota++;return {rows:[{id:'delivery-1'}]};}
  if(sql.startsWith('UPDATE report_delivery')){for(const d of deliveries.values())d.state=sql.includes("state='accepted'")?'accepted':'unknown';return {rows:[{id:'delivery-1'}]};}
  if(sql.startsWith('INSERT INTO report_audit')){assert.equal(tenant,v[1]);return {rows:[{id:1}]};}
  if(sql.includes('FROM tenant_mail_configuration'))return {rows:[]};
  if(sql.includes('SELECT roles AS role')){assert.deepEqual(v,[tenant]);return {rows:[{role:'ceo',count:1},{role:'rmt',count:2}]};}
  if(sql.includes('COUNT(*)::int AS count FROM auth_sessions')){assert.deepEqual(v,[tenant]);return {rows:[{count:2}]};}
  if(sql.includes('FROM auth_account_audit'))return {rows:[]};
  if(sql.includes('FROM pg_attribute'))return {rows:[]};
  if(sql.startsWith('BEGIN')||sql==='COMMIT'||sql==='ROLLBACK'||sql.startsWith('SELECT pg_advisory'))return {rows:[]};
  assert.fail('Unexpected query '+sql);
 };return {queries,deliveries,setQuota:n=>{quota=n;}};
}
async function call(path='/reports',method='GET',data,headers={},target=env) {
 return reporting(new Request('https://test'+path,{method,headers:{authorization:'Bearer '+'a'.repeat(43),...(data?{'content-type':'application/json'}:{}),...headers},...(data?{body:JSON.stringify(data)}:{})}),target,path.split('?')[0],{});
}
test('registry is grounded in all governed role grants, with organization authority preserved',()=>{
 const all=new Set(workspace.screens.flatMap(p=>p.grants.filter(g=>g.view===1).map(g=>g.role)));
 const grants=registry.definitions.find(d=>d.report_id==='page_readiness').grants;
 for(const role of all)assert.ok(grants.some(g=>g.role===role),role);
 assert.deepEqual(registry.definitions.find(d=>d.report_id==='organization_summary').grants.map(g=>g.role),['ceo']);
 for(const locale of ['en','fr','es'])assert.deepEqual(Object.keys(registry.resources[locale]).sort(),Object.keys(registry.resources.en).sort());
 assert.ok(registry.surfaces.some(s=>s.screen==='admin_dashboard'));
});
test('role catalogs and report rows never expose another role pages',async()=>{
 for(const role of ['admin','cfo','coo','hr_director','scheduler','rmt','maintenance']){
  fixture(role);const catalog=await (await call()).json();assert.equal(catalog.reports.length,1,role);
  const result=await call('/reports/page_readiness');assert.equal(result.status,200);const data=await result.json();
  const allowed=workspace.screens.filter(p=>p.renderer!=='account'&&p.grants.some(g=>g.role===role&&g.view===1));
  assert.deepEqual(data.rows.map(r=>r.page),allowed.map(p=>p.name));
  assert.equal((await call('/reports/organization_summary')).status,403);
 }
});
test('missing, malformed, expired sessions and cross-tenant requests fail closed',async()=>{
 fixture(null);assert.equal((await call()).status,401);
 fixture();assert.equal((await call('/reports','GET',null,{authorization:'bad'})).status,401);
 fixture('ceo',null);assert.equal((await call()).status,403);
 fixture();assert.equal((await call('/reports','GET',null,{'x-tenant-id':'other'})).status,403);
});
test('queries, methods, unknown ids, locales and caller-controlled tenant are validated',async()=>{
 fixture();for(const p of ['/reports?tenant=other','/reports?locale=ar','/reports?locale=en&locale=fr','/reports?search=ceo'])assert.equal((await call(p)).status,400,p);
 assert.equal((await call('/reports/page_readiness','POST',{})).status,405);
 assert.equal((await call('/reports/unknown')).status,404);
 assert.throws(()=>parseReportRequest({search:'x'.repeat(101)}));
 assert.throws(()=>parseReportRequest({search:'\n'}));
});
test('readiness search and locale filters work; zero results are real empty reports',async()=>{
 fixture();const data=await (await call('/reports/page_readiness?locale=fr&search=ceo')).json();assert.equal(data.locale,'fr');assert.ok(data.title.includes('État'));assert.ok(data.rows.every(r=>r.page.toLowerCase().includes('ceo')));
 const empty=await (await call('/reports/page_readiness?search=does-not-exist')).json();assert.deepEqual(empty.rows,[]);
});
test('organization report uses tenant aggregates and unavailable sources never become zero',async()=>{
 const {queries}=fixture();const response=await call('/reports/organization_summary');assert.equal(response.status,200);const data=await response.json();assert.equal(data.rows[0].value,3);assert.equal(data.scope,'organization');assert.ok(data.rows.some(r=>r.value==='Data unavailable'));assert.ok(!queries.some(q=>/FROM "(clients|providers|visits|invoices|schedules)"/.test(q.sql)));
 assert.equal((await call('/reports/organization_summary?search=x')).status,400);
});
test('PDF is binary, no-store, has correct offsets, pagination and all rows',async()=>{
 fixture();const result=await (await call('/reports/page_readiness')).json();result.rows=Array.from({length:150},(_,i)=>({page:`row-${i}`,role:'admin',status:'Créée',blockers:'pending '.repeat(20)}));const bytes=new PdfReportRenderer().render(result);const pdf=Buffer.from(bytes).toString('latin1');assert.ok(pdf.startsWith('%PDF-1.4'));assert.ok(pdf.includes('row-149'));assert.ok(pdf.includes('Créée'));assert.ok(Number(/\/Count (\d+)/.exec(pdf)[1])>1);
 const xref=Number(/startxref\n(\d+)/.exec(pdf)[1]);assert.ok(pdf.slice(xref).startsWith('xref'));
 const offsets=[...pdf.matchAll(/(\d{10}) 00000 n /g)].map(m=>Number(m[1]));for(let i=0;i<offsets.length;i++)assert.ok(pdf.slice(offsets[i]).startsWith(`${i+1} 0 obj`));
 await writeFile(join(dir,'report.pdf'),bytes);
 const r=await call('/reports/page_readiness/pdf');assert.equal(r.status,200);assert.equal(r.headers.get('content-type'),'application/pdf');assert.equal(r.headers.get('cache-control'),'no-store');
});
test('email rejects header injection, uploaded content, missing consent and oversized bodies',async()=>{
 fixture();for(const b of [{...body,to:'x@example.com\r\nBcc:x@y.com'},{...body,confirmed:false},{...body,pdf:'uploaded'},{...body,subject:'bad\nsubject'}]){assert.throws(()=>parseReportEmail(b));assert.equal((await call('/reports/page_readiness/email','POST',b,{'idempotency-key':'a'.repeat(20)})).status,400);}
 assert.equal((await call('/reports/page_readiness/email','POST',body)).status,400);
 assert.equal((await call('/reports/page_readiness/email','POST',{...body,message:'x'.repeat(9000)},{'idempotency-key':'a'.repeat(20)})).status,413);assert.equal(sent.length,0);
});
test('email includes server-generated PDF and commits the claim before sending',async()=>{
 const {queries}=fixture();env.EMAIL.send=async m=>{assert.equal(queries.at(-1).sql,'COMMIT');sent.push(m);return {messageId:'mail-1'};};
 const response=await call('/reports/page_readiness/email','POST',{...body,message:'<script>bad</script>'},{'idempotency-key':'b'.repeat(20)});assert.equal(response.status,202);assert.equal((await response.json()).state,'accepted');assert.equal(sent.length,1);assert.ok(sent[0].html.includes('&lt;script&gt;'));assert.ok(!sent[0].html.includes('<script>'));assert.ok(Buffer.from(sent[0].attachments[0].content).toString().startsWith('%PDF-'));assert.equal(sent[0].to,'outside@example.net');
});
test('same key replay sends once, and changed payload conflicts',async()=>{
 fixture();env.EMAIL.send=async m=>{sent.push(m);return {messageId:'mail-1'};};const h={'idempotency-key':'c'.repeat(20)};
 assert.equal((await call('/reports/page_readiness/email','POST',body,h)).status,202);
 assert.equal((await call('/reports/page_readiness/email','POST',body,h)).status,200);assert.equal(sent.length,1);
 assert.equal((await call('/reports/page_readiness/email','POST',{...body,to:'other@example.com'},h)).status,409);assert.equal(sent.length,1);
});
test('ambiguous delivery and audit failures never retry a committed send',async()=>{
 fixture();env.EMAIL.send=async m=>{sent.push(m);throw Error('secret provider timeout');};const h={'idempotency-key':'d'.repeat(20)};
 const r=await call('/reports/page_readiness/email','POST',body,h);assert.equal(r.status,503);assert.deepEqual(await r.json(),{state:'unknown'});assert.equal((await call('/reports/page_readiness/email','POST',body,h)).status,409);assert.equal(sent.length,1);
});
test('quota, missing mail binding, missing migration and corrupt counts fail honestly',async()=>{
 let f=fixture();f.setQuota(10);assert.equal((await call('/reports/page_readiness/email','POST',body,{'idempotency-key':'e'.repeat(20)})).status,429);
 fixture();assert.equal((await call('/reports/page_readiness/email','POST',body,{'idempotency-key':'e'.repeat(20)},{...env,EMAIL:undefined})).status,503);
 fixture();const base=globalThis.__reportQuery;globalThis.__reportQuery=async(sql,v)=>{if(sql.startsWith('INSERT INTO report_audit'))throw Error('private db detail');return base(sql,v);};const r=await call('/reports/page_readiness');assert.equal(r.status,503);assert.ok(!(await r.text()).includes('private'));
 fixture();const valid=globalThis.__reportQuery;globalThis.__reportQuery=async(sql,v)=>sql.includes('SELECT roles AS role')?{rows:[{role:'ceo',count:-1}]}:valid(sql,v);assert.equal((await call('/reports/organization_summary')).status,503);
});
test('routes execute only on governance service',async()=>{fixture();assert.equal(await call('/reports','GET',undefined,{}, {...env,SERVICE_NAME:'billing'}),null);});

test('gateway and service dispatch catalog, PDF and email through the shared report policy',async()=>{
 const require=createRequire(import.meta.url);
 const service=require(join(dir,'service.cjs')).default,gateway=require(join(dir,'gateway.cjs')).default;
 const bindings={GOVERNANCE:{fetch:request=>service.fetch(request,env)}};
 const request=(path,method='GET',data)=>new Request('https://api.test/v1/governance'+path,{method,headers:{authorization:'Bearer '+'a'.repeat(43),...(data?{'content-type':'application/json','idempotency-key':'gateway-delivery-key-123'}:{})},...(data?{body:JSON.stringify(data)}:{})});
 fixture('admin');
 const catalog=await gateway.fetch(request('/reports?locale=es'),bindings);
 assert.equal(catalog.status,200);assert.equal((await catalog.json()).reports.length,1);
 const pdf=await gateway.fetch(request('/reports/page_readiness/pdf?locale=fr'),bindings);
 assert.equal(pdf.status,200);assert.equal(Buffer.from(await pdf.arrayBuffer()).subarray(0,5).toString(),'%PDF-');
 const email=await gateway.fetch(request('/reports/page_readiness/email','POST',body),bindings);
 assert.equal(email.status,202);assert.equal(sent.length,1);
 assert.equal((await gateway.fetch(request('/reports/organization_summary'),bindings)).status,403);
 assert.equal(email.headers.get('x-primecare-gateway'),'cloudflare-worker-typescript');
});

test('deployment gives governance a restricted native mail binding and includes the report migration',async()=>{
 const configs=await mkdtemp(join(tmpdir(),'report-worker-configs-'));
 execFileSync(process.execPath,['scripts/generate-cloudflare-worker-config.mjs',configs]);
 for(const name of ['auth','governance','client','billing']) {
  const config=JSON.parse(await readFile(join(configs,name+'.jsonc'),'utf8'));
  if(['auth','governance'].includes(name)){
   assert.equal(config.send_email[0].name,'EMAIL');
   assert.deepEqual(config.send_email[0].allowed_sender_addresses,[config.vars.EMAIL_FROM]);
   assert.equal(config.vars.EMAIL_ALLOWED_SENDER,config.vars.EMAIL_FROM);
  }else assert.equal(config.send_email,undefined);
 }
 const migration=await readFile('packages/database/migrations/20261011_admin_reports.sql','utf8');
 assert.ok(migration.includes('CREATE TABLE IF NOT EXISTS report_delivery'));
 assert.ok(migration.includes('CREATE TABLE IF NOT EXISTS report_audit'));
 const workflow=await readFile('.github/workflows/deploy-database-migrations.yml','utf8');
 assert.ok(workflow.includes('packages/database/migrations/*.sql'));
});
