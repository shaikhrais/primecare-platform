// Pure presentation for the already-authorized Growth dashboard. Its host
// owns the Screen Manager, route, actor, links, text resources and bindings.
const escapeText=(value:unknown)=>String(value??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]!));

export function growthMetricMarkup(label:string,value:unknown,iconMarkup:string):string {
 return `<article class="metric growth-metric"><span class="growth-metric-icon">${iconMarkup}</span><div><span>${escapeText(label)}</span><strong>${escapeText(value)}</strong></div></article>`;
}

type GrowthDashboardState =
 | {kind:'loading';message:string}
 | {kind:'error';title:string;message:string;refresh:string;back:string;backHref:'/dashboard?enable-semantics=true'};

export function growthDashboardStateMarkup(state:GrowthDashboardState):string {
 if(state.kind==='loading')return `<div role="status" data-cy="growth-loading">${escapeText(state.message)}</div>`;
 return `<section role="alert" data-cy="growth-error"><h1>${escapeText(state.title)}</h1><p>${escapeText(state.message)}</p><button data-cy="growth-retry">${escapeText(state.refresh)}</button><a data-cy="growth-back" href="${state.backHref}">${escapeText(state.back)}</a></section>`;
}
