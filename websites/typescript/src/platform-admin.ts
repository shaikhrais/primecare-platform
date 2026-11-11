import {requireScreenManager,showScreenConfigurationError} from '../../../packages/primecare_ui/web/screen-manager';
import {resolveManagedRoute} from './managed-routes';
import {mountAdminSidebarMenu} from './admin-sidebar-menu';
import {matchApprovedAdminTopbar} from './admin-topbar';
import {shellIcon} from './shell-icons';
import {mountDemoCallHistory} from './admin-demo-calls';
import {codeAdminPage,codeAdminNavigation,codeAdminDescription} from './code-admin-layout';
import {mountAdminDashboard} from './admin-dashboard';
import {mountVapiAdmin} from './vapi-admin';
import {mountExternalDialer,canUseExternalCalls} from './external-calls';
import masterTenant from '../../../tools/governance-production/code-admin-root.json';
import {BundleController} from './platform-bundle/controller';
import {signOut} from './auth-client';
import {bundleText} from './platform-bundle/panel';
import {OperationsController} from './tenant-operations/controller';
import {operationsText} from './tenant-operations/panel';
import {TerritoryController} from './territories/controller';
import {territoryText} from './territories/panel';
import {AdminRowDraft} from './admin-row-draft';
import {FormDraft} from './form-draft';
import draftPolicy from '../../../packages/shared/src/admin-form-draft.json';
import {DashboardMediaLook} from './media-look';
import look from '../../../packages/shared/src/look/registry.json';
import daylight from '../../../packages/shared/src/growth/registry.json';
import {onboardingPanel} from './platform-onboarding';
import {trainingPanel,trainingText} from './admin-training';
import {screenTextEditor} from './screen-text-editor';
import {liveScreenText} from './screen-text';
import {accountMarkup,bindAccount} from './account';
import {renderShell,bindShell} from './shell';
import {reportPanel} from './reports';
import hierarchy from '../../../cloudflare/workers/src/admin-hierarchy.json';
import bundledText from '../../../cloudflare/workers/src/screen-text-defaults.json';
const resources=bundledText.platform_administration;
import {escapeHtml} from './workspace';
type Tenant={id:string;slug:string;name:string};
type User={id:string;email:string;roles:string;status:string;canModify:boolean};
type Master={id:string;type:string;code:string;label:string;status:string;version:number};
const adminOwners=new WeakMap<HTMLElement,()=>void>();
export async function renderPlatformAdmin(root:HTMLElement,gateway:string):Promise<void>{
 let canCall=false;let overviewDemoOnly=false;let demoDataset:any=null;let demoPreferenceInitialized=false;
 const callLabel=()=>document.documentElement.lang==='fr'?'Appels':document.documentElement.lang==='es'?'Llamadas':'Calls';

 adminOwners.get(root)?.();
 const manager=requireScreenManager(root);
 let storedToken:string|null;try{storedToken=sessionStorage.getItem('primecare_session');}catch(error){root.replaceChildren();throw error;}if(!storedToken){root.replaceChildren();location.assign('/login');return;}const token:string=storedToken;
 const savedRows=new Set<string>();let discardRows=false;let renderedDraftScope='';let partners:any[]=[];let reports:HTMLElement|null=null;let reportsLocale='';let view='tenants',initialNavigation=true;let dirtyForm=false;const live=liveScreenText(gateway);
 let adminRole='',scope='',canCreateTenant=true,extended=true,canViewTraining=false,growthDashboard=false,canViewReports=false,canViewTerritories=false,canViewOperations=false,canViewBundle=false;let bundle:BundleController|null=null;let operations:OperationsController|null=null;let territories:TerritoryController|null=null;
 let locale:'en'|'fr'|'es'=document.documentElement.lang==='fr'?'fr':document.documentElement.lang==='es'?'es':'en';const text=(key:string)=>((hierarchy.locales[locale] as Record<string,string>)[key==='role'||key==='title'?adminRole:key==='scope'?scope+'_scope':key]??live.text('platform_administration',locale,key,(resources[locale] as Record<string,string>)[key]??key));const label=(key:string)=>escapeHtml(text(key));
 const base=gateway.replace(/\/+$/,'')+'/v1/governance/platform';let tenants:Tenant[]=[],roles:string[]=[],types:string[]=[],users:User[]=[],records:Master[]=[],events:{action:string;created_at:string}[]=[],selected='',actor='',busy=false,denied=false,notice='';
 let disposed=false,stopLive=()=>{},pendingHistory=false,historyTimer:ReturnType<typeof setTimeout>|undefined;
 const dispose=()=>{if(disposed)return;disposed=true;stopLive();operations?.dispose();territories?.dispose();window.removeEventListener('hashchange',onHistory);window.removeEventListener('popstate',onHistory);window.removeEventListener('pagehide',onPageHide);window.removeEventListener('pageshow',onPageShow);root.removeEventListener('input',onInput);if(historyTimer!==undefined)clearTimeout(historyTimer);if(adminOwners.get(root)===dispose)adminOwners.delete(root);};
 adminOwners.set(root,dispose);
 // This is the existing sidebar inventory and its server capability filter, shared by
 // rendering and navigation. A hash never grants access to a hidden destination.
 const navigationItems=()=>[['tenants',canCreateTenant?'create_tenant':'select_tenant'],['tenant-selection','select_tenant'],['launch','launch'],['onboarding','onboarding'],['documents','documents'],['support','support'],['accounts','accounts'],['masters','masters'],['audit','audit'],['reports','reports'],['territories','territories'],['operations','operations'],['bundle','bundle'],['text','screen_text'],['training','training'],['appearance','appearance']].filter(([id])=>(id!=='tenants'||canCreateTenant)&&(id!=='onboarding'||canCreateTenant)&&(id!=='reports'||canViewReports)&&(id!=='territories'||canViewTerritories)&&(id!=='operations'||canViewOperations)&&(!['bundle','launch','documents','support'].includes(id)||canViewBundle)&&(id!=='text'||extended||adminRole==='code_admin')&&(id!=='training'||canViewTraining));
 const navigationPending=()=>busy||bundle?.navigationPending||operations?.navigationPending||territories?.navigationPending;
 const current=()=>{
  if(disposed||adminOwners.get(root)!==dispose)return false;
  if(!root.isConnected||!['/platform/administration','/success'].includes(location.pathname)){dispose();return false;}
  try{if(sessionStorage.getItem('primecare_session')===token)return true;}catch{dispose();root.replaceChildren();return false;}
  dispose();root.replaceChildren();location.reload();return false;
 };
 const requireCurrent=()=>{if(!current()||!enterPresentation())throw Error('Administrator session or presentation changed');};
 let presentationRoute='';
 // Continue the dispatcher's entry scope rather than creating another owner of
 // its platform registration or of the workspace's account registration. These
 // are existing adapters, not governed screens or permission grants.
 const enterPresentation=()=>{
  if(!current())return false;
  // History may already have moved during a mutation. Until reconciliation,
  // the mounted view, not that pending URL, owns presentation and its data.
  const path=initialNavigation?location.pathname:view==='account'?'/success':'/platform/administration';
  const route=resolveManagedRoute(path,'');
  try{
   if(presentationRoute!==path){manager.registerScope('entry',[route]);presentationRoute=path;}
   manager.enter(route.id,route.route);
  }catch(error){if(current()){dispose();showScreenConfigurationError(root,error);}return false;}
  return current();
 };
 const resolveView=(id:string,tenant=selected):string|null=>{
  if(id==='vapi')return adminRole==='code_admin'?id:null;
  if(id==='calls')return canCall||adminRole==='code_admin'&&demoDataset?id:null;
  if(!navigationItems().some(([key])=>key===id))return null;
  return id==='tenant-selection'||['accounts','masters','audit'].includes(id)&&!tenant?'organizations':id;
 };
 const defaultView=()=>canCreateTenant?'tenants':'organizations';
 const hashView=()=>location.pathname==='/success'?'account':location.hash?resolveView(location.hash.slice(1)):defaultView();
 const viewId=()=>view==='organizations'?'tenant-selection':view;
 const navigationUrl=(path:string,hash='')=>{const url=new URL(location.href);url.pathname=path;url.hash=hash;if(locale!=='en'||url.searchParams.has('locale'))url.searchParams.set('locale',locale);url.searchParams.delete('enable-semantics');url.searchParams.set('enable-semantics','true');return url.pathname+url.search+url.hash;};
 const accountUrl=()=>navigationUrl('/success');
 const tabUrl=(id:string)=>navigationUrl('/platform/administration',id);
 const writeHash=(id:string)=>{if(pendingHistory)return;const url=tabUrl(id);if(url!==location.pathname+location.search+location.hash)history.pushState(history.state,'',url);};
 // Check both fulfillment and rejection, then check again at the consuming await.
 // A helper's final check cannot cover its caller's next microtask.
 async function readForCurrent<T>(read:()=>Promise<T>):Promise<T>{
  requireCurrent();try{return await read();}finally{requireCurrent();}
 }
 const request=async(path='',method='GET',body?:Record<string,unknown>)=>{
  requireCurrent();const headers:Record<string,string>={authorization:'Bearer '+token};let pending='';
  if(body){
   headers['content-type']='application/json';
   const digest=await readForCurrent(()=>crypto.subtle.digest('SHA-256',new TextEncoder().encode(JSON.stringify(Object.fromEntries(Object.entries(body).filter(([key])=>key!=='password'))))));requireCurrent();
   const hash=Array.from(new Uint8Array(digest)).map(v=>v.toString(16).padStart(2,'0')).join('');
   pending=`primecare-platform-request:${actor}:${method}:${path}:${hash}`;headers['Idempotency-Key']=sessionStorage.getItem(pending)??crypto.randomUUID();sessionStorage.setItem(pending,headers['Idempotency-Key']);
  }
  const forgetPending=()=>{if(pending&&sessionStorage.getItem(pending)===headers['Idempotency-Key'])sessionStorage.removeItem(pending);};
  const r=await readForCurrent(()=>fetch(base+path,{method,headers,cache:'no-store',...(body?{body:JSON.stringify(body)}:{})}));requireCurrent();
  const data=await readForCurrent(()=>r.json());requireCurrent();
  if(!r.ok){
   if(r.status>=400&&r.status<500)forgetPending();
   if(r.status===401){sessionStorage.removeItem('primecare_session');dispose();root.replaceChildren();location.assign('/login');}
   if(r.status===403)denied=true;
   throw new Error(data.error??'Request failed. Retry the same values after checking the audit.');
  }
  // Keep uncertain mutation identity until the immediate caller accepts success.
  // A stale owner never clears, restores or overwrites a newer owner's retry key.
  return {consume:()=>{requireCurrent();forgetPending();return data;}};
 };
 const jump=async(id:string,tenant?:Tenant|string,before?:()=>void)=>{
  if(!current()||navigationPending()||denied)return false;
  const nextTenant=typeof tenant==='string'?tenant:tenant?.id;
  const next=id==='account'?'account':resolveView(id,nextTenant??selected);if(!next)return false;
  // An explicit, accepted click after work settles supersedes an older queued
  // traversal even if the nested-controller idle timer has not fired yet.
  pendingHistory=false;if(historyTimer!==undefined){clearTimeout(historyTimer);historyTimer=undefined;}
  const changed=next!==view||nextTenant!==undefined&&nextTenant!==selected||!!before;
  if(nextTenant!==undefined&&nextTenant!==selected){if(typeof tenant==='object'&&!tenants.some(t=>t.id===tenant.id))tenants.push(tenant);selected=nextTenant;users=[];records=[];events=[];}
  before?.();view=next;
  if(id==='account'){const url=accountUrl();if(url!==location.pathname+location.search+location.hash)history.pushState(history.state,'',url);}else writeHash(viewId());
  if(!enterPresentation())return false;
  if(id==='calls'&&canCall)mountExternalDialer(gateway,token,true);
  root.querySelector('aside')?.classList.remove('open');root.querySelector('[data-cy=sidebar-toggle]')?.setAttribute('aria-expanded','false');
  if(changed)await action(()=>load());if(!current()||navigationPending())return false;window.scrollTo({top:0});root.querySelector<HTMLElement>('main h1')?.focus({preventScroll:true});return true;
 };
 // Traversal already moved the history index. Never rewrite that entry while
 // work owns the view: keep its tenant stable, then reconcile the latest URL.
 function onHistory(){
  if(!current()||denied)return;
  if(navigationPending()){
   pendingHistory=true;
   // Parent actions reconcile in finally. Nested controllers expose only their
   // existing busy state, so check again while this mounted owner is active.
   if(!busy&&historyTimer===undefined)historyTimer=setTimeout(()=>{historyTimer=undefined;onHistory();},50);
   return;
  }
  pendingHistory=false;if(historyTimer!==undefined){clearTimeout(historyTimer);historyTimer=undefined;}
  const next=hashView()??defaultView();if(next===view){enterPresentation();return;}
  view=next;void action(()=>load());
 }
 function onPageHide(event:PageTransitionEvent){if(!event.persisted)dispose();}
 function onPageShow(event:PageTransitionEvent){if(event.persisted){if(!current())return;dispose();root.replaceChildren();location.reload();return;}onHistory();}
 function onInput(){dirtyForm=true;}
 function draw(){if(!enterPresentation())return;const draftScope=JSON.stringify([actor,selected,view]);const drafts=new Map<string,FormDraft>();
 if(renderedDraftScope===draftScope)for(const form of root.querySelectorAll<HTMLFormElement>('form[data-cy]')){if(!draftPolicy.formTestIds.includes(form.dataset.cy!)&&!draftPolicy.formPrefixes.some(prefix=>form.dataset.cy!.startsWith(prefix)))continue;const draft=new FormDraft();draft.capture(form,draftPolicy.excludeInputTypes);drafts.set(form.dataset.cy!,draft);}
 const rowDraft=new AdminRowDraft();if(renderedDraftScope===draftScope&&!discardRows)rowDraft.capture(root,savedRows);savedRows.clear();discardRows=false;root.querySelectorAll('dialog[data-admin-form-dialog]').forEach(d=>d.remove());
 operations?.dispose();territories?.dispose();renderedDraftScope=draftScope;dirtyForm=false;const media=new DashboardMediaLook(locale);renderShell(root,{home:'/platform/administration',role:label('role'),description:text('purpose'),navigation:codeAdminNavigation(`${adminRole==='code_admin'?`<a href="${escapeHtml(tabUrl('vapi'))}" data-section="vapi" data-cy="platform-nav-vapi">Voice AI · Vapi</a>`:''}${(canCall||adminRole==='code_admin'&&demoDataset)?`<a href="${escapeHtml(tabUrl('calls'))}" data-section="calls" data-cy="platform-nav-calls">${escapeHtml(callLabel())}</a>`:''}${navigationItems().map(([id,key])=>`<a href="${escapeHtml(tabUrl(id))}" ${id===view?'aria-current="page"':''} data-section="${id}" data-cy="platform-nav-${id}">${media.navigationIcon(id)}${key==='bundle'?escapeHtml(bundleText(locale,'nav')):key==='operations'?escapeHtml(operationsText(locale,'nav')):key==='territories'?escapeHtml(territoryText(locale,'nav')):key==='training'?escapeHtml(trainingText(gateway,locale,'nav')):label(key)}</a>`).join('')}${growthDashboard?`<a href="/growth?enable-semantics=true" data-cy="platform-growth-link">${media.navigationIcon('growth')}${label('growth_dashboard')}</a>`:''}<a href="/tenant-dashboard?dataset=demo&enable-semantics=true" data-cy="tenant-dashboard-demo-nav">Tenant dashboard · demo</a><a href="/coordinator-charge?enable-semantics=true" data-cy="coordinator-charge-nav">Coordinator additional charge</a><a href="/psw?dataset=demo&experience=personal" data-cy="psw-personal-nav">PSW personal dashboard · demo</a><a href="/psw?dataset=demo" data-cy="psw-workspace-nav">PSW workspace · database demo</a><a href="/business-plans" data-cy="business-plans-nav">Business plans &amp; learning</a><a data-cy="look-nav" href="/appearance-review?enable-semantics=true">${media.navigationIcon('look')}${escapeHtml(look.locales[locale].title)}</a><a href="${escapeHtml(accountUrl())}" data-section="account">${media.navigationIcon('account')}${label('account')}</a>`,locale),controls:`<label class="topbar-tenant topbar-icon-control" title="${label('select_tenant')}"><span aria-hidden="true">${shellIcon('building')}</span><select aria-label="${label('select_tenant')}" data-cy="platform-topbar-tenant"><option value="">${adminRole==='code_admin'?({en:'All organizations',fr:'Toutes les organisations',es:'Todas las organizaciones'}[locale]):label('choose_tenant')}</option>${tenants.map(t=>`<option value="${escapeHtml(t.id)}" ${selected===t.id?'selected':''}>${escapeHtml(t.name)}</option>`).join('')}</select></label><label class="topbar-icon-control topbar-language" title="${escapeHtml(daylight.locales[locale].language)}"><span aria-hidden="true">${languageFlag(locale,adminRole==='code_admin')}</span><select data-cy="platform-language" aria-label="${escapeHtml(daylight.locales[locale].language)}">${['en','fr','es'].map(l=>`<option value="${l}" ${l===locale?'selected':''}>${({en:"English",fr:"Français",es:"Español"} as Record<string,string>)[l]}</option>`).join('')}</select></label><details class="shell-utilities" data-cy="shell-utilities"><summary aria-label="${{en:"More",fr:"Plus",es:"Más"}[locale]}" title="${{en:"More",fr:"Plus",es:"Más"}[locale]}"><span aria-hidden="true">${shellIcon('user-circle')}${shellIcon('chevron-down')}</span></summary><div class="shell-utility-actions" data-cy="shell-utility-actions"><a href="${escapeHtml(accountUrl())}" data-section="account" data-cy="platform-account-link">${label('account')}</a><a href="/">${label('workspace')}</a><button data-cy="platform-refresh">${label('refresh')}</button><button data-cy="platform-logout">${label('logout')}</button></div></details>`,mainAttributes:`class="code-admin-layout" data-admin-view="${escapeHtml(view)}"`,content:codeAdminPage({title:view==='tenants'?(adminRole==='code_admin'?({en:'Your platform, at a glance.',fr:'Votre plateforme en un coup d’œil.',es:'Tu plataforma, de un vistazo.'}[locale]):({en:'Dashboard',fr:'Tableau de bord',es:'Panel'}[locale])):view==='organizations'?({en:'Organizations',fr:'Organisations',es:'Organizaciones'}[locale]):view==='account'?text('account'):view==='training'?trainingText(gateway,locale,'nav'):view==='vapi'?'Voice AI · Vapi':view==='bundle'?bundleText(locale,'title'):view==='operations'?operationsText(locale,'title'):view==='territories'?territoryText(locale,'title'):view==='calls'?callLabel():view==='launch'?bundleText(locale,'launch'):view==='documents'?bundleText(locale,'documents'):view==='support'?bundleText(locale,'support'):view==='appearance'?({en:'Appearance & language',fr:'Apparence et langue',es:'Apariencia e idioma'}[locale]):text(view),description:codeAdminDescription(view,locale),view,content:`<output role="status" data-cy="platform-status">${escapeHtml(notice)}</output>

${view==='vapi'&&adminRole==='code_admin'?'<div data-cy=platform-vapi></div>':''}
${['bundle','launch','documents','support'].includes(view)?'<div data-cy=platform-bundle></div>':''}
${view==='organizations'?'<div data-cy=admin-organizations></div>':''}
${view==='appearance'?'<section class="section"><h2>Workspace appearance</h2><p>Solid theme, layout, density and language preferences use your existing settings manager.</p><button data-cy=platform-open-appearance>Open appearance settings</button></section>':''}
${view==='operations'?'<div data-cy=platform-operations></div>':''}
${view==='territories'?'<div data-cy=platform-territories></div>':''}
${view==='onboarding'?onboardingPanel(partners,text):''}
${view==='text'?'<section class="section" data-cy="screen-text-editor"></section>':''}
${view==='tenants'?`<div data-cy="admin-dashboard"></div><section class="section guide-welcome"><div><span class="account-eyebrow">NEW TO PRIMECARE?</span><h2>Start with a guided tour</h2><p>Understand your organization, people, services and daily tasks.</p></div><button data-cy="guide-open">Open beginner guide</button></section>${canCreateTenant?`<section id="tenants" class="section"><h2 tabindex="-1">${label('create_tenant')}</h2><form data-cy="platform-tenant-form"><label>${label('name')}<input name="name" required maxlength="150"></label><label>${label('slug')}<input name="slug" required pattern="[a-z][a-z0-9-]{2,62}" maxlength="63"></label><button>${label('create_tenant')}</button></form></section>`:''}<section id="tenant-selection" class="section">${tenants.some(t=>t.slug===masterTenant.slug)?`<p data-cy="master-tenant-hierarchy"><strong>Master tenant: ${escapeHtml(tenants.find(t=>t.slug===masterTenant.slug)!.name)}</strong><br>Other tenants are children of this master. Account and clinical data remain isolated.</p>`:''}<h2 tabindex="-1">${label('select_tenant')}</h2><select data-cy="platform-tenant-select" aria-label="${label('select_tenant')}"><option value="">${label('choose_tenant')}</option>${tenants.map(t=>`<option value="${escapeHtml(t.id)}" ${selected===t.id?'selected':''}>${t.slug===masterTenant.slug?'Master tenant — ':''}${escapeHtml(t.name)} (${escapeHtml(t.slug)})</option>`).join('')}</select><p>${label('limit')}</p></section>`:''}
${view==='accounts'&&selected?`<section id="accounts" class="section"><h2 tabindex="-1">${label('accounts')}</h2><form data-cy="platform-account-form"><label>${label('email')}<input type="email" name="email" required maxlength="254"></label><label>${label('password')}<input type="password" name="password" required minlength="12" maxlength="72" autocomplete="new-password"></label><label>${label('assigned_role')}<select name="role">${roleOptions('admin')}</select></label><button>${label('create_account')}</button></form><div class="table-scroll" tabindex="0" role="region" aria-label="${label('accounts')}"><table data-cy="platform-users"><thead><tr><th>${label('email')}</th><th>${label('assigned_role')}</th><th>${label('status')}</th><th>${label('action')}</th></tr></thead><tbody>${users.map(u=>`<tr data-user="${escapeHtml(u.id)}" data-row-draft="user-${escapeHtml(u.id)}" data-cy="platform-user-${escapeHtml(u.id)}" data-draft-baseline="${escapeHtml(JSON.stringify([u.roles,u.status,u.canModify]))}"><td>${escapeHtml(u.email)}</td><td><select data-role data-cy="platform-user-role-${escapeHtml(u.id)}" aria-label="${label('assigned_role')} · ${escapeHtml(u.email)}" ${u.canModify?'':'disabled data-protected'}>${u.canModify?roleOptions(u.roles):`<option>${escapeHtml(text(u.roles))}</option>`}</select></td><td><select data-status data-cy="platform-user-status-${escapeHtml(u.id)}" aria-label="${label('status')} · ${escapeHtml(u.email)}" ${u.canModify?'':'disabled data-protected'}>${statusOptions(u.status)}</select></td><td><button data-save-user data-cy="platform-user-save-${escapeHtml(u.id)}" ${u.canModify?'':'disabled data-protected'}>${label('save_revoke')}</button></td></tr>`).join('')}</tbody></table></div></section>`:''}
${view==='masters'&&selected?`<section id="masters" class="section"><h2 tabindex="-1">${label('masters')}</h2><p>${label('master_scope')}</p><form data-cy="platform-master-form"><label>${label('type')}<select name="type" data-cy="platform-master-create-type">${types.map(t=>`<option>${escapeHtml(t)}</option>`).join('')}</select></label><label>${label('code')}<input data-cy="platform-master-create-code" name="code" required pattern="[a-z][a-z0-9_-]{1,63}" maxlength="64"></label><label>${label('label')}<input data-cy="platform-master-create-label" name="label" required maxlength="150"></label><button data-cy="platform-master-create-submit">${label('create_master')}</button></form><div class="table-scroll" tabindex="0" role="region" aria-label="${label('masters')}"><table data-cy="platform-masters"><thead><tr><th>${label('type')} / ${label('code')}</th><th>${label('label')}</th><th>${label('status')}</th><th>${label('action')}</th></tr></thead><tbody>${records.map(r=>`<tr data-master="${escapeHtml(r.id)}" data-row-draft="master-${escapeHtml(r.id)}" data-cy="platform-master-${escapeHtml(r.id)}" data-draft-baseline="${escapeHtml(JSON.stringify([r.version,r.label,r.status]))}"><td>${escapeHtml(r.type)} / ${escapeHtml(r.code)}</td><td><input data-label data-cy="platform-master-label-${escapeHtml(r.id)}" aria-label="${label('label')} · ${escapeHtml(r.code)}" value="${escapeHtml(r.label)}" maxlength="150" required></td><td><select data-status data-cy="platform-master-status-${escapeHtml(r.id)}" aria-label="${label('status')} · ${escapeHtml(r.code)}">${statusOptions(r.status)}</select></td><td><button data-save-master data-cy="platform-master-save-${escapeHtml(r.id)}">${label('save')}</button></td></tr>`).join('')}</tbody></table></div></section>`:''}
${view==='calls'?'<div data-cy=platform-demo-calls></div>'+(canCall?'<section data-cy=platform-native-calls><h2>Phone dialer</h2><p>Use the floating phone in the bottom corner. Minimize it to continue working while a call is connected.</p><button type="button" data-cy=platform-open-dialer>Open dialer</button></section>':''):''}
${view==='account'?accountMarkup(label):''}
${view==='audit'&&selected?`<section id="audit" class="section"><h2 tabindex="-1">${label('audit')}</h2><ul data-cy="platform-audit">${events.map(e=>`<li>${escapeHtml(e.action)} · ${escapeHtml(e.created_at)}</li>`).join('')}</ul></section>`:''}
`})});
 if(adminRole==='code_admin'&&demoDataset)root.querySelectorAll<HTMLElement>('#tenants,#tenant-selection').forEach(e=>e.hidden=true);
 if(view==='organizations')root.querySelector('[data-cy=platform-nav-tenant-selection]')?.setAttribute('aria-current','page');
 root.querySelector('.app-shell')?.classList.toggle('approved-code-admin',adminRole==='code_admin');
 if(adminRole==='code_admin'){const brand=root.querySelector('.brand');if(brand)brand.innerHTML='<span class="approved-brand-mark">+</span><span>PrimeCare<small>ADMINISTRATION</small></span>';}
 const demoScope=selected?tenants.find(t=>t.id===selected)?.slug.startsWith('demo-primecare-'):overviewDemoOnly;
 if(demoScope)root.querySelector('[data-cy=code-admin-page-body]')?.insertAdjacentHTML('afterbegin','<div class="approved-demo-banner" data-cy=admin-demo-banner><strong>DEMO workspace</strong> · Database-backed sample records. No sample calls, messages or invitations are sent. Launch and clinical approval are separate.</div>');
 if(['tenants','organizations'].includes(view)){const header=root.querySelector('.code-admin-page-header');header?.insertAdjacentHTML('beforeend','<div class="approved-header-actions"><button type="button" data-cy=admin-open-audit>'+shellIcon('clipboard-check')+'View audit trail</button>'+ (canCreateTenant?'<button type="button" class="primary" data-cy=admin-create-organization>'+shellIcon('building-plus')+'Create organization</button>':'')+'</div>');root.querySelector<HTMLElement>('[data-cy=admin-open-audit]')!.onclick=()=>jump('audit');root.querySelector<HTMLElement>('[data-cy=admin-create-organization]')?.addEventListener('click',async()=>{if(view!=='tenants'&&!await jump('tenants'))return;openForm('[data-cy=platform-tenant-form]',text('create_tenant'));});}
 root.querySelector<HTMLElement>('[data-cy=platform-open-appearance]')?.addEventListener('click',()=>root.querySelector<HTMLElement>('[data-cy=appearance-open]')?.click());
 for(const form of root.querySelectorAll<HTMLFormElement>('form[data-cy]'))drafts.get(form.dataset.cy!)?.restore(form);
 rowDraft.restore(root);
 if(['tenants','organizations'].includes(view))void mountAdminDashboard(root.querySelector<HTMLElement>(view==='tenants'?'[data-cy=admin-dashboard]':'[data-cy=admin-organizations]')!,gateway,token,locale,{tenants,selected,directory:view==='organizations',demoOnly:overviewDemoOnly,canCreate:canCreateTenant,canOperations:canViewOperations,demoCalls:demoDataset?.examples?.calls,demoOrder:demoDataset?.examples?.tenants?.map((t:any)=>demoDataset.tenantIds[t.id]),onNavigate:(destination,tenant)=>{void jump(destination,tenant);},onCreate:()=>openForm('[data-cy=platform-tenant-form]',text('create_tenant')),onDemoChange:value=>{if(!current()||navigationPending())return;overviewDemoOnly=value;draw();}});
 root.querySelector<HTMLButtonElement>('[data-cy=guide-open]')?.addEventListener('click',()=>jump('training'));
 bindAccount(root,gateway,token,text('request_failed'),text('unavailable'));
 root.querySelector<HTMLSelectElement>('[data-cy=platform-language]')!.onchange=e=>{if(!current())return;if(navigationPending()){(e.currentTarget as HTMLSelectElement).value=locale;return;}locale=(e.currentTarget as HTMLSelectElement).value as typeof locale;document.documentElement.lang=locale;draw();};
 if(view==='calls'&&demoDataset?.examples?.calls){const rows=demoDataset.examples.calls.filter((c:any)=>!selected||demoDataset.tenantIds[c.tenant]===selected);mountDemoCallHistory(root.querySelector<HTMLElement>('[data-cy=platform-demo-calls]')!,rows);}
 if(canCall)mountExternalDialer(gateway,token);root.querySelector('[data-cy=platform-open-dialer]')?.addEventListener('click',()=>mountExternalDialer(gateway,token,true));
 if(view==='vapi'&&adminRole==='code_admin')mountVapiAdmin(root.querySelector<HTMLElement>('[data-cy=platform-vapi]')!,gateway,token,locale);
 if(view==='training')root.querySelector('[data-cy=code-admin-page-body]')!.append(trainingPanel(gateway,actor,locale,()=>jump('tenants')));
 if(view==='reports'){if(!reports||reportsLocale!==locale){reports=reportPanel(gateway,'/v1/governance/reports',token,actor,locale);reportsLocale=locale;}reports.id='reports';root.querySelector('[data-cy=code-admin-page-body]')!.append(reports);}
 root.querySelectorAll<HTMLAnchorElement>('[data-section]').forEach(link=>link.onclick=e=>{if(e.defaultPrevented||e.button>0||e.metaKey||e.ctrlKey||e.shiftKey||e.altKey||link.target&&link.target!=='_self'||link.hasAttribute('download'))return;e.preventDefault();root.querySelector<HTMLDetailsElement>('[data-cy=shell-utilities]')?.removeAttribute('open');jump(link.dataset.section!);});
 bindShell(root,view==='bundle'?bundleText(locale,'title'):view==='operations'?operationsText(locale,'title'):view==='territories'?territoryText(locale,'title'):view==='training'?trainingText(gateway,locale,'title'):view==='calls'?callLabel():text(view==='tenants'?'title':view),locale,text('search_scope'),()=>[
 ...Array.from(root.querySelectorAll<HTMLAnchorElement>('[data-section]')).map(a=>({title:a.textContent!,detail:text('task'),open:()=>jump(a.dataset.section!)})),
 ...tenants.map(t=>({title:t.name,detail:t.slug+' · '+text('tenant'),open:()=>{void jump('accounts',t);}})),
 ...users.map(u=>({title:u.email,detail:u.roles+' · '+text('accounts'),open:()=>jump('accounts')})),
 ...records.map(r=>({title:r.label,detail:r.type+' / '+r.code+' · '+text('masters'),open:()=>jump('masters')})),
 ...Array.from(reports?.querySelectorAll<HTMLOptionElement>('[data-cy=report-select] option')??[]).map(o=>({title:o.textContent!,detail:text('reports'),open:async()=>{if(!await jump('reports')||!current())return;const select=reports!.querySelector<HTMLSelectElement>('[data-cy=report-select]')!;select.value=o.value;select.dispatchEvent(new Event('change'));}}))], adminRole+':'+actor,daylight.visual.theme);
 if(adminRole==='code_admin'){matchApprovedAdminTopbar(root,locale,view==='tenants');mountAdminSidebarMenu(root,locale);}
 root.querySelectorAll<HTMLInputElement|HTMLButtonElement|HTMLSelectElement>('input,button,select').forEach(e=>{if(!reports?.contains(e))e.disabled=busy||e.hasAttribute('data-protected');});
 root.querySelector<HTMLButtonElement>('[data-cy=platform-refresh]')!.onclick=()=>void action(async()=>{await load(true);requireCurrent();discardRows=true;});
 root.querySelector<HTMLButtonElement>('[data-cy=platform-logout]')!.onclick=()=>void action(async()=>{try{await readForCurrent(()=>signOut(gateway,token));}catch{requireCurrent();throw new Error(text('unavailable'));}requireCurrent();sessionStorage.removeItem('primecare_session');dispose();root.replaceChildren();location.assign('/login?enable-semantics=true');});
 root.querySelectorAll<HTMLFormElement>('[data-partner]').forEach(form=>form.onsubmit=e=>{e.preventDefault();const p=partners.find(p=>p.id===form.dataset.partner),values=Object.fromEntries(new FormData(form));void action(async()=>{(await request('/onboarding/'+p.id+'/activate','POST',{...values,version:p.version})).consume();form.reset();notice=text('tenant_created');await load(true);});});
 root.querySelectorAll<HTMLSelectElement>('[data-cy=platform-tenant-select],[data-cy=platform-topbar-tenant]').forEach(select=>select.onchange=e=>{if(!current())return;if(navigationPending()){select.value=selected;return;}const tenant=(e.currentTarget as HTMLSelectElement).value;void action(async()=>{selected=tenant;users=[];records=[];events=[];view=hashView()??defaultView();await load();});});
 form('platform-tenant-form',async(values,clear)=>{const data=(await request('/tenants','POST',values)).consume();clear();selected=data.tenant.id;view='accounts';writeHash('accounts');notice=text('tenant_created');await load(true);});
 const editor=root.querySelector<HTMLElement>('[data-cy=screen-text-editor]');if(editor)void screenTextEditor(editor,gateway,locale);
 if(selected){form('platform-account-form',async(values,clear)=>{(await request(`/tenants/${selected}/accounts`,'POST',values)).consume();clear();notice=text('account_created');await load();});form('platform-master-form',async(values,clear)=>{(await request(`/tenants/${selected}/masters`,'POST',values)).consume();clear();notice=text('master_created');await load();});
 for(const row of root.querySelectorAll<HTMLElement>('[data-user]'))row.querySelector('button')!.addEventListener('click',()=>void action(async()=>{(await request(`/tenants/${selected}/accounts/${row.dataset.user}`,'PATCH',{role:row.querySelector<HTMLSelectElement>('[data-role]')!.value,status:row.querySelector<HTMLSelectElement>('[data-status]')!.value})).consume();savedRows.add('user-'+row.dataset.user);notice=text('account_updated');await load();}));
 for(const row of root.querySelectorAll<HTMLElement>('[data-master]'))row.querySelector('button')!.addEventListener('click',()=>{const record=records.find(r=>r.id===row.dataset.master)!;void action(async()=>{(await request(`/tenants/${selected}/masters/${record.id}`,'PATCH',{label:row.querySelector<HTMLInputElement>('[data-label]')!.value,status:row.querySelector<HTMLSelectElement>('[data-status]')!.value,version:record.version})).consume();savedRows.add('master-'+record.id);notice=text('master_updated');await load();});});}
 if(['bundle','launch','documents','support'].includes(view)&&bundle)bundle.mount(root.querySelector<HTMLElement>('[data-cy=platform-bundle]')!,locale);
 if(view==='operations'&&operations)operations.mount(root.querySelector<HTMLElement>('[data-cy=platform-operations]')!,locale);
 if(view==='territories'&&territories)territories.mount(root.querySelector<HTMLElement>('[data-cy=platform-territories]')!,locale);
 }
 // Text subscription can start its own read, so validate presentation first.
 if(!enterPresentation())return;
 stopLive=live.subscribe(()=>{if(!current())return;if(!navigationPending()&&!dirtyForm&&view!=='text'&&view!=='calls'&&view!=='vapi'&&root.querySelector('[data-cy=platform-status]'))draw();});
 root.addEventListener('input',onInput);
 window.addEventListener('hashchange',onHistory);window.addEventListener('popstate',onHistory);window.addEventListener('pagehide',onPageHide);window.addEventListener('pageshow',onPageShow);
 const roleOptions=(current:string)=>`<option value="" disabled ${roles.includes(current)?'':'selected'}>${label('choose_role')}</option>`+roles.map(r=>`<option ${r===current?'selected':''}>${escapeHtml(r)}</option>`).join('');
 const statusOptions=(current:string)=>['active','inactive'].map(s=>`<option value="${s}" ${s===current?'selected':''}>${label(s)}</option>`).join('');
 function openForm(selector:string,title:string){if(!current()||navigationPending())return;const form=root.querySelector<HTMLFormElement>(selector);if(!form)return;const marker=document.createElement('div');form.replaceWith(marker);const dialog=document.createElement('dialog');dialog.dataset.adminFormDialog='true';dialog.className='approved-admin-dialog';const heading=document.createElement('h2');heading.textContent=title;const close=document.createElement('button');close.type='button';close.textContent='Close';const restore=()=>{if(marker.isConnected)marker.replaceWith(form);dialog.close();dialog.remove();};close.onclick=restore;dialog.addEventListener('cancel',event=>{event.preventDefault();restore();});dialog.append(heading,form,close);root.append(dialog);dialog.showModal();form.querySelector<HTMLInputElement>('input')?.focus();}
 function form(id:string,work:(values:Record<string,string>,clear:()=>void)=>Promise<void>){const element=root.querySelector<HTMLFormElement>(`[data-cy=${id}]`);if(!element)return;element.onsubmit=e=>{e.preventDefault();const values=Object.fromEntries(new FormData(e.currentTarget as HTMLFormElement)) as Record<string,string>;void action(()=>work(values,()=>element.reset()));};}
 async function action(work:()=>Promise<void>){if(!current()||navigationPending()||denied||!enterPresentation())return;busy=true;notice='';const output=root.querySelector('[data-cy=platform-status]');if(output)output.textContent=text('working');root.querySelectorAll<HTMLInputElement|HTMLButtonElement|HTMLSelectElement>('input,button,select').forEach(e=>{if(!reports?.contains(e))e.disabled=true;});try{await work();}catch(error){if(current())notice=(error as Error).message;}finally{busy=false;if(!current())return;if(denied){dispose();root.innerHTML=`<main role="alert"><h1>${label('title')}</h1><p>${escapeHtml(notice)}</p><a href="/">${label('workspace')}</a></main>`;}else{draw();if(pendingHistory)onHistory();}}}
 async function load(refresh=false){
  if(!enterPresentation())return;
  requireCurrent();
  if(!actor||refresh){
   const data=(await request()).consume();
   if(!Object.keys(hierarchy.roles).includes(data.role))throw new Error('Administrator required');
   adminRole=data.role;if(adminRole==='tenant_admin'&&location.hash&&!selected)selected=data.tenants[0]?.id||'';
   scope=data.scope;canCreateTenant=data.canCreateTenant;canViewReports=data.canViewReports===true;canViewTerritories=data.canViewTerritories===true;canViewOperations=data.canViewOperations===true;canViewBundle=data.canViewBundle===true;extended=data.extended;canViewTraining=data.canViewTraining===true||data.extended===true;growthDashboard=data.growthDashboard;actor=data.identity.userId;
   const calls=await readForCurrent(()=>canUseExternalCalls(gateway,token));requireCurrent();canCall=calls;
   tenants=data.tenants;roles=data.assignableRoles;types=data.masterTypes;
   const demo=adminRole==='code_admin'?tenants.find(t=>t.slug==='demo-primecare-maple-home-care'):null;
   if(demo){const audit=(await request('/tenants/'+encodeURIComponent(demo.id)+'/audit')).consume();demoDataset=audit.events?.find((e:any)=>e.current_state?.demoDataset?.version==='approved-code-admin-demo-v1')?.current_state.demoDataset??null;if(demoDataset&&!demoPreferenceInitialized&&!actor.startsWith('synthetic')){overviewDemoOnly=true;demoPreferenceInitialized=true;}}
  }
  requireCurrent();
  if(initialNavigation){view=hashView()??defaultView();initialNavigation=false;}else if(view!=='account'&&!resolveView(viewId()))view=defaultView();
  if(selected&&!tenants.some(t=>t.id===selected)){const extra=(await request('/tenants/'+encodeURIComponent(selected))).consume().tenant;tenants.push(extra);}
  if(['bundle','launch','documents','support'].includes(view)){bundle??=new BundleController(gateway,token,item=>{void jump('bundle',item.tenant??'',()=>bundle!.openWorkflow(item));});if(view!=='bundle')bundle.openTab(view);await bundle.load(selected);requireCurrent();}
  if(view==='operations'){operations??=new OperationsController(gateway,token,(tenant,destination)=>{void jump(destination,tenant);});await operations.load();requireCurrent();}
  if(view==='territories'){territories??=new TerritoryController(gateway,token,actor);await territories.load();requireCurrent();}
  if(view==='onboarding')partners=(await request('/onboarding')).consume().partners;
  if(selected){
   if(view==='accounts')users=(await request(`/tenants/${selected}/accounts`)).consume().users;
   if(view==='masters')records=(await request(`/tenants/${selected}/masters`)).consume().records;
   if(view==='audit')events=(await request(`/tenants/${selected}/audit`)).consume().events;
  }
 }
 try{busy=true;await load();busy=false;if(current()){draw();if(pendingHistory)onHistory();}}catch(error){busy=false;if(!current()||!enterPresentation())return;dispose();root.innerHTML=`<main role="alert"><h1>${label('title')}</h1><p>${escapeHtml((error as Error).message)}</p><a href="/">Return to workspace</a></main>`;}
}


