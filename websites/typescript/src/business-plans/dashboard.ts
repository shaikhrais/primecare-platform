import {requireScreenManager,showScreenConfigurationError,ScreenConfigurationError} from '../../../../packages/primecare_ui/web/screen-manager';
import {resolveManagedRoute} from '../managed-routes';
import {BaseSessionClient} from '../infrastructure/http/base-session-client';
import {renderShell,bindShell} from '../shell';
import {normalizePatch} from '../../../../packages/shared/src/business-plans/template-learning.mjs';
import {FAMILIES} from '../../../../packages/shared/src/business-plans/template-families.mjs';
const esc=(x:unknown)=>String(x??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]!));
// Authentication effects belong to the current renderer, never a stale response.
class PlanClient extends BaseSessionClient{
 protected endpoint='/v1/governance/growth/cycles';
 protected accountChangedError(){return Error('Your account changed. Reload this page.');}
 protected rejectResponse(r:Response,v:unknown):never{throw Object.assign(Error(String(this.errorData(v).error||'Business planning is unavailable. Refresh to confirm saved data.')),{status:r.status});}
 async call(query:string,body?:unknown){return this.requestJson(query,body?'POST':'GET',body);}
}
// JSONB may reorder object keys; reflection of accepted learning is structural.
const canonical=(value:unknown)=>JSON.stringify(value,(_key,item)=>item&&typeof item==='object'&&!Array.isArray(item)?Object.fromEntries(Object.entries(item).sort(([a],[b])=>a<b?-1:a>b?1:0)):item);
const planningRenders=new WeakMap<HTMLElement,()=>void>();
type Receipt={tenant:string;body:any;result:any;lessonIds:Set<string>;lessonPatch?:unknown;values:Record<string,FormDataEntryValue>};
type PlanningDialog={key:string;open:()=>boolean;values:Record<string,FormDataEntryValue>};

