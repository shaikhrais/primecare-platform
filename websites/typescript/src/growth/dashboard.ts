import {growthOwner,guardGrowthBindings} from './ownership';
import {growthScope,growthReflected,validateGrowth,validateGrowthReport,type GrowthReceipt} from './recovery';
import {bindMarketingStatement} from './marketing-statement';
import lookRegistry from '../../../../packages/shared/src/look/registry.json';
import {businessView,bindBusiness} from './business';
import {alertsView,performanceView,bindPerformance} from './reporting';
import {intakeView,bindIntake} from './intake';
import {taskControls,bindTasks} from './tasks';
import {hero,icon,marketingImage,sectionNavigation,bindSectionNavigation} from './visuals';
import {briefsView,bindBriefs} from './briefs';
import {searchView,contactView,duplicatesView,bindContacts} from './contacts';
import {operationsView,bindOperations} from './operations';
import {registry,stages,type Pipeline} from '../../../../packages/shared/src/growth/contract';
import {renderShell,bindShell} from '../shell';
import {GrowthClient} from './client';
import {esc,growthForms,formValues,due,money,type T} from './forms';
export async function renderGrowth(root:HTMLElement,gateway:string){
 const owner=growthOwner(root);if(!owner.current())return;if(!owner.token){owner.redirect();return;}
 const transport=new GrowthClient(gateway,owner.token,true),receipts=new Map<string,GrowthReceipt>();
 let command='',operation:{key:string;control:string;drafts:Map<string,Record<string,string>>}|undefined,loading=false;
 const client=transport;let report:any=null,reportPeriod:any=null,marketingStatement:any=null,marketingMonth:string|undefined=undefined;let data:any,locale:'en'|'fr'|'es'=document.documentElement.lang==='fr'?'fr':document.documentElement.lang==='es'?'es':'en',offset=0,filters:Record<string,string>={},notice='',busy=false,readVersion=0;
 const t:T=key=>esc((registry.locales as Record<string,Record<string,string>>)[locale][key]??registry.locales.en[key as keyof typeof registry.locales.en]??key);
 const moneyText=(n:unknown)=>new Intl.NumberFormat(locale,{style:'currency',currency:'CAD'}).format(Number(n)/100);
 const metric=(label:string,value:unknown,glyph:'people'|'clock'|'wallet',id:string)=>`<article class="metric growth-metric"><span class="growth-metric-icon">${icon(glyph,'metric-'+id)}</span><div><span>${label}</span><strong>${esc(value)}</strong></div></article>`;
 const drafts=()=>{const saved=new Map([...root.querySelectorAll<HTMLFormElement>('form[data-cy]')].map(f=>[f.dataset.cy!,{...formValues(f),...Object.fromEntries([...f.querySelectorAll<HTMLInputElement>('input[type=checkbox][name]')].map(e=>[e.name,e.checked?'true':'false']))}]));
  for(const prefix of registry.draftPolicy.rowFieldPrefixes)for(const field of root.querySelectorAll<HTMLInputElement|HTMLSelectElement>(`[data-cy^="${prefix}"]`)){if(field.disabled)continue;const baseline=(field.closest<HTMLElement>('[data-lead-draft-baseline],[data-campaign-draft-baseline]')?.dataset.leadDraftBaseline??field.closest<HTMLElement>('[data-campaign-draft-baseline]')?.dataset.campaignDraftBaseline);if(baseline)saved.set('@row:'+field.dataset.cy,{value:field.value,baseline});}return saved;};
 const restore=(saved:Map<string,Record<string,string>>)=>{for(const [id,values] of saved){if(id.startsWith('@field:')){const field=[...root.querySelectorAll<HTMLInputElement>('[data-cy]')].find(node=>node.dataset.cy===id.slice(7));if(field){field.value=values.value;if(field.type==='checkbox')field.checked=values.checked==='true';}continue;}if(id.startsWith('@row:')){const field=root.querySelector<HTMLInputElement|HTMLSelectElement>(`[data-cy="${id.slice(5)}"]`);if(field&&!field.disabled&&(field.closest<HTMLElement>('[data-lead-draft-baseline],[data-campaign-draft-baseline]')?.dataset.leadDraftBaseline??field.closest<HTMLElement>('[data-campaign-draft-baseline]')?.dataset.campaignDraftBaseline)===values.baseline){if(!(field instanceof HTMLSelectElement)||Array.from(field.options).some(o=>o.value===values.value))field.value=values.value;}continue;}const f=root.querySelector<HTMLFormElement>(`[data-cy="${id}"]`);if(f)for(const [name,value] of Object.entries(values)){const input=f.elements.namedItem(name) as HTMLInputElement|null;if(input){if(input.type==='checkbox')input.checked=value==='true';else input.value=value;}}}};
 const table=(headers:string[],rows:string[])=>`<div class="table-scroll" tabindex="0" role="region" aria-label="${headers.map(h=>t(h)).join(', ')}"><table><thead><tr>${headers.map(h=>`<th scope="col">${t(h)}</th>`).join('')}</tr></thead><tbody>${rows.join('')||`<tr><td colspan="${headers.length}">${t('empty')}</td></tr>`}</tbody></table></div>`;
 const draw=(prepared:()=>void=()=>{})=>{
  if(!owner.current())return;
  const forms=growthForms(t,data),weak=data.priorities.map((f:any)=>`<li><strong>${t(f.pipeline)}: ${t(f.stage)}</strong><p>${t(f.fix)}</p></li>`);
  const funnel=(pipeline:Pipeline)=>`<section class="section" data-cy="growth-funnel-${pipeline}"><h2>${icon(pipeline==='tenant'?'people':'heart',pipeline)}${t(pipeline)}</h2><div class="growth-flow">${data.funnels[pipeline].map((f:any)=>`<article class="growth-stage ${f.status==='behind'?'growth-behind':''}" data-cy="growth-stage-${pipeline}-${esc(f.stage)}"><h3>${t(f.stage)}</h3><div class="growth-stage-count"><strong>${Number(f.actual)}</strong><span>/ ${Number(f.target)} ${t('target')}</span></div><progress value="${Math.min(Number(f.actual),Number(f.target))}" max="${Math.max(1,Number(f.target))}" aria-label="${t(f.stage)} · ${t('target')}"></progress><p>${t(f.status)}</p><small>${t('expected')}: ${Number(f.expected)}<br>${t('gap')}: ${Number(f.gap)}<br>${t('rate')}: ${f.rate===null?'—':new Intl.NumberFormat(locale,{style:'percent',maximumFractionDigits:0}).format(f.rate)}</small><details><summary>${t('fix')}</summary><p>${t(f.fix)}</p></details></article>`).join('')}</div></section>`;
  const leadRows=data.leads.map((l:any)=>{const next=l.nextStage,closed=l.stage==='lost'||!data.capabilities.editLead;return `<tr data-cy="growth-lead-${esc(l.id)}" data-lead-draft-baseline="${esc(JSON.stringify([data.identity.userId,data.identity.tenantId,l.id,l.version]))}"><th scope="row">${esc(l.name)}<small>${t(l.pipeline)} · ${t(l.stage)}${l.contact_blocked?' · '+t('contact_blocked'):''}</small></th><td>${t(l.source)}<small>${esc(l.reference)}</small></td><td>${esc(l.email)}<small>${esc(l.phone)}</small>${contactView(t,l,data)}</td><td><select data-cy="growth-owner-${esc(l.id)}" aria-label="${t('owner')}"><option value="">${t('unassigned')}</option>${data.owners.map((o:any)=>`<option value="${esc(o.id)}" ${o.id===l.owner_id?'selected':''}>${esc(o.email)}</option>`).join('')}</select><input data-cy="growth-due-${esc(l.id)}" aria-label="${t('due')}" type="datetime-local" value="${l.due_at?esc(new Date(Date.parse(l.due_at)-new Date(l.due_at).getTimezoneOffset()*60000).toISOString().slice(0,16)):''}"></td><td>${closed?'':`<input data-cy="growth-evidence-${esc(l.id)}" aria-label="${t('evidence')}" maxlength="500" placeholder="${t('evidence')}"><button data-cy="growth-assign-${esc(l.id)}" data-lead="${esc(l.id)}" data-stage="${esc(l.stage)}">${t('save')}</button>${next?`<button data-cy="growth-advance-${esc(l.id)}" data-lead="${esc(l.id)}" data-stage="${esc(next)}">${t('advance')}</button>`:''}<button data-cy="growth-close-${esc(l.id)}" data-lead="${esc(l.id)}" data-stage="lost">${t('close')}</button>`}</td></tr>`;});
  const campaignRows=data.campaigns.map((c:any)=>`<tr data-campaign-draft-baseline="${esc(JSON.stringify([data.identity.userId,data.identity.tenantId,c.id,c.version]))}"><th scope="row">${esc(c.name)}<small>${t(c.source)} · ${esc(c.reference)}</small></th><td>${data.capabilities.manageCampaignMoney?`<input data-cy="growth-budget-${esc(c.id)}" aria-label="${t('budget')}" type="number" min="0" max="1000000" step="0.01" value="${Number(c.budget_cents)/100}">`:moneyText(c.budget_cents)}</td><td>${data.capabilities.manageCampaignMoney?`<input data-cy="growth-spend-${esc(c.id)}" aria-label="${t('spend')}" type="number" min="0" max="1000000" step="0.01" value="${Number(c.spend_cents)/100}"><button data-cy="growth-campaign-update-${esc(c.id)}" data-campaign="${esc(c.id)}">${t('save')}</button>`:moneyText(c.spend_cents)}</td><td>${Number(c.leads)}</td><td>${c.cplCents===null?'—':moneyText(c.cplCents)}</td></tr>`);
  const taskRows=data.tasks.map((a:any)=>`<tr><th scope="row">${esc(a.name)}</th><td>${esc(data.owners.find((o:any)=>o.id===a.owner_id)?.email??a.owner_id)}</td><td>${esc(a.due_at)}</td><td>${t(a.status)}<p>${t('task_priority')}: ${t(a.priority)}${a.overdue?' · '+t('overdue'):''}</p></td><td>${a.status==='open'&&data.capabilities.editTask?`<input data-cy="growth-task-evidence-${esc(a.id)}" aria-label="${t('evidence')}" maxlength="500"><button data-cy="growth-complete-${esc(a.id)}" data-task="${esc(a.id)}">${t('complete')}</button>`:esc(a.evidence)}</td></tr>${a.actions.length?`<tr><td colspan="5">${taskControls(t,data,a)}</td></tr>`:''}`);
  const presentation={home:'/dashboard?enable-semantics=true',role:t('role_'+data.identity.role),navigation:`<a href="/business-plans">Business plans &amp; learning</a><a href="/growth?enable-semantics=true" aria-current="page" data-cy="sidebar-item-founder-growth-dashboard">${icon('chart','nav-growth')}${t('nav')}</a>${sectionNavigation(t,data)}${data.canOpenAdmin?`<a href="/platform/administration?enable-semantics=true" data-cy="growth-admin-link">${icon('home','nav-admin')}${t('tenant_console')}</a>`:''}${data.canReviewLook?`<a href="/appearance-review?enable-semantics=true" data-cy="look-nav">${esc(lookRegistry.locales[locale].title)}</a>`:''}<a href="/dashboard?enable-semantics=true" data-cy="growth-back">${icon('home','nav-back')}${t('back')}</a>`,menuLabel:t('nav'),controls:`<label>${t('language')}<select data-cy="growth-language">${['en','fr','es'].map(l=>`<option value="${l}" ${l===locale?'selected':''}>${l.toUpperCase()}</option>`).join('')}</select></label><button data-cy="growth-refresh">${icon('refresh','refresh')}${t('refresh')}</button>`,mainAttributes:'data-cy="screen-founder-growth-dashboard"',content:`${hero(t,data)}<details class="growth-reading"><summary>${t('reported')}</summary><p>${t('targets_note')}</p><p>${t('period_note')}</p></details><div role="status" aria-live="polite" data-cy="growth-notice">${notice?t(notice):''}</div><section class="section" data-cy="growth-summary"><h2>${icon('chart','summary')}${t('summary')}</h2><div class="metric-grid">${metric(t('leads'),data.stats.total,'people','leads')}${metric(t('overdue'),data.stats.overdue,'clock','overdue')}${metric(t('spend'),moneyText(data.spendCents),'wallet','spend')}</div><ul>${weak.join('')||`<li>${t('on_track')}</li>`}</ul></section><div data-cy="growth-funnels">${funnel('tenant')}${funnel('client')}</div><section class="section" data-cy="growth-leads"><h2>${icon('people','leads')}${t('leads')}</h2>${searchView(t,data)}<p>${t('shown')}: ${data.leads.length} / ${data.stats.total}</p>${table(['name','source','email','owner','fix'],leadRows)}<div class="pagination"><button data-cy="growth-prev" ${offset===0?'disabled':''}>←</button><button data-cy="growth-next" ${offset+100>=data.stats.total?'disabled':''}>→</button></div>${data.capabilities.createLead?forms.leads:''}</section><section class="section" data-cy="growth-campaigns"><h2>${icon('campaign','campaigns')}${t('campaigns')}</h2>${marketingImage(t)}<p>${t('shown')}: ${data.campaigns.length} / ${data.campaignTotal}</p>${table(['name','budget','spend','leads','cpl'],campaignRows)}${briefsView(t,data)}${data.capabilities.createCampaign?forms.campaigns:''}<ul>${data.sourcePerformance.map((s:any)=>`<li>${t(s.source)}: ${Number(s.leads)}</li>`).join('')}</ul></section><section class="section" data-cy="growth-tasks"><h2>${icon('check','tasks')}${t('tasks')}</h2><p>${t('task_note')}</p>${table(['description','owner','due','stage','evidence'],taskRows)}${data.capabilities.createTask?forms.tasks:''}</section>${businessView(t,data.business,moneyText,marketingStatement,marketingMonth,locale)}${alertsView(t,data)}${performanceView(t,data,report?.locale===locale?report:null,reportPeriod)}${intakeView(t,data)}${duplicatesView(t,data)}${operationsView(t,data)}<section class="section" data-cy="growth-integrations"><h2>${icon('link','integrations')}${t('integrations')}</h2><p>${t('manual')}</p><p>Google Ads / Facebook: ${t('not_connected')}</p><p>${t('marketing_owner')}</p></section><section class="section" data-cy="growth-operations"><h2>${icon('heart','operations')}${t('operations')}</h2><p>${t('operations_note')}</p></section>${data.canEditPlan?`<section class="section" data-cy="growth-plan">${forms.plan}</section>`:''}`};
  if(!owner.current())return;prepared();
  let shell:Element|null=null;const published=()=>!!shell&&root.contains(shell)&&root.querySelector('.app-shell')===shell;
  if(!owner.commit(()=>{renderShell(root,presentation);shell=root.querySelector('.app-shell');bindShell(root,registry.locales[locale].title,locale,t(data.scopeKey??'scope'),()=>[],data.identity.role+':'+data.identity.userId,registry.visual.theme,undefined,owner.current);return published();},published))return;
  const active=owner.capture(),client=scopedClient(active),mutate=(action:()=>Promise<any>,preserveDrafts=false)=>runMutation(active,action,preserveDrafts);
  root.querySelector('.app-shell')?.classList.add('growth-shell');
  if(!data.capabilities.viewFunnels)root.querySelector('[data-cy="growth-funnels"]')?.remove();
  if(!data.capabilities.viewLeads){root.querySelector('[data-cy="growth-leads"]')?.remove();root.querySelector('[data-cy="growth-summary"]')?.remove();}
  if(!data.capabilities.viewCampaigns)root.querySelector('[data-cy="growth-campaigns"]')?.remove();
  if(!data.capabilities.recordCall)root.querySelector('[data-cy="growth-calls"]')?.remove();
  if(!data.capabilities.createAppointment&&!data.capabilities.editAppointment)root.querySelector('[data-cy="growth-appointments"]')?.remove();
  if(data.scopeKey)root.querySelector('[data-cy="growth-team"]')?.remove();
  if(!data.capabilities.editLead)root.querySelectorAll<HTMLSelectElement|HTMLInputElement>('[data-cy^="growth-owner-"],[data-cy^="growth-due-"]').forEach(e=>e.disabled=true);
  if(!data.capabilities.editCampaign)root.querySelectorAll<HTMLButtonElement>('[data-campaign]').forEach(e=>e.disabled=true);
  bindSectionNavigation(root);
  bindBriefs(root,data,client,mutate);
  bindContacts(root,data,client,mutate,values=>{filters=values;offset=0;void load();});
  bindOperations(root,data,client,mutate);
  if(!active())return;
  root.querySelector<HTMLSelectElement>('[data-cy="growth-language"]')!.onchange=e=>{const values=drafts();locale=(e.target as HTMLSelectElement).value as 'en'|'fr'|'es';draw();restore(values);};
  root.querySelector<HTMLButtonElement>('[data-cy="growth-refresh"]')!.onclick=()=>void load();
  const previous=root.querySelector<HTMLButtonElement>('[data-cy="growth-prev"]'),next=root.querySelector<HTMLButtonElement>('[data-cy="growth-next"]');if(previous)previous.onclick=()=>{offset=Math.max(0,offset-100);void load();};if(next)next.onclick=()=>{offset+=100;void load();};
  if(!data.capabilities.edit)root.querySelectorAll<HTMLButtonElement>('[data-lead],[data-task],[data-campaign]').forEach(b=>b.disabled=true);
  const submit=(id:string,action:(v:Record<string,string>)=>Promise<any>)=>{const f=root.querySelector<HTMLFormElement>(`[data-cy="growth-${id}-form"]`);if(f)f.onsubmit=e=>{e.preventDefault();void mutate(()=>action(formValues(f)));};};
  submit('campaign',v=>client.request('/campaigns','POST',{name:v.name,source:v.source,reference:v.reference,budgetCents:money(v.budget),spendCents:money(v.spend)}));
  submit('lead',v=>client.request('/leads','POST',{pipeline:v.pipeline,name:v.name,email:v.email,phone:v.phone,source:v.source,reference:v.reference,contactBasis:v.contact_basis,campaignId:v.campaignId||null,ownerId:v.ownerId||null,dueAt:due(v.due)}));
  submit('task',v=>client.request('/tasks','POST',{name:v.description,ownerId:v.ownerId,dueAt:due(v.due)}));
  submit('plan',v=>client.request('/plan','PUT',{start:v.start,end:v.end,version:data.plan.version,targets:Object.fromEntries(['tenant','client'].map(p=>[p,(registry.pipelines as Record<string,string[]>)[p].map((_,i)=>Number(v[p+'_'+i]))]))}));
  root.querySelectorAll<HTMLButtonElement>('[data-lead]').forEach(b=>b.onclick=()=>{const l=data.leads.find((l:any)=>l.id===b.dataset.lead),evidence=root.querySelector<HTMLInputElement>(`[data-cy="growth-evidence-${l.id}"]`)!.value;void mutate(()=>client.request('/leads/'+l.id,'PATCH',{stage:b.dataset.stage,version:l.version,ownerId:root.querySelector<HTMLSelectElement>(`[data-cy="growth-owner-${l.id}"]`)!.value||null,dueAt:due(root.querySelector<HTMLInputElement>(`[data-cy="growth-due-${l.id}"]`)!.value),evidence}));});
  root.querySelectorAll<HTMLButtonElement>('[data-campaign]').forEach(b=>b.onclick=()=>{const c=data.campaigns.find((c:any)=>c.id===b.dataset.campaign);void mutate(()=>client.request('/campaigns/'+c.id,'PATCH',{version:c.version,budgetCents:money(root.querySelector<HTMLInputElement>(`[data-cy="growth-budget-${c.id}"]`)!.value),spendCents:money(root.querySelector<HTMLInputElement>(`[data-cy="growth-spend-${c.id}"]`)!.value)}));});
  bindBusiness(root,data.business,client,mutate);
  bindMarketingStatement(root,client,mutate,locale,value=>{if(active())marketingStatement=value;},value=>{if(active())marketingMonth=value;},active,owner.onDispose);
  bindTasks(root,data,client,mutate);
  bindIntake(root,data,client,mutate,t);
  bindPerformance(root,data,client,mutate,locale,value=>{if(active())report=value;},value=>{if(active())reportPeriod=value;},active,owner.onDispose);
  root.querySelectorAll<HTMLButtonElement>('[data-task]').forEach(b=>b.onclick=()=>{const a=data.tasks.find((a:any)=>a.id===b.dataset.task);void mutate(()=>client.request('/tasks/'+a.id,'PATCH',{version:a.version,evidence:root.querySelector<HTMLInputElement>(`[data-cy="growth-task-evidence-${a.id}"]`)!.value}));});
  if(!active())return;
  guardGrowthBindings(root,active,()=>!busy&&!loading,(key,action)=>{command=key;try{if(receipts.has(JSON.stringify([growthScope(data),key])))void mutate(async()=>{});else action();}catch(error){if(active())setNotice(errorKey(error));}finally{command='';}});
  restoreReceipts();setNotice(notice);
 };
 const errorKey=(e:unknown)=>'error_'+(e as Error).message in registry.locales.en?'error_'+(e as Error).message:'error';
 const error=(e:unknown)=>t(errorKey(e));
 function setNotice(key:string){notice=key;const output=root.querySelector('[data-cy="growth-notice"]');if(output)output.textContent=key?((registry.locales as any)[locale][key]??registry.locales.en.error):'';}
 function scopedClient(active:()=>boolean):GrowthClient{
  const check=()=>{if(!active())throw Error('account_changed');};
  return Object.assign(Object.create(transport),{
   async request(path='',method='GET',body?:any){
    check();const op=operation,receipt=method!=='GET'&&op?{scope:growthScope(data),control:op.control,path,method,body:JSON.parse(JSON.stringify(body??null)),result:null,accepted:false,before:data,drafts:op.drafts}:undefined;
    try{
     const result=await transport.request(path,method,body);
     // Retain an acknowledgement before awaiting visibility, but never show it optimistically.
     if(receipt&&op){receipt.result=result;receipt.accepted=true;receipts.set(op.key,receipt);}
     await owner.wait();check();
     return method==='GET'&&/^\/(performance|marketing-statement)\?/.test(path)?validateGrowthReport(result):result;
    }catch(error){
     if(receipt&&op&&!receipt.accepted&&(!(error as any).status||(error as any).status>=500||(error as Error).message==='delivery_uncertain'))receipts.set(op.key,receipt);
     await owner.wait();check();throw error;
    }
   },
   async blob(path:string){check();try{const result=await transport.blob(path);await owner.wait();check();return result;}catch(error){await owner.wait();check();throw error;}},
   resetReportRetry(){if(active()&&![...receipts.values()].some(receipt=>receipt.path==='/performance/email'&&!receipt.accepted))transport.resetReportRetry();},
  });
 }
 function restoreReceipts(){
  for(const receipt of receipts.values()){
   if(receipt.scope!==growthScope(data))continue;
   const control=[...root.querySelectorAll<HTMLElement>('[data-cy]')].find(node=>node.dataset.cy===receipt.control);if(!control)continue;
   restore(receipt.drafts);
   for(const id of receipt.drafts.keys()){const field=[...root.querySelectorAll<HTMLInputElement>('[data-cy]')].find(node=>node.dataset.cy===id.slice(7));if(field)field.disabled=true;}
  }
 }
 async function runMutation(active:()=>boolean,action:()=>Promise<any>,preserveDrafts=false){
  if(!active()||busy||loading||!command)return;
  const values=drafts(),identity=growthScope(data),key=JSON.stringify([identity,command]);
  const control=[...root.querySelectorAll<HTMLElement>('[data-cy]')].find(node=>node.dataset.cy===command),region=control?.tagName==='FORM'?control:control?.closest('tr,li')??control?.parentElement;
  const saved=new Map<string,Record<string,string>>();for(const field of region?.querySelectorAll<HTMLInputElement>('input,select,textarea')??[])if(field.dataset.cy)saved.set('@field:'+field.dataset.cy,{value:field.value,checked:String(field.checked)});
  if(command.startsWith('growth-business-revoke-')){const field=root.querySelector<HTMLInputElement>('[data-cy=growth-business-evidence-onboarding]');if(field)saved.set('@field:'+field.dataset.cy,{value:field.value});}
  operation={key,control:command,drafts:receipts.get(key)?.drafts??saved};busy=true;
  const controls=[...root.querySelectorAll<HTMLButtonElement|HTMLInputElement|HTMLSelectElement|HTMLTextAreaElement>('button,input,select,textarea')],disabled=controls.map(control=>control.disabled);
  try{
   const receipt=receipts.get(key);
   const pending=receipt?(receipt.accepted?Promise.resolve():scopedClient(active).request(receipt.path,receipt.method,receipt.body)):action();
   controls.forEach(control=>control.disabled=true);await pending;
   await owner.wait();if(!active())return;
   notice='';const loaded=await load();
   if(preserveDrafts&&loaded&&identity===growthScope(data)&&owner.current()){restore(values);restoreReceipts();}
  }catch(error){
   await owner.wait();if(!active())return;
   if(owner.denied(error))return;
   if((error as any).status===403){renderError(error);return;}
   setNotice(errorKey(error));restore(values);
  }finally{
   busy=false;operation=undefined;
   if(owner.current()){controls.forEach((control,i)=>{if(root.contains(control))control.disabled=disabled[i];});restoreReceipts();}
  }
 }
 function renderError(error:unknown){
  if(!owner.current())return;data=undefined;report=null;marketingStatement=null;
  renderState(false,`<section role="alert" data-cy="growth-error"><h1>${t('title')}</h1><p>${t(errorKey(error))}</p><button data-cy="growth-retry">${t('refresh')}</button><a data-cy="growth-back" href="/dashboard?enable-semantics=true">${t('back')}</a></section>`);
  const active=owner.capture(),retry=root.querySelector<HTMLButtonElement>('[data-cy="growth-retry"]');if(!retry||!active())return;
  retry.onclick=()=>{if(active()&&!busy&&!loading)void load();};
  guardGrowthBindings(root,active,()=>!busy&&!loading,(_key,action)=>{action();});
 }
 async function load(){
  if(!owner.current())return false;const version=++readVersion;loading=true;
  try{
   const next=await client.list(offset,filters);await owner.wait();if(!owner.current()||version!==readVersion)return false;
   validateGrowth(next);
   if(data&&growthScope(data)!==growthScope(next)){report=null;reportPeriod=null;marketingStatement=null;marketingMonth=undefined;}
   data=next;draw(()=>{
    let recovered=false,emailState='';
    for(const[key,receipt]of receipts){
     // These terminal states come from the original email response, not a guessed
     // delivery-row match. A fresh rendered form requires new explicit confirmation.
     const terminal=receipt.accepted&&receipt.scope===growthScope(next)&&receipt.path==='/performance/email'&&['accepted','not_sent'].includes(receipt.result?.state);
     if(terminal||growthReflected(receipt,next)){receipts.delete(key);recovered=true;if(terminal)emailState='report_'+receipt.result.state;}
    }
    if(emailState)notice=emailState;else if(operation)notice=receipts.has(operation.key)?'error':'saved';else if(recovered)notice='saved';
   });if(!owner.current())return false;
   return true;
  }catch(error){
   await owner.wait();if(!owner.current()||version!==readVersion)return false;
   if(owner.denied(error))return false;
   if(data&&(error as Error).message==='invalid_request'){filters=data.filters??{};setNotice(errorKey(error));return false;}
   renderError(error);return false;
  }finally{if(version===readVersion)loading=false;}
 }
 function renderState(loading:boolean,content:string){
  owner.commit(()=>renderShell(root,{home:'/dashboard?enable-semantics=true',role:'',navigation:'',controls:'',hideChrome:true,mainAttributes:`data-cy="screen-founder-growth-dashboard" aria-busy="${loading}"`,content}));
 }
 renderState(true,`<div role="status" data-cy="growth-loading">${t('loading')}</div>`);await load();
}