function languageFlag(locale:string,canadian=false):string {
 const body=canadian&&locale==='en'?'<path fill="#fff" d="M0 0h30v20H0z"/><path fill="#d52b3b" d="M0 0h7v20H0zM23 0h7v20h-7zM15 3l1.3 3.6 2-1-.6 4 2.7-1-.6 2 2 1-4.6 3 .5 2-2.2-.4V19h-1v-2.8l-2.2.4.5-2-4.6-3 2-1-.6-2 2.7 1-.6-4 2 1z"/>':locale==='fr'?'<path fill="#fff" d="M0 0h30v20H0z"/><path fill="#2448a0" d="M0 0h10v20H0z"/><path fill="#e54242" d="M20 0h10v20H20z"/>':locale==='es'?'<path fill="#c42b3d" d="M0 0h30v20H0z"/><path fill="#ffd65b" d="M0 5h30v10H0z"/>':'<path fill="#23407b" d="M0 0h30v20H0z"/><path stroke="#fff" stroke-width="5" d="m0 0 30 20M30 0 0 20"/><path stroke="#d94252" stroke-width="2" d="m0 0 30 20M30 0 0 20"/><path stroke="#fff" stroke-width="7" d="M15 0v20M0 10h30"/><path stroke="#d94252" stroke-width="4" d="M15 0v20M0 10h30"/>';
 return '<svg viewBox="0 0 30 20" width="27" height="18" focusable="false">'+body+'</svg>';
}
