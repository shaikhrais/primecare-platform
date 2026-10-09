import {build} from 'esbuild';import {test} from 'node:test';import assert from 'node:assert/strict';
const plugin={name:'fixture',setup(b){b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));b.onLoad({filter:/.*/,namespace:'fixture'},()=>({contents:'export class Client {async connect(){} async end(){} async query(s,v){return globalThis.__billingQuery(s,v)}}',loader:'js'}));}};
const bundle=async(path,plugins=[])=>{const r=await build({entryPoints:[path],bundle:true,write:false,platform:'node',format:'esm',plugins});return import('data:text/javascript;base64,'+Buffer.from(r.outputFiles[0].text).toString('base64'));};
const {TENANCY}=await bundle('packages/domain/src/registries/ApiRegistry/tenancy.ts');const {clientSelf}=await bundle('cloudflare/workers/src/client-self.ts',[plugin]);const {default:gateway}=await bundle('cloudflare/workers/src/gateway.ts');
const invoice={id:'invoice',status:'pending',currency:'CAD',subtotal:'100.10',tax:'13.01',total:'113.11',created_at:'2026-01-01T00:00:00Z',updated_at:'2026-01-01T00:00:00Z'};
let queries;
function fixture(){queries=[];globalThis.__billingQuery=async(sql,values)=>{queries.push({sql,values});
 if(sql.startsWith('SELECT u.id'))return {rows:[{id:'own-user',tenant_id:'tenant-a'}]};
 if(sql.startsWith('SELECT id,full_name')){assert.deepEqual(values,['own-user','tenant-a']);return {rows:[{id:'own-profile'}]};}
 if(sql.startsWith('SELECT COUNT')){assert.deepEqual(values,['own-profile','tenant-a']);return {rows:[{count:1}]};}
 if(sql.startsWith('SELECT id,status')){assert.deepEqual(values,sql.includes('AND id::text=$3')?['own-profile','tenant-a','invoice']:['own-profile','tenant-a',25,0]);return {rows:[invoice]};}
 assert.ok(sql.startsWith('BEGIN')||sql==='ROLLBACK',sql);return {rows:[]};};}
const call=(path,method='GET')=>gateway.fetch(new Request('https://gateway.test'+path,{method,headers:{authorization:'Bearer '+'a'.repeat(43)}}),{CLIENT:{fetch:r=>clientSelf(r,{SERVICE_NAME:'client',DB_URL:'fixture'},new URL(r.url).pathname,{})}});
test('billing registry list and detail resolve through gateway to actual owned invoice read DTOs',async()=>{
 fixture();const list=await call(TENANCY.CLIENT.BILLING_INVOICES);assert.equal(list.status,200);assert.deepEqual((await list.json()).invoices,[invoice]);
 fixture();const detail=await call(TENANCY.CLIENT.BILLING_INVOICE_DETAIL('invoice'));assert.equal(detail.status,200);assert.deepEqual(await detail.json(),{invoice});
});
test('billing caller reconciliation grants no invoice mutation authority',async()=>{for(const path of [TENANCY.CLIENT.BILLING_INVOICES,TENANCY.CLIENT.BILLING_INVOICE_DETAIL('invoice')]){fixture();const r=await call(path,'POST');assert.equal(r.status,405);assert.equal(r.headers.get('allow'),'GET');assert.equal(queries.length,0);}});
