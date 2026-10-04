type Page = {code:string;name:string;route:string;role:string;appCode:string;renderer:string;lifecycle:string;
  productionReady:boolean;blockers:string[];sections:{code:string;name:string;type:string;purpose:string;testId:string;
  elements:{key:string;label:string;testId:string;actionRequired:number}[]}[]};
type Workspace = {identity:{userId:string;role:string};landing:string;screens:Page[];inventory:Page[];actions:Page[];
  resources:Record<string,string>;overview:{activeAccounts:number;activeSessions:number;accountRoles:{role:string;count:number}[];
  activity:{action:string;created_at:string}[];metrics:{code:string;available:boolean;count?:number}[];scope:string}};
export const escapeHtml = (value:unknown) => String(value??'').replace(/[&<>'"]/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;',"'":'&#39;','"':'&quot;'}[c]!));
const routeUrl = (route:string) => `${route}${route.includes('?')?'&':'?'}enable-semantics=true`;
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
    if((error as {status?:number}).status===401){sessionStorage.removeItem('primecare_session');location.assign(routeUrl('/login'));return;}
    root.innerHTML=`<main data-cy="error-state" role="alert"><p>${escapeHtml((error as Error).message)}</p><button data-cy="workspace-retry">Retry</button></main>`;
    root.querySelector('button')?.addEventListener('click',()=>void renderWorkspace(root,gateway));return;
  }
  let search='';let pendingOnly=false;let pageNumber=0;
  const t=(key:string)=>escapeHtml(data.resources['workspace.'+key]??key);
  const link=(page:Page)=>`<a href="${escapeHtml(routeUrl(page.route))}" data-route="${escapeHtml(page.route)}" data-cy="sidebar-item-${escapeHtml(page.code)}">${escapeHtml(page.name)}</a>`;
  const metric=(label:string,value:unknown)=>`<article class="metric"><span>${label}</span><strong>${escapeHtml(value)}</strong></article>`;
  const activities=()=>data.overview.activity.length?`<ul class="activity-list">${data.overview.activity.map(a=>`<li><strong>${escapeHtml(a.action.replaceAll('_',' '))}</strong><time datetime="${escapeHtml(a.created_at)}">${escapeHtml(new Date(a.created_at).toLocaleString())}</time></li>`).join('')}</ul>`:`<p class="empty">${t('empty')}</p>`;
  const chart=()=>`<div class="role-bars">${data.overview.accountRoles.map(r=>`<div><div><span>${escapeHtml(r.role)}</span><strong>${r.count}</strong></div><meter min="0" max="${Math.max(1,data.overview.activeAccounts)}" value="${r.count}" aria-label="${escapeHtml(r.role)}">${r.count}</meter></div>`).join('')}</div>`;
  const draw=()=>{
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
    const nav=(data.actions??[]).map(p=>`<a href="${escapeHtml(routeUrl(p.route))}">${escapeHtml(p.name)}</a>`).join('')+data.screens.map(s=>link(s).replace('<a ',`<a ${s.code===page?.code?'aria-current="page"':''} `)).join('');
    const cards=metric(t('users'),data.overview.activeAccounts)+metric(t('sessions'),data.overview.activeSessions)+metric(t('pages'),data.screens.length)+metric(t('pending'),pending.length);
    const sections=page?.sections.map(section=>{
      let body=`<p>${escapeHtml(section.purpose)}</p>`;
      if(page!.renderer==='dashboard' && section.type==='metrics')body+=`<div class="metric-grid">${cards}</div>`;
      else if(page!.renderer==='dashboard' && section.type==='chart')body+=chart();
      else if(page!.renderer==='dashboard' && section.type==='list')body+=activities();
      else if(section.type==='header')body+=`<p>${escapeHtml(data.identity.role)} · ${escapeHtml(page!.name)}</p>`;
      else if(section.type==='action_bar')body+=`<div class="quick-links">${data.screens.map(link).join('')}</div>`;
      else body+=`<p class="notice">${t('no_data')}</p>`;
      body+=section.elements.map(e=>`<div data-cy="${escapeHtml(e.testId)}">${escapeHtml(e.label||e.key)}${e.actionRequired?`<p class="notice">${t('no_action')}</p>`:''}</div>`).join('');
      return `<section class="section" data-cy="${escapeHtml(section.testId||section.code)}"><h2>${escapeHtml(section.name)}</h2>${body}</section>`;
    }).join('')??'';
    const tableRows=rows.slice(pageNumber*25,(pageNumber+1)*25).map(p=>`<tr data-cy="inventory-${escapeHtml(p.code)}"><th scope="row">${allowed.has(p.code)?link(p):escapeHtml(p.name)}</th><td>${escapeHtml(p.appCode)}</td><td>${escapeHtml(p.role)}</td><td>${t('created')}</td><td>${escapeHtml(p.blockers.join('; '))}</td></tr>`).join('');
    root.innerHTML=`<div class="app-shell" data-cy="app-shell"><aside data-cy="app-sidebar"><a class="brand" href="${escapeHtml(routeUrl(data.landing??'/'))}">PrimeCare</a><p>${escapeHtml(data.identity.role)}</p><nav aria-label="${t('pages')}">${nav}</nav></aside>
      <div class="workspace"><header class="topbar" data-cy="app-topbar"><button class="menu" data-cy="sidebar-toggle" aria-label="${t('pages')}">☰</button>
      <button data-cy="workspace-refresh">${t('refresh')}</button><a href="${routeUrl('/success')}" data-route="/success" data-cy="workspace-account">${t('account')}</a><button data-cy="workspace-logout">${t('sign_out')}</button></header>
      <main data-cy="screen-${escapeHtml(page?.code??'account')}"><div class="screen-header"><div><p class="eyebrow">${escapeHtml(data.identity.role)}</p><h1 tabindex="-1" data-cy="workspace-title">${account?t('account'):escapeHtml(page?.name)}</h1></div><span class="badge">${t('created')}</span></div>
      ${account?`<section class="section"><p>${escapeHtml(data.identity.role)}</p><form data-cy="change-password-form"><label>${t('current_password')}<input required type="password" name="currentPassword" autocomplete="current-password" data-cy="current-password"></label><label>${t('new_password')}<input required minlength="12" type="password" name="newPassword" autocomplete="new-password" data-cy="new-password"></label><button type="submit" data-cy="change-password-submit">${t('change_password')}</button><output role="status" data-cy="change-password-status"></output></form></section>`:
      `<section class="section" data-cy="workspace-overview"><h2>${t('title')}</h2><div class="metric-grid">${cards}</div></section>
      <section class="section" data-cy="workspace-organization"><h2>${t('roles')}</h2>${chart()}<div class="metric-grid">${data.overview.metrics.map(m=>metric(t(m.code),m.available?m.count:data.resources['workspace.unconnected'])).join('')}</div></section>
      <section class="section" data-cy="workspace-activity"><h2>${t('activity')}</h2>${activities()}</section>${sections}
      <section class="section" data-cy="workspace-inventory"><h2>${t('inventory')}</h2><div class="inventory-controls"><label>${t('search')}<input data-cy="workspace-search" value="${escapeHtml(search)}"></label><label><input type="checkbox" data-cy="workspace-pending" ${pendingOnly?'checked':''}>${t('pending')}</label><button data-cy="workspace-export">${t('export')}</button></div>
      <div class="table-scroll"><table><thead><tr><th>${t('pages')}</th><th>${t('portal')}</th><th>${t('role')}</th><th>${t('status')}</th><th>${t('pending')}</th></tr></thead><tbody>${tableRows}</tbody></table></div><div class="pagination"><button data-cy="inventory-prev" ${pageNumber===0?'disabled':''}>←</button><output data-cy="inventory-count">${rows.length} · ${pageNumber+1}/${countPages}</output><button data-cy="inventory-next" ${pageNumber+1===countPages?'disabled':''}>→</button></div></section>`}</main></div></div>`;
    root.querySelectorAll<HTMLAnchorElement>('a[data-route]').forEach(a=>a.addEventListener('click',e=>{e.preventDefault();history.pushState({},'',a.href);draw();root.querySelector<HTMLElement>('h1')?.focus();}));
    root.querySelector('[data-cy="sidebar-toggle"]')?.addEventListener('click',()=>root.querySelector('aside')?.classList.toggle('open'));
    root.querySelector('[data-cy="workspace-refresh"]')?.addEventListener('click',()=>void renderWorkspace(root,gateway));
    root.querySelector('[data-cy="workspace-logout"]')?.addEventListener('click',async()=>{await fetch(`${gateway}/v1/auth/logout`,{method:'POST',headers:{authorization:'Bearer '+token}}).catch(()=>undefined);sessionStorage.removeItem('primecare_session');location.assign(routeUrl('/login'));});
    root.querySelector<HTMLInputElement>('[data-cy="workspace-search"]')?.addEventListener('input',e=>{const input=e.currentTarget as HTMLInputElement;const cursor=input.selectionStart;search=input.value;pageNumber=0;draw();const next=root.querySelector<HTMLInputElement>('[data-cy="workspace-search"]');next?.focus();next?.setSelectionRange(cursor,cursor);});
    root.querySelector<HTMLInputElement>('[data-cy="workspace-pending"]')?.addEventListener('change',e=>{pendingOnly=(e.currentTarget as HTMLInputElement).checked;pageNumber=0;draw();});
    root.querySelector('[data-cy="inventory-prev"]')?.addEventListener('click',()=>{pageNumber--;draw();});
    root.querySelector('[data-cy="inventory-next"]')?.addEventListener('click',()=>{pageNumber++;draw();});
    root.querySelector('[data-cy="workspace-export"]')?.addEventListener('click',()=>{const url=URL.createObjectURL(new Blob([inventoryCsv(rows)],{type:'text/csv;charset=utf-8'}));const a=document.createElement('a');a.href=url;a.download='PrimeCare-Page-Inventory.csv';a.click();URL.revokeObjectURL(url);});
    root.querySelector<HTMLFormElement>('[data-cy="change-password-form"]')?.addEventListener('submit',async e=>{
      e.preventDefault();const form=e.currentTarget as HTMLFormElement;const fields=new FormData(form);const out=form.querySelector<HTMLOutputElement>('output')!;const button=form.querySelector<HTMLButtonElement>('button')!;button.disabled=true;
      try{const response=await fetch(`${gateway}/v1/user/change-password`,{method:'POST',headers:{authorization:'Bearer '+token,'content-type':'application/json'},body:JSON.stringify(Object.fromEntries(fields))});const payload=await response.json();if(response.ok){sessionStorage.removeItem('primecare_session');location.assign(routeUrl('/login'));}else out.value=payload.error??data.resources['workspace.request_failed'];}catch{out.value=data.resources['workspace.unavailable'];}finally{button.disabled=false;}
    });
  };
  window.onpopstate=draw;draw();
}
