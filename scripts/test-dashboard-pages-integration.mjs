import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {tenantFixture} from './tenant-dashboard-fixture.mjs';
import {projectRecordPage} from '../packages/shared/src/dashboard-pages/record-pages.mjs';
import {DashboardPageSession} from '../packages/shared/src/dashboard-pages/session.mjs';
const bundle=await build({entryPoints:['websites/typescript/src/tenant-dashboard/dashboard-page-transport.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {dashboardPageTransport}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
const f=await tenantFixture();let checks=0;
try {
 const response=await f.call('admin',{action:'create',value:{title:'B16 independent count',ownerId:f.actors.psw.id,dueOn:'2026-11-05',priority:'normal',flowId:'fixture.tenant.process',notes:'Disposable fixture only'}});
 assert.equal(response.status,200);
 const scope={tenantId:f.tenants[0],userId:f.actors.admin.id,role:f.actors.admin.role,dataset:'live'};
 let token=f.actors.admin.token;
 let requests=0;
 const fetcher=async(url,init)=>{requests++;assert.equal(init.method,'GET');assert.equal(init.cache,'no-store');assert.equal(init.redirect,'error');assert.equal(new URL(url).searchParams.get('dataset'),'live');return f.tenantDashboard(new Request(url,init),f.env,'/tenant-dashboard',{});};
 const read=dashboardPageTransport('https://fixture.test',token,'live',()=>token,fetcher);
 const s=new DashboardPageSession('project',scope,read,()=>scope);await s.load();assert.equal(s.state.status,'ready');checks++;
 const count=Number((await f.db.query("SELECT COUNT(*) AS n FROM tenant_work_tasks WHERE tenant_id=$1 AND status NOT IN ('completed','cancelled')",[scope.tenantId])).rows[0].n);
 assert.equal(s.state.projection.metrics.find(x=>x.key==='open').value,count);checks++;
 const reload=new DashboardPageSession('project',scope,read,()=>scope);await reload.load();assert.deepEqual(reload.state.projection,s.state.projection);checks++;
 const wrong=new DashboardPageSession('project',{...scope,tenantId:f.tenants[1]},read,()=>({...scope,tenantId:f.tenants[1]}));await wrong.load();assert.equal(wrong.state.status,'denied');assert.equal(wrong.state.projection,null);checks++;
 const pswScope={...scope,userId:f.actors.psw.id,role:f.actors.psw.role};const psw=new DashboardPageSession('analytics',pswScope,dashboardPageTransport('https://fixture.test',f.actors.psw.token,'live',()=>f.actors.psw.token,fetcher),()=>pswScope);await psw.load();assert.equal(psw.state.status,'denied');assert.deepEqual(psw.state.projection.metrics,[]);checks++;
 const recordSessions=[];
 for(const kind of ['search','activity']){
  const session=new DashboardPageSession(kind,scope,read,()=>scope,projectRecordPage);recordSessions.push(session);await session.load();assert.equal(session.state.status,'ready');
  if(kind==='search'){
   const stored=(await f.db.query('SELECT id::text,title FROM tenant_work_tasks WHERE tenant_id=$1',[scope.tenantId])).rows;
   for(const item of stored)assert.ok(session.state.projection.rows.some(row=>row.type==='task'&&row.detail===item.id&&row.title===item.title));
  }else{const stored=(await f.db.query('SELECT action FROM tenant_dashboard_events WHERE tenant_id=$1 ORDER BY created_at DESC',[scope.tenantId])).rows;assert.deepEqual(session.state.projection.rows.map(row=>row.title),stored.map(row=>row.action));}
  const fresh=new DashboardPageSession(kind,scope,read,()=>scope,projectRecordPage);recordSessions.push(fresh);await fresh.load();assert.deepEqual(fresh.state.projection,session.state.projection);checks++;
 }
 for(const session of recordSessions)session.dispose();
 const before=requests;token='changed';await s.load();assert.equal(s.state.status,'denied');assert.equal(s.state.projection,null);assert.equal(requests,before);checks++;
 let captured=f.actors.admin.token;
 const race=dashboardPageTransport('https://fixture.test',captured,'live',()=>captured,async()=>({ok:true,json:async()=>{captured='changed';return {};}}));await assert.rejects(()=>race(new AbortController().signal),/denied/);checks++;
 for(const origin of ['http://public.example','https://u:p@example.test','https://example.test/path','https://example.test/?token=x'])assert.throws(()=>dashboardPageTransport(origin,'token','live',()=>''));checks++;
 for(const session of [s,reload,wrong,psw])session.dispose();
 console.log(`PASS dashboard page integration: ${checks} groups; ${f.native?'native PostgreSQL':'PGlite PostgreSQL'}, real tenant handler, independent SQL, reload, tenant mismatch, role denial and token changes`);
}finally{await f.close();}
