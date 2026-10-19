import {esc,type T} from '../growth/forms';
import {select,memo,check} from './views';

export function prerequisitePicker(t:T,options:any){
 return `<p>${t('followup_prerequisites_note')}</p><label>${t('followup_prerequisites')}<select name="prerequisiteIds" multiple data-cy="care-followup-prerequisites">${options.prerequisites.map((p:any)=>`<option value="${esc(p.id)}">${t('category_'+p.category)} · ${t('followup_'+p.status)} · ${esc(p.owner_id)} · ${esc(p.id)}</option>`).join('')}</select></label>${options.prerequisitesTruncated?`<p data-cy="care-followup-prerequisites-truncated">${t('followup_prerequisites_truncated')}</p>`:''}`;
}
export function dependenciesView(t:T,r:any){
 const d=r.dependencies;if(!d?.records.length)return '';
 const releasable=d.records.filter((p:any)=>p.canRelease);
 return `<section data-cy="care-followup-dependencies-${esc(r.id)}"><h4>${t('followup_prerequisites')}</h4>${d.waiting?`<p>${t('followup_dependency_pending')}</p>`:''}${d.records.map((p:any)=>`<div data-cy="care-followup-dependency-${esc(r.id)}-${esc(p.id)}"><p>${t('category_'+p.category)} · ${t('followup_'+p.status)} · ${esc(p.id)}</p><p>${t('followup_owner')}: ${esc(p.ownerId)}</p><p>${t(p.released?'followup_dependency_released':p.fulfilled?'followup_dependency_fulfilled':'followup_dependency_waiting')}${p.released?' · '+esc(p.releasedBy)+' · '+esc(p.releasedAt):''}</p></div>`).join('')}${releasable.length?`<form class="growth-form" data-cy="care-followup-release-form-${esc(r.id)}"><h4>${t('followup_release_dependency')}</h4><p>${t('followup_dependency_independent_note')}</p>${select(t,'care-followup-release-parent-'+r.id,'followup_prerequisites','prerequisiteId',releasable.map((p:any)=>({id:p.id,label:t('category_'+p.category)+' · '+p.id})))}${memo(t,'care-followup-release-note-'+r.id,'evidence','note').replace('maxlength="2000"','maxlength="1000"')}${check(t,'care-followup-release-checked-'+r.id,'followup_dependency_checked','checked')}<button data-cy="care-followup-release-save-${esc(r.id)}">${t('followup_release_dependency')}</button></form>`:''}</section>`;
}
