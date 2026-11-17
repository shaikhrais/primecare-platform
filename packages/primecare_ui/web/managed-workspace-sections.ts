// Shared appearance for an already-entered governed workspace.
// The owning host remains responsible for Screen Manager, session, authorization,
// navigation, live text, data selection and event lifecycle. These are pure
// render helpers and cannot register, display or grant access to any route.
export type WorkspaceLabel = (key:string)=>string;
const escapeHtml = (value:unknown)=>String(value??'').replace(/[&<>'"]/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;',"'":'&#39;','"':'&quot;'}[c]!));

type WorkspaceOverviewModel={t:WorkspaceLabel;cards:string;chart:string;metrics:string;activities:string;details:string};
type WorkspaceInventoryModel={t:WorkspaceLabel;inventoryOpen:boolean;readiness?:{summary:string;empty:string};search:string;pendingOnly:boolean;rowCount:number;tableRows:string;pageNumber:number;countPages:number};

export const workspaceMetric=(label:string,value:unknown)=>`<article class="metric"><span>${label}</span><strong>${escapeHtml(value)}</strong></article>`;

export const workspaceActivity=(activity:readonly {action:string;created_at:string}[],t: WorkspaceLabel)=>activity.length?`<ul class="activity-list">${activity.map(a=>`<li><strong>${escapeHtml(a.action.replaceAll('_',' '))}</strong><time datetime="${escapeHtml(a.created_at)}">${escapeHtml(new Date(a.created_at).toLocaleString())}</time></li>`).join('')}</ul>`:`<p class="empty">${t('empty')}</p>`;

export const workspaceRoleChart=(roles:readonly {role:string;count:number}[],activeAccounts:number,roleLabel:(role:string)=>string)=>`<div class="role-bars">${roles.map(r=>`<div><div><span>${escapeHtml(roleLabel(r.role))}</span><strong>${escapeHtml(r.count)}</strong></div><meter min="0" max="${Math.max(1,activeAccounts)}" value="${escapeHtml(r.count)}" aria-label="${escapeHtml(roleLabel(r.role))}">${escapeHtml(r.count)}</meter></div>`).join('')}</div>`;

export const workspaceShortcuts=<P extends {code:string;route:string}>(screens:readonly P[],entries:readonly (readonly [string,string])[],prefix:string,pageLink:(page:P,testId:string)=>string)=>entries.flatMap(([code,path])=>
      screens.filter(p=>p.code===code&&p.route===path).map(p=>pageLink(p,prefix+'-shortcut-'+code))
    ).join('');

export const workspaceActions=(prefix:string,links:string,t:WorkspaceLabel,readinessLabel:string,{trainingLabel,metadataOnly=false}:{trainingLabel?:()=>string;metadataOnly?:boolean}={})=>`<section class="section" data-cy="${escapeHtml(prefix)}-authorized-actions">
      <h2>${t('pages')}</h2>${metadataOnly?`<p class="notice">${t('no_data')}</p>`:''}<div class="quick-links">${links}
      <button type="button" data-cy="${escapeHtml(prefix)}-open-readiness">${escapeHtml(readinessLabel)}</button>
      ${trainingLabel?`<button type="button" data-cy="training-director-open-training">${escapeHtml(trainingLabel())}</button>`:''}
      </div></section>`;

export const workspaceOverview=({t,cards,chart,metrics,activities,details}: WorkspaceOverviewModel)=>`<section class="section" data-cy="workspace-overview"><h2>${t('title')}</h2><div class="metric-grid">${cards}</div></section>
      <section class="section" data-cy="workspace-organization"><h2>${t('roles')}</h2>${chart}<div class="metric-grid">${metrics}</div></section>
      <section class="section" data-cy="workspace-activity"><h2>${t('activity')}</h2>${activities}</section><details class="section" data-cy="workspace-delivery"><summary>${t('details')}</summary>${details}</details>`;

export const workspaceInventory=({t,inventoryOpen,readiness,search,pendingOnly,rowCount,tableRows,pageNumber,countPages}: WorkspaceInventoryModel)=>`<details class="section workspace-inventory-disclosure" data-cy="workspace-inventory" ${inventoryOpen?'open':''}><summary>${readiness?escapeHtml(readiness.summary):t('inventory')}</summary><div class="inventory-controls"><label>${t('search')}<input data-cy="workspace-search" value="${escapeHtml(search)}"></label><label><input type="checkbox" data-cy="workspace-pending" ${pendingOnly?'checked':''}>${t('pending')}</label><button data-cy="workspace-export">${t('export')}</button></div>
      ${readiness&&rowCount===0?`<p role="status" data-cy="readiness-empty">${escapeHtml(readiness.empty)}</p>`:''}<div class="table-scroll"><table><thead><tr><th>${t('pages')}</th><th>${t('portal')}</th><th>${t('role')}</th><th>${t('status')}</th><th>${t('pending')}</th></tr></thead><tbody>${tableRows}</tbody></table></div><div class="pagination"><button data-cy="inventory-prev" aria-label="${t('previous')}" ${pageNumber===0?'disabled':''}>←</button><output data-cy="inventory-count">${rowCount} · ${pageNumber+1}/${countPages}</output><button data-cy="inventory-next" aria-label="${t('next')}" ${pageNumber+1===countPages?'disabled':''}>→</button></div></details>`;
