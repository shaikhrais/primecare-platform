// Presentation-only controls for mounted specialist care workspaces.
// The host owns Screen Manager entry, roles, data, keyboard/click binding and
// every side effect. Keep the existing CSS hooks and control selectors intact.
const escapeText=(value:unknown)=>String(value??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]!));
type CareMetric=readonly [label:string,value:string|number,detail:string];
export function carePersonalMetricsMarkup(items:readonly CareMetric[]):string {
 return `<div class="grid stats">${items.map(([label,value,detail])=>`<article class="card stat"><p class="muted">${escapeText(label)}</p><div class="value">${escapeText(value)}</div><small>${escapeText(detail)}</small></article>`).join('')}</div>`;
}
export function careScheduleToolbarMarkup(date:string,view:string):string {
 return `<div class="schedule-toolbar"><div class="date-nav"><button data-live-date="prev" aria-label="Previous date">‹</button><button data-live-date="today">Today</button><button data-live-date="next" aria-label="Next date">›</button><input type="date" data-live-date-input value="${escapeText(date)}" aria-label="Calendar date"></div><div class="segmented">${['day','week','agenda'].map(v=>`<button data-live-view="${v}" class="${view===v?'active':''}">${v[0].toUpperCase()+v.slice(1)}</button>`).join('')}</div></div>`;
}
