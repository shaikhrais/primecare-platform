import {build} from 'esbuild';
import assert from 'node:assert/strict';
import {test} from 'node:test';
import {readFileSync} from 'node:fs';

const plugin={name:'source-limit-db-sentinel',setup(b){
 b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'source-fixture'}));
 b.onLoad({filter:/.*/,namespace:'source-fixture'},()=>({loader:'js',contents:'export class Client {async connect(){globalThis.__sourceDbTouches++;throw Error("private-database-sentinel")}}'}));
}};
async function bundle(path,plugins=[]){const r=await build({entryPoints:[path],bundle:true,write:false,platform:'node',format:'esm',plugins});return import('data:text/javascript;base64,'+Buffer.from(r.outputFiles[0].text).toString('base64'));}
const {default:service}=await bundle('cloudflare/workers/src/service.ts',[plugin]);
const {default:gateway}=await bundle('cloudflare/workers/src/gateway.ts');
const {sourceLimitAllowed}=await bundle('cloudflare/workers/src/source-limit-result.ts');
const governance=JSON.parse(readFileSync('cloudflare/workers/src/governance-api-registry.json','utf8'));
const token='A'.repeat(43);
const malformed=[undefined,null,true,false,[],{}, {success:'true'},{success:'false'},{success:1},{success:0},{success:null},{success:new Boolean(true)}];
test('source provider result requires an actual boolean in an object',()=>{
 for(const value of malformed)assert.throws(()=>sourceLimitAllowed(value),/Invalid source limiter result/);
 assert.equal(sourceLimitAllowed({success:true,private:'ignored'}),true);
 assert.equal(sourceLimitAllowed({success:false}),false);
});
const providerRecords=JSON.parse(readFileSync('cloudflare/workers/src/provider-records-registry.json','utf8'));
const selfRecords=JSON.parse(readFileSync('cloudflare/workers/src/self-records-registry.json','utf8'));
const clientRecords=JSON.parse(readFileSync('cloudflare/workers/src/client-records-registry.json','utf8'));
const recordRoutes=records=>records.flatMap(r=>[[r.path,'GET'],...(!r.singleton?[[r.path+'/fixture-record','GET']]:[]),...(r.summaryField&&r.summaryBatch!==0?[[r.path+'/summary','GET']]:[])]);
const families=[
 {batch:269,name:'public authentication',service:'auth',binding:'AUTH_SOURCE_LIMIT',routes:[['/login','POST'],['/forgot-password','POST'],['/reset-password','POST']]},
 {batch:270,name:'workspace',service:'governance',routes:[['/workspace','GET']]},
 {batch:271,name:'governance catalog',service:'governance',routes:governance.bindings.map(b=>[b.path,'GET'])},
 {batch:272,name:'account reads and revocation',service:'auth',routes:[['/admin/users','GET'],['/admin/users/fixture-user','GET'],['/admin/users/fixture-user/sessions','DELETE']]},
 {batch:273,name:'personal sessions',service:'auth',routes:[['/user/sessions','GET'],['/user/sessions','DELETE']]},
 {batch:274,name:'client owned reads',service:'client',routes:[...['/home/profile','/invoices','/invoices/summary','/invoices/fixture-invoice','/bookings','/bookings/summary','/visits','/payments','/invoices/fixture-invoice/payments'].map(p=>[p,'GET']),...recordRoutes(clientRecords)]},
 {batch:275,name:'provider owned reads',service:'provider',routes:['/profile','/availability','/availability/summary','/availability/fixture-record','/visits','/visits/summary','/visits/fixture-record','/documents','/documents/summary','/documents/fixture-record'].map(p=>[p,'GET'])},
 {batch:276,name:'provider registered records',service:'provider',routes:recordRoutes(providerRecords)},
 {batch:277,name:'account owned records',service:'auth',routes:recordRoutes(selfRecords)},
 {batch:278,name:'client booking lifecycle',service:'client',routes:[['/booking-requests','POST'],['/booking-requests/fixture-record/cancel','POST'],['/booking-requests/fixture-record/audit','GET']]},
 {batch:279,name:'provider timesheet items',service:'provider',routes:[['/timesheet-items','GET'],['/timesheet-items/summary','GET'],['/timesheet-items/fixture-record','GET']]},
];
for(const family of families){
 const binding=family.binding??'WORKSPACE_SOURCE_LIMIT';
 const publicPath=path=>family.service==='auth'&&path.startsWith('/admin/')?'/v1'+path:family.service==='auth'&&path.startsWith('/user/')?'/v1'+path:'/v1/'+family.service+path;
 async function call(path,method,result,{viaGateway=false,fail=false,authenticated=true}={}){
  globalThis.__sourceDbTouches=0;const keys=[];
  const env={SERVICE_NAME:family.service,DB_URL:'fixture',
   [binding]:{limit:async({key})=>{keys.push(key);if(fail)throw Error('private-source-provider');return result;}}};
  const headers={'cf-connecting-ip':'192.0.2.10',origin:'https://primecare-clinic.pages.dev','content-type':'application/json','idempotency-key':'source-fixture-key',...(authenticated?{authorization:'Bearer '+token}:{})};
  const bodies={
   '/booking-requests':{service_type:'Massage',preferred_date:new Date(Date.now()+86400000).toISOString()},
   '/login':{email:'fixture@example.invalid',password:'fixture-password'},
   '/forgot-password':{email:'fixture@example.invalid'},
   '/reset-password':{email:'fixture@example.invalid',code:'ABC123ABC123',newPassword:'new-fixture-password'},
  };
  const body=method==='POST'?bodies[path]:undefined;
  const request=new Request('https://fixture'+(viaGateway?publicPath(path):path),{method,headers,...(body?{body:JSON.stringify(body)}:{})});
  const response=viaGateway?await gateway.fetch(request,{[family.service.toUpperCase()]:{fetch:r=>service.fetch(r,env)}}):await service.fetch(request,env);
  return {response,keys,touches:globalThis.__sourceDbTouches};
 }
 test('batch '+family.batch+' '+family.name+' rejects malformed or failed providers before database access',async()=>{
  for(const [path,method] of family.routes)for(const viaGateway of [false,true])for(const result of malformed){
   const {response,keys,touches}=await call(path,method,result,{viaGateway});
   assert.equal(response.status,503,path+' '+method);
   assert.equal(response.headers.get('cache-control'),'no-store');
   assert.equal(response.headers.get('set-cookie'),null);
   assert.equal(response.headers.get('access-control-allow-origin'),'https://primecare-clinic.pages.dev');
   assert.ok(!(await response.text()).includes('private-'));
   assert.equal(keys.length,1,path+' must reach source limiter');assert.equal(touches,0);
  }
  for(const [path,method] of family.routes){const {response,touches}=await call(path,method,undefined,{fail:true});assert.equal(response.status,503);assert.ok(!(await response.text()).includes('private-'));assert.equal(touches,0);}
 });
 test('batch '+family.batch+' '+family.name+' retains boolean decisions and hashed keys',async()=>{
  for(const [path,method] of family.routes){
   const denied=await call(path,method,{success:false});const alias=await call(path,method,{success:false},{viaGateway:true});
   for(const {response,keys,touches} of [denied,alias]){assert.equal(response.status,429);assert.equal(response.headers.get('retry-after'),'60');assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(touches,0);assert.match(keys[0],/^[a-f0-9]{64}$/);}
   assert.deepEqual(denied.keys,alias.keys);
   const allowed=await call(path,method,{success:true});
   assert.equal(allowed.touches,1,'valid allow must proceed to database');
  }
 });
 if(binding==='WORKSPACE_SOURCE_LIMIT')test('batch '+family.batch+' '+family.name+' still requires bearer before calling provider',async()=>{
  for(const [path,method] of family.routes){const {response,keys,touches}=await call(path,method,{success:true},{authenticated:false});assert.equal(response.status,401);assert.equal(keys.length,0);assert.equal(touches,0);}
 });
}

test('source success is read once, without a second accessor decision',()=>{
 let reads=0;const result={get success(){return ++reads===1?false:'true';}};
 assert.equal(sourceLimitAllowed(result),false);assert.equal(reads,1);
});
