import {seedBusinessPlanTemplates} from './seed-business-plan-templates.mjs';
import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import {readFile,mkdtemp} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {build} from 'esbuild';
import {createRequire} from 'node:module';
import {businessRoles,contributors,manager,authorizeAction,loopSummary,publicCycle} from '../packages/shared/src/business-plans/policy.mjs';
import {familyPayload,FAMILIES} from '../packages/shared/src/business-plans/template-families.mjs';
import {validatePayload} from '../packages/shared/src/business-plans/template-learning.mjs';
const dir=await mkdtemp(join(tmpdir(),'business-plan-test-'));
await build({entryPoints:['cloudflare/workers/src/business-plans/repository.ts'],outfile:join(dir,'repository.cjs'),bundle:true,platform:'node',format:'cjs'});
const {BusinessPlanRepository}=createRequire(import.meta.url)(join(dir,'repository.cjs'));
let db,finish;
if(process.env.BUSINESS_PLAN_TEST_DATABASE_URL){const url=new URL(process.env.BUSINESS_PLAN_TEST_DATABASE_URL);if(!['localhost','127.0.0.1'].includes(url.hostname)||url.pathname!=='/business_plan_test')throw Error('Disposable local business_plan_test only');const {Client}=await import('pg');db=new Client({connectionString:url.href});await db.connect();const schema='bp_'+randomUUID().replaceAll('-','');await db.query('CREATE SCHEMA '+schema);await db.query('SET search_path TO '+schema);finish=async()=>{await db.query('DROP SCHEMA '+schema+' CASCADE');await db.end();};}else{const {PGlite}=await import(process.env.BUSINESS_PLAN_PGLITE_MODULE||'@electric-sql/pglite');db=new PGlite();finish=()=>db.close();}
let checks=0;const check=(v,msg)=>{assert.ok(v,msg);checks++;};
const ta=randomUUID(),tb=randomUUID(),ma={id:randomUUID(),roles:'tenant_admin',tenant_id:ta},mb={id:randomUUID(),roles:'owner',tenant_id:tb},staff={id:randomUUID(),roles:'growth_caller',tenant_id:ta},reviewer={id:randomUUID(),roles:'ceo',tenant_id:ta},code={id:randomUUID(),roles:'code_admin',tenant_id:ta};
const repo=a=>new BusinessPlanRepository(db,a,a.tenant_id),rm=repo(ma),rs=repo(staff),rr=repo(reviewer),rc=repo(code);
async function tx(r,b){await db.query('BEGIN');try{const result=await r.execute(b);await db.query('COMMIT');return result;}catch(e){await db.query('ROLLBACK');throw e;}}
async function reject(r,b){await assert.rejects(()=>tx(r,b));checks++;}
try{
 await db.exec?.("CREATE TABLE tenants(id TEXT PRIMARY KEY,name TEXT,slug TEXT,status TEXT);CREATE TABLE users(id TEXT PRIMARY KEY,email TEXT,roles TEXT,tenant_id TEXT,status TEXT);");if(!db.exec){await db.query("CREATE TABLE tenants(id TEXT PRIMARY KEY,name TEXT,slug TEXT,status TEXT);CREATE TABLE users(id TEXT PRIMARY KEY,email TEXT,roles TEXT,tenant_id TEXT,status TEXT);");}
 for(const file of ['20261028_business_plan_cycles.sql']){const sql=await readFile('packages/database/migrations/'+file,'utf8');if(db.exec)await db.exec(sql);else await db.query(sql);}
 await seedBusinessPlanTemplates(db);
 await db.query('INSERT INTO tenants VALUES($1,$2,$3,$4),($5,$6,$7,$8)',[ta,'Fixture A','fixture-a','active',tb,'Fixture B','fixture-b','active']);
 for(const a of [ma,mb,staff,reviewer,code])await db.query('INSERT INTO users VALUES($1,$2,$3,$4,$5)',[a.id,a.roles+'@example.invalid',a.roles,a.tenant_id,'active']);
 for(const role of contributors){check(businessRoles.includes(role)&&!manager({roles:role}),'support roles remain assigned-only: '+role);}
 const catalog=await rm.list();check(catalog.templates.length===14,'14 templates');check(catalog.notices.length===1,'role rollout notice');
 for(const f of FAMILIES)for(const flow of ['master','tenant']){validatePayload(familyPayload(flow,f.key),flow);checks++;}
 const tpl=catalog.templates.find(t=>t.flow==='tenant'&&t.family==='lean_operations');
 const created=await tx(rm,{action:'create',value:{templateId:tpl.id,name:'Fixture efficiency plan',baseline:'Verified baseline fixture — no live business claim',capacity:'Safe qualified cover confirmed in fixture'}});const id=created.id;
 let c=(await rm.list(id)).cycles[0];check(c.data.goals.every(g=>g.actual===0&&!g.updates.length),'zero achievements');check(c.data.start===null&&c.data.plan==='HOLD','no assumed start or launch');
 check((await rs.list()).cycles.length===0,'staff no unassigned plan');await reject(repo(mb),{id,version:c.version,action:'archive',value:{reason:'foreign'}});
 await reject(rs,{id,version:c.version,action:'assign',value:{id:c.data.tasks[0].id,userId:staff.id}});
 const taskId=c.data.tasks[0].id;await tx(rm,{id,version:c.version,action:'assign',value:{id:taskId,userId:staff.id}});c=(await rm.list(id)).cycles[0];
 const visible=(await rs.list(id)).cycles[0];check(visible.data.tasks.length===1&&!visible.data.growth,'staff assigned-only projection');check((await rs.list()).notices.some(n=>n.title.startsWith('Task assigned')),'assignment notice');
 await reject(rm,{id,version:1,action:'assign',value:{id:taskId,userId:mb.id}});await reject(rm,{id,version:c.version,action:'assign',value:{id:taskId,userId:mb.id}});
 await reject(rs,{id,version:c.version,action:'progress',value:{id:c.data.goals[0].id,actual:999,evidence:'fake',next:'fake'}});
 await tx(rs,{id,version:c.version,action:'submitTask',value:{id:taskId,evidence:'Fixture-only work output'}});c=(await rm.list(id)).cycles[0];check(c.summary.pendingReview===1,'pending manager review');
 await reject(rs,{id,version:c.version,action:'reviewTask',value:{id:taskId,decision:'accept',reason:'self'}});
 await tx(rr,{id,version:c.version,action:'reviewTask',value:{id:taskId,decision:'accept',reason:'Different manager verified output'}});c=(await rm.list(id)).cycles[0];check(c.data.tasks[0].status==='done','manager acceptance');
 await reject(rm,{id,version:c.version,action:'taskUpdate',value:{id:c.data.tasks[1].id,status:'done',evidence:'bypass'}});
 await reject(rm,{id,version:c.version,action:'plan',value:{plan:'A',reason:'premature'}});
 await tx(rm,{id,version:c.version,action:'rescheduleGrowth',value:{start:'2026-11-01',reason:'Fixture start',baselineConfirmed:true}});c=(await rm.list(id)).cycles[0];check(c.data.end==='2027-04-29','180 calendar days');
 await tx(rm,{id,version:c.version,action:'progress',value:{id:c.data.goals[0].id,actual:2,evidence:'Fixture measurement source',next:'Review causes'}});c=(await rm.list(id)).cycles[0];check(c.data.goals[0].updates[0].reporter===ma.id,'verified session actor');
 await tx(rm,{id,version:c.version,action:'developmentPlan',value:{sourceType:'goal',sourceId:c.data.goals[0].id,teamCode:c.data.teams[0].code,start:'2026-11-02',duration:'7',target:3,unit:'outputs',owner:'Fixture named owner',manager:'Fixture manager',reason:'Missed test goal',rootCause:'Fixture root cause',resources:'Fixture resources',strategy:'Fixture corrective test',success:'Independent evidence accepted'}});c=(await rm.list(id)).cycles[0];check(c.data.developmentPlans.length===1&&c.data.developmentPlans[0].taskIds.length===4,'four corrective tasks');await reject(rm,{id,version:c.version,action:'reviewDevelopment',value:{id:c.data.developmentPlans[0].id,decision:'closed',reviewer:ma.id,evidence:'premature',next:'none'}});
 const original=tpl.payload.tenant.tasks[0];await tx(rm,{id,version:c.version,action:'lesson',value:{title:'Fixture learning',kind:'development_test',sampleSize:1,observation:'Synthetic test of the learning loop',evidence:'Local fixture only',limitations:'Not a business result',patch:{tasks:[{...original,description:original.description+' Fixture revised instruction.'}]}}});
 const pending=(await rc.list()).lessons.find(l=>l.cycle_id===id);await reject(rm,{action:'reviewLesson',value:{id:pending.id,decision:'publish',reason:'Not authorized',attested:true}});
 await tx(rc,{action:'reviewLesson',value:{id:pending.id,decision:'publish',reason:'Fixture-only engineering review',attested:true}});const published=(await rc.list()).templates.find(t=>t.flow==='tenant'&&t.family==='lean_operations'&&t.version===2);check(!!published,'new immutable version');
 c=(await rm.list(id)).cycles[0];check(c.data.templateOrigin.version===1&&!c.data.growth.templateSpec.tasks[0].description.includes('Fixture revised instruction'),'old plan pinned');
 const successor=await tx(rm,{action:'create',value:{templateId:published.id,name:'Fixture next cycle',baseline:'Prior evidence reviewed',capacity:'Qualified capacity reviewed',previousCycleId:id}});const next=(await rm.list(successor.id)).cycles[0];check(next.data.templateOrigin.version===2&&next.data.goals.every(g=>g.actual===0)&&next.data.previousCycle.goals[0].actual===2,'fresh next cycle plus baseline');
 await reject(repo(mb),{action:'create',value:{templateId:published.id,name:'Foreign predecessor',baseline:'none',capacity:'none',previousCycleId:id}});
 await tx(rm,{id,version:c.version,action:'archive',value:{reason:'Fixture closed'}});c=(await rm.list(id)).cycles[0];await reject(rm,{id,version:c.version,action:'progress',value:{id:c.data.goals[0].id,actual:10,evidence:'archived',next:'none'}});await tx(rm,{id,version:c.version,action:'reopen',value:{reason:'Fixture reopen'}});
 const broadcast=(await rs.list()).notices.find(n=>n.id==='cebc06aa-9464-4fe1-bf4d-bbd881581801');await tx(rs,{action:'acknowledge',value:{id:broadcast.id}});check((await rs.list()).notices.find(n=>n.id===broadcast.id).read,'read receipt');check((await rm.list(id)).audit.length>8,'independent audit trail');
 console.log(`Business plan loop passed ${checks} checks: templates, isolation, assignment, review, evidence, recovery, versioning, successor baseline, notices and audit.`);
}finally{await finish();}
