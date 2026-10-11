// One inherited Admin browser workflow shared by isolated CI and live verification.
import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import {runPlatformAdminBrowserScenario} from './platform-admin-browser-scenario.mjs';
import {fillFlutterField} from './flutter-browser-input.mjs';

async function refreshWorkspace(page,strings) {
 const response=page.waitForResponse(r=>r.request().method()==='GET'&&new URL(r.url()).pathname.endsWith('/admin/workspace'));
 await page.getByRole('button',{name:strings['admin.refresh'],exact:true}).click();
 assert.equal((await response).status(),200);
 await page.getByRole('button',{name:strings['admin.refresh'],exact:true,disabled:false}).waitFor();
}

export async function runAdminBrowserScenario({browser,db,language,strings,email,password,tenant,admin,organization,uiUrl,api,accountsBefore=1,auditBefore=0,ignoreHTTPSErrors=false,platformControl=false,onPhase=()=>{}}) {
 const userEmail=`browser-user-${randomUUID()}@example.invalid`,updatedEmail=`updated-${randomUUID()}@example.invalid`;
 const page=await browser.newPage({ignoreHTTPSErrors,viewport:{width:1280,height:1000}});
 page.setDefaultTimeout(20000);
 onPhase('login');await page.goto(uiUrl,{waitUntil:'networkidle'});
 const placeholder=page.locator('flt-semantics-placeholder');if(await placeholder.count())await placeholder.evaluate(e=>e.click());
 if(language!=='en') { await page.getByRole('button',{name:'Language',exact:true}).click();await page.getByLabel(language==='es'?'Español':'Français',{exact:true}).click(); }
 await fillFlutterField(page,strings['auth.email'],email);await fillFlutterField(page,strings['auth.password'],password,true);
 await page.getByRole('button',{name:strings['auth.signIn'],exact:true}).click();
 await page.getByRole('button',{name:strings['admin.open'],exact:true}).click();
 await page.getByText(organization,{exact:true}).waitFor();
 onPhase('task overview');await page.getByRole('button',{name:strings['admin.tasks'],exact:true}).click();
 await page.getByText(strings['admin.tasksIntro'],{exact:true}).waitFor();await page.getByText(strings['task.create.title'],{exact:true}).waitFor();await page.getByText(strings['task.create.description'],{exact:true}).waitFor();
 await page.getByRole('button',{name:strings['back'],exact:true}).click();
 onPhase('create user');await page.getByRole('button',{name:strings['admin.create'],exact:true}).click();
 await fillFlutterField(page,strings['admin.email'],userEmail);await fillFlutterField(page,strings['admin.password'],'initial-password-1234',true);
 const creation=page.waitForResponse(r=>r.url().endsWith('/admin/workspace/users')&&r.request().method()==='POST');
 await page.getByRole('button',{name:strings['admin.save'],exact:true}).click();assert.equal((await creation).status(),201);
 await page.getByText(userEmail,{exact:true}).waitFor();
 const user=(await db.query('SELECT id,roles FROM users WHERE email=$1 AND tenant_id=$2',[userEmail,tenant])).rows[0];assert.equal(user.roles,'client');
 const login=await api('/login',{method:'POST',headers:{'content-type':'application/json'},body:JSON.stringify({email:userEmail,password:'initial-password-1234'})});assert.equal(login.status,200);const userToken=(await login.json()).token;
 assert.equal((await api('/admin/workspace',{headers:{authorization:'Bearer '+userToken}})).status,403);
 onPhase('edit role and deactivate');await page.getByRole('button',{name:strings['admin.editAccount'].replace('{email}',userEmail),exact:true}).click();
 await fillFlutterField(page,strings['admin.email'],updatedEmail);
 await page.getByText(strings['admin.role']+' '+strings['role.client'],{exact:true}).click();await page.getByLabel(strings['role.rmt'],{exact:true}).click();
 await page.getByText(strings['admin.status']+' '+strings['active'],{exact:true}).click();await page.getByLabel(strings['inactive'],{exact:true}).click();
 const mutation=page.waitForResponse(r=>r.url().endsWith('/admin/workspace/users/'+user.id)&&r.request().method()==='PUT');
 await page.getByRole('button',{name:strings['admin.save'],exact:true}).click();assert.equal((await mutation).status(),200);
 await page.getByText(updatedEmail,{exact:true}).waitFor();
 const persisted=(await db.query('SELECT email,roles,status FROM users WHERE id=$1',[user.id])).rows[0];assert.deepEqual(persisted,{email:updatedEmail,roles:'rmt',status:'inactive'});
 const me=await api('/me',{headers:{authorization:'Bearer '+userToken}});assert.equal(me.status,401);
 onPhase('reactivate account');await page.getByRole('button',{name:strings['admin.editAccount'].replace('{email}',updatedEmail),exact:true}).click();
 await page.getByText(strings['admin.status']+' '+strings['inactive'],{exact:true}).click();await page.getByLabel(strings['active'],{exact:true}).click();
 const reactivation=page.waitForResponse(r=>r.url().endsWith('/admin/workspace/users/'+user.id)&&r.request().method()==='PUT');
 await page.getByRole('button',{name:strings['admin.save'],exact:true}).click();assert.equal((await reactivation).status(),200);await page.getByText(updatedEmail,{exact:true}).waitFor();
 const resumed=await api('/login',{method:'POST',headers:{'content-type':'application/json'},body:JSON.stringify({email:updatedEmail,password:'initial-password-1234'})});assert.equal(resumed.status,200);const resumedToken=(await resumed.json()).token;
 onPhase('deactivate reactivated account');await page.getByRole('button',{name:strings['admin.editAccount'].replace('{email}',updatedEmail),exact:true}).click();
 await page.getByText(strings['admin.status']+' '+strings['active'],{exact:true}).click();await page.getByLabel(strings['inactive'],{exact:true}).click();
 const finalDeactivation=page.waitForResponse(r=>r.url().endsWith('/admin/workspace/users/'+user.id)&&r.request().method()==='PUT');
 await page.getByRole('button',{name:strings['admin.save'],exact:true}).click();assert.equal((await finalDeactivation).status(),200);await page.getByText(updatedEmail,{exact:true}).waitFor();
 assert.equal((await api('/me',{headers:{authorization:'Bearer '+resumedToken}})).status,401);
 onPhase('reload');await refreshWorkspace(page,strings);await page.getByText(updatedEmail,{exact:true}).waitFor();
 onPhase('search account');await fillFlutterField(page,strings['admin.searchLabel'],updatedEmail.toUpperCase());
 await page.getByRole('button',{name:strings['admin.searchApply'],exact:true}).click();await page.getByText(strings['admin.matchingCounts'].replace('{total}','1').replace('{active}','0'),{exact:true}).waitFor();
 await page.getByText(updatedEmail,{exact:true}).waitFor();
 onPhase('status filtering');await page.getByText(strings['admin.statusFilter']+' '+strings['admin.allStatuses'],{exact:true}).click();await page.getByLabel(strings['active'],{exact:true}).click();
 await page.getByText(strings['admin.matchingCounts'].replace('{total}','0').replace('{active}','0'),{exact:true}).waitFor();await page.getByText(strings['admin.empty'],{exact:true}).waitFor();
 await page.getByText(strings['admin.statusFilter']+' '+strings['active'],{exact:true}).click();await page.getByLabel(strings['inactive'],{exact:true}).click();
 await page.getByText(strings['admin.matchingCounts'].replace('{total}','1').replace('{active}','0'),{exact:true}).waitFor();await page.getByText(updatedEmail,{exact:true}).waitFor();
 await refreshWorkspace(page,strings);await page.getByText(updatedEmail,{exact:true}).waitFor();
 await page.getByText(strings['admin.statusFilter']+' '+strings['inactive'],{exact:true}).click();await page.getByLabel(strings['admin.allStatuses'],{exact:true}).click();
 await page.getByText(strings['admin.matchingCounts'].replace('{total}','1').replace('{active}','0'),{exact:true}).waitFor();
 onPhase('filtered audit');const filteredResponse=page.waitForResponse(r=>r.request().method()==='GET'&&new URL(r.url()).pathname.endsWith('/admin/workspace/audit')&&new URL(r.url()).searchParams.get('userId')===user.id);await page.getByRole('button',{name:strings['audit.viewAccount'].replace('{email}',updatedEmail),exact:true}).click();
 await page.getByText(strings['audit.accountHistory'].replace('{email}',updatedEmail),{exact:true}).waitFor();await page.getByText(strings['audit.count'].replace('{total}','4'),{exact:true}).waitFor();
 const filteredData=await (await filteredResponse).json();assert.equal(filteredData.total,4);assert(filteredData.events.every(event=>event.target===user.id));
 await page.getByText(strings['audit.target'].replace('{id}',user.id),{exact:true}).first().waitFor();
 await page.getByRole('button',{name:strings['audit.clearFilter'],exact:true}).click();await page.getByText(strings['audit.count'].replace('{total}',String(auditBefore+4)),{exact:true}).waitFor();
 await page.getByRole('button',{name:strings['back'],exact:true}).click();
 await page.getByRole('button',{name:strings['admin.searchClear'],exact:true}).click();
 await page.getByText(strings['admin.counts'].replace('{total}',String(accountsBefore+1)).replace('{active}','1'),{exact:true}).waitFor();
 onPhase('audit history');await page.getByRole('button',{name:strings['audit.title'],exact:true}).click();await page.getByText(strings['audit.account_created'],{exact:true}).first().waitFor();await page.getByText(strings['audit.account_updated'],{exact:true}).first().waitFor();await page.getByRole('button',{name:strings['back'],exact:true}).click();
 if(platformControl)await runPlatformAdminBrowserScenario({page,db,strings,language,onPhase});
 onPhase('logout');await page.getByRole('button',{name:strings['back'],exact:true}).click();await page.getByRole('button',{name:strings['auth.signOut'],exact:true}).click();await page.getByRole('button',{name:strings['auth.signIn'],exact:true}).waitFor();
 assert.equal((await db.query('SELECT count(*)::int AS n FROM auth_sessions WHERE user_id=$1',[admin])).rows[0].n,0);
 await page.close();console.log('PASS '+language+': Admin browser E2E login, inherited workspace, create, edit email/role, deactivate/reactivate, persistence, task overview, search/status filters, filtered audit, session revocation and logout');
 return {id:user.id,email:userEmail,updatedEmail};
}
