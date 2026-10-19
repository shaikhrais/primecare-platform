import {registry} from '../../../../packages/shared/src/care/contract';
import {esc,type T} from '../growth/forms';
import {input} from './views';

const metrics=[['followup_open','open'],['workload_blocked','blocked'],['filter_late','late'],['followup_submitted','review'],['followup_extensions','extensions'],['workload_waiting','waiting']];
export function workloadView(t:T,data:any){
 const s=data.workload;if(!s)return '';
 return `<section class="section" data-cy="care-workload"><h2>${t('workload_title')}</h2><p>${t('workload_note')}</p>
 <form class="growth-form" data-cy="care-workload-search-form">${input(t,'care-workload-search','workload_search','query','search',s.query,false).replace('maxlength="2000"',`maxlength="${registry.workloadPolicy.queryMaxLength}"`)}<p>${t('workload_search_help')}</p><button data-cy="care-workload-search-save">${t('workload_search_submit')}</button></form>
 <p>${t('workload_owners')}: ${Number(s.total)}</p><div class="metric-grid">${metrics.map(([label,key])=>`<article class="metric"><span>${t(label)}</span><strong>${Number(s[key])}</strong></article>`).join('')}</div>
 ${s.records.map((r:any)=>`<article data-cy="care-workload-owner-${esc(r.owner_id)}"><h3>${esc(r.email||r.owner_id)}</h3><p>${esc(r.owner_id)}</p>${r.needsReassignment?`<p>${t('workload_owner_unavailable')}</p>`:''}<p>${metrics.map(([label,key])=>t(label)+': '+Number(r[key])).join(' · ')}</p><p>${t('workload_oldest_due')}: ${esc(r.earliest_due)}</p><button data-workload-owner="${esc(r.owner_id)}" data-cy="care-workload-open-${esc(r.owner_id)}">${t('workload_open_tasks')}</button></article>`).join('')||`<p>${t('empty')}</p>`}
 <div class="pagination"><button data-cy="care-workload-prev" ${s.offset===0?'disabled':''}>${t('previous')}</button><button data-cy="care-workload-next" ${s.offset+s.limit>=s.total?'disabled':''}>${t('next')}</button></div></section>`;
}
