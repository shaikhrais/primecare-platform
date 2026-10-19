import {registry} from '../../../../packages/shared/src/growth/contract';
import {esc,formValues,type T} from './forms';
import type {GrowthClient} from './client';

export function capacityView(t:T,c:any){
 const r=c.readiness;if(!r)return '';const id=esc(c.id);
 return `<div data-cy="growth-readiness-${id}"><h4>${t('readiness_title')}</h4><p>${t('readiness_note')}</p><ul>${r.gates.map((g:any)=>`<li>${t('readiness_'+g.key)}: <strong>${t(g.applicable===false?'readiness_not_required':g.ok?'readiness_yes':'readiness_no')}</strong></li>`).join('')}</ul>${r.capacity?`<p>${t('capacity_latest')}: ${Number(r.capacity.clientSlots)} · ${esc(r.capacity.expiresAt)} · ${t('version')} ${Number(r.capacity.version)}</p>`:''}${!r.schemaReady?`<p>${t('capacity_missing')}</p>`:r.canConfirm?`<p>${t('capacity_zero')}</p><form class="growth-form" data-capacity="${id}" data-cy="growth-capacity-form-${id}"><label>${t('capacity_slots')}<input name="clientSlots" type="number" min="0" max="${registry.capacityPolicy.maxSlots}" step="1" required data-cy="growth-capacity-slots-${id}"></label><label>${t('capacity_expiry')}<input name="expiresAt" type="datetime-local" required data-cy="growth-capacity-expiry-${id}"></label><label>${t('capacity_evidence')}<input name="evidence" maxlength="500" required data-cy="growth-capacity-evidence-${id}"></label><button data-cy="growth-capacity-save-${id}">${t('capacity_save')}</button></form>`:!r.gates.find((g:any)=>g.key==='brief')?.ok?`<p>${t('capacity_review')}</p>`:''}</div>`;
}

export function bindCapacity(root:HTMLElement,data:any,client:GrowthClient,mutate:(action:()=>Promise<any>)=>Promise<void>){
 root.querySelectorAll<HTMLFormElement>('[data-capacity]').forEach(form=>form.onsubmit=e=>{e.preventDefault();const c=data.campaigns.find((c:any)=>c.id===form.dataset.capacity),v=formValues(form);void mutate(()=>client.request('/capacity/'+c.id,'PUT',{version:c.readiness.capacity?.version??0,briefVersion:c.brief.version,clientSlots:Number(v.clientSlots),expiresAt:v.expiresAt+'Z',evidence:v.evidence}));});
}
