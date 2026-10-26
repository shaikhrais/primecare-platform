import {mutationActorForScreen,accountCreationMarkup,bindAccountCreation} from './account-mutations-panel';
import {tenantAccountsScreen,tenantAccountsMarkup,bindTenantAccounts} from './tenant-accounts-panel';
import careRegistry from '../../../packages/shared/src/care/registry.json';
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
  if(locale==='fr'||locale==='es')url.searchParams.set('locale',locale);
  url.searchParams.delete('enable-semantics');url.searchParams.set('enable-semantics','true');
  return url.pathname+'?'+url.searchParams;
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
export async function renderWorkspace(root:HTMLElement,gateway:string):Promise<void> {
  const token=sessionStorage.getItem('primecare_session');
  if(!token){location.assign(routeUrl('/login'));return;}
  root.innerHTML='<main aria-busy="true" data-cy="workspace-loading"><progress aria-label="Loading workspace"></progress></main>';
  let data:Workspace;
  try {data=await loadWorkspace(gateway,token);}
  catch(error) {
    if(sessionStorage.getItem('primecare_session')!==token){location.reload();return;}
    if((error as {status?:number}).status===401){sessionStorage.removeItem('primecare_session');location.assign(routeUrl('/login'));return;}
    root.innerHTML=`<main data-cy="error-state" role="alert"><p>${escapeHtml((error as Error).message)}</p><button data-cy="workspace-retry">Retry</button></main>`;
    root.querySelector('button')?.addEventListener('click',()=>void renderWorkspace(root,gateway));return;
  }
  if(sessionStorage.getItem('primecare_session')!==token){location.reload();return;}
  const callScreens=data.screens.filter(s=>['psw_messages','patient_messages','communication','messaging'].includes(s.code));
  if(new URLSearchParams(location.search).get('view')==='calls'&&callScreens.some(s=>s.route===location.pathname)){
    const {renderInternalCalls}=await import('./internal-calls');
    await renderInternalCalls(root,gateway,{userId:data.identity.userId,role:data.identity.role,home:data.landing??'/',navigation:data.screens.map(s=>`<a href="${escapeHtml(routeUrl(s.route))}">${escapeHtml(s.name)}</a>`).join('')});return;
  }
  const reportPanels=new Map<string,HTMLElement>();
  if(data.identity.role==='platform_admin'&&location.pathname!=='/success'){location.assign(routeUrl('/platform/administration'));return;}
  if(['/','/dashboard'].includes(location.pathname)&&data.landing===careRegistry.route&&data.screens.some(s=>s.route===careRegistry.route)){location.assign(routeUrl(careRegistry.route));return;}
  const live=liveScreenText(gateway);let dirtyForm=false;root.addEventListener('input',()=>dirtyForm=true);
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
  let disposeAccountReads=()=>{};let disposeAccountCreation=()=>{};
  const draw=()=>{
    disposeAccountCreation();disposeAccountCreation=()=>{};disposeAccountReads();disposeAccountReads=()=>{};
    const inventoryOpen=root.querySelector<HTMLDetailsElement>('[data-cy="workspace-inventory"]')?.open??false;
    let page=data.screens.find(s=>s.route===location.pathname);
    if(location.pathname==='/' || location.pathname==='/dashboard') {
      page=data.screens.find(s=>s.route===data.landing)??data.screens[0];
      if(page)history.replaceState({},'',routeUrl(page.route));
    }
    const account=location.pathname==='/success';
    if(!page&&!account){root.innerHTML=`<main data-cy="error-state"><h1>${t('forbidden')}</h1><a href="${escapeHtml(routeUrl(data.landing??'/'))}">${t('title')}</a></main>`;return;}
    const pending=data.inventory.filter(p=>p.blockers.length>0);
    const rows=data.inventory.filter(p=>(!pendingOnly||p.blockers.length>0)&&`${p.name} ${p.role} ${p.appCode} ${p.route}`.toLowerCase().includes(search.toLowerCase()));
    const countPages=Math.max(1,Math.ceil(rows.length/25));pageNumber=Math.min(pageNumber,countPages-1);
    const allowed=new Set(data.screens.map(p=>p.code));
    const callEntry=callScreens[0];
    const callLink=callEntry?`<a data-cy=internal-call-open href="${escapeHtml(routeUrl(callEntry.route))}&amp;view=calls">${escapeHtml(document.documentElement.lang==='fr'?'Appels':document.documentElement.lang==='es'?'Llamadas':'Calls')}</a>`:'';
    const nav=callLink+(data.actions??[]).map(p=>`<a href="${escapeHtml(routeUrl(p.route))}">${escapeHtml(p.name)}</a>`).join('')+data.screens.map(s=>link(s).replace('<a ',`<a ${s.code===page?.code?'aria-current="page"':''} `)).join('');
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
    renderShell(root,{home:escapeHtml(routeUrl(data.landing??'/')),role:escapeHtml(media.roleLabel(data.identity.role)),navigation:nav,menuLabel:t('pages'),controls:`<button data-cy="workspace-training">${escapeHtml(trainingText(gateway,locale,'nav'))}</button><button data-cy="workspace-refresh">${t('refresh')}</button><a href="${routeUrl('/success')}" data-route="/success" data-cy="workspace-account">${t('account')}</a><button data-cy="workspace-logout">${t('sign_out')}</button>`,mainAttributes:`data-cy="screen-${escapeHtml(page?.code??'account')}"`,content:`<div class="screen-header">${media.heading(account?text('account'):page!.name,media.roleLabel(data.identity.role),page?.renderer==='dashboard'?'chart':'home','workspace-title')}<span class="badge">${t('created')}</span></div>
      ${account?accountMarkup(t):
      `${page?.renderer!=='dashboard'?sections:''}<section class="section" data-cy="workspace-overview"><h2>${t('title')}</h2><div class="metric-grid">${cards}</div></section>
      <section class="section" data-cy="workspace-organization"><h2>${t('roles')}</h2>${chart()}<div class="metric-grid">${data.overview.metrics.map(m=>metric(t(m.code),m.available?m.count:data.resources['workspace.unconnected'])).join('')}</div></section>
      <section class="section" data-cy="workspace-activity"><h2>${t('activity')}</h2>${activities()}</section><details class="section" data-cy="workspace-delivery"><summary>${t('details')}</summary>${details(page!)}</details>
      <details class="section workspace-inventory-disclosure" data-cy="workspace-inventory" ${inventoryOpen?'open':''}><summary>${t('inventory')}</summary><div class="inventory-controls"><label>${t('search')}<input data-cy="workspace-search" value="${escapeHtml(search)}"></label><label><input type="checkbox" data-cy="workspace-pending" ${pendingOnly?'checked':''}>${t('pending')}</label><button data-cy="workspace-export">${t('export')}</button></div>
      <div class="table-scroll"><table><thead><tr><th>${t('pages')}</th><th>${t('portal')}</th><th>${t('role')}</th><th>${t('status')}</th><th>${t('pending')}</th></tr></thead><tbody>${tableRows}</tbody></table></div><div class="pagination"><button data-cy="inventory-prev" aria-label="${t('previous')}" ${pageNumber===0?'disabled':''}>←</button><output data-cy="inventory-count">${rows.length} · ${pageNumber+1}/${countPages}</output><button data-cy="inventory-next" aria-label="${t('next')}" ${pageNumber+1===countPages?'disabled':''}>→</button></div></details>`}`});
    root.querySelectorAll<HTMLAnchorElement>('a[data-route]').forEach(a=>a.onclick=e=>{e.preventDefault();if(a.dataset.route===careRegistry.route){location.assign(a.href);return;}history.pushState({},'',a.href);draw();root.querySelector<HTMLElement>('h1')?.focus();});
    if(page && data.reporting?.screens.includes(page.code)) {
      let panel=reportPanels.get(page.code);
      if(!panel){panel=reportPanel(gateway,data.reporting.endpoint,token,data.identity.userId);reportPanels.set(page.code,panel);}
      root.querySelector('main')!.insertBefore(panel,root.querySelector('[data-cy="workspace-inventory"]'));
    }
    bindShell(root,account?text('account'):page?.name??'PrimeCare',locale,'Authorized screens and tasks for this account',()=>[...data.screens,...(data.actions??[])].map(s=>({title:s.name,detail:s.role+' · '+s.route,open:()=>{if(s.route===careRegistry.route){location.assign(routeUrl(s.route));return;}history.pushState({},'',routeUrl(s.route));draw();root.querySelector<HTMLElement>('h1')?.focus();}})),data.identity.role+':'+data.identity.userId);
    root.querySelector<HTMLButtonElement>('[data-cy="workspace-training"]')!.onclick=()=>openAdminTraining(gateway,data.identity.userId);
    root.querySelector<HTMLButtonElement>('[data-cy="workspace-refresh"]')!.onclick=()=>void renderWorkspace(root,gateway);
    root.querySelector<HTMLButtonElement>('[data-cy="workspace-logout"]')!.onclick=async event=>{
      if(signingOut)return;
      if(sessionStorage.getItem('primecare_session')!==token){location.reload();return;}
      signingOut=true;const button=event.currentTarget as HTMLButtonElement;button.disabled=true;
      try{await signOut(gateway,token);
        if(sessionStorage.getItem('primecare_session')!==token){location.reload();return;}
        sessionStorage.removeItem('primecare_session');location.assign(routeUrl('/login'));
      }catch{if(sessionStorage.getItem('primecare_session')!==token){location.reload();return;}
        button.textContent=text('request_failed');button.setAttribute('aria-live','polite');
      }finally{signingOut=false;button.disabled=false;}
    };
    root.querySelector<HTMLInputElement>('[data-cy="workspace-search"]')?.addEventListener('input',e=>{const input=e.currentTarget as HTMLInputElement;const cursor=input.selectionStart;search=input.value;pageNumber=0;draw();const next=root.querySelector<HTMLInputElement>('[data-cy="workspace-search"]');next?.focus();next?.setSelectionRange(cursor,cursor);});
    root.querySelector<HTMLInputElement>('[data-cy="workspace-pending"]')?.addEventListener('change',e=>{pendingOnly=(e.currentTarget as HTMLInputElement).checked;pageNumber=0;draw();});
    root.querySelector('[data-cy="inventory-prev"]')?.addEventListener('click',()=>{pageNumber--;draw();});
    root.querySelector('[data-cy="inventory-next"]')?.addEventListener('click',()=>{pageNumber++;draw();});
    root.querySelector('[data-cy="workspace-export"]')?.addEventListener('click',()=>{const url=URL.createObjectURL(new Blob([inventoryCsv(rows)],{type:'text/csv;charset=utf-8'}));const a=document.createElement('a');a.href=url;a.download='PrimeCare-Page-Inventory.csv';a.click();URL.revokeObjectURL(url);});
    if(page?.code===tenantAccountsScreen&&!account){const target=root.querySelector('main')!;target.insertAdjacentHTML('beforeend',tenantAccountsMarkup());disposeAccountReads=bindTenantAccounts(root,gateway,token,data.identity.role,value=>media.roleLabel(value));}
    if(page&&mutationActorForScreen(page.code,data.identity.role)&&!account){root.querySelector('main')!.insertAdjacentHTML('beforeend',accountCreationMarkup());disposeAccountCreation=bindAccountCreation(root,gateway,token,data.identity.role,value=>media.roleLabel(value));}
    bindAccount(root,gateway,token,text('request_failed'),text('unavailable'));
  };
  const unsubscribe=live.subscribe(()=>{if(!root.querySelector('[data-cy=workspace-organization]')){unsubscribe();return;}if(!dirtyForm&&!signingOut)draw();});
  window.onpopstate=draw;draw();
}
