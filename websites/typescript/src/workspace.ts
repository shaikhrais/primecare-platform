import {mountClientInvoices} from './client-invoice-host';
import {requireScreenManager, showScreenConfigurationError, ScreenConfigurationError} from '../../../packages/primecare_ui/web/screen-manager';
import {businessRoles as planRoles} from '../../../packages/shared/src/business-plans/policy.mjs';
import {mutationActorForScreen,accountCreationMarkup,bindAccountCreation} from './account-mutations-panel';
import {tenantAccountsScreen,tenantAccountsMarkup,bindTenantAccounts} from './tenant-accounts-panel';
import {resolveManagedRoute} from './managed-routes';
import {openAdminTraining,trainingText} from './admin-training';
import {DashboardMediaLook} from './media-look';
import {liveScreenText} from './screen-text';
import {accountMarkup,bindAccount} from './account';
import {signOut} from './auth-client';
import workspaceCatalog from '../../../packages/primecare_ui/lib/src/localization/screens/workspace.json';
import {renderShell,bindShell} from './shell';
import {reportPanel} from './reports';
type Page = {code:string;name:string;route:string;role:string;appCode:string;renderer:string;lifecycle:string;
  productionReady:boolean;blockers:string[];
  requirements?:{business_purpose?:string;user_story?:string;acceptance_criteria?:string};
  contracts?:{code:string;method:string;route:string;implementation:string;permission:string;health:string;lastTested:string|null;schemas:number}[];
  pendingActions?:{key:string;label:string;status:string;apiUsage:string|null}[];
  sections:{code:string;name:string;type:string;purpose:string;testId:string;
  elements:{key:string;label:string;testId:string;actionRequired:number}[]}[]};
type Workspace = {identity:{userId:string;role:string};landing:string;screens:Page[];inventory:Page[];actions:Page[];
  reporting?:{endpoint:string;screens:string[]}|null;resources:Record<string,string>;overview:{activeAccounts:number;activeSessions:number;accountRoles:{role:string;count:number}[];
  activity:{action:string;created_at:string}[];metrics:{code:string;available:boolean;count?:number}[];scope:string}};