const field=(name:string,label:string,value='',type='text',required=true)=>`<label>${esc(label)}<input name="${name}" type="${type}" value="${esc(value)}" ${required?'required':''}></label>`;
const area=(name:string,label:string,value='',required=true)=>`<label>${esc(label)}<textarea name="${name}" maxlength="2000" rows="3" ${required?'required':''}>${esc(value)}</textarea></label>`;
const select=(name:string,label:string,options:any[],value='')=>`<label>${esc(label)}<select name="${name}" ${name==='previousCycleId'?'':'required'}>${options.map(o=>`<option value="${esc(o.id??o)}" ${(o.id??o)===value?'selected':''}>${esc(o.label??o)}</option>`).join('')}</select></label>`;
export async function renderBusinessPlans(root:HTMLElement,gateway:string){
 planningRenders.get(root)?.();
 const manager=requireScreenManager(root),entry=resolveManagedRoute('/business-plans',''),documentRoute=location.pathname+location.search;
 const events=root.ownerDocument.defaultView??window;
 let alive=true,suspended=false,epoch=0,generation=0,loading=false,busy=false,owner:MutationObserver|undefined;
 let ownedNodes=Array.from(root.childNodes),data:any,selected='',scope=new URLSearchParams(location.search).get('tenant')||'',notice='',commandKey='';
 let activeDialog:PlanningDialog|undefined;
 const dialogs=new Set<HTMLDialogElement>(),resumes=new Set<()=>void>(),receipts=new Map<string,Receipt>();
 const release=()=>{for(const resume of resumes)resume();resumes.clear();};
 const whenActive=()=>suspended&&alive?new Promise<void>(resolve=>resumes.add(resolve)):Promise.resolve();
 const ownsRoot=()=>alive&&planningRenders.get(root)===teardown;
 function owned(){
  if(!ownsRoot())return false;
  const nodes=Array.from(root.childNodes);
  if(!root.isConnected||nodes.length!==ownedNodes.length||nodes.some((node,i)=>node!==ownedNodes[i])){teardown();return false;}
  return true;
 }
 function fail(error:unknown){if(owned()){teardown();showScreenConfigurationError(root,error);}return false;}
 let token:string|null;
 try{token=sessionStorage.getItem('primecare_session');}catch{showScreenConfigurationError(root,new ScreenConfigurationError('Session storage is unavailable'));return;}
 function context(){
  if(!owned())return false;
  if(location.pathname!==entry.route||location.pathname+location.search!==documentRoute){teardown();root.replaceChildren();return false;}
  try{if(sessionStorage.getItem('primecare_session')!==token){teardown();root.replaceChildren();return false;}}catch{return fail(new ScreenConfigurationError('Session storage is unavailable'));}
  return true;
 }
 function current(){if(suspended||!context())return false;try{manager.enter(entry.id,entry.route);}catch(error){return fail(error);}return context();}
 function closeDialogs(){for(const dialog of [...dialogs]){dialogs.delete(dialog);dialog.close();dialog.remove();}activeDialog=undefined;}
 function teardown(){
  if(!alive)return;alive=false;suspended=false;epoch++;generation++;release();owner?.disconnect();closeDialogs();
  events.removeEventListener('popstate',onHistory);events.removeEventListener('hashchange',onHistory);events.removeEventListener('pagehide',leave);events.removeEventListener('pageshow',resume);
  if(planningRenders.get(root)===teardown)planningRenders.delete(root);
 }
 const onHistory=()=>{if(!suspended)context();};
 const leave=(event:PageTransitionEvent)=>{if(event.persisted)suspended=true;else teardown();};
 const resume=(event:PageTransitionEvent)=>{if(!event.persisted||!suspended||!ownsRoot())return;suspended=false;current();release();};
 planningRenders.set(root,teardown);
 owner=new MutationObserver(()=>{if(!owned())return;for(const dialog of dialogs)if(!dialog.isConnected){dialogs.delete(dialog);dialog.close();}});
 owner.observe(root.ownerDocument,{childList:true,subtree:true});
 events.addEventListener('popstate',onHistory);events.addEventListener('hashchange',onHistory);events.addEventListener('pagehide',leave);events.addEventListener('pageshow',resume);
 if(!current())return;
 if(!token){teardown();root.replaceChildren();try{location.assign('/login?enable-semantics=true');}catch(error){showScreenConfigurationError(root,error);}return;}
 const client=new PlanClient(gateway,token);
 const query=(tenant:string,id='')=>{const q=new URLSearchParams();if(tenant)q.set('tenant',tenant);if(id)q.set('id',id);return q.size?'?'+q:'';};
 function denied(error:unknown){
  if((error as {status?:number}).status!==401)return false;
  try{sessionStorage.removeItem('primecare_session');}catch{fail(new ScreenConfigurationError('Session storage is unavailable'));return true;}
  teardown();root.replaceChildren();try{location.assign('/login?enable-semantics=true');}catch(error){showScreenConfigurationError(root,error);}return true;
 }
 function bindLinks(active:()=>boolean){root.querySelectorAll<HTMLAnchorElement>('a').forEach(link=>link.onclick=event=>{
  if(!active()||busy||dialogs.size)event.preventDefault();
  // A canceled click is not route departure. Actual departure retires the owner.
 });}
 function errorState(error:unknown){
  if(!current())return;closeDialogs();data=undefined;generation++;
  root.innerHTML=`<main class="business-plans"><h1>Business plans</h1><p role="alert">${esc((error as Error).message)}</p><button data-retry>Retry</button><a href="/platform/administration">Administration</a></main>`;
  ownedNodes=Array.from(root.childNodes);const drawn=generation,active=()=>drawn===generation&&current();bindLinks(active);
  root.querySelector('[data-retry]')!.addEventListener('click',()=>{if(active()&&!busy&&!loading)void load();});
 }
 async function load(operation?:PlanningDialog){
  if(!current())return false;
  const version=++epoch,requestedScope=scope,requestedSelection=selected;loading=true;
  try{
   const next=await client.call(query(requestedScope,requestedSelection));await whenActive();
   if(!current()||version!==epoch||operation&&!operation.open())return false;
   if(!next.identity||typeof next.identity.tenantId!=='string'||typeof next.identity.role!=='string'||!['cycles','scopes','notices','templates','members','audit','lessons'].every(key=>Array.isArray(next[key])))throw Error('Business planning is unavailable. Refresh to confirm saved data.');
   const prepared=presentation(next,requestedSelection);
   data=next;scope=next.identity.tenantId;
   // A successful read can still be a same-version replica. Keep its accepted
   // command receipt until the server proves that command's state advanced.
   for(const [key,receipt] of receipts){
    if(receipt.tenant!==next.identity.tenantId)continue;const body=receipt.body;
    if(body.action==='create'&&typeof receipt.result?.id==='string'&&next.cycles.some((cycle:any)=>cycle.id===receipt.result.id)
      ||body.id&&next.cycles.some((cycle:any)=>cycle.id===body.id&&Number.isSafeInteger(cycle.version)&&Number.isSafeInteger(body.version)&&cycle.version>body.version)
      ||body.action==='lesson'&&next.lessons.some((item:any)=>item.cycle_id===body.id&&!receipt.lessonIds.has(item.id)
       &&['title','kind','sampleSize','observation','evidence','limitations'].every(field=>String(item.data?.[field])===String(body.value[field]).trim().slice(0,field==='title'?200:2000))
       &&receipt.lessonPatch!==undefined&&canonical(item.data?.patch)===canonical(receipt.lessonPatch))
      ||body.action==='acknowledge'&&!next.notices.some((item:any)=>item.id===body.value.id&&!item.read)
      ||body.action==='reviewLesson'&&!next.lessons.some((item:any)=>item.id===body.value.id&&item.status==='pending'))receipts.delete(key);
   }
   draw(prepared);return true;
  }catch(error){
   await whenActive();if(!current()||version!==epoch)return false;
   // A current forbidden read revokes the old visible authority even if its
   // submitting dialog was dismissed while the refresh was pending.
   if((error as {status?:number}).status===403){errorState(error);return false;}
   if(operation&&!operation.open())return false;
   if(denied(error))return false;
   if(operation)throw error;
   errorState(error);return false;
  }finally{if(version===epoch)loading=false;}
 }
 async function save(body:any){
  const operation=activeDialog;
  if(!current()||busy||loading||operation&&!operation.open())return false;
  const tenant=data.identity.tenantId,key=operation?.key??JSON.stringify([tenant,body]),values=operation?.values??{},lessonIds=new Set<string>(data.lessons.map((item:any)=>item.id));
  busy=true;epoch++;
  const controls=Array.from(root.querySelectorAll<HTMLButtonElement|HTMLSelectElement>('button,select'));
  const disabled=controls.map(control=>control.disabled);controls.forEach(control=>control.disabled=true);
  try{
   let receipt=receipts.get(key);
   if(!receipt){
    let lessonPatch:unknown;
    if(body.action==='lesson')try{const plan=data.cycles.find((cycle:any)=>cycle.id===body.id).data;lessonPatch=normalizePatch({[plan.flow]:plan.growth.templateSpec},plan.flow,body.value.patch);}catch{/* The server still owns input validation; unknown reflection retains the receipt. */}
    const result=await client.call(query(tenant),body);receipt={tenant,body,result,lessonIds,lessonPatch,values};receipts.set(key,receipt);
   }
   await whenActive();if(!current()||operation&&!operation.open())return false;
   if(typeof receipt.result?.id==='string')selected=receipt.result.id;
   scope=tenant;notice='Saved to the project database.';
   return await load(operation);
  }catch(error){
   await whenActive();if(!current()||operation&&!operation.open())return false;
   if(denied(error))return false;
   if(operation)throw error;
   notice=(error as Error).message;draw();return false;
  }finally{
   busy=false;
   if(current())controls.forEach((control,i)=>{if(control.isConnected&&root.contains(control))control.disabled=disabled[i];});
  }
 }
 function dialog(title:string,content:string,submit:(v:any)=>Promise<boolean>){
  if(!current()||loading||busy||dialogs.size)return;
  const drawn=generation,opener=root.ownerDocument.activeElement;
  const active=()=>drawn===generation&&current(),el=document.createElement('dialog');
  el.className='bp-dialog';el.innerHTML=`<form><header><h2>${esc(title)}</h2><button type="button" data-close aria-label="Close">×</button></header><p class="bp-error" role="alert"></p>${content}<footer><button type="button" data-close>Cancel</button><button type="submit" class="primary">Save</button></footer></form>`;
  document.body.append(el);dialogs.add(el);el.showModal();
  const form=el.querySelector('form')!,button=el.querySelector<HTMLButtonElement>('button[type=submit]')!;
  const operation:PlanningDialog={key:commandKey,values:{},open:()=>active()&&dialogs.has(el)&&el.isConnected&&el.open&&el.contains(form)};
  activeDialog=operation;
  const fields=Array.from(el.querySelectorAll<HTMLInputElement|HTMLSelectElement|HTMLTextAreaElement>('input,select,textarea'));
  function syncReceipt(){const receipt=receipts.get(operation.key);if(receipt){for(const field of fields){const name=field.getAttribute('name')!;if(name in receipt.values){if(field instanceof HTMLInputElement&&field.type==='checkbox')field.checked=receipt.values[name]==='on';else field.value=String(receipt.values[name]);}field.disabled=true;}}}
  syncReceipt();
  const remove=()=>{dialogs.delete(el);el.remove();if(activeDialog===operation)activeDialog=undefined;if(active()&&opener instanceof HTMLElement&&opener.isConnected)opener.focus();};
  el.addEventListener('close',remove);el.addEventListener('cancel',event=>{event.preventDefault();el.close();});
  el.querySelectorAll('[data-close]').forEach(control=>control.addEventListener('click',()=>{if(operation.open())el.close();}));
  form.onsubmit=async event=>{
   event.preventDefault();if(!operation.open()||busy||loading)return;
   operation.values=Object.fromEntries(new FormData(form));button.disabled=true;
   const disabled=fields.map(field=>field.disabled);fields.forEach(field=>field.disabled=true);
   try{
    const receipt=receipts.get(operation.key),saved=await (receipt?save(receipt.body):submit(operation.values));
    if(saved){el.close();el.remove();}
   }catch(error){if(operation.open())el.querySelector('[role=alert]')!.textContent=(error as Error).message;}
   finally{if(operation.open()){fields.forEach((field,i)=>field.disabled=disabled[i]);syncReceipt();button.disabled=false;}}
  };
 }
 function presentation(data:any,selected:string){const cycle=data.cycles.find((x:any)=>x.id===selected),d=cycle?.data,manager=data.canManage;return {home:'/dashboard',role:data.identity.role,navigation:`${manager?'<a href="/platform/administration">Administration</a>':''}<a href="/growth">Growth dashboard</a><a href="/business-plans" aria-current="page">Business plans</a><a href="/success">Account</a>`,controls:'<button data-refresh>Refresh</button>',mainAttributes:'class="business-plans"',content:`<div class="bp-heading"><div><p class="eyebrow">PRIMECARE · BUSINESS EXECUTION</p><h1>Turn the plan into progress.</h1><p>Plan → assign → deliver evidence → review → recover → learn → next six months.</p></div>${manager?'<button class="primary" data-create>Create a six-month plan</button>':''}</div><p role="status">${esc(notice)}</p>${data.scopes.length?select('scope','Organization',data.scopes.map((x:any)=>({id:x.id,label:x.name})),data.identity.tenantId):`<p>Organization scope: ${esc(data.identity.organization||data.identity.tenantId)}</p>`}<section class="bp-notices" aria-label="Business planning notices">${data.notices.filter((n:any)=>!n.read).map((n:any)=>`<article><strong>${esc(n.title)}</strong><p>${esc(n.message)}</p><button data-ack="${n.id}">Mark read</button></article>`).join('')}</section>${!d?`<h2>${manager?'Choose your business stage':'Your assigned plans'}</h2>${manager?`<div class="bp-grid">${FAMILIES.map(f=>`<article class="bp-card"><span>180-day cycle</span><h3>${esc(f.name)}</h3><p>Verify the baseline, allocate real people, test improvements, then review the evidence.</p><button data-family="${f.key}">Use this template</button></article>`).join('')}</div>`:''}<h2>Saved plans</h2><p>Up to 100 latest plans in this organization. No achievement is copied from a template.</p><div class="bp-grid">${data.cycles.map((c:any)=>`<article class="bp-card"><small>${esc(c.data.code)} · v${c.version}</small><h3>${esc(c.name)}</h3><p>${esc(c.data.growth?.familyName||'Assigned business work')} · ${esc(c.data.start||'Start date not set')}</p><strong>${c.summary.percentComplete}% tasks accepted</strong><p>${c.summary.overdue} overdue · ${c.summary.blocked} blocked · ${c.summary.pendingReview} awaiting review</p><button data-open="${c.id}">Open plan</button></article>`).join('')||'<p>No plans yet. A manager can create the first plan.</p>'}</div>`:`<button data-back>← All plans and templates</button><section class="bp-card"><small>${esc(d.code)} · template v${d.templateOrigin?.version} · ${esc(d.flow)} flow</small><h2>${esc(d.name)}</h2><p>${esc(d.organization)} · ${esc(d.start||'Unscheduled')} — ${esc(d.end||'180 days after your chosen start')}</p><p><strong>${cycle.summary.percentComplete}% tasks accepted</strong> · ${cycle.summary.overdue} overdue · ${cycle.summary.missedGoals} missed targets · ${cycle.summary.pendingReview} awaiting review · ${cycle.summary.openRecovery} recovery plans</p><progress value="${cycle.summary.percentComplete}" max="100"></progress><p>Task completion measures delivery. Business success requires measured outcomes.</p>${manager?`<div class="bp-actions"><button data-action="schedule">Set start / reschedule</button><button data-action="decision">Plan ${esc(d.plan)} · review decision</button><button data-action="next">Create next cycle</button><button data-action="learning">Submit learning</button><button data-action="${d.archived?'reopen':'archive'}">${d.archived?'Reopen':'Archive'}</button></div><p><strong>Baseline:</strong> ${esc(d.tenantContext?.baseline)}<br><strong>Capacity:</strong> ${esc(d.tenantContext?.capacity)}</p>${d.previousCycle?`<details><summary>Previous cycle baseline</summary>${d.previousCycle.goals.map((g:any)=>`<p>${esc(g.title)}: ${esc(g.actual)} / ${esc(g.target)} · ${g.hasEvidence?'recorded evidence':'unverified'}</p>`).join('')}</details>`:''}`:''}</section>${manager&&d.growth?`<details class="bp-card"><summary>Strategy, phases and weekly review guide</summary><p>${esc(d.growth.templateSpec.summary)}</p><h3>Six-month phases</h3>${d.growth.templateSpec.phases.map((p:any)=>`<p>Days ${p.startDay}–${p.endDay}: ${esc(p.name)}</p>`).join('')}<h3>Weekly execution rhythm</h3>${d.growth.templateSpec.weeklyRhythm.map((x:string)=>`<p>${esc(x)}</p>`).join('')}<h3>Finance and capacity</h3>${d.growth.templateSpec.finance.map((x:string)=>`<p>${esc(x)}</p>`).join('')}<h3>Plans A, B and C</h3>${d.growth.templateSpec.fallbacks.map((x:string)=>`<p>${esc(x)}</p>`).join('')}<h3>Planning references</h3>${d.growth.sources.map((x:string[])=>`<p><a href="${esc(x[1])}" target="_blank" rel="noopener noreferrer">${esc(x[0])}</a> · ${esc(x[2])}</p>`).join('')}<p>${esc(d.growth.disclaimer)}</p></details>`:''}<h2>Targets and achievements</h2><div class="bp-grid">${d.goals.map((g:any)=>`<article class="bp-card"><small>${esc(g.code)}</small><h3>${esc(g.title)}</h3><p><strong>${esc(g.actual)} / ${esc(g.target)}</strong> ${esc(g.unit)}</p><p>Due ${esc(g.due||'Day '+g.dueDay)}</p><p>${esc(g.achievementDefinition)}</p>${manager?`<button data-goal="${g.id}">Record result</button><button data-target="${g.id}">Adapt target</button><button data-recovery="${g.id}" data-kind="goal">Create recovery plan</button>`:''}</article>`).join('')}</div><h2>Detailed task list</h2>${d.tasks.map((t:any)=>`<details class="bp-card" ${t.submission?.status==='pending'?'open':''}><summary><strong>${esc(t.code)} · ${esc(t.title)}</strong> — ${esc(t.status)} ${t.submission?.status==='pending'?'· AWAITING REVIEW':''}</summary><p>${esc(t.description)}</p><p><strong>Deliverable:</strong> ${esc(t.deliverable)}</p><p><strong>Acceptance:</strong> ${esc(t.acceptance)}</p><p><strong>Owner:</strong> ${esc(t.owner)} · <strong>Manager:</strong> ${esc(t.manager)}<br><strong>Due:</strong> ${esc(t.due||'Day '+t.dueDay)} · <strong>Depends on:</strong> ${esc(t.dependencies||'None')}</p>${t.evidence?`<p>Evidence: ${esc(t.evidence)}</p>`:''}${t.submission?`<p>Submission: ${esc(t.submission.status)} · ${esc(t.submission.evidence)} · ${esc(t.submission.reason||'')}</p>`:''}<div class="bp-actions">${manager?`<button data-assign="${t.id}">Assign person</button>`:''}${t.status!=='done'?`<button data-update="${t.id}">Update / report blocker</button>${t.submission?.status==='pending'?'':`<button data-submit="${t.id}">Submit evidence</button>`}`:''}${manager&&t.submission?.status==='pending'?`<button data-review="${t.id}">Review submission</button>`:''}${manager?`<button data-recovery="${t.id}" data-kind="task">Create recovery plan</button>`:''}</div></details>`).join('')}${manager?`<h2>Readiness checks</h2><div class="bp-grid">${d.checks.map((c:any)=>`<article class="bp-card"><h3>${esc(c.label)}</h3><p>${esc(c.status)} · ${esc(c.evidence)}</p><button data-check="${c.id}">Record test result</button></article>`).join('')}</div><h2>Corrective development plans</h2>${d.developmentPlans.map((p:any)=>`<article class="bp-card"><h3>${esc(p.code)} · ${esc(p.sourceCode)}</h3><p>${esc(p.rootCause)} · ${esc(p.strategy)}</p><p>${esc(p.start)} — ${esc(p.end)} · ${esc(p.status)}</p><p>Owner ${esc(p.owner)} · target ${esc(p.target)} ${esc(p.unit)}</p>${p.status==='open'?`<button data-recovery-review="${p.id}">Review recovery</button>`:''}</article>`).join('')||'<p>No corrective plans. Review overdue or blocked work weekly.</p>'}<details class="bp-card"><summary>Independent audit history</summary>${data.audit.map((a:any)=>`<p>${esc(a.created_at)} · ${esc(a.actor_id)} · ${esc(a.action)}<br>${esc(JSON.stringify(a.detail))}</p>`).join('')}</details>`:''}`}${manager?`<h2>Learning and template review</h2><p>Submit observations without patient information. Publishing a revised template does not prove it improves outcomes. Existing plans keep their pinned version.</p>${data.lessons.map((l:any)=>`<article class="bp-card"><h3>${esc(l.data.title)}</h3><p>${esc(l.status)} · ${esc(l.data.kind)} · sample ${esc(l.data.sampleSize)}</p><p>${esc(l.data.observation)}</p><p>Evidence: ${esc(l.data.evidence)}<br>Limitations: ${esc(l.data.limitations)}</p><details><summary>Proposed changes</summary><pre>${esc(JSON.stringify(l.data.patch,null,2))}</pre></details>${data.canPublish&&l.status==='pending'?`<button data-lesson-review="${l.id}">Review and publish / reject</button>`:''}</article>`).join('')||'<p>No learning submitted yet.</p>'}`:''}`};}
 function draw(prepared?:Parameters<typeof renderShell>[1]){if(!current())return;const options=prepared??presentation(data,selected),drawn=++generation,active=()=>drawn===generation&&current();const cycle=data.cycles.find((x:any)=>x.id===selected),d=cycle?.data,manager=data.canManage;
 renderShell(root,options);
 ownedNodes=Array.from(root.childNodes);bindLinks(active);
 bindShell(root,'Business plans','en','Business execution and evidence review',()=>[]);root.querySelector<HTMLButtonElement>('[data-refresh]')!.onclick=()=>{if(active()&&!busy&&!dialogs.size)void load();};const scopeControl=root.querySelector<HTMLSelectElement>('[name=scope]');if(scopeControl)scopeControl.onchange=()=>{if(!active())return;if(busy||dialogs.size){scopeControl.value=data.identity.tenantId;return;}scope=scopeControl.value;selected='';void load();};
 const on=(sel:string,fn:(b:HTMLButtonElement)=>void)=>root.querySelectorAll<HTMLButtonElement>(sel).forEach(b=>b.onclick=()=>{
  if(!active()||busy||dialogs.size||!b.isConnected||!root.contains(b)||loading&&!['[data-open]','[data-back]'].includes(sel))return;
  commandKey=JSON.stringify([data.identity.tenantId,...(['[data-create]','[data-family]','[data-lesson-review]'].includes(sel)?[]:[cycle?.id??'',cycle?.version??null]),sel,b.getAttribute(sel.slice(1,-1)),b.getAttribute('data-kind')]);fn(b);
 });
 on('[data-open]',b=>{selected=b.dataset.open!;void load();});on('[data-back]',()=>{selected='';void load();});on('[data-ack]',b=>void save({action:'acknowledge',value:{id:b.dataset.ack}}));
 function create(family='startup',previous=''){const choices=data.templates.filter((t:any)=>t.family===family&&(t.flow==='tenant'||['code_admin','platform_admin','central_admin','ceo'].includes(data.identity.role)));dialog(previous?'Start the next six months':'Create a six-month plan',select('templateId','Flow and template version',choices.map((t:any)=>({id:t.id,label:`${t.flow} · ${t.name} · v${t.version}`})))+field('name','Plan name')+area('baseline','Current baseline and source references')+area('capacity','Available people, funding, service scope and safe capacity')+select('previousCycleId','Previous cycle baseline (optional)',[{id:'',label:'Fresh plan'},...data.cycles.map((c:any)=>({id:c.id,label:c.name}))],previous)+'<p>Dates remain unset until you choose a start. Targets and proposed roles need local review.</p>',v=>save({action:'create',value:v}));}
 on('[data-create]',()=>create());on('[data-family]',b=>create(b.dataset.family));
 on('[data-lesson-review]',b=>dialog('Review template learning',select('decision','Decision',['reject','publish'])+area('reason','Review rationale and limitations')+'<label><input type="checkbox" name="attested" required> I reviewed the proposed changes and evidence. This is not proof of improved results.</label>',v=>save({action:'reviewLesson',value:{...v,id:b.dataset.lessonReview,attested:v.attested==='on'}})));
 if(!d)return;const mutate=(action:string,value:any)=>save({id:cycle.id,version:cycle.version,action,value});
 on('[data-action]',b=>{const a=b.dataset.action;if(a==='next'){create(d.growth?.family||'startup',cycle.id);return;}if(a==='schedule')dialog('Confirm baseline and set start date',field('start','Start date',d.start||'','date')+area('reason','Reason for starting or moving dates')+'<label><input type="checkbox" name="confirmed" required> I reviewed the baseline, capacity and planning assumptions.</label>',v=>mutate('rescheduleGrowth',{...v,baselineConfirmed:v.confirmed==='on'}));else if(a==='decision')dialog('Review business decision',select('plan','Decision',['HOLD','A','B','C'],d.plan)+area('reason','Decision, evidence and next review'),v=>mutate('plan',v));else if(a==='archive'||a==='reopen')dialog(a==='archive'?'Archive plan':'Reopen plan',area('reason','Reason'),v=>mutate(a,v));else if(a==='learning'){const spec=d.growth.templateSpec;dialog('Propose a template improvement',field('title','Learning title')+select('kind','Evidence category',['hypothesis','development_test','business_outcome'])+field('sampleSize','Sample size','0','number')+area('observation','What happened?')+area('evidence','Evidence reference (no patient data)')+area('limitations','Limitations and uncertainty')+select('taskKey','Task to improve',spec.tasks.map((t:any)=>({id:t.key,label:t.title})))+area('change','Additional instruction to add to this task'),v=>{const original=spec.tasks.find((t:any)=>t.key===v.taskKey);return mutate('lesson',{...v,sampleSize:Number(v.sampleSize),patch:{tasks:[{...original,description:original.description+' '+v.change}]}});});}});
 on('[data-goal]',b=>{const g=d.goals.find((x:any)=>x.id===b.dataset.goal);dialog('Record verified business result',field('actual','Current cumulative actual',String(g.actual),'number')+area('evidence','Evidence and measurement source')+area('next','Next action',g.next),v=>mutate('progress',{...v,id:g.id}));});
 on('[data-target]',b=>{const g=d.goals.find((x:any)=>x.id===b.dataset.target);dialog('Adapt an unmeasured planning target',field('target','Target',String(g.target),'number')+area('reason','Baseline evidence and reason')+(d.start?field('due','Due date',g.due,'date'):field('dueDay','Due day (1–180)',String(g.dueDay),'number')),v=>mutate('editGoal',{...g,...v}));});
 on('[data-assign]',b=>dialog('Assign an active team member',select('userId','Person in this organization',data.members.map((m:any)=>({id:m.id,label:m.email+' · '+m.roles}))),v=>mutate('assign',{...v,id:b.dataset.assign})));
 on('[data-update]',b=>dialog('Update work or report a blocker',select('status','Status',['open','in_progress','blocked'])+area('reason','What changed?')+area('blocker','Blocker','',false)+area('recovery','Recovery action (required when blocked)','',false)+field('review','Next review date','','date',false)+area('evidence','Evidence reference','',false),v=>mutate('taskUpdate',{...v,id:b.dataset.update})));
 on('[data-submit]',b=>dialog('Submit work for manager review',area('evidence','Deliverable and evidence reference'),v=>mutate('submitTask',{...v,id:b.dataset.submit})));
 on('[data-review]',b=>dialog('Review submitted work',select('decision','Decision',['accept','revise'])+area('reason','Acceptance evidence or required changes')+field('actual','Task output actual if a task target exists','0','number'),v=>mutate('reviewTask',{...v,id:b.dataset.review})));
 on('[data-check]',b=>dialog('Record a readiness test',select('status','Test result',['unknown','working','failed','degraded'])+area('evidence','Test reference, date and observed outcome'),v=>mutate('check',{...v,id:b.dataset.check})));
 on('[data-recovery]',b=>dialog('Create a time-bound recovery plan',select('teamCode','Responsible team',d.teams.map((t:any)=>({id:t.code,label:t.name})))+field('owner','Named accountable owner')+field('manager','Reviewing manager')+field('start','Recovery start','','date')+select('duration','Recovery days',['7','14','21','30'])+field('target','Measurable recovery target','','number')+field('unit','Target unit')+area('reason','Why is recovery needed?')+area('rootCause','Root cause and evidence')+area('resources','Resources and support')+area('strategy','Corrective strategy')+area('success','Success and acceptance criteria'),v=>mutate('developmentPlan',{...v,sourceType:b.dataset.kind,sourceId:b.dataset.recovery})));
 on('[data-recovery-review]',b=>dialog('Review corrective plan',select('decision','Decision',['revise','reassign','hold','closed'])+area('evidence','Review evidence')+area('next','Next action'),v=>mutate('reviewDevelopment',{...v,id:b.dataset.recoveryReview,reviewer:data.identity.userId})));
 }
 root.innerHTML='<main class="business-plans" role="status">Loading business plans from the project database…</main>';ownedNodes=Array.from(root.childNodes);await load();
}
