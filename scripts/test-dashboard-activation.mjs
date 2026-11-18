import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {test} from 'node:test';
import {build} from 'esbuild';

const path='websites/typescript/src/dashboard-activation.json';
const {screens}=JSON.parse(await readFile('cloudflare/workers/src/workspace-registry.json','utf8'));
const tuple=x=>JSON.stringify([x.project,x.appCode,x.code,x.route]);
const projects={'primecare-business-development':'bd','primecare-governance':'go','primecare-support':'su','primecare-marketing':'ma','primecare-franchise':'fr',
  'primecare-corporate':'co','primecare-client':'cl','primecare-clinic':'ci'};
function validate(m){
  assert.equal(m.version,1);
  assert.equal(new Set(m.cohorts.map(c=>c.id)).size,m.cohorts.length);
  for(const c of m.cohorts)assert.ok(c.dashboards.length>0&&c.dashboards.length<=10);
  const rows=[...m.retained,...m.cohorts.flatMap(c=>c.dashboards)];
  assert.equal(new Set(rows.map(tuple)).size,rows.length);
  for(const x of rows){
    assert.equal(x.appCode,projects[x.project]);
    assert.ok(screens.some(s=>s.renderer==='dashboard'&&s.appCode===x.appCode&&s.code===x.code&&s.route===x.route),tuple(x));
  }
  return new Set(rows.map(tuple));
}
const plan=JSON.parse(await readFile(path,'utf8'));
test('checked-in release has exact unique registry tuples; each cohort has at most ten screens',()=>{validate(plan);});
test('one release may add at most ten exact tuples without altering retained registrations',async()=>{
  if(!process.env.PRIMECARE_COHORT_PRIOR)return;
  const old=JSON.parse(await readFile(process.env.PRIMECARE_COHORT_PRIOR,'utf8'));
  const before=validate(old),after=validate(plan);
  assert.deepEqual(old.retained,plan.retained);
  assert.deepEqual(old.cohorts,plan.cohorts.slice(0,old.cohorts.length));
  assert.equal(plan.cohorts.length,old.cohorts.length+1);
  assert.ok([...before].every(x=>after.has(x)));
  assert.ok(after.size-before.size>0&&after.size-before.size<=10);
});
test('wrong portal, app, code or route and unbound roots never select the new shell',async()=>{
  const {outputFiles:[f]}=await build({stdin:{contents:"export * from './websites/typescript/src/dashboard-activation'",resolveDir:process.cwd()},bundle:true,write:false,format:'esm'});
  const {installDashboardActivation,dashboardActivated}=await import('data:text/javascript;base64,'+Buffer.from(f.text).toString('base64'));
  const sample=plan.cohorts[0].dashboards[0],root={},foreign={};
  assert.equal(dashboardActivated(root,sample.code,sample.route,sample.appCode),false);
  installDashboardActivation(root,sample.project,sample.appCode);
  installDashboardActivation(foreign,'primecare-support','su');
  assert.equal(dashboardActivated(root,sample.code,sample.route,sample.appCode),true);
  assert.equal(dashboardActivated(root,sample.code,sample.route,'su'),false);
  assert.equal(dashboardActivated(root,sample.code,sample.route+'/'),false);
  assert.equal(dashboardActivated(root,sample.code+'-unknown',sample.route),false);
  assert.equal(dashboardActivated(foreign,sample.code,sample.route,sample.appCode),false);
  assert.equal(dashboardActivated(root,'founder_growth_dashboard','/growth'),false);
  assert.equal(dashboardActivated(root,'care_delivery','/care'),false);
  assert.equal(dashboardActivated(root,'tenant_admin_command_center','/tenant-dashboard'),false);
  assert.throws(()=>installDashboardActivation(root,'primecare-support','su'),/portal changed/);
  for(const row of [...plan.retained,...plan.cohorts.flatMap(c=>c.dashboards)]){
    const selected={};installDashboardActivation(selected,row.project,row.appCode);
    assert.equal(dashboardActivated(selected,row.code,row.route,row.appCode),true,tuple(row));
  }
  const growth={};installDashboardActivation(growth,'primecare-marketing','ma');
  assert.equal(dashboardActivated(growth,'founder_growth_dashboard','/growth'),true);
});