export const escapeHtml = (value:unknown) => String(value??'').replace(/[&<>'"]/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;',"'":'&#39;','"':'&quot;'}[c]!));
const routeUrl = (route:string) => {
  const url=new URL(route,document.baseURI),locale=document.documentElement.lang;
  if(!route.startsWith('/')||route.startsWith('//')||/[?#\\\s\u0000-\u001f\u007f]/.test(route)||
    url.origin!==new URL(document.baseURI).origin||url.pathname!==route)throw new ScreenConfigurationError('Invalid workspace route');
  if(locale==='fr'||locale==='es')url.searchParams.set('locale',locale);
  url.searchParams.delete('enable-semantics');url.searchParams.set('enable-semantics','true');
  const target=url.pathname+'?'+url.searchParams;
  if(new URL(target,document.baseURI).origin!==url.origin)throw new ScreenConfigurationError('Invalid workspace route');
  return target;
};
export async function loadWorkspace(gateway:string,token:string,send:typeof fetch=fetch):Promise<Workspace> {
  const response=await send(`${gateway}/v1/governance/workspace`,{headers:{authorization:'Bearer '+token},cache:'no-store'});
  const data=await response.json();
  if(!response.ok)throw Object.assign(new Error(typeof data.error==='string'?data.error:'Workspace unavailable'),{status:response.status});
  if(!data.identity || !Array.isArray(data.screens) || !data.overview || !Array.isArray(data.inventory))throw new Error('Invalid workspace response');
  return data;
}
export function inventoryCsv(pages:Page[]):string {
  const quote=(v:unknown)=>'"'+String(v??'').replace(/^([=+@-])/,'\t$1').replaceAll('"','""')+'"';
  return [['Screen','Name','App','Role','Route','Page status','Production ready','Pending work'],
    ...pages.map(p=>[p.code,p.name,p.appCode,p.role,p.route,p.lifecycle,p.productionReady?'Yes':'No',p.blockers.join('; ')])]
    .map(row=>row.map(quote).join(',')).join('\r\n');
}
const workspaceLoads=new WeakMap<HTMLElement,number>();
const workspaceOwners=new WeakMap<HTMLElement,()=>void>();
const workspaceRestores=new WeakMap<HTMLElement,Promise<void>>();
// main.ts owns this document's dispatcher entry. Internal governed navigation
// does not replace it or turn presentation metadata into an authorization grant.
const workspaceEntries=new WeakMap<HTMLElement,ReturnType<typeof resolveManagedRoute>>();
// This module already runs inside the workspace adapter, not the auth-portal fallback.
const documentRoute=(route:string)=>resolveManagedRoute(route,'').adapter!=='workspace';
export async function renderWorkspace(root:HTMLElement,gateway:string):Promise<void> {
  const manager=requireScreenManager(root);
  workspaceOwners.get(root)?.();workspaceRestores.delete(root);
  const generation=(workspaceLoads.get(root)??0)+1;workspaceLoads.set(root,generation);
  const eventTarget=root.ownerDocument.defaultView??window;
  let retired=false,suspended=false;let disposeInvoices=()=>{},disposeCalls=()=>{},disposeAccountReads=()=>{},disposeAccountCreation=()=>{},disposeAccount=()=>{},disposeReports=()=>{},stopLive=()=>{},redraw=()=>{};
  let renderVersion=0,dirtyForm=false;
  const onInput=()=>{dirtyForm=true;};
  const ownsRoot=()=>!retired&&workspaceLoads.get(root)===generation;
  const isCurrent=()=>{if(!ownsRoot()||suspended)return false;if(root.isConnected===false){retire();return false;}return true;};
  const callView=()=>new URLSearchParams(location.search).get('view')==='calls';
  const initialRoute=location.pathname,initialCalls=callView();
  const entry=workspaceEntries.get(root)??resolveManagedRoute(initialRoute,'');
  const onHistory=()=>{
    if(!isCurrent())return;
    if((initialCalls||callView())&&(location.pathname!==initialRoute||callView()!==initialCalls)){if(sessionCurrent()&&enter(entry.id,entry.route))void renderWorkspace(root,gateway);}
    else redraw();
  };
  const retire=()=>{
    if(retired)return;retired=true;renderVersion++;
    disposeCalls();disposeCalls=()=>{};disposeInvoices();disposeInvoices=()=>{};disposeAccountCreation();disposeAccountCreation=()=>{};disposeAccountReads();disposeAccountReads=()=>{};disposeAccount();disposeAccount=()=>{};disposeReports();stopLive();stopLive=()=>{};
    eventTarget.removeEventListener('pagehide',leave);eventTarget.removeEventListener('pageshow',resume);eventTarget.removeEventListener('popstate',onHistory);root.removeEventListener('input',onInput);
    if(workspaceOwners.get(root)===retire){workspaceOwners.delete(root);manager.registerScope('workspace',[]);}
  };
  const fail=(error:unknown)=>{
    if(ownsRoot()){retire();showScreenConfigurationError(root,error);}return false;
  };
  const enter=(id:string,route:string)=>{
    if(!isCurrent())return false;
    try{manager.enter(id,route);}catch(error){return fail(error);}
    return isCurrent();
  };
  let token:string;
  const sessionCurrent=()=>{
    try{if(sessionStorage.getItem('primecare_session')===token)return true;}
    catch{return fail(new ScreenConfigurationError('Session storage is unavailable'));}
    retire();root.replaceChildren();location.reload();return false;
  };
  const leave=(event:PageTransitionEvent)=>{
    if(!ownsRoot())return;
    suspended=true;renderVersion++;disposeCalls();disposeCalls=()=>{};disposeInvoices();disposeInvoices=()=>{};disposeAccountCreation();disposeAccountCreation=()=>{};disposeAccountReads();disposeAccountReads=()=>{};disposeAccount();disposeAccount=()=>{};disposeReports();stopLive();stopLive=()=>{};manager.registerScope('workspace',[]);
    workspaceRestores.delete(root);
    if(!event.persisted)retire();
  };
  const resume=(event:PageTransitionEvent)=>{
    if(!event.persisted||!ownsRoot()||root.isConnected===false||workspaceRestores.has(root))return;
    if(!sessionCurrent())return;
    // Install the replacement lifecycle before awaiting either the grant read or
    // calls import/start. Duplicate restoration events share this refresh.
    const work=renderWorkspace(root,gateway);workspaceRestores.set(root,work);
    void work.catch(error=>{if(workspaceRestores.get(root)===work)showScreenConfigurationError(root,error);}).finally(()=>{
      if(workspaceRestores.get(root)===work)workspaceRestores.delete(root);
    });
  };
  manager.registerScope('workspace',[]);
  let storedToken:string|null;
  try{storedToken=sessionStorage.getItem('primecare_session');}
  catch{showScreenConfigurationError(root,new ScreenConfigurationError('Session storage is unavailable'));return;}
  if(!storedToken){root.replaceChildren();location.assign(routeUrl('/login'));return;}
  token=storedToken;
  workspaceOwners.set(root,retire);eventTarget.addEventListener('pagehide',leave);eventTarget.addEventListener('pageshow',resume);eventTarget.addEventListener('popstate',onHistory);
  if(!enter(entry.id,entry.route))return;
  workspaceEntries.set(root,entry);
  root.innerHTML='<main aria-busy="true" data-cy="workspace-loading"><progress aria-label="Loading workspace"></progress></main>';
  let data:Workspace;
  try {data=await loadWorkspace(gateway,token);}
  catch(error) {
    if(!isCurrent())return;
    if(!sessionCurrent()||!enter(entry.id,entry.route))return;
    if((error as {status?:number}).status===401){sessionStorage.removeItem('primecare_session');retire();location.assign(routeUrl('/login'));return;}
    root.innerHTML=`<main data-cy="error-state" role="alert"><p>${escapeHtml((error as Error).message)}</p><button data-cy="workspace-retry">Retry</button></main>`;
    root.querySelector('button')?.addEventListener('click',()=>{if(isCurrent()&&sessionCurrent()&&enter(entry.id,entry.route))void renderWorkspace(root,gateway);});return;
  }
  if(!isCurrent())return;
  if(!sessionCurrent()||!enter(entry.id,entry.route))return;
  // Only the authenticated, server-filtered screens become presentation registrations.
  // The broader inventory and public portal manifest must never be used for this snapshot.
  try {
    // Actions are not generic screen registrations, but their navigation URLs must
    // obey the same canonical, same-origin path contract as authorized screens.
    for(const page of [...data.screens,...(data.actions??[])])routeUrl(page.route);
    manager.registerScope('workspace',[
    ...data.screens.map(page=>({id:'governed:'+page.code,route:page.route,kind:'governed' as const,adapter:'workspace'})),
    {id:'typescript:account',route:'/success',kind:'feature',adapter:'workspace-account'},
  ]);}catch(error){fail(error);return;}
  const callScreens=data.screens.filter(s=>['psw_messages','patient_messages','communication','messaging'].includes(s.code));
  if(new URLSearchParams(location.search).get('view')==='calls'&&callScreens.some(s=>s.route===location.pathname)){
    {const page=callScreens.find(s=>s.route===location.pathname)!;if(!enter('governed:'+page.code,page.route))return;}
    const {renderInternalCalls}=await import('./internal-calls');
    if(!isCurrent())return;
    if(!sessionCurrent())return;
    // The query and route can change while the lazy renderer is loading.
    if(new URLSearchParams(location.search).get('view')!=='calls'||!callScreens.some(s=>s.route===location.pathname)){await renderWorkspace(root,gateway);return;}
    {const page=callScreens.find(s=>s.route===location.pathname)!;if(!enter('governed:'+page.code,page.route))return;}
    const callsRoute=location.pathname;
    await renderInternalCalls(root,gateway,{isCurrent:()=>isCurrent()&&location.pathname===callsRoute&&callView()&&sessionCurrent()&&enter('governed:'+callScreens.find(s=>s.route===callsRoute)!.code,callsRoute),userId:data.identity.userId,role:data.identity.role,home:data.landing??'/',navigation:data.screens.map(s=>`<a href="${escapeHtml(routeUrl(s.route))}">${escapeHtml(s.name)}</a>`).join('')},panel=>{
      if(!isCurrent()){panel.close();return;}disposeCalls=()=>panel.close();
    });return;
  }
  const reportPanels=new Map<string,HTMLElement>(),reportLifecycles=new Map<string,{dispose:()=>void;redraw:()=>void}>();
  disposeReports=()=>{for(const lifecycle of reportLifecycles.values())lifecycle.dispose();reportLifecycles.clear();reportPanels.clear();};
  if(data.identity.role==='tenant_admin'&&['/','/dashboard'].includes(location.pathname)){location.assign(routeUrl('/tenant-dashboard'));return;}
  if(['code_admin','central_admin','platform_admin'].includes(data.identity.role)&&['/','/dashboard'].includes(location.pathname)){location.assign(routeUrl('/platform/administration'));return;}
  const live=liveScreenText(gateway);root.addEventListener('input',onInput);
  let search='';let pendingOnly=false;let pageNumber=0;let signingOut=false;
  const locale=document.documentElement.lang==='fr'?'fr':document.documentElement.lang==='es'?'es':'en';
  const text=(key:string)=>live.text('workspace',locale,key,(workspaceCatalog.locales[locale] as Record<string,string>)[key]??data.resources['workspace.'+key]??key);
  const t=(key:string)=>escapeHtml(text(key));
  const media=new DashboardMediaLook(locale);
  const link=(page:Page)=>`<a href="${escapeHtml(routeUrl(page.route))}" data-route="${escapeHtml(page.route)}" data-cy="sidebar-item-${escapeHtml(page.code)}">${media.sectionIcon(page.renderer==='dashboard'?'chart':'header')}${escapeHtml(page.name)}</a>`;
  const metric=(label:string,value:unknown)=>`<article class="metric"><span>${label}</span><strong>${escapeHtml(value)}</strong></article>`;
  const details=(p:Page)=>`<details data-cy="delivery-${escapeHtml(p.code)}"><summary>${t('details')}</summary>
    <h3>${t('requirements')}</h3><p>${escapeHtml(p.requirements?.business_purpose||data.resources['workspace.no_requirements'])}</p>
    <p>${escapeHtml(p.requirements?.user_story)}</p><h4>${t('acceptance')}</h4><p>${escapeHtml(p.requirements?.acceptance_criteria)}</p>
    <h3>${t('contracts')}</h3>${p.contracts?.length?`<ul>${p.contracts.map(a=>`<li><code>${escapeHtml(a.method)} ${escapeHtml(a.route)}</code> · ${escapeHtml(a.implementation)} · ${escapeHtml(a.health||'not_tested')}</li>`).join('')}</ul>`:`<p>${t('no_contracts')}</p>`}
    <h3>${t('pending_actions')}</h3>${p.pendingActions?.length?`<ul>${p.pendingActions.map(a=>`<li>${escapeHtml(a.label||a.key)} · ${escapeHtml(a.status)}</li>`).join('')}</ul>`:`<p>${t('no_pending_actions')}</p>`}
    <ul>${p.blockers.map(b=>`<li>${escapeHtml(b)}</li>`).join('')}</ul></details>`;
  const activities=()=>data.overview.activity.length?`<ul class="activity-list">${data.overview.activity.map(a=>`<li><strong>${escapeHtml(a.action.replaceAll('_',' '))}</strong><time datetime="${escapeHtml(a.created_at)}">${escapeHtml(new Date(a.created_at).toLocaleString())}</time></li>`).join('')}</ul>`:`<p class="empty">${t('empty')}</p>`;
  const chart=()=>`<div class="role-bars">${data.overview.accountRoles.map(r=>`<div><div><span>${escapeHtml(media.roleLabel(r.role))}</span><strong>${r.count}</strong></div><meter min="0" max="${Math.max(1,data.overview.activeAccounts)}" value="${r.count}" aria-label="${escapeHtml(media.roleLabel(r.role))}">${r.count}</meter></div>`).join('')}</div>`;
  let handingOff=false;
  const currentNavigation=()=>{
    if(!isCurrent()||handingOff)return false;
    return sessionCurrent();
  };
  const handoff=(route:string,replace=false)=>{
    handingOff=true;renderVersion++;disposeInvoices();disposeInvoices=()=>{};disposeAccountCreation();disposeAccountCreation=()=>{};disposeAccountReads();disposeAccountReads=()=>{};disposeAccount();disposeAccount=()=>{};disposeReports();stopLive();stopLive=()=>{};
    if(replace)location.replace(routeUrl(route));else location.assign(routeUrl(route));
  };
  const navigate=(route:string,active:()=>boolean)=>{
    if(!active())return;
    if(documentRoute(route)){handoff(route);return;}
    const url=routeUrl(route);
    if(location.pathname+location.search!==url)history.pushState({},'',url);
    draw();root.querySelector<HTMLElement>('h1')?.focus();
  };
  const draw=()=>{
    if(!currentNavigation())return;
    const version=++renderVersion;
    disposeInvoices();disposeInvoices=()=>{};disposeAccountCreation();disposeAccountCreation=()=>{};disposeAccountReads();disposeAccountReads=()=>{};disposeAccount();disposeAccount=()=>{};
    const inventoryOpen=root.querySelector<HTMLDetailsElement>('[data-cy="workspace-inventory"]')?.open??false;
    let page=data.screens.find(s=>s.route===location.pathname);
    if(location.pathname==='/' || location.pathname==='/dashboard') {
      page=data.screens.find(s=>s.route===data.landing)??data.screens[0];
      if(page&&documentRoute(page.route)){handoff(page.route,true);return;}
      if(page)history.replaceState({},'',routeUrl(page.route));
    }
    const account=location.pathname==='/success';
    // Back/Forward can reach a document route in an older workspace history entry.
    // Only the server-filtered screen/action snapshot may request this handoff.
    if(!account&&documentRoute(location.pathname)&&(page||data.actions?.some(s=>s.route===location.pathname))){handoff(location.pathname,true);return;}
    if(!page&&!account){root.innerHTML=`<main data-cy="error-state"><h1>${t('forbidden')}</h1><a href="${escapeHtml(routeUrl(data.landing??'/'))}">${t('title')}</a></main>`;return;}
    const id=account?'typescript:account':'governed:'+page!.code,route=location.pathname;
    if(!enter(id,route))return;
    // DOM handlers belong to this particular render, not just to its session.
    // A removed control must not act on a replacement view with the same token.
    const active=()=>version===renderVersion&&location.pathname===route&&currentNavigation()&&enter(id,route);
    const pending=data.inventory.filter(p=>p.blockers.length>0);
    const rows=data.inventory.filter(p=>(!pendingOnly||p.blockers.length>0)&&`${p.name} ${p.role} ${p.appCode} ${p.route}`.toLowerCase().includes(search.toLowerCase()));
    const countPages=Math.max(1,Math.ceil(rows.length/25));pageNumber=Math.min(pageNumber,countPages-1);
    const allowed=new Set(data.screens.map(p=>p.code));
    const callEntry=callScreens[0];
    const callLink=callEntry?`<a data-cy=internal-call-open href="${escapeHtml(routeUrl(callEntry.route))}&amp;view=calls">${escapeHtml(document.documentElement.lang==='fr'?'Appels':document.documentElement.lang==='es'?'Llamadas':'Calls')}</a>`:'';
    const nav=(planRoles.includes(data.identity.role)?'<a href="/business-plans">Business plans &amp; learning</a>':'')+callLink+(data.actions??[]).map(p=>`<a href="${escapeHtml(routeUrl(p.route))}">${escapeHtml(p.name)}</a>`).join('')+data.screens.map(s=>link(s).replace('<a ',`<a ${s.code===page?.code?'aria-current="page"':''} `)).join('');
    const cards=metric(t('users'),data.overview.activeAccounts)+metric(t('sessions'),data.overview.activeSessions)+metric(t('pages'),data.screens.length)+metric(t('pending'),pending.length);
    const sections=page?.sections.map(section=>{
      let body=`<p>${escapeHtml(section.purpose)}</p>`;
      if(page!.renderer==='dashboard' && section.type==='metrics')body+=`<div class="metric-grid">${cards}</div>`;
      else if(page!.renderer==='dashboard' && section.type==='chart')body+=chart();
      else if(page!.renderer==='dashboard' && section.type==='list')body+=activities();
      else if(section.type==='header')body+=`<p>${escapeHtml(data.identity.role)} · ${escapeHtml(page!.name)}</p>`;
      else if(section.type==='action_bar')body+=`<div class="quick-links">${data.screens.map(link).join('')}</div>`;
      else body+=`<p class="notice">${t('no_data')}</p>`;
      body+=section.elements.map(e=>`<div data-cy="${escapeHtml(e.testId)}">${escapeHtml(e.key.endsWith('-role-badge')?data.identity.role:e.label||e.key)}${e.actionRequired?`<p class="notice">${t('no_action')}</p>`:''}</div>`).join('');
      return `<section class="section" data-cy="${escapeHtml(section.testId||section.code)}"><h2 class="media-section-heading">${media.sectionIcon(section.type)}${escapeHtml(section.name)}</h2>${body}</section>`;
    }).join('')??'';
    const tableRows=rows.slice(pageNumber*25,(pageNumber+1)*25).map(p=>`<tr data-cy="inventory-${escapeHtml(p.code)}"><th scope="row">${allowed.has(p.code)?link(p):escapeHtml(p.name)}</th><td>${escapeHtml(p.appCode)}</td><td>${escapeHtml(p.role)}</td><td>${t('created')}</td><td>${escapeHtml(p.blockers.join('; '))}${details(p)}</td></tr>`).join('');
    renderShell(root,{home:escapeHtml(routeUrl(data.landing??'/')),role:escapeHtml(media.roleLabel(data.identity.role)),navigation:nav,menuLabel:t('pages'),controls:`<details class="shell-utilities" data-cy="shell-utilities"><summary>${{en:"More",fr:"Plus",es:"Más"}[locale]}</summary><div class="shell-utility-actions" data-cy="shell-utility-actions"><button data-cy="workspace-training">${escapeHtml(trainingText(gateway,locale,'nav'))}</button><button data-cy="workspace-refresh">${t('refresh')}</button><a href="${routeUrl('/success')}" data-route="/success" data-cy="workspace-account">${t('account')}</a><button data-cy="workspace-logout">${t('sign_out')}</button></div></details>`,mainAttributes:`data-cy="screen-${escapeHtml(page?.code??'account')}"`,content:`<div class="screen-header">${media.heading(account?text('account'):page!.name,media.roleLabel(data.identity.role),page?.renderer==='dashboard'?'chart':'home','workspace-title')}</div>
      ${account?`<section class="section"><h2>Continue to your workspace</h2><p>Your sign-in is complete. Open your dashboard to see the work available to you.</p><a class="guide-dashboard-link" href="${escapeHtml(routeUrl(data.identity.role==='tenant_admin'?'/tenant-dashboard':['code_admin','central_admin','platform_admin'].includes(data.identity.role)?'/platform/administration':data.landing??'/'))}">Open dashboard</a></section>`+accountMarkup(t):
      `${page?.renderer!=='dashboard'?sections:''}<section class="section" data-cy="workspace-overview"><h2>${t('title')}</h2><div class="metric-grid">${cards}</div></section>
      <section class="section" data-cy="workspace-organization"><h2>${t('roles')}</h2>${chart()}<div class="metric-grid">${data.overview.metrics.map(m=>metric(t(m.code),m.available?m.count:(data.resources['workspace.unconnected']??text('unavailable')))).join('')}</div></section>
      <section class="section" data-cy="workspace-activity"><h2>${t('activity')}</h2>${activities()}</section><details class="section" data-cy="workspace-delivery"><summary>${t('details')}</summary>${details(page!)}</details>
      <details class="section workspace-inventory-disclosure" data-cy="workspace-inventory" ${inventoryOpen?'open':''}><summary>${t('inventory')}</summary><div class="inventory-controls"><label>${t('search')}<input data-cy="workspace-search" value="${escapeHtml(search)}"></label><label><input type="checkbox" data-cy="workspace-pending" ${pendingOnly?'checked':''}>${t('pending')}</label><button data-cy="workspace-export">${t('export')}</button></div>
      <div class="table-scroll"><table><thead><tr><th>${t('pages')}</th><th>${t('portal')}</th><th>${t('role')}</th><th>${t('status')}</th><th>${t('pending')}</th></tr></thead><tbody>${tableRows}</tbody></table></div><div class="pagination"><button data-cy="inventory-prev" aria-label="${t('previous')}" ${pageNumber===0?'disabled':''}>←</button><output data-cy="inventory-count">${rows.length} · ${pageNumber+1}/${countPages}</output><button data-cy="inventory-next" aria-label="${t('next')}" ${pageNumber+1===countPages?'disabled':''}>→</button></div></details>`}`});
    root.querySelectorAll<HTMLAnchorElement>('a[data-route]').forEach(a=>a.onclick=e=>{e.preventDefault();navigate(a.dataset.route!,active);});
    if(page && data.reporting?.screens.includes(page.code)) {
      let panel=reportPanels.get(page.code);
      if(!panel){panel=reportPanel(gateway,data.reporting.endpoint,token,data.identity.userId,'en',{
        // Cached report state survives same-screen shell redraws. Its active
        // route and parent lifecycle, not a removed shell's version, own it.
        isCurrent:()=>currentNavigation()&&location.pathname===route&&enter(id,route),
        onLifecycle:(dispose,redraw)=>reportLifecycles.set(page!.code,{dispose,redraw}),
      });if(!active())return;reportPanels.set(page.code,panel);}
      root.querySelector('main')!.insertBefore(panel,root.querySelector('[data-cy="workspace-inventory"]'));
      reportLifecycles.get(page.code)?.redraw();if(!active())return;
    }
    bindShell(root,account?text('account'):page?.name??'PrimeCare',locale,'Authorized screens and tasks for this account',()=>[...data.screens,...(data.actions??[])].map(s=>({title:s.name,detail:s.role+' · '+s.route,open:()=>navigate(s.route,active)})),data.identity.role+':'+data.identity.userId);
    root.querySelector<HTMLButtonElement>('[data-cy="workspace-training"]')!.onclick=()=>{if(active())openAdminTraining(gateway,data.identity.userId);};
    root.querySelector<HTMLButtonElement>('[data-cy="workspace-refresh"]')!.onclick=()=>{if(active())void renderWorkspace(root,gateway);};
    root.querySelector<HTMLButtonElement>('[data-cy="workspace-logout"]')!.onclick=async event=>{
      if(signingOut||!active())return;
      signingOut=true;const button=event.currentTarget as HTMLButtonElement;button.disabled=true;
      try{await signOut(gateway,token);
        if(!active())return;
        sessionStorage.removeItem('primecare_session');retire();root.replaceChildren();location.assign(routeUrl('/login'));
      }catch{if(!active())return;
        button.textContent=text('request_failed');button.setAttribute('aria-live','polite');
      }finally{signingOut=false;if(active())button.disabled=false;}
    };
    root.querySelector<HTMLInputElement>('[data-cy="workspace-search"]')?.addEventListener('input',e=>{if(!active())return;const input=e.currentTarget as HTMLInputElement;const cursor=input.selectionStart;search=input.value;pageNumber=0;draw();const next=root.querySelector<HTMLInputElement>('[data-cy="workspace-search"]');next?.focus();next?.setSelectionRange(cursor,cursor);});
    root.querySelector<HTMLInputElement>('[data-cy="workspace-pending"]')?.addEventListener('change',e=>{if(!active())return;pendingOnly=(e.currentTarget as HTMLInputElement).checked;pageNumber=0;draw();});
    root.querySelector('[data-cy="inventory-prev"]')?.addEventListener('click',()=>{if(!active())return;pageNumber--;draw();});
    root.querySelector('[data-cy="inventory-next"]')?.addEventListener('click',()=>{if(!active())return;pageNumber++;draw();});
    root.querySelector('[data-cy="workspace-export"]')?.addEventListener('click',()=>{if(!active())return;const url=URL.createObjectURL(new Blob([inventoryCsv(rows)],{type:'text/csv;charset=utf-8'}));const a=document.createElement('a');a.href=url;a.download='PrimeCare-Page-Inventory.csv';a.click();URL.revokeObjectURL(url);});
    if(page?.code===tenantAccountsScreen&&!account){const target=root.querySelector('main')!;target.insertAdjacentHTML('beforeend',tenantAccountsMarkup());disposeAccountReads=bindTenantAccounts(root,gateway,token,data.identity.role,value=>media.roleLabel(value));}
    if(page&&mutationActorForScreen(page.code,data.identity.role)&&!account){root.querySelector('main')!.insertAdjacentHTML('beforeend',accountCreationMarkup());disposeAccountCreation=bindAccountCreation(root,gateway,token,data.identity.role,value=>media.roleLabel(value));}
    if(page&&!account)disposeInvoices=mountClientInvoices(root,{gateway,token,page,identity:data.identity,locale,isCurrent:active});
    disposeAccount=bindAccount(root,gateway,token,text('request_failed'),text('unavailable'),active);
  };
  redraw=draw;
  stopLive=live.subscribe(()=>{if(!isCurrent()){stopLive();return;}if(!root.querySelector('[data-cy=workspace-organization]')){stopLive();return;}if(!dirtyForm&&!signingOut)draw();});
  draw();
}
