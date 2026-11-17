import {esc,tenantStyles} from '../../shared/src/tenant-dashboard/view.mjs';
export {esc,tenantView,tenantNavigation,taskForm,taskDetail} from '../../shared/src/tenant-dashboard/view.mjs';

/** Use the existing preview-compatible theme tokens; this host owns no style values. */
export function installTenantDashboardStyles(document:Document):void{
 if(!document.getElementById('tenant-dashboard-styles')){const style=document.createElement('style');style.id='tenant-dashboard-styles';style.textContent=tenantStyles;document.head.append(style);}
}

export function renderTenantDashboardControls(today:string,locale:'en'|'fr'|'es',shellIcon:(name:'user-circle')=>string,synthetic:boolean,role:string):string{
 const language=locale==='fr'?'Français':locale==='es'?'Español':'English';
 return `<div class="td-top-controls"><span class="td-wide">${esc(today)} · Toronto</span><span aria-label="${language}" title="${language}">${locale.toUpperCase()}</span><a href="/success?enable-semantics=true" aria-label="Account & security" data-cy="tenant-top-account">${shellIcon('user-circle')}</a><span class="td-avatar" aria-label="Tenant workspace">${synthetic?'DM':esc(role.slice(0,2).toUpperCase())}</span></div>`;
}

export function renderTenantDashboardLoading(root:HTMLElement):Element|null{
 root.innerHTML='<main class="td-root" role="status"><h1>Loading tenant workspace…</h1><p>Reading authorized workflows and tasks from PostgreSQL.</p></main>';
 return root.firstElementChild;
}

export function renderTenantDashboardUnavailable(root:HTMLElement,message:string):Element{
 root.innerHTML='<main class="td-root" data-cy="tenant-dashboard-error"><h1>Tenant workspace unavailable</h1><p role="alert">Your access changed. Reload this workspace.</p><button data-cy="tenant-retry">Retry</button> <a href="/tenant-dashboard?dataset=demo&enable-semantics=true">Open marked demo</a> <a href="/success?enable-semantics=true">Account</a></main>';
 root.querySelector('[role=alert]')!.textContent=message;
 return root.firstElementChild!;
}
